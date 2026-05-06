#!/usr/bin/env bash

source "./scripts/bash/utils-scripts.sh"

show_help() {
  show_script_help "run-deps.sh" "Dependency check wrapper script" "Run all dependency checks" \
    "deps:Run dependency checks" \
    "circular:Check for circular dependencies" \
    "graph:Generate dependency graph" \
    "orphans:Check for orphaned dependencies"
}

COMMAND=$1
shift # Remove the first argument (command)

# If no specific command is provided, run the default deps check
if [ -z "$COMMAND" ]; then
  echo "Running deps check..."
  make deps "$@"
  exit $?
fi

case "$COMMAND" in
  "deps")
    make deps "$@"
    ;;
  "circular")
    make deps-circular "$@"
    ;;
  "graph")
    make deps-graph "$@"
    ;;
  "orphans")
    make deps-orphans "$@"
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
