#!/usr/bin/env bash
# Runs the Firestore security-rules tests (test/rules) against a throwaway
# emulator on its own ports, so it never touches the dev emulator (:8085).
# Needs: firebase-tools and a JDK 21+ (the Firestore emulator).
set -euo pipefail
cd "$(dirname "$0")/.."

if ! command -v java >/dev/null 2>&1 && [[ -x "$HOME/.local/jdk/bin/java" ]]; then
  export PATH="$HOME/.local/jdk/bin:$PATH"
fi
if ! command -v java >/dev/null 2>&1; then
  echo "Missing 'java'. The Firestore emulator needs a JDK 21 or newer." >&2
  exit 1
fi

targets="${*:-test/rules}"
exec firebase emulators:exec --config firebase.rules-test.json --only firestore \
  --project demo-fino-rules "flutter test $targets"
