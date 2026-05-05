#!/usr/bin/env bash

# Exit on any error
set -e 

# Source NVM to ensure we're using the correct Node version
/bin/bash ./scripts/nvm-use.sh

# Guard clause to check if any packages were provided
if [ $# -eq 0]; then
  echo "Error: No packages specified"
  echo "Usage: ./pnpm-add.sh PACKAGE [PACKAGE2 ...] [FLAGS]"
  echo "Example: ./pnpm-add.sh react es-toolkit"
  echo "Example: ./pnpm-add.sh @types/react -D"
  exit 1
fi

# Otherwise, we proceed
echo "Installing packages: $*"
pnpm add "$@"

echo " ✅ Successfully installed: $*"