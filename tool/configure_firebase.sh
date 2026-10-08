#!/usr/bin/env bash
# Usage: tool/configure_firebase.sh <qa|prod>
# Generates lib/core/firebase/options/firebase_options_<flavor>.dart with the
# FlutterFire CLI, for the flavor's project in .firebaserc (Android + web).
set -euo pipefail
cd "$(dirname "$0")/.."
source tool/src/validate_flavor.sh

flavor="${1:-}"
validate_flavor "$flavor"
if [[ "$flavor" == "dev" ]]; then
  echo "dev runs against the local emulators and needs no Firebase project (see tool/emulators.sh)." >&2
  exit 64
fi

for cmd in firebase flutterfire; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Missing '$cmd'. Install: npm i -g firebase-tools && dart pub global activate flutterfire_cli" >&2
    exit 1
  fi
done

base_id="$(sed -n 's/^val baseApplicationId = "\(.*\)"/\1/p' android/app/build.gradle.kts)"
case "$flavor" in
  prod) package="$base_id" ;;
  *) package="$base_id.$flavor" ;;
esac

project="$(jq -r ".projects[\"$flavor\"]" .firebaserc)"

flutterfire configure \
  --project="$project" \
  --out="lib/core/firebase/options/firebase_options_${flavor}.dart" \
  --platforms=android,web \
  --android-package-name="$package" \
  --yes

# FlutterFire patches Gradle to apply the google-services plugin and writes
# android/app/google-services.json. This project initializes Firebase from Dart
# (see STACK.md §3), so both are unwanted: one json cannot cover the three
# flavor packages. Undo them.
sed -i '/START: FlutterFire Configuration/,/END: FlutterFire Configuration/d' \
  android/app/build.gradle.kts android/settings.gradle.kts
rm -f android/app/google-services.json

cat <<MSG

Done. Two manual steps remain for '$flavor':
  1. Firebase console → Authentication → enable Google, and copy the *web*
     client id into googleServerClientId in
     lib/core/flavor/configs/${flavor}_flavor_config.dart
  2. Firebase console → Project settings → add this app's SHA-1 / SHA-256
     (debug: 'cd android && ./gradlew signingReport').
MSG
