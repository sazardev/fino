#!/usr/bin/env bash
# Builds the web app (prod) and deploys it to Firebase Hosting
# (site `fino-sazarcode`; project from .firebaserc).
set -euo pipefail
cd "$(dirname "$0")/.."

tool/build.sh prod web

project="$(jq -r '.projects.prod' .firebaserc)"
firebase deploy --only hosting --project "$project"
