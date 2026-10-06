# Fino

App de finanzas para llevar deudas entre compañeros de trabajo. Flutter, para
Android (móvil y tablet) y web.

Reglas de código y proceso: [`STACK.md`](STACK.md). Reglas de diseño:
[`DESIGN.md`](DESIGN.md).

## Primer arranque

```sh
tool/setup.sh                    # dependencias, código generado, hooks de git
tool/emulators.sh                # Firebase local (Auth, Firestore); déjalo corriendo
tool/run.sh dev --linux          # escritorio;  --web para Chrome;  sin flag, Android
```

`dev` corre contra los emuladores (no necesita proyecto de Firebase): el botón
"Continuar con Google" entra con una cuenta falsa. `tool/emulators.sh` necesita
`firebase-tools` (`npm i -g firebase-tools`) y un JDK 21 o superior.

Para `qa` y `prod` sí hace falta Firebase real:
`tool/configure_firebase.sh qa` (y `prod`). Sin eso `prod` se niega a arrancar.
Linux solo ejecuta `dev`.

## Comandos

| Comando | Qué hace |
| --- | --- |
| `tool/run.sh <dev\|qa\|prod> [--web\|--linux]` | Corre un flavor |
| `tool/emulators.sh` | Levanta los emuladores de Firebase (dev) |
| `tool/build.sh <flavor> <apk\|appbundle\|web>` | Compila un flavor |
| `tool/gen.sh` | Regenera código (Riverpod, rutas, Drift, Freezed) |
| `tool/check.sh` | Formato, analyzer, tamaño de archivos, tests y cobertura |
| `dart run tool/bump_version.dart <major\|minor\|patch> [--dry-run]` | Publica versión: sube `pubspec.yaml`, genera `CHANGELOG.md` desde los commits, commit + tag |
| `tool/update_web_assets.sh` | Descarga el runtime web de Drift |
