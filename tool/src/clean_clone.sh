# Shared by tool/commit_clean.sh and tool/release.sh (sourced, not run).
#
# Pre-commit hooks run on the whole working tree, so unrelated work in
# progress can fail a commit that is fine on its own. These helpers do the git
# work in a throwaway clone of HEAD instead: the hooks (never skipped) run on
# exactly what ends up committed, and the working tree here is not touched.
#
# A `git worktree` is not an option: inside a worktree hook Flutter loses its
# SDK version and `pub get` fails.

die() {
  echo "error: $*" >&2
  exit 1
}

# Sets ROOT, BASE (HEAD at start), WORK (temp dir) and CLONE.
clean_clone_open() {
  ROOT="$(git rev-parse --show-toplevel)"
  BASE="$(git -C "$ROOT" rev-parse HEAD)"
  WORK="$(mktemp -d)"
  CLONE="$WORK/repo"
  trap 'rm -rf "$WORK"' EXIT

  command -v lefthook >/dev/null || die "lefthook is required (tool/setup.sh)"
  git clone -q --no-hardlinks "$ROOT" "$CLONE"
  git -C "$CLONE" checkout -q --detach "$BASE"
  (cd "$CLONE" && flutter pub get >/dev/null && lefthook install >/dev/null)
}

# Moves the current branch here to the clone's HEAD. $1 is the `git reset`
# mode: --mixed leaves every file as it is on disk; --keep also writes the
# files the new commits changed, and refuses if any of them has local edits.
clean_clone_land() {
  [[ "$(git -C "$ROOT" rev-parse HEAD)" == "$BASE" ]] ||
    die "HEAD moved while working in the clone; nothing was changed here"
  git -C "$ROOT" fetch -q "$CLONE" HEAD
  git -C "$ROOT" reset -q "$1" FETCH_HEAD
}
