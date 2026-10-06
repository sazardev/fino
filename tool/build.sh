#!/usr/bin/env bash
# Usage: tool/build.sh <dev|qa|prod> <apk|appbundle|web> [extra flutter args]
set -euo pipefail
cd "$(dirname "$0")/.."
source tool/src/validate_flavor.sh

flavor="${1:-}"
target="${2:-}"
validate_flavor "$flavor"
case "$target" in
  apk | appbundle | web) ;;
  *)
    echo "Target must be one of: apk | appbundle | web (got '$target')" >&2
    exit 64
    ;;
esac
shift 2

args=(-t "lib/main_${flavor}.dart")
[[ "$target" != "web" ]] && args+=(--flavor "$flavor")
if [[ "$flavor" == "prod" ]]; then
  mkdir -p build/symbols
  [[ "$target" != "web" ]] && args+=(--obfuscate --split-debug-info=build/symbols)
  args+=(--release)
fi
exec flutter build "$target" "${args[@]}" "$@"
