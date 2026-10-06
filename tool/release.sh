#!/usr/bin/env bash
# Cuts a release (version bump, CHANGELOG.md, assets/changelog.json, commit and
# tag) from the commits already made: see tool/bump_version.dart.
#  - --dry-run: just shows what would be released.
#  - Clean working tree: runs bump_version.dart right here.
#  - Pending changes: bump_version.dart refuses to run, so the release is made
#    in a clean clone of HEAD (hooks included) and landed here. Pending changes
#    are not part of the release and are not touched; the only thing written
#    into pubspec.yaml is its `version:` line. If CHANGELOG.md or
#    assets/changelog.json have local edits it refuses before starting.
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

generated=(CHANGELOG.md assets/changelog.json)
[[ -z "$(git status --porcelain -- "${generated[@]}")" ]] ||
  die "${generated[*]} have local edits; commit or stash them and retry"

echo "Pending changes in the working tree: releasing from a clean clone of HEAD."
clean_clone_open
(cd "$CLONE" && dart run tool/bump_version.dart "$part")
tag="$(git -C "$CLONE" describe --tags --match 'v*' --exact-match HEAD)"
version_line="$(grep -m1 '^version:' "$CLONE/pubspec.yaml")"
pubspec_edited="$(git status --porcelain -- pubspec.yaml)"

# --mixed moves the branch and index and leaves the files as they were; then
# bring over only what the release changed.
clean_clone_land --mixed
git checkout -q -- "${generated[@]}"
if [[ -n "$pubspec_edited" ]]; then
  sed -i "s|^version:.*|$version_line|" pubspec.yaml
else
  git checkout -q -- pubspec.yaml
fi
git fetch -q "$CLONE" "refs/tags/$tag:refs/tags/$tag"
echo "Released $tag."
