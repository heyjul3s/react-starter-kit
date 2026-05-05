#!/usr/bin/env bash

# Shared utility functions for parsing and validating environment modes for scripts like run-dev.sh, run-build.sh, etc.


# Parse and validate env mode with help support
# Usage: parse_environment_mode "$1" "$DEFAULT_MODE" "$SCRIPT_NAME" "$ACTION
# Example: parse_environment_mode "$MODE" "$DEFAULT_MODE" "run-dev.sh" "Start dev server"
# Returns: sets global MODE variable to the parsed mode, or exits with error if invalid
parse_environment_mode() {
  local input_mode="$1"
  local default_mode="$2"
  local script_name="$3"
  local action_desc="$4"

  if [ "$input_mode" = "--help" ] || [ "$input_mode" = "-h" ] || [ "$input_mode" = "help" ]; then
    echo "Usage: ./$script_name [mode] [args...]"
    echo ""
    echo "Available modes:"
    echo "  (no mode)       $action_desc for $default_mode (default)"
    echo ""
    list_available_environments "help"
    echo ""
    echo "Examples:"
    echo "  ./$script_name                  # $action_desc for $default_mode"
    echo "  ./$script_name development      # $action_desc for development"
    echo "  ./$script_name production       # $action_desc for production"
    exit 0
  fi

  # Use default if not specified
  if [ -z "$input_mode" ]; then
    MODE="$default_mode"
    echo "No mode specified, using default $MODE"
  else
    MODE="$input_mode"
  fi

  validate_environment "$MODE" || exit 1
}

# List available environments by looking for .env.* files in the project root
# Usage: list_available_environments "help" or "list"
list_available_environments() {
  local format="$1" #"help" or "list"

  for env_file in .env.*; do
    if [ -f "$env_file" ]; then
      env_name=${env_file#.env.}
      # Skip environments that shouldn't be shown
      case "$env_name" in
        # NOTE: add any environment names here that should be hidden from the list (e.g. secret|secret2|another-secret|)
        secret)
          continue
          ;;
        *)
          if [ "$format" = "help" ]; then
            echo "  $env_name Start dev server for $env_name environment"
          else
            echo "  $env_name"
          fi
          ;;
      esac
    fi
  done
}

# Validate that the provided environment exists by checking for the corresponding .env file
# Usage: validate_environment "development"
# Returns: 0 if valid, 1 if invalid (and prints error message)
validate_environment() {
  local env="$1"

  if [ ! -f ".env.$env" ]; then
    echo "Error: Environment '$env' not found (.env.$env does not exist!)"
    echo "Available environments:"
    list_available_environments "list"
    exit 1
  fi

  return 0
}