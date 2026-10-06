# Fino — Modelo de datos (Firestore + Drift)

Cómo se guarda la lógica de `SPEC.md`. **Drift es la fuente de la verdad** de la
UI (offline-first); Firestore es la sincronización y la red de seguridad de
autorización (`firestore.rules`). Cada acción de negocio es **un lote atómico**.

## Firestore

```
invites/{CODE}                                 { teamId, teamName }          solo `get`, nunca lista
teams/{team}                                   { name, adminId, inviteCode, memberIds[], createdAt }
teams/{team}/members/{uid}                     { userId, role, joinedAt, displayName, photoUrl? }
teams/{team}/members/{uid}/payout/main         { type: clabe|card, number, bankName?, holderName? }
teams/{team}/members/{uid}/payers/{debtorId}   {}   ← quién puede ver mi método de cobro (M4)
teams/{team}/orders/{id}                       { creditorId, concept, note?, total, spentAt, createdAt, updatedAt }
teams/{team}/debts/{id}                        { orderId, creditorId, debtorId, amount, status, paymentId?, createdAt, updatedAt }
teams/{team}/payments/{id}                     { creditorId, debtorId, debtIds[], payoutShown{bankName?,last4}, reference?, reportedAt, awaitingConfirmationReminderSent }
teams/{team}/ledger/{id}                       { orderId, type, actorId, at, debtId?, paymentId?, amountBefore?, amountAfter?, note?, confidential, partyIds[] }
teams/{team}/notices/{id}                      { senderId, recipientIds[], template?, text?, sentAt }   solo lo lee quien lo envió
users/{uid}/inbox/{id}                         { kind, actorId, teamId, targetType, targetId, amountCents?, concept?, debtCount?, rejectedCount?, note?, templateKey?, createdAt, readAt? }
```

- Montos en **centavos enteros**; enums como su `name` de Dart; `createdAt` /
  `updatedAt` / `at` / `sentAt` / `reportedAt` **siempre** `serverTimestamp`
  (las reglas exigen `== request.time`).
- Todo cuelga de `teams/{team}`: un equipo borrado deja sus subdocumentos
  inalcanzables (las reglas leen `teams/{team}` para saber quién es miembro).
- Descubrir mis equipos: `collectionGroup('members').where('userId', '==', uid)`
  (índice en `firestore.indexes.json`).

## Qué imponen las reglas

| Tema | Regla |
|---|---|
| Miembros | Solo `memberIds` del equipo lee/escribe (un equipo inexistente se lee como "no existe", así los demás dispositivos se enteran de que lo eliminaron); un solo documento (`teams/{team}`) valida casi todo (límite de 20 accesos por batch). |
| Entrar (E2) | Se crea `members/{yo}` con un `inviteCode` válido **y** se agrega a `memberIds` en el mismo batch. Sin código válido, no. |
| Admin (E5, E6) | Un solo admin (`adminId`); roles siguen a `adminId`; el admin no puede salirse. |
| Pedidos (M2) | Solo el acreedor, miembro, **con método de cobro**; no se borran. |
| Deudas (6.1) | Solo transiciones válidas por rol: el acreedor edita monto / cancela / confirma / rechaza / deshace (si el deudor sigue); el deudor reporta (con su `payment` en el mismo batch) o retira. `CANCELADA` es final; nada se borra. |
| Pagos | Los crea el deudor; solo el acreedor marca el aviso de 48 h. Inmutables. |
| Bitácora | Se agrega con tu propio `actorId`; nunca se edita; `confidential` ⇔ tipo `paymentReported`/`debtObjected`; esas solo las ven `partyIds`. |
| Método de cobro (M4) | Solo su dueño lo escribe y no se puede quitar. Lo lee el dueño o quien el dueño dio de alta en `payers/{debtorId}` (la app lo da de alta al crear la primera deuda viva y lo quita al cerrarse la última). |
| Buzón | Un compañero de equipo deja un aviso a otro miembro; solo su dueño lo lee, lo marca leído o lo borra. |

### Lo que las reglas **no** pueden imponer (lo hace el dominio)

- Salir / expulsar / eliminar el equipo **con deudas vivas** (SPEC §4.2): Firestore
  no cuenta documentos. Lo bloquea `LeaveTeam` / `ExpelMember` / `DeleteTeam`.
- Que cada pedido sume bien, el reparto, el límite de 1 h entre avisos, los
  textos válidos: casos de uso del dominio.
- Un cliente malicioso **dentro del equipo** podría saltarse el dominio; las
  reglas lo limitan a lo que cada rol puede hacer, no a lo que la UI muestra.
  Cerrar ese hueco por completo requiere Cloud Functions (plan Blaze).
- **Push (FCM)**: las reglas permiten dejar el aviso en el buzón; el envío real
  del push necesita un servidor (p. ej. una función con trigger `onCreate` en
  `users/*/inbox/*`). Mientras tanto el buzón en la app es la fuente de verdad.

## Drift (offline)

`AppDatabase` v2 compone las tablas de cada feature (`features/*/data/tables`) y
sus DAOs (`features/*/data/daos`). Un mapper por entidad (`data/mappers`)
convierte fila ↔ dominio.

| Tabla | Feature | Espejo de |
|---|---|---|
| `teams`, `team_members`, `payout_methods` | teams | equipos, miembros, métodos de cobro visibles |
| `orders`, `debts`, `payments`, `ledger_entries` | orders | pedidos, deudas, pagos, bitácora |
| `notice_records` | notices | avisos enviados (alimenta el límite de 1 h) |
| `inbox_notifications` | inbox | `users/{uid}/inbox` |
| `outbox_entries` | core | escrituras pendientes, agrupadas por `batch_id` |

- Fechas en UTC; dinero en centavos.
- Migración v1 → v2 versionada con test (`test/core/database/migration_test.dart`).
  Cada cambio: subir `schemaVersion`, `dart run drift_dev schema dump …`,
  `dart run drift_dev schema generate …` y escribir la migración.

## Capas (de la UI hacia Firebase)

```
presentation  →  commands (domain)  →  use cases puros (domain)
                      │                      └─ devuelven un ChangeSet (qué cambió + qué notificar)
                      ▼
             repositorio (interfaz en domain)  ←  LocalXRepository (data)
                      │  una transacción de Drift:
                      │    1. filas locales   2. planners → RemoteWrites   3. outbox (un batchId)
                      ▼
                  OutboxPump → OutboxProcessor → RemoteGateway → Firestore
                                                       ▲
 Drift ◄── appliers ◄── SyncCoordinator / TeamPull ◄───┘  (escucha de bajada)
```

- **Comandos** (`features/*/domain/commands`, uno por archivo): cargan el estado
  (repositorio / puertos), ejecutan el caso de uso puro y guardan el resultado.
  Ej.: `CreateOrderCommand`, `ReportPaymentCommand`, `JoinTeamCommand`.
- **Puertos** que cada feature declara para lo que no es suyo, sin importarse
  entre features: `TeamDirectory` (pedidos), `LiveDebtsDirectory` e
  `InviteLookup` (equipos), `NoticeAudience` (avisos).
- **Entrar a un equipo es lo único que exige conexión** (el código solo se
  verifica en el servidor). Todo lo demás funciona offline.

## Escribir (offline-first)

1. El comando guarda en **una transacción de Drift**: las filas locales **y** el
   lote del outbox (la UI cambia al instante).
2. Los **planners** (`data/remote`) traducen el `ChangeSet` a `RemoteWrite`s sin
   SDK; todas las de una acción comparten `batchId`.
3. `OutboxProcessor` manda **un lote atómico a la vez, en orden** (una edición
   nunca llega antes que la creación que edita):
   - éxito → el lote sale de la cola;
   - falla transitoria (red) → reintento con backoff y la cola espera;
   - rechazo de las reglas → el lote se **descarta**, se avisa y se vuelve a
     bajar el estado del servidor de ese equipo (lo local se corrige solo).
4. `create`/`set` son idempotentes (en Firestore, una escritura sobre un
   documento nuevo se evalúa como `create`); `update` solo toca lo que cambió;
   `RemoteMarker.fieldDelete` quita un campo.

## Leer / bajar (Firestore → Drift)

`SyncCoordinator` (por usuario) y `TeamPull` (por equipo) escuchan y aplican a
Drift con los `ScopedCollectionApplier`:

- **Descubrir mis equipos**: `collectionGroup('members')` donde `userId == yo`.
- Por equipo: el documento del equipo, miembros, pedidos, deudas, pagos,
  **bitácora en dos consultas** (las abiertas, y las confidenciales donde soy
  parte: las reglas no filtran, la consulta debe pedir solo lo legible), mis
  avisos y el método de cobro de cada acreedor con quien tengo deuda viva (M4).
- Más mi buzón `users/{uid}/inbox`.
- **Lo que tiene escrituras pendientes en el outbox no se pisa.** En la
  instantánea inicial, lo local que el servidor no trae (y no está pendiente) se
  borra: así se reconcilian lotes rechazados o equipos eliminados.
- `ResilientSubscription` reabre sola cada escucha caída (más espaciado si
  las reglas la rechazan).

## Gateways (`RemoteGateway`)

| Implementación | Dónde | Notas |
|---|---|---|
| `CloudFirestoreGateway` | Android, web | Los lotes salen como **transacciones de solo escritura**: atómicas y **fallan sin red** (un `WriteBatch` se quedaría en la cola interna del SDK). Ignora instantáneas "de caché" para no confundir una vacía con la inicial. |
| `FirestoreRestGateway` | Linux (dev) y pruebas | REST contra el emulador; la escucha es por sondeo. Token sin firma: **solo emulador**. |

La app elige con `remoteGatewayProvider`; `syncCoordinatorProvider` enciende la
sincronización al haber sesión (no en sesión demo) y `bootstrap` lo escucha.

## Pruebas

- `flutter test` — dominio, comandos, repositorios, planners, mappers, outbox,
  códecs y migraciones. Las de reglas se **omiten** sin emulador.
- `tool/test_rules.sh` — emulador propio (puerto 8195, JDK 21+):
  - reglas una por una (`teams_`, `payout_`, `orders_`, `debt_transitions_`,
    `ledger_inbox_`);
  - **contrato dominio ↔ reglas** (`contract_*`);
  - el gateway REST (`gateway_rest_test`);
  - **extremo a extremo con dos dispositivos** (`sync_e2e_test`): crear/entrar/
    salir/eliminar equipos, pedido → reporte → confirmación, offline, rechazo
    de las reglas con autocorrección, avisos, confidencialidad.
- `integration_test/cloud_firestore_gateway_test.dart` — el gateway del SDK
  contra los emuladores, en dispositivo o navegador (el SDK no corre en
  `flutter test`).

## Límites conocidos

- Un lote de Firestore admite 500 operaciones: un pedido con muchísimos
  deudores (cada uno suma deuda + bitácora + aviso + marcador) debería
  partirse; hoy el dominio no impone un tope.
- Al cerrar sesión se borra lo local (`AppDatabase.wipe`): lo que siga en el
  outbox y no haya salido se pierde.
- Los documentos de un equipo eliminado (pedidos, deudas…) quedan huérfanos pero
  inalcanzables; se limpian solo miembros e invitación.
