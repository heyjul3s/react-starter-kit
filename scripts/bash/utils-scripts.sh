#!/usr/bin/env bash

# Shared utilities for run-*.sh wrapper scripts
# Source this file for usage: source "./scripts/utils-scripts.sh"

# Display help for wrapper scripts (run-dev.sh, run-lint.sh, run-deps.sh, run-test.sh, etc.)
#  Usage: show_script_help "script-name" "Description of the script" "Default action description" \
#          "command1:Description of command1" \
#          "command2:Description of command2" \
#          ...
# Commands: format: "command:description" pairs as per usage above
show_script_help() {
  local script_name="$1"
  local description="$2"
  local default_action="$3"
  shift 3

  echo "$description"
  echo "Usage: ./$script_name [command] [args...]"
  echo ""
  echo "Available commands:"
  echo "  (no command)   - $default_action"

  for cmd in "$@"; do
    local command="${cmd%%:*}"
    local desc="${cmd#*:}"
    printf "  %-15s - %s\n" "$command" "$desc"
  done

  echo ""
  echo "Examples:"
  echo "  ./$script_name                 # $default_action"
  if [ $# -gt 0 ]; then
    local first_cmd="${1%%:*}"
    local first_desc="${1#*:}"
    echo "  ./$script_name ${first_cmd}         # ${first_desc}"
  fi
}