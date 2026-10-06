#!/usr/bin/env bash
# Sourced by run.sh / build.sh: aborts unless $1 is dev, qa or prod.
validate_flavor() {
  case "${1:-}" in
    dev | qa | prod) ;;
    *)
      echo "Flavor must be one of: dev | qa | prod (got '${1:-}')" >&2
      exit 64
      ;;
  esac
}
