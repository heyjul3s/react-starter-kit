#!/usr/bin/env bash

# Wrapper script to run dev commands and pass through CLI args
# Usage: ./scripts/run-dev.sh [mode] [additional args]

source "./scripts/env-utils.sh"

parse_environment_mode "$1" "dev" "run-dev.sh" "Start dev server"

# Remove the first argument (mode) so that $@ now contains only additional arguments
shift 

# Start dev server based on provided environment
make dev-$MODE "$@"

# Return exit code from dev command
exit $?

