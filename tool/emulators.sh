#!/usr/bin/env bash
# Starts the Firebase emulators (Auth :9099, Firestore :8085, UI :4000) that
# the dev flavor talks to. Data is kept in .firebase/data between runs.
# Needs: firebase-tools and a JDK 21+ (Firestore emulator).
set -euo pipefail
cd "$(dirname "$0")/.."

if ! command -v firebase >/dev/null 2>&1; then
  echo "Missing 'firebase'. Install: npm i -g firebase-tools" >&2
  exit 1
fi
if ! command -v java >/dev/null 2>&1; then
  echo "Missing 'java'. The Firestore emulator needs a JDK 21 or newer." >&2
  exit 1
fi

args=(emulators:start --project demo-fino-dev --export-on-exit .firebase/data)
if [[ -d .firebase/data ]]; then
  args+=(--import .firebase/data)
fi
exec firebase "${args[@]}" "$@"
