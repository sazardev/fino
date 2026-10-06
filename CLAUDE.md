# Fino

Antes de escribir o modificar código, lee **`STACK.md`** (código, herramientas,
proceso) y **`DESIGN.md`** (UI/UX). Son obligatorios: si una tarea choca con
alguno, detente y pregunta; no rompas la regla.

Lo que más se olvida:

- Un archivo = una responsabilidad. Máx. 500 líneas (objetivo ≤ 200).
- `flutter analyze` en 0 errores, warnings **e infos**. Nunca `// ignore` sin motivo.
- Nunca saltes el pre-commit (`--no-verify`, `LEFTHOOK=0`…). Arregla la causa.
- Riverpod con codegen, rutas tipadas con go_router, offline-first con Drift.
- Android + web, responsivo por ancho. 60 FPS medidos en `--profile`.
- Tras cambiar providers, rutas, tablas o modelos: `tool/gen.sh`.
- Antes de dar algo por terminado: `tool/check.sh`.
