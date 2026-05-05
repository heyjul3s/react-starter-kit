# Lint targets
# =======================================================================

.PHONY: lint lint-ci lint-fix lint-css lint-css-fix lintox lint-ox-fix
.PHONY: lint-types lint-prettier lint-prettier-fix
.PHONY: lint-markup lint-sh lint-staged

# Capture additional arguments for lint commands
LINT_ARGS ?=

lint:
	@echo "Running all linters..."
	$(MAKE) lint-types LINT_ARGS="$(LINT_ARGS)"
	$(MAKE) lint-ox LINT_ARGS="$(LINT_ARGS)"
	$(MAKE) lint-css LINT_ARGS="$(LINT_ARGS)"
	$(MAKE) lint-prettier LINT_ARGS="$(LINT_ARGS)"

lint-ci: 
	@echo "Running all linters in parallel..."
	@set -e; \
	$(MAKE) lint-ox & pid1=$$!; \
	$(MAKE) lint-css LINT_ARGS="--cache --cache-location .stylelintcache" & pid2=$$!; \
	$(MAKE) lint-prettier LINT_ARGS="--cache --cache-location .prettiercache" & pid3=$$!; \
	fail=0; \
	wait $$pid1 || fail=1; \
	wait $$pid2 || fail=1; \
	wait $$pid3 || fail=1; \
	exit $$fail

lint-css:
	@echo "Running CSS linting..."
	pnpx stylelint "src/**/*.{module.css,css}" --config ./config/lint/stylelint.config.ts $(LINT_ARGS)

lint-css-fix:
	@echo "Running CSS lint fixes..."
	pnpx stylelint "src/**/*.{module.css,css}" --config ./config/lint/stylelint.config.ts --fix $(LINT_ARGS)

lint-fix:
	@echo "Running all lint fixes..."
	$(MAKE) lint-ox LINT_ARGS="$(LINT_ARGS)"
	$(MAKE) lint-css LINT_ARGS="$(LINT_ARGS)"
	$(MAKE) lint-prettier LINT_ARGS="$(LINT_ARGS)"

lint-markup:
	@echo "Running Markup linting..."
	pnpx markuplint --config ./config/lint/markuplint.config.ts "src/**/*.{html,jsx,tsx}" $(LINT_ARGS)

lint-ox:
	@echo "Running Oxlint..."
	pnpx oxlint --config ./config/lint/oxlint.config.ts ./src ./scripts --deny-warnings $(LINT_ARGS)

lint-ox-fix:
	@echo "Running Oxlint fixes..."
	pnpx oxlint --config ./config/lint/oxlint.config.ts ./src ./scripts --deny-warnings --fix $(LINT_ARGS)

lint-prettier:
	@echo "Running Prettier linting..."
	pnpx prettier --config ./config/lint/prettier.config.ts --check "src/**/*.{ts,tsx,js,jsx,json,css,md}" --quiet $(LINT_ARGS)

lint-prettier-fix:
	@echo "Running Prettier fixes..."
	pnpx prettier --config ./config/lint/prettier.config.ts --write "src/**/*.{ts,tsx,js,jsx,json,css,md}" --quiet $(LINT_ARGS)
	
lint-sh:
	@echo "Running Shell script linting..."
	pnpx shellcheck ./scripts/**/*.sh $(LINT_ARGS)

lint-staged:
	@echo "Running lint-staged for staged files..."
	pnpx lint-staged --config ./config/lint/lint-staged.config.ts $(LINT_ARGS)