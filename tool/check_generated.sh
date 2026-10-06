#!/usr/bin/env bash
# Fails when build_runner output is stale (regenerating changes any file).
set -euo pipefail
cd "$(dirname "$0")/.."

snapshot() {
  find lib test \( -name '*.g.dart' -o -name '*.freezed.dart' \
    -o -name '*.drift.dart' -o -name '*.gr.dart' \) -print0 2>/dev/null |
    sort -z | xargs -0 -r sha256sum
}

before="$(snapshot)"
tool/gen.sh >/dev/null
after="$(snapshot)"

if [[ "$before" != "$after" ]]; then
  echo "Generated files are out of date: run tool/gen.sh and commit them." >&2
  exit 1
fi
echo "Generated files: up to date."
