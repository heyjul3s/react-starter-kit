#!/usr/bin/env bash

# Exit on any error
set -e 

# Source NVM to ensure we're using the correct Node version
source "./scripts/bash/nvm-use.sh"

# Guard clause to check if any packages were provided
if [ $# -eq 0 ]; then
  echo "Error: No packages specified"
  echo "Usage: ./pnpm-del.sh PACKAGE [PACKAGE2 ...]"
  echo "Example: ./pnpm-del.sh react es-toolkit"
  exit 1
fi

# Otherwise, we proceed
echo "Removing packages: $*"
pnpm remove "$@"

echo " ✅ Successfully removed: $*"
