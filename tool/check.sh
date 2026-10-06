#!/usr/bin/env bash
# Full quality gate on the whole project: what the pre-commit/CI enforce.
set -euo pipefail
cd "$(dirname "$0")/.."

dart format --output=none --set-exit-if-changed .
flutter analyze --fatal-infos --fatal-warnings
dart run tool/check_file_length.dart
flutter test --coverage
dart run tool/check_coverage.dart
echo "All checks passed."
