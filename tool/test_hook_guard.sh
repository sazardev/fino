#!/usr/bin/env bash
# Feeds sample tool-call payloads to the guard; prints "<exit> <- <command>".
guard="$(dirname "$0")/../.claude/hooks/block-hook-bypass.sh"
t() {
  printf '{"tool_name":"Bash","tool_input":{"command":%s}}' \
    "$(python3 -c 'import json,sys;print(json.dumps(sys.argv[1]))' "$1")" |
    "$guard" 2>/dev/null
  echo "$? <- $1"
}
while IFS= read -r c; do t "$c"; done <<'CASES'
git commit --no-verify -m x
git commit -n -m x
git commit -nm x
git commit -m "x" -n
git push --no-verify
LEFTHOOK=0 git commit
HUSKY=0 git commit
SKIP=a git commit
git config core.hooksPath x
lefthook uninstall
rm -rf .git/hooks
git commit -m "fix: add -n flag"
git commit -am "x"
git log -n 5
git status
flutter test -n foo
CASES
