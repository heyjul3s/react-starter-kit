#!/usr/bin/env bash

source "./scripts/bash/utils-scripts.sh"

source "./scripts/bash/nvm-use.sh"

show_help() {
  show_script_help "run-test.sh" "Test wrapper script" "Run all tests" \
    "bash:Run bash tests" \
    "bash-ci:Run bash tests in CI environment" \
    "report:Generate test report" \
    "report-ci:Generate test report for CI environment" \
    "ui:Run UI tests" \
    "watch:Run tests in watch mode" \
    "storybook:Run Storybook tests"
}

COMMAND=$1
shift # Remove the first argument (command)

if [ -z "$COMMAND" ]; then
  make test "$@"
  exit $?
fi

case "$COMMAND" in
  "bash")
    make test-bash "$@"
    ;;
  "bash-ci")
    make test-bash-ci "$@"
    ;;
  "report")
    make test-report "$@"
    ;;
  "report-ci")
    make test-report-ci "$@"
    ;;
  "ui")
    make test-ui "$@"
    ;;
  "watch")
    make test-watch "$@"
    ;;
  "storybook")
    make test-storybook "$@"
    ;;
  "help"|"h"|"--help")
    show_help
    exit 0
    ;;
  *)
    echo "Error: Unknown test command '$COMMAND'"
    show_help
    exit 1
    ;;
esac
