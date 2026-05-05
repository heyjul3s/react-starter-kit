#!/usr/bin/env bash

source "./scripts/vars-colors.sh"

# if [[ -d "./node_modules" || -f "pnpm-lock.yaml" ]]; then
#   printf "%s\n" "Clearing and pruning"
#   rm -rf node_modules && rm pnpm-lock.yaml && pnpm store prune
# else 
#   printf "%s\n" "No relevant depdendencies or lockfiles found. Aborting."
# fi

LOCKFILE="pnpm-lock.yaml"
NODE_MODULES="node_modules"
PNPM_STORE=".pnpm-store"

if [[ -d "$NODE_MODULES" || -f "$LOCKFILE" ]]; then
  printf "%s\n" "Clearing PNPM artifacts..."
  
  if [[ -d "$NODE_MODULES" ]]; then
    printf "%s\n" " - Removing node_modules..."
    rm -rf "$NODE_MODULES"
  fi

  if [[ -f "$LOCKFILE" ]]; then
    printf "%s\n" " - Removing lockfile..."
    rm "$LOCKFILE"
  fi

  if [[ -d "$PNPM_STORE" ]]; then
    printf "%s\n" " - Removing local PNPM store..."
    rm -rf "$PNPM_STORE"
  fi

  printf "%s\n" " - Pruning global PNPM store..."
  pnpm store prune

  printf "%s\n" " ✅ Clean successful."
else 
  printf "%s\n" "No relevant depdendencies or lockfiles found. Skipping."
fi