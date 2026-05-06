# Test targets
# =======================================================================

.PHONY: test test-bash test-bash-ci test-ci test-report
.PHONY: test-report-ci test-ui test-watch test-storybook

test:
	pnpm exec vitest run --passWithNoTests

test-bash:
	pnpm exec bats scripts/*.bats

test-bash-ci:
	pnpm exec bats scripts/*.bats -- --formatter tap

test-ci:
	pnpm exec vitest run --passWithNoTests --coverage --reporter=basic

test-report:
	pnpm exec vitest --coverage --run --reporter junit

test-report-ci:
	pnpm exec vitest --coverage --reporter=junit --reporter=basic

test-ui:
	pnpm exec vitest --ui --coverage.enabled --coverage.all --coverage.src='./src' --coverage.reporter='html'

test-watch:
	pnpm exec vitest --watch

test-storybook:
	pnpm exec test-storybook
