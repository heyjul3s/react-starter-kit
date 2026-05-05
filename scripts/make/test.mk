# Test targets
# =======================================================================

.PHONY: test test-bash test-bash-ci test-ci test-report
.PHONY: test-report-ci test-ui test-watch test-storybook

test:
	pnpx vitest run --passWithNoTests

test-bash:
	pnpx bats scripts/*.bats

test-bash-ci:
	pnpx bats scripts/*.bats -- --formatter tap

test-ci:
	pnpx vitest run --passWithNoTests --coverage --reporter=basic

test-report:
	pnpx vitest --coverage --run --reporter junit

test-report-ci:
	pnpx vitest --coverage --reporter=junit --reporter=basic

test-ui:
	pnpx vitest --ui --coverage.enabled --coverage.all --coverage.src='./src' --coverage.reporter='html'

test-watch:
	pnpx vitest --watch

test-storybook:
	pnpx test-storybook
