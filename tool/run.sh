#!/usr/bin/env bash
# Usage: tool/run.sh <dev|qa|prod> [--web] [extra flutter args]
set -euo pipefail
cd "$(dirname "$0")/.."
source tool/src/validate_flavor.sh

flavor="${1:-}"
validate_flavor "$flavor"
shift

if [[ "${1:-}" == "--web" ]]; then
  shift
  exec flutter run -d chrome -t "lib/main_${flavor}.dart" "$@"
fi
exec flutter run --flavor "$flavor" -t "lib/main_${flavor}.dart" "$@"
