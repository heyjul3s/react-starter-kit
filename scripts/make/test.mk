# Test targets
# =======================================================================

.PHONY: test test-bash test-bash-ci test-ci test-report
.PHONY: test-report-ci test-ui test-watch test-storybook

test:
	source ./scripts/bash/nvm-use.sh && pnpm exec vitest run --passWithNoTests

test-bash:
	source ./scripts/bash/nvm-use.sh && pnpm exec bats scripts/bash/*.bats

test-bash-ci:
	source ./scripts/bash/nvm-use.sh && pnpm exec bats scripts/bash/*.bats -- --formatter tap

test-ci:
	source ./scripts/bash/nvm-use.sh && pnpm exec vitest run --passWithNoTests --coverage --reporter=basic

test-report:
	source ./scripts/bash/nvm-use.sh && pnpm exec vitest --coverage --run --reporter junit

test-report-ci:
	source ./scripts/bash/nvm-use.sh && pnpm exec vitest --coverage --reporter=junit --reporter=basic

test-ui:
	source ./scripts/bash/nvm-use.sh && pnpm exec vitest --ui --coverage.enabled --coverage.all --coverage.src='./src' --coverage.reporter='html'

test-watch:
	source ./scripts/bash/nvm-use.sh && pnpm exec vitest --watch

test-storybook:
	source ./scripts/bash/nvm-use.sh && pnpm exec test-storybook
