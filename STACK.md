# Fino — STACK.md

Contrato técnico de **Fino**. Es **obligatorio** para toda persona y todo agente.
No se negocia, no se "adapta por esta vez" y no se ignora. Si una tarea choca con
este documento, **se detiene la tarea y se pregunta**; no se rompe la regla.

> UI/UX vive en `DESIGN.md`. Este documento define **código, herramientas y proceso**.
> Si hay conflicto: `STACK.md` manda en código, `DESIGN.md` manda en diseño.

---

## 0. Reglas innegociables

1. **Un archivo = una sola responsabilidad.** Ni más, ni menos (SOLID).
2. **0 errores, 0 warnings, 0 infos** del analyzer. Nunca se silencia con `// ignore` sin motivo escrito en la misma línea.
3. **Ningún archivo supera 500 líneas** sin justificación explícita (ver §4).
4. **El pre-commit no se salta.** Nunca `--no-verify`, nunca desactivar hooks (ver §5).
5. **Offline-first:** la UI lee siempre de la base local, nunca directo de la red (ver §8).
6. **60 FPS** como mínimo en dispositivos reales, medido en `profile` (ver §9).
7. **Nada de código muerto, comentarios obvios, `print`, `TODO` sin dueño ni lógica duplicada.**

---

## 1. Stack

| Capa | Tecnología |
| --- | --- |
| Framework | Flutter (stable) + Dart ^3.13 |
| Estado / DI | **Riverpod** (`flutter_riverpod` + `riverpod_annotation` + `riverpod_generator`) |
| Rutas / deep links | **go_router** |
| Base local | **Drift** (SQLite; `drift_flutter`, WASM en web) |
| Backend | **Firebase**: Auth (Google Sign-In), Firestore, Analytics, Cloud Messaging |
| Notificaciones locales | `flutter_local_notifications` (+ `timezone`, que el plugin exige para programar) |
| Tipografía | **Geist** / Geist Mono, empaquetadas como assets (nunca `google_fonts` en runtime) |
| Modelos | `freezed` + `json_serializable` (inmutables) |
| Splash | `flutter_native_splash` |
| Calidad | `very_good_analysis` + modo estricto, `dart format`, `lefthook` |
| Tests | `flutter_test`, `mocktail`, `integration_test`, goldens donde aporten |

**Plataformas objetivo:** Android móvil, Android tablet y Web; además **Linux de escritorio solo para desarrollo** (flavor `dev` contra los emuladores, ver §3 y §8).
No se añade soporte, código ni dependencias para iOS, Windows o macOS.
**No se agrega ninguna dependencia fuera de esta tabla sin aprobación explícita.**

---

## 2. Arquitectura y estructura

Feature-first, capas por feature. Dependencias **siempre hacia adentro**:
`presentation → domain ← data`. `domain` no importa Flutter, Drift ni Firebase.

```
lib/
├── main_dev.dart | main_qa.dart | main_prod.dart   # entrypoints mínimos (solo flavor + bootstrap)
├── bootstrap/            # una función por paso: errores, Firebase, servicios diferidos; `bootstrap()` los orquesta
├── app/                  # FinoApp, router, tema, localización
├── core/                 # transversal sin dominio: errores, red, utils, constantes, extensiones
├── ui/                   # design system compartido (tokens, componentes) según DESIGN.md
└── features/
    └── <feature>/
        ├── domain/       # entidades, interfaces de repositorio, casos de uso
        ├── data/         # tablas/DAOs Drift, fuentes remotas, DTOs, implementación de repositorios
        └── presentation/
            ├── providers/  # un notifier/provider por archivo
            ├── pages/      # una página por archivo
            └── widgets/    # un widget por archivo
```

### Una sola responsabilidad — qué significa aquí

- Una clase pública por archivo. Nombre del archivo = nombre de la clase en `snake_case`.
- **Página** = compone widgets y lee providers. No contiene lógica, consultas ni formato.
- **Widget** = pinta. Sin lógica de negocio, sin acceso a datos.
- **Notifier/provider** = estado y orquestación. No construye UI ni toca SDKs directamente.
- **Repositorio** = única puerta a datos. Decide local vs. remoto; la UI no lo sabe.
- **DAO** = solo consultas Drift. **DTO/mapper** = solo conversión.
- Prohibidos los archivos `utils.dart`, `helpers.dart`, `common.dart`, `manager.dart` que acumulan cosas. Si no se puede nombrar con precisión, hace demasiado.
- Un `build()` que crece se parte en widgets (clases), **no** en métodos `_buildX()`.
- Sin imports entre features. Lo compartido sube a `core/` o `ui/`.
- Imports relativos dentro de la feature; `package:fino/...` entre capas distintas.

---

## 3. Flavors: dev, qa, prod

| Flavor | applicationId | Firebase | Uso |
| --- | --- | --- | --- |
| `dev` | `<id>.dev` | **emuladores locales** (`demo-fino-dev`, sin proyecto real) | desarrollo diario, logs verbosos |
| `qa` | `<id>.qa` | proyecto `fino-qa` | pruebas, datos de prueba, Crashlytics/Analytics en modo debug |
| `prod` | `<id>` | proyecto `fino-prod` | producción, sin logs, minificado |

- `applicationId` final por definir; **reemplazar `com.example.fino`** antes de registrar las apps en Firebase y de cualquier release (vive en `baseApplicationId`, `android/app/build.gradle.kts`). Los hosts de App Links (`*.fino.example`) también son placeholders.
- Flavors **nativos**: `productFlavors` en Gradle + un entrypoint por flavor (`main_<flavor>.dart`) + `firebase_options_<flavor>.dart` por flavor.
- Cada entrypoint solo define `Flavor` + llama `bootstrap(flavor)`. **Cero lógica** ahí.
- `bootstrap()` es el único sitio que inicializa servicios, en orden y con manejo de errores: zona de errores → Firebase → Drift → notificaciones → `runApp(ProviderScope(...))`.
- La configuración por flavor (URLs, flags, nombre visible, ícono) vive en **un** objeto `FlavorConfig` inyectado por Riverpod. Prohibido `if (kDebugMode)` o comparar strings de flavor repartidos por el código.
- Ícono y nombre distintos por flavor para distinguir builds instaladas a la vez (`Fino Dev`, `Fino QA`, `Fino`).
- Scripts únicos para correr/compilar: `tool/run.sh <flavor>`, `tool/build.sh <flavor>`. No comandos sueltos en la documentación. En Android `--flavor` es obligatorio: sin él Flutter no sabe qué variante compilar.
- Firebase por flavor: `tool/configure_firebase.sh <flavor>` genera `firebase_options_<flavor>.dart` (FlutterFire CLI). Mientras sean placeholders (`REPLACE_ME`), `prod` **se niega a arrancar** (`strictConfiguration`) y dev/qa avisan en el log.
- **No** se usa el plugin Gradle `google-services`: Firebase se inicializa desde Dart con las opciones del flavor.
- **`dev` usa los Firebase Emulators** (`FlavorConfig.emulators`): Auth `:9099`, Firestore `:8085`, UI `:4000` (`firebase.json`). Se levantan con `tool/emulators.sh` (necesita `firebase-tools` y JDK 21+) y los datos persisten en `.firebase/data`. El inicio de sesión de dev usa una identidad Google falsa que el emulador acepta, así que no hace falta cuenta real ni `configure_firebase.sh`. Android dev permite HTTP en claro (`src/dev/AndroidManifest.xml`); en un teléfono físico hace falta `adb reverse tcp:<puerto> tcp:<puerto>` por cada puerto.
- `qa` y `prod` siempre usan proyectos reales; nunca apuntan a emuladores.

---

## 4. Calidad: linter, analyzer, formatter, tamaño de archivo

- `analysis_options.yaml` en modo estricto: `strict-casts`, `strict-inference`, `strict-raw-types`.
- Reglas obligatorias mínimas: `prefer_const_constructors`, `prefer_final_locals`, `avoid_print`, `always_declare_return_types`, `unawaited_futures`, `use_build_context_synchronously`, `require_trailing_commas`, `directives_ordering`, `public_member_api_docs` solo en `core/` y `ui/`.
- El analyzer excluye únicamente código generado (`*.g.dart`, `*.freezed.dart`, `*.drift.dart`) y carpetas de plataforma no usadas.
- Formato: `dart format --set-exit-if-changed .` con la config del repo. Sin discusiones de estilo.
- **Límite de tamaño — `tool/check_file_length.dart`:**
  - Objetivo sano: **≤ 200 líneas**. Tope duro: **500**.
  - Excluye código generado y `assets/`.
  - Un archivo > 500 solo pasa con `// file-length-ok: <motivo concreto>` en las primeras 5 líneas (p. ej. tabla de datos estática, esquema Drift extenso). "Es más cómodo" **no** es motivo.
  - Si un archivo se acerca a 500, **se parte antes de agregar más**, no después.
- Funciones cortas (objetivo ≤ 30 líneas), nombres que expliquen la intención, sin anidación profunda, early returns, `const` siempre que se pueda.
- Código generado (`build_runner`) **no se edita a mano** y se regenera en CI para verificar que está al día.

---

## 5. Pre-commit y hooks (no saltables)

Gestor: **lefthook** (`lefthook.yml` versionado). Instalación automática con `tool/setup.sh`.

**pre-commit** (solo archivos staged cuando sea posible):
1. `dart format --set-exit-if-changed`
2. `flutter analyze --fatal-infos --fatal-warnings`
3. `dart run tool/check_file_length.dart`
4. Tests unitarios/widget de lo afectado

**pre-push:** `flutter test` completo + `build_runner` sin diff pendiente.

**CI** (rama protegida, check requerido para merge): repite todo lo anterior + build de `dev` y `qa`. **Es la red de seguridad real**: un hook local siempre puede evadirse, el CI no.

### Reglas para agentes (obligatorio)

- **Prohibido** `git commit --no-verify` / `-n`, `git push --no-verify`, `LEFTHOOK=0`, `HUSKY=0`, cambiar `core.hooksPath` o borrar/editar `lefthook.yml` o `.git/hooks` para evitar una verificación.
- Si el hook falla: **se arregla la causa**. Nunca se esquiva, se baja una regla ni se agrega `// ignore` para pasar.
- Está bloqueado también en `.claude/settings.json` (deny) y por el hook `PreToolUse` `.claude/hooks/block-hook-bypass.sh`, que rechaza el comando antes de ejecutarlo; el CI lo verifica. Esos archivos no se editan para aflojar el bloqueo.
- Un commit que no pasó el hook **no se reporta como hecho**.
- **Commit con trabajo ajeno sin commitear en el árbol.** El pre-commit corre sobre *todo* el árbol, no solo lo staged: un archivo a medias de otra línea de trabajo (o de otra sesión) lo tumba aunque tu cambio esté bien. No se salta ni se baja una regla: se commitea desde un clon limpio, donde el hook corre completo sobre exactamente lo que se commitea.
  1. `git add <solo lo tuyo>`
  2. `tool/commit_clean.sh -m "tipo(alcance): asunto"` (o `-F archivo`). Clona `HEAD`, aplica solo lo staged, commitea con los hooks y mueve la rama aquí sin tocar tus archivos.
  - No sirve `git worktree`: dentro de un hook de worktree Flutter pierde su versión y `pub get` falla.
  - Si el hook falla, no se commitea nada: arregla la causa y repite. Si `HEAD` se movió mientras tanto, se niega y no cambia nada.

---

## 6. Riverpod

- Providers con **codegen** (`@riverpod`). Un provider/notifier por archivo.
- Estado inmutable (`freezed`). Estados asíncronos con `AsyncValue`; la UI siempre maneja `loading`, `error` y `data`.
- Providers de infraestructura (DB, Firebase, repositorios) en `data/` o `bootstrap/`, expuestos como interfaces de `domain`. Se **sobrescriben en tests** con `ProviderScope(overrides: ...)`.
- `ref.watch` en `build`, `ref.read` solo en callbacks, `ref.listen` para efectos (navegación, snackbars).
- Reconstrucción mínima: `select` / widgets pequeños. Prohibido observar un provider grande para usar un campo.
- `autoDispose` por defecto; `keepAlive` solo con motivo.
- Sin singletons globales, sin `static` con estado, sin `GetIt` ni otro service locator.

---

## 7. Rutas y deep linking

- **go_router** con rutas tipadas (`go_router_builder`). Rutas declaradas en un solo lugar (`app/router/`), una definición por archivo cuando crezcan.
- **Cada pantalla tiene URL propia**, incluidos detalles con parámetros (`/personas/:id`). Sin navegación imperativa con `Navigator.push`.
- Web: `usePathUrlStrategy()`, refrescar o pegar una URL abre la pantalla correcta.
- Android: **App Links** verificados (`assetlinks.json`) + intent filters por flavor. Un link entrante abre la pantalla correcta con la app cerrada, en segundo plano o abierta.
- Las notificaciones push y locales llevan un **payload de ruta** y navegan por el mismo router.
- Guards de autenticación vía `redirect` + `refreshListenable` conectado a Riverpod. Ninguna pantalla protegida se renderiza sin sesión.
- Transiciones **custom** (ver `DESIGN.md`) definidas una vez en `CustomTransitionPage`, no repetidas por ruta.

---

## 8. Datos: Drift, Firebase y offline-first

**Fuente de la verdad = Drift.** Firestore es sincronización, no origen directo de la UI.

- La UI observa `Stream`s de Drift. Escribir = guardar local primero → la UI cambia **al instante** → se sincroniza después.
- **Outbox** (tabla de operaciones pendientes) con reintentos con backoff; idempotente. Sin conexión no hay errores visibles ni spinners bloqueantes.
- Resolución de conflictos definida y documentada (por defecto: *last-write-wins* con `updatedAt` del servidor). Cualquier excepción se documenta junto al repositorio.
- Migraciones Drift **versionadas y con tests**. Cada cambio de esquema: subir `schemaVersion`, `dart run drift_dev schema dump lib/core/database/app_database.dart drift_schemas/`, regenerar `test/generated_migrations/` (`drift_dev schema generate`) y escribir la migración. Nunca se destruye la base del usuario.
- Web: `web/sqlite3.wasm` y `web/drift_worker.js` deben coincidir con las versiones de `pubspec.lock` (`tool/update_web_assets.sh`).
- Índices en columnas consultadas; consultas pesadas fuera del hilo de UI (isolate de Drift).
- Firestore: persistencia local desactivada si Drift ya cubre el caso (una sola fuente). `firestore.rules` e índices versionados en el repo y probados con emulador.
- Auth: **Google Sign-In** vía Firebase Auth. Estado de sesión como `Stream` en un provider; cierre de sesión limpia datos locales sensibles.
- **Linux no tiene plugins FlutterFire.** Ahí (solo dev) Auth habla con el emulador por REST (`EmulatorAuthRepository`), Analytics y FCM son no-op y las notificaciones locales sí funcionan. Firestore no tiene cliente en Linux: cuando exista la sincronización, necesitará una implementación REST detrás de su interfaz. `bootstrap` rechaza `qa`/`prod` en Linux con un mensaje claro. Nada fuera de `core/platform/` decide por plataforma si hay plugins: todo pasa por `firebasePluginsSupportedFlagProvider`.
- El login REST se prueba contra el Auth emulator real (`test/emulator/`) y el flujo completo de dev con `integration_test/dev_emulator_flow_test.dart` (`flutter test integration_test/dev_emulator_flow_test.dart -d linux`). Ambos se saltan solos si los emuladores no están corriendo.
- Analytics: eventos centralizados en **un** `AnalyticsService` con nombres tipados. Prohibido llamar `FirebaseAnalytics` desde UI.
- Push (FCM) + locales: un servicio por responsabilidad (permisos, canales, handler de payload, programación). Canales Android definidos y nombrados; permiso `POST_NOTIFICATIONS` pedido en contexto, no al abrir.
- Secretos y llaves **nunca** en el repo: `google-services.json` por flavor sí se versiona solo si no contiene secretos sensibles; el keystore de release **jamás**.

---

## 9. Rendimiento y fluidez (60 FPS)

- Se mide en **`flutter run --profile` sobre dispositivo real** (gama baja incluida), con DevTools. `debug` no cuenta.
- Presupuesto: **16 ms por frame**. Cero jank en scroll, transiciones y animaciones.
- `const` por defecto. Widgets pequeños y con `Key` donde corresponda.
- Listas: siempre `ListView.builder` / `SliverList.builder`; `itemExtent` o `prototypeItem` cuando sea posible. Paginación sobre Drift.
- Nada pesado en `build()`: sin parseo, ordenado, formato ni filtros. Eso va en providers o en el repositorio.
- Trabajo costoso (JSON grande, cálculos) en `Isolate.run`/`compute`.
- `RepaintBoundary` solo donde el profiler lo justifique, no por reflejo.
- Evitar `Opacity`, `ClipRRect`, `saveLayer` y sombras costosas en listas/animaciones; preferir alternativas baratas (`FadeTransition`, `DecoratedBox`).
- Imágenes: tamaño decodificado acorde (`cacheWidth`/`cacheHeight`), formatos livianos.
- **Animaciones custom** con `AnimationController`/implícitas, animando solo la parte que cambia (`AnimatedBuilder` con `child`). Respetan `MediaQuery.disableAnimations`. Detalles de movimiento en `DESIGN.md`.
- Arranque en frío rápido: `bootstrap` paraleliza lo independiente y difiere lo no crítico (Analytics, FCM) hasta después del primer frame.

---

## 10. Responsivo

- Un solo árbol de UI adaptado por **ancho**, no por tipo de dispositivo. Breakpoints definidos en un único archivo (`core/layout/breakpoints.dart`).
- Compacto (móvil) → barra inferior; medio/expandido (tablet y web) → rail lateral + contenido con ancho máximo. Ver `DESIGN.md`.
- `LayoutBuilder`/`MediaQuery.sizeOf` (nunca `MediaQuery.of` completo para solo el tamaño).
- Probado en: móvil vertical/horizontal, tablet, web en escritorio y ventana estrecha. Texto escalado (`textScaler`) hasta 200 % sin overflow.
- Web: teclado, foco visible, hover y selección de texto donde corresponda.

---

## 11. Testing

- Lo que se escribe, se prueba. **Cobertura mínima**: `domain` y notifiers ≥ 90 %, repositorios/DAOs ≥ 80 %, global ≥ 75 %.
- Pirámide: muchos unit tests (domain, notifiers, mappers) → widget tests por pantalla/estado (`loading`/`error`/`data`/vacío) → pocos `integration_test` de flujos críticos (login, alta, sync offline→online).
- Drift se prueba con base **en memoria**. Firebase se aísla detrás de interfaces y se mockea con `mocktail`; las reglas de Firestore con el emulador.
- Goldens solo para componentes del design system.
- Tests deterministas: sin `sleep`, sin red real, sin depender del orden.
- Un bug corregido = un test que lo reproduce primero.

---

## 12. Empaquetado y splash (Android)

- `applicationId` definitivo y estable; `namespace`, nombre visible e íconos por flavor.
- **Splash nativo** con `flutter_native_splash` (Android 12+ incluido), mismo color de fondo que el primer frame de la app. Sin splash artificial ni esperas fijas: desaparece cuando `bootstrap` termina.
- Release: **App Bundle (`.aab`)**, R8/minify + shrinkResources activos, ofuscación (`--obfuscate --split-debug-info`) con símbolos archivados.
- Firma por `key.properties` **fuera del repo**. `minSdk`/`targetSdk` explícitos en un solo lugar.
- Versionado semántico en `pubspec.yaml` (`x.y.z+build`); el build number sube en cada release.
- **Releases y changelog automáticos**, desde los commits: `dart run tool/bump_version.dart <major|minor|patch> [--dry-run]`. Lee los Conventional Commits (`feat`, `fix`, `perf`…) desde el último tag `v*`, sube la versión de `pubspec.yaml`, regenera `CHANGELOG.md` y `assets/changelog.json` (lo que muestra Ajustes → Novedades), y crea el commit `chore(release): vX.Y.Z` con su tag. Con `--dry-run` solo muestra lo que saldría.
  - Los archivos del release **no se editan a mano**. Un commit que no siga `tipo(alcance): asunto` no aparece en el changelog: escribe los asuntos pensando en quien lee las novedades (`feat` → Novedades, `fix` → Correcciones, `perf` → Mejoras; el resto solo en `CHANGELOG.md`). `tipo!:` marca un cambio incompatible: sube `major`.
  - Exige árbol limpio; el commit pasa por el pre-commit de siempre y, si falla, no deja nada a medias.
  - **Siempre se publica con `tool/release.sh <major|minor|patch> [--dry-run]`.** Con el árbol limpio equivale a `bump_version.dart`; con trabajo pendiente (que `bump_version.dart` no acepta) hace el release en un clon limpio de `HEAD` —pre-commit incluido— y trae commit + tag con `git reset`. Solo publica lo ya commiteado, no lo pendiente, y en tu `pubspec.yaml` solo escribe la línea `version:` (tus otros cambios ahí se respetan). Si `CHANGELOG.md` o `assets/changelog.json` tienen cambios locales, se niega antes de empezar. Ver también el commit con trabajo ajeno en §5.
  - Receta: commitea lo tuyo (§5) → `tool/release.sh patch --dry-run` para ver las notas → `tool/release.sh patch`.
- Permisos de Android: solo los estrictamente necesarios.
- Tamaño de la app vigilado: sin assets ni dependencias sin uso; `flutter build appbundle --analyze-size` en revisiones de release.

---

## 13. Definición de "terminado"

Una tarea **no está terminada** hasta que, sin excepciones:

- [ ] `flutter analyze` → 0 errores, 0 warnings, 0 infos
- [ ] `dart format` sin cambios pendientes
- [ ] `dart run tool/check_file_length.dart` en verde
- [ ] Tests nuevos y existentes pasan; cobertura no baja
- [ ] Cada archivo nuevo/modificado hace **una sola cosa** y está en su capa correcta
- [ ] Funciona sin conexión (si toca datos) y en móvil, tablet y web
- [ ] Probado en `profile` sin jank si toca UI o animación
- [ ] Probado en los flavors afectados
- [ ] Commit pasó el pre-commit **sin saltarlo**

> Ante la duda: más pequeño, más claro, más simple. Si no cumple el stack, no se entrega.
