# Build Targets
# =======================================================================

.PHONY: deps deps-circular deps-graph deps-orphans

DEPS_ARGS ?=

# NOTE: Adding "|| true" at the end of the cmd as madge tool exists with a non-zero
# status code when it finds circular dependencies. Similar for depcheck

deps:
	@echo "Checking for dependency issues..."
	pnpm dlx depcheck $(DEPS_ARGS) || true

deps-circular:
	@echo "Checking for circular dependencies..."
	pnpm dlx madge --circular --extensions ts,tsx src/ $(DEPS_ARGS) || true

deps-graph:
	@echo "Generating dependency graph..."
	pnpm dlx skott $(DEPS_ARGS)

deps-orphans:
	@echo "Checking for orphaned dependencies..."
	pnpm dlx madge --orphans --exclude '(\.test\.tsx?$$|\.spec\.tsx?$$|\.storybook)' --extensions ts,tsx src/ $(DEPS_ARGS) || true
