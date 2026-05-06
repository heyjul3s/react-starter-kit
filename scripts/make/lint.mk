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
	pnpm exec stylelint "src/**/*.{module.css,css}" $(LINT_ARGS)

lint-css-fix:
	@echo "Running CSS lint fixes..."
	pnpm exec stylelint "src/**/*.{module.css,css}" --fix $(LINT_ARGS)

lint-fix:
	@echo "Running all lint fixes..."
	$(MAKE) lint-ox-fix LINT_ARGS="$(LINT_ARGS)"
	$(MAKE) lint-css-fix LINT_ARGS="$(LINT_ARGS)"
	$(MAKE) lint-prettier-fix LINT_ARGS="$(LINT_ARGS)"

lint-markup:
	@echo "Running Markup linting..."
	pnpm exec markuplint  "src/**/*.{html,jsx,tsx}" $(LINT_ARGS)

lint-ox:
	@echo "Running Oxlint..."
	pnpm exec oxlint ./src ./scripts --deny-warnings $(LINT_ARGS)

lint-ox-fix:
	@echo "Running Oxlint fixes..."
	pnpm exec oxlint ./src ./scripts --deny-warnings --fix $(LINT_ARGS)

lint-prettier:
	@echo "Running Prettier linting..."
	pnpm exec prettier --check "src/**/*.{ts,tsx,js,jsx,json,css,md}" $(LINT_ARGS)

lint-prettier-fix:
	@echo "Running Prettier fixes..."
	pnpm exec prettier --write "src/**/*.{ts,tsx,js,jsx,json,css,md}" $(LINT_ARGS)

lint-types:
	@echo "Running TypeScript type checking..."
	pnpm exec tsc --noEmit $(LINT_ARGS)
	
lint-sh:
	@echo "Running Shell script linting..."
	pnpm exec shellcheck ./scripts/**/*.sh $(LINT_ARGS)

lint-staged:
	@echo "Running lint-staged for staged files..."
	pnpm exec lint-staged $(LINT_ARGS)
