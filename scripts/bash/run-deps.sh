#!/usr/bin/env bash

source "./scripts/bash/utils-scripts.sh"

source "./scripts/bash/nvm-use.sh"

show_help() {
  show_script_help "run-deps.sh" "Dependency check wrapper script" "Run all dependency checks" \
    "deps:Run dependency checks" \
    "circular:Check for circular dependencies" \
    "graph:Generate dependency graph" \
    "orphans:Check for orphaned dependencies"
}

COMMAND=${1:-}

if [ $# -gt 0 ]; then
  shift
fi

# If no specific command is provided, run the default deps check
if [ -z "$COMMAND" ]; then
  echo "Running deps check..."
  make deps DEPS_ARGS="$*"
  exit $?
fi

case "$COMMAND" in
  "deps")
    make deps DEPS_ARGS="$*"
    ;;
  "circular")
    make deps-circular DEPS_ARGS="$*"
    ;;
  "graph")
    make deps-graph DEPS_ARGS="$*"
    ;;
  "orphans")
    make deps-orphans DEPS_ARGS="$*"
    ;;
  "help"|"h"|"--help")
    show_help
    exit 0
    ;;
  *)
    echo "Unknown deps command '$COMMAND'"
    echo ""
    show_help
    exit 1
    ;;
esac
