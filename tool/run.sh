#!/usr/bin/env bash
# Usage: tool/run.sh <dev|qa|prod> [--web|--linux] [extra flutter args]
# Android is the default. --linux runs the desktop build and only works for
# dev: Linux has no Firebase plugins, so it talks to the emulators.
set -euo pipefail
cd "$(dirname "$0")/.."
source tool/src/validate_flavor.sh

flavor="${1:-}"
validate_flavor "$flavor"
shift

case "${1:-}" in
  --web)
    shift
    exec flutter run -d chrome -t "lib/main_${flavor}.dart" "$@"
    ;;
  --linux)
    shift
    if [[ "$flavor" != "dev" ]]; then
      echo "Linux only runs the dev flavor (it needs the Firebase emulators)." >&2
      exit 64
    fi
    exec flutter run -d linux -t "lib/main_${flavor}.dart" "$@"
    ;;
esac
exec flutter run --flavor "$flavor" -t "lib/main_${flavor}.dart" "$@"
