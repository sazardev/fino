#!/usr/bin/env bash
# PreToolUse hook (Bash): blocks any attempt to skip or tamper with git hooks.
# STACK.md §5: the pre-commit is never skipped, by anyone or any agent.
# Reads the tool-call JSON on stdin; exit 2 = block (stderr goes to the agent).
set -euo pipefail

if ! command -v jq >/dev/null 2>&1; then
  echo "Blocked: jq is required by this guard and is not installed." >&2
  exit 2
fi

command="$(jq -r '.tool_input.command // empty')"
[[ -z "$command" ]] && exit 0

# Short-flag check ignores quoted text, so `-m "add -n flag"` is not a bypass.
unquoted="$(sed -E "s/\"[^\"]*\"//g; s/'[^']*'//g" <<<"$command")"
short_flag='git[[:space:]]+([^|;&]*[[:space:]])?(commit|push|merge|rebase|cherry-pick|am)[[:space:]]([^|;&]*[[:space:]])?-[a-zA-Z]*n[a-zA-Z]*([[:space:]]|$)'
if [[ "$unquoted" =~ $short_flag ]]; then
  echo "Blocked: -n skips the git hooks (STACK.md §5)." >&2
  exit 2
fi

patterns=(
  '(^|[[:space:]])--no-verify([[:space:]=]|$)'
  'LEFTHOOK(_EXCLUDE)?[[:space:]]*='
  'HUSKY[[:space:]]*='
  '(^|[[:space:];&|])SKIP[[:space:]]*='
  'core\.hooksPath'
  'lefthook[[:space:]]+uninstall'
  'rm[[:space:]]+.*\.git/hooks'
  '(mv|cp|ln|truncate|chmod)[[:space:]]+.*\.git/hooks'
  '>[[:space:]]*\.git/hooks'
)

for pattern in "${patterns[@]}"; do
  if [[ "$command" =~ $pattern ]]; then
    echo "Blocked: this command bypasses or tampers with the git hooks (STACK.md §5)." >&2
    echo "Fix the cause of the failing check instead of skipping it." >&2
    exit 2
  fi
done
exit 0
