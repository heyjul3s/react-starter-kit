# Build Targets
# =======================================================================

.PHONY: deps deps-circular deps-graph deps-orphans

DEPS_ARGS ?=

# NOTE: Adding "|| true" to the Madge targets because it exits non-zero when it
# finds circular or orphaned dependencies. This is done to prevent it from failing
# the command (think of this as preventing it from throwing) if circular dependencies, etc. 
# are found and have it still print findings and finally, exit succesfully.

deps:
	@echo "Checking for dependency hygiene..."
	source ./scripts/bash/nvm-use.sh && pnpm exec knip --reporter compact --no-config-hints $(DEPS_ARGS)

deps-circular:
	@echo "Checking for circular dependencies..."
	source ./scripts/bash/nvm-use.sh && pnpm exec madge --circular --extensions ts,tsx src/ $(DEPS_ARGS) || true

deps-graph:
	@echo "Generating dependency graph..."
	source ./scripts/bash/nvm-use.sh && pnpm exec skott $(DEPS_ARGS)

deps-orphans:
	@echo "Checking for orphaned dependencies..."
	source ./scripts/bash/nvm-use.sh && pnpm exec madge --orphans --exclude '(\.test\.tsx?$$|\.spec\.tsx?$$|\.storybook)' --extensions ts,tsx src/ $(DEPS_ARGS) || true
