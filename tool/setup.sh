#!/usr/bin/env bash
# One-time (and idempotent) project setup: deps, generated code, git hooks.
set -euo pipefail
cd "$(dirname "$0")/.."

flutter pub get
tool/gen.sh

if ! command -v lefthook >/dev/null 2>&1; then
  echo "lefthook is required: https://lefthook.dev/installation/" >&2
  exit 1
fi
lefthook install

for hook in pre-commit pre-push; do
  if ! grep -q lefthook ".git/hooks/$hook" 2>/dev/null; then
    echo "Git hook '$hook' is not installed." >&2
    exit 1
  fi
done
echo "Setup complete: dependencies, generated code and git hooks are ready."
