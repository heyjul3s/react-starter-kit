#!/usr/bin/env bash

source "./scripts/bash/utils-scripts.sh"

show_help() {
  show_script_help "run-lint.sh" "Lint wrapper script" "Run all linters" \
    "css:Run CSS linter" \
    "css-fix:Run CSS linter with auto-fix" \
    "fix:Run all linters with auto-fix" \
    "knip:Run Knip unused dependency and export checks" \
    "markup:Run markup linter" \
    "ox:Run custom 'ox' linter" \
    "ox-fix:Run 'ox' linter with auto-fix" \
    "prettier:Run Prettier code formatter" \
    "prettier-fix:Run Prettier with auto-fix (same as prettier)" \
    "sh:Run shell script linter" \
    "stage:Run linters on staged files (lint-staged)" \
    "types:Run TypeScript type checker"
}

COMMAND=${1:-}

if [ $# -gt 0 ]; then
  shift
fi

if [ -z "$COMMAND" ]; then
  echo "Running all linters..."
  make lint LINT_ARGS="$*"
  exit $?
fi

case "$COMMAND" in
  "css")
    make lint-css LINT_FILES="$*"
    ;;
  "css-fix")
    make lint-css-fix LINT_FILES="$*"
    ;;
  "fix")
    make lint-fix LINT_ARGS="$*"
    ;;
  "knip")
    make lint-knip LINT_ARGS="$*"
    ;;
  "markup")
    make lint-markup LINT_FILES="$*"
    ;;
  "ox")
    make lint-ox LINT_FILES="$*"
    ;;
  "ox-fix")
    make lint-ox-fix LINT_FILES="$*"
    ;;
  "prettier")
    make lint-prettier LINT_FILES="$*"
    ;;
  "prettier-fix")
    make lint-prettier-fix LINT_FILES="$*"
    ;;
  "sh")
    make lint-sh LINT_FILES="$*"
    ;;
  "stage")
    make lint-staged LINT_ARGS="$*"
    ;;
  "types")
    make lint-types LINT_ARGS="$*"
    ;;
  "help"|"h"|"--help")
    show_help
    exit 0
    ;;
  *)
    echo "Error: Unknown lint command '$COMMAND'"
    show_help
    exit 1
    ;;
esac  
    

  
