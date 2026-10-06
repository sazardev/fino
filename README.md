# Fino

App de finanzas para llevar deudas entre compañeros de trabajo. Flutter, para
Android (móvil y tablet) y web.

Reglas de código y proceso: [`STACK.md`](STACK.md). Reglas de diseño:
[`DESIGN.md`](DESIGN.md).

## Primer arranque

```sh
tool/setup.sh                    # dependencias, código generado, hooks de git
tool/configure_firebase.sh dev   # Firebase del flavor (también qa y prod)
tool/run.sh dev                  # Android;  tool/run.sh dev --web  para web
```

Sin `configure_firebase.sh` la app arranca en dev/qa, pero el inicio de sesión
con Google no funciona (y las pantallas están detrás del login); `prod` se
niega a arrancar.

## Comandos

| Comando | Qué hace |
| --- | --- |
| `tool/run.sh <dev\|qa\|prod> [--web]` | Corre un flavor |
| `tool/build.sh <flavor> <apk\|appbundle\|web>` | Compila un flavor |
| `tool/gen.sh` | Regenera código (Riverpod, rutas, Drift, Freezed) |
| `tool/check.sh` | Formato, analyzer, tamaño de archivos, tests y cobertura |
| `tool/update_web_assets.sh` | Descarga el runtime web de Drift |
