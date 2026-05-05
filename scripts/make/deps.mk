# Build Targets
# =======================================================================

.PHONY: deps deps-circular deps-graph deps-orphans

DEPS_ARGS ?=

# NOTE: Adding "|| true" at the end of the cmd as madge tool exists with a non-zero
# status code when it finds circular dependencies. Similar for depcheck

deps:
	@echo "Checking for dependency issues..."
	pnpx depcheck $(DEPS_ARGS) || true

deps-circular:
	@echo "Checking for circular dependencies..."
	pnpx madge --circular --extensions ts,tsx src/ $(DEPS_ARGS) || true

deps-graph:
	@echo "Generating dependency graph..."
	pnpx skott $(DEPS_ARGS)

deps-orphans:
	@echo "Checking for orphaned dependencies..."
	pnpx madge --orphans --exclude '(\.test\.ts$||\.test\.tsx$|\.spec\.ts$.spec\.tsx$.storybook)' --extensions ts,tsx src/ $(DEPS_ARGS) || true