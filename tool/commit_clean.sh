#!/usr/bin/env bash
# Commits what is staged, running the pre-commit hook on a clean clone of HEAD
# plus only that staged change: unrelated work in progress in the working tree
# can't fail it. The hook still runs in full; there is no way around it here.
# Files on disk are left as they are; the staged files end up committed.
# Usage: tool/commit_clean.sh <git commit args>   e.g. -m "feat: ..." / -F msg
set -euo pipefail
cd "$(dirname "$0")/.."
source tool/src/clean_clone.sh

(($#)) || die "usage: tool/commit_clean.sh -m <message> | -F <file>"
git diff --cached --quiet && die "nothing is staged"

clean_clone_open
git diff --cached --binary >"$WORK/staged.patch"
git -C "$CLONE" apply --index "$WORK/staged.patch"
git -C "$CLONE" commit "$@"
clean_clone_land --mixed
git log --oneline -1
