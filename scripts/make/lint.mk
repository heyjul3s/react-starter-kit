# Lint targets
# =======================================================================

.PHONY: lint lint-ci lint-fix lint-css lint-css-fix lintox lint-ox-fix
.PHONY: lint-types lint-prettier lint-prettier-fix
.PHONY: lint-knip lint-markup lint-sh lint-staged

# Capture additional arguments for lint commands
LINT_ARGS ?=
LINT_FILES ?=
CSS_FILES := "src/**/*.{module.css,css}"
MARKUP_FILES := "src/**/*.{html,jsx,tsx}"
OX_FILES := ./src ./scripts
PRETTIER_FILES := "src/**/*.{ts,tsx,js,jsx,json,css,md}"
SHELL_FILES := ./scripts/**/*.sh

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
	source ./scripts/bash/nvm-use.sh && pnpm exec stylelint $(if $(LINT_FILES),$(LINT_FILES),$(CSS_FILES)) $(LINT_ARGS)

lint-css-fix:
	@echo "Running CSS lint fixes..."
	source ./scripts/bash/nvm-use.sh && pnpm exec stylelint $(if $(LINT_FILES),$(LINT_FILES),$(CSS_FILES)) --fix $(LINT_ARGS)

lint-fix:
	@echo "Running all lint fixes..."
	$(MAKE) lint-ox-fix LINT_ARGS="$(LINT_ARGS)"
	$(MAKE) lint-css-fix LINT_ARGS="$(LINT_ARGS)"
	$(MAKE) lint-prettier-fix LINT_ARGS="$(LINT_ARGS)"

lint-knip:
	@echo "Running Knip..."
	source ./scripts/bash/nvm-use.sh && pnpm exec knip --reporter compact --no-config-hints $(LINT_ARGS)

lint-markup:
	@echo "Running Markup linting..."
	source ./scripts/bash/nvm-use.sh && pnpm exec markuplint $(if $(LINT_FILES),$(LINT_FILES),$(MARKUP_FILES)) $(LINT_ARGS)

lint-ox:
	@echo "Running Oxlint..."
	source ./scripts/bash/nvm-use.sh && pnpm exec oxlint $(if $(LINT_FILES),$(LINT_FILES),$(OX_FILES)) --deny-warnings $(LINT_ARGS)

lint-ox-fix:
	@echo "Running Oxlint fixes..."
	source ./scripts/bash/nvm-use.sh && pnpm exec oxlint $(if $(LINT_FILES),$(LINT_FILES),$(OX_FILES)) --deny-warnings --fix $(LINT_ARGS)

lint-prettier:
	@echo "Running Prettier linting..."
	source ./scripts/bash/nvm-use.sh && pnpm exec prettier --check $(if $(LINT_FILES),$(LINT_FILES),$(PRETTIER_FILES)) $(LINT_ARGS)

lint-prettier-fix:
	@echo "Running Prettier fixes..."
	source ./scripts/bash/nvm-use.sh && pnpm exec prettier --write $(if $(LINT_FILES),$(LINT_FILES),$(PRETTIER_FILES)) $(LINT_ARGS)

lint-types:
	@echo "Running TypeScript type checking..."
	source ./scripts/bash/nvm-use.sh && pnpm exec tsc --noEmit $(LINT_ARGS)
	
lint-sh:
	@echo "Running Shell script linting..."
	source ./scripts/bash/nvm-use.sh && pnpm exec shellcheck $(if $(LINT_FILES),$(LINT_FILES),$(SHELL_FILES)) $(LINT_ARGS)

lint-staged:
	@echo "Running lint-staged for staged files..."
	source ./scripts/bash/nvm-use.sh && pnpm exec lint-staged $(LINT_ARGS)
