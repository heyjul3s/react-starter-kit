#!/usr/bin/env bash

# Wrapper script to run build commands and pass through CLI
# Usage: ./scripts/run-build.sh [mode] [additional args]

source "./scripts/env-utils.sh"

parse_environment_mode "$1" "dev" "run-build.sh" "Build"

# Remove the first argument (mode) so that $@ now contains only additional arguments
shift 

# Start dev server based on provided environment
make build-$MODE "$@"

# Return exit code from dev command
exit $?

