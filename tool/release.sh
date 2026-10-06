#!/usr/bin/env bash
# Cuts a release (version bump, CHANGELOG.md, assets/changelog.json, commit and
# tag) from the commits already made: see tool/bump_version.dart.
#  - --dry-run: just shows what would be released.
#  - Clean working tree: runs bump_version.dart right here.
#  - Pending changes: bump_version.dart refuses to run, so the release is made
#    in a clean clone of HEAD (hooks included) and landed here with
#    `git reset --keep`. Your pending changes are not touched, and are not
#    part of the release. If pubspec.yaml, CHANGELOG.md or
#    assets/changelog.json have local edits it refuses and leaves nothing behind.
# Usage: tool/release.sh <major|minor|patch> [--dry-run]
set -euo pipefail
cd "$(dirname "$0")/.."
source tool/src/clean_clone.sh

part="${1:-}"
flag="${2:-}"
[[ "$part" =~ ^(major|minor|patch)$ && ( -z "$flag" || "$flag" == --dry-run ) ]] ||
  die "usage: tool/release.sh <major|minor|patch> [--dry-run]"

if [[ -n "$flag" || -z "$(git status --porcelain)" ]]; then
  exec dart run tool/bump_version.dart "$part" ${flag:+"$flag"}
fi

echo "Pending changes in the working tree: releasing from a clean clone of HEAD."
clean_clone_open
(cd "$CLONE" && dart run tool/bump_version.dart "$part")
tag="$(git -C "$CLONE" describe --tags --match 'v*' --exact-match HEAD)"

clean_clone_land --keep ||
  die "$tag was made in the clone but can't be applied here: pubspec.yaml," \
    "CHANGELOG.md or assets/changelog.json have local edits. Commit or stash" \
    "them and retry."
git fetch -q "$CLONE" "refs/tags/$tag:refs/tags/$tag"
echo "Released $tag."
