#!/usr/bin/env bash
# Regenerates all build_runner output (riverpod, freezed, drift, json, router).
set -euo pipefail
cd "$(dirname "$0")/.."

dart run build_runner build --delete-conflicting-outputs
