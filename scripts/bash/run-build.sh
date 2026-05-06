#!/usr/bin/env bash

# Wrapper script to run build commands and pass through CLI
# Usage: ./scripts/run-build.sh [mode] [additional args]

source "./scripts/bash/utils-env.sh"

parse_environment_mode "$1" "develop" "run-build.sh" "Build"

# Remove the first argument (mode) so that $@ now contains only additional arguments
shift 

# Start dev server based on provided environment
make build-$MODE "$@"

# Return exit code from dev command
exit $?
