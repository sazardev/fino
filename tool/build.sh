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
flutter build "$target" "${args[@]}" "$@"

# Release builds are obfuscated, so Crashlytics needs the Dart symbols to
# deobfuscate stack traces. Non-fatal: a missing or unauthenticated firebase
# CLI must not break the build.
if [[ "$flavor" == "prod" && "$target" != "web" ]]; then
  app_id="$(jq -r \
    '.flutter.platforms.dart["lib/core/firebase/options/firebase_options_prod.dart"].configurations.android' \
    firebase.json)"
  if [[ -n "$app_id" && "$app_id" != "null" ]] && command -v firebase >/dev/null 2>&1; then
    firebase crashlytics:symbols:upload --app="$app_id" build/symbols ||
      echo "warning: Crashlytics symbols were not uploaded." >&2
  else
    echo "warning: no firebase CLI or app id; Crashlytics symbols not uploaded." >&2
  fi
fi
