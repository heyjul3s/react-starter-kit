#!/usr/bin/env bash

source "./scripts/utils-scripts.sh"

show_help() {
  show_script_help "run-lint.sh" "Lint wrapper script" "Run all linters" \
    "css:Run CSS linter" \
    "css-fix:Run CSS linter with auto-fix" \
    "fix:Run all linters with auto-fix" \
    "markup:Run markup linter" \
    "ox:Run custom 'ox' linter" \
    "ox-fix:Run 'ox' linter with auto-fix" \
    "prettier:Run Prettier code formatter" \
    "prettier-fix:Run Prettier with auto-fix (same as prettier)" \
    "sh:Run shell script linter" \
    "stage:Run linters on staged files (lint-staged)" \
    "types:Run TypeScript type checker"
}

COMMAND=$!
shift

if [ -z "$COMMAND" ]; then
  echo "Running all linters..."
  make lint "$@"
  exit $?
fi

case "$COMMAND" in
  "css")
    make lint-css "$@"
    ;;
  "css-fix")
    make lint-css-fix "$@"
    ;;
  "fix")
    make lint-fix "$@"
    ;;
  "markup")
    make lint-markup "$@"
    ;;
  "ox")
    make lint-ox "$@"
    ;;
  "ox-fix")
    make lint-ox-fix "$@"
    ;;
  "prettier")
    make lint-prettier "$@"
    ;;
  "prettier-fix")
    make lint-prettier-fix "$@"
    ;;
  "sh")
    make lint-sh "$@"
    ;;
  "stage")
    make lint-staged "$@"
    ;;
  "types")
    make lint-types "$@"
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
    

  