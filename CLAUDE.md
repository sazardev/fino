# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# Fino

App de finanzas para llevar deudas entre compañeros de trabajo. Flutter, Android
(móvil y tablet) + web; Linux de escritorio solo para desarrollo.

Antes de escribir o modificar código, lee **`STACK.md`** (código, herramientas,
proceso) y **`DESIGN.md`** (UI/UX). Son obligatorios: si una tarea choca con
alguno, detente y pregunta; no rompas la regla.

Lo que más se olvida:

- Un archivo = una responsabilidad. Máx. 500 líneas (objetivo ≤ 200).
  **Excepción en `lib/`:** `test/design_rules_test.dart` falla con archivos de
  más de **150 líneas** (DESIGN.md §10); el tope de 500 de `tool/check_file_length.dart`
  no basta. Partir antes de llegar a 150.
- `flutter analyze` en 0 errores, warnings **e infos**. Nunca `// ignore` sin motivo.
- Nunca saltes el pre-commit (`--no-verify`, `LEFTHOOK=0`…). Arregla la causa.
  Está bloqueado en `.claude/settings.json` y `.claude/hooks/`; no los edites.
- Riverpod con codegen, rutas tipadas con go_router, offline-first con Drift.
- Android + web, responsivo por ancho. 60 FPS medidos en `--profile`.
- Tras cambiar providers, rutas, tablas o modelos: `tool/gen.sh`.
- Antes de dar algo por terminado: `tool/check.sh`.

## Comandos

Todo pasa por los scripts de `tool/` (no comandos sueltos). `<flavor>` = `dev|qa|prod`.

```sh
tool/setup.sh                         # pub get, codegen, hooks de lefthook
tool/emulators.sh                     # emuladores Firebase (Auth :9099, Firestore :8085); necesario para dev
tool/run.sh dev --linux               # también --web; sin flag = Android (--flavor obligatorio, el script lo pone)
tool/build.sh <flavor> <apk|appbundle|web>
tool/gen.sh                           # build_runner (riverpod, freezed, drift, json, go_router)
tool/check.sh                         # lo que exige CI: format, analyze, file length, tests+cobertura
tool/check_generated.sh               # falla si el código generado está desactualizado
tool/test_rules.sh                    # tests de firestore.rules (test/rules) con un emulador desechable
tool/release.sh <major|minor|patch> [--dry-run]   # release: pubspec, CHANGELOG.md, assets/changelog.json, tag (usa bump_version.dart; vale con el árbol sucio)
tool/commit_clean.sh -m "tipo: asunto"   # commit de lo staged con el pre-commit en un clon limpio (trabajo ajeno sin commitear en el árbol)
```

Un solo test: `flutter test test/ruta/archivo_test.dart` (o `--plain-name "texto"`).
Los tests de `test/emulator/` y `integration_test/dev_emulator_flow_test.dart`
(`-d linux`) se saltan solos si los emuladores no corren.

Pre-commit (lefthook) corre format, analyze `--fatal-infos`, file-length y **todo**
`flutter test`; pre-push añade `check_generated.sh` y `check.sh`. Los archivos
`*.g.dart`/`*.freezed.dart` nunca se editan a mano.

Cambio de esquema Drift: subir `schemaVersion`, volcar con
`dart run drift_dev schema dump lib/core/database/app_database.dart drift_schemas/`,
regenerar `test/generated_migrations/` y escribir la migración con su test
(STACK.md §8).

## Arquitectura (visión general)

Feature-first con capas `presentation → domain ← data`; `domain` no importa
Flutter, Drift ni Firebase. **Sin imports entre features**: lo compartido sube a
`core/` o `ui/`. Una clase pública por archivo; prohibidos `utils.dart`,
`helpers.dart`, `manager.dart`; sin `_buildX()` (se parte en widgets).

- `lib/main_{dev,qa,prod}.dart` — solo eligen `Flavor` y llaman `bootstrap()`.
  `lib/bootstrap/` es el único sitio que inicializa servicios (errores → Firebase
  → Drift → notificaciones → `runApp`), un archivo por paso.
- `lib/core/flavor/` — `FlavorConfig` (inyectado por Riverpod) es el único lugar
  con diferencias por flavor; no se usa `kDebugMode` ni se comparan strings de flavor.
  `dev` apunta a emuladores; `qa`/`prod` a proyectos reales (`firebase_options_<flavor>.dart`,
  `prod` se niega a arrancar con placeholders `REPLACE_ME`).
- `lib/core/platform/` — única fuente de verdad de "¿hay plugins de Firebase?"
  (`firebasePluginsSupportedFlagProvider`). Linux no los tiene: Auth va por REST
  al emulador, Analytics/FCM son no-op. Nada fuera de ahí decide por plataforma.
- `lib/core/database/` + `lib/core/sync/` + `features/*/data/` — **Drift es la fuente
  de la verdad**; la UI solo observa streams de Drift. Escribir = guardar local →
  encolar en la tabla **outbox** (`OutboxOperation`, backoff, idempotente) →
  sincronizar a Firestore después. `RemoteWrite` describe una escritura pendiente
  sin depender del SDK; las de una misma acción de negocio comparten `batchId` y
  viajan en un batch atómico. Firestore (`firestore.rules`) es sincronización, no origen de la UI.
- `lib/app/` — composición (`FinoApp`, router, ajustes, shell, splash); es la
  única capa que conoce a todas las demás. Rutas en `app/router/` con
  `go_router_builder`: una definición por archivo en `routes/`, registradas en
  `app_routes.dart`; cada pantalla tiene URL propia, sin `Navigator.push`.
  Guards vía `auth_redirect.dart` + `auth_refresh_listenable.dart`.
- `lib/ui/` — sistema de diseño (copiado de Enfo, M3 Expressive). Dependencias
  solo hacia abajo: `templates → organisms → molecules → atoms → design/responsive/theme`;
  `ui/` y `core/` nunca importan `app/`.
- `lib/features/<f>/` — `auth`, `changelog` (lee `assets/changelog.json`, lo genera
  `bump_version.dart`), `inbox`, `notices`, `orders`, `teams` (los cuatro últimos
  aún solo con `domain`/`data`).

### Reglas de UI que los tests hacen cumplir

`test/design_rules_test.dart` escanea `lib/` y falla ante `AppBar`/`SliverAppBar`/`appBar:`,
`showDialog`/`AlertDialog`, bottom sheets, `InkWell`, `BoxShadow` y `HapticFeedback.`
directo (usa `Haptics.*`). Navegación: barra inferior en compacto, rail en ≥ 600 dp,
decidido por **ancho** (`Responsive.of(context)`), nunca por plataforma. Los
destinos no se repiten como título. Textos de UI en español dentro de los widgets.

### Tests

Cobertura mínima (`tool/check_coverage.dart`): domain y notifiers ≥ 90 %,
repos/DAOs ≥ 80 %, global ≥ 75 %. Drift se prueba en memoria; Firebase se mockea
con `mocktail` tras interfaces; los providers de infraestructura se sobrescriben con
`ProviderScope(overrides: …)`. Los tests de UI cargan Geist real con `FontLoader`
(la fuente por defecto de test genera overflows falsos). Un bug corregido = un test que lo reproduce.
