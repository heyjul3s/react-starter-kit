SHELL           := /bin/bash
.DEFAULT_GOAL   := help
.SILENT:        # don't echo commands as they run

ENV ?= development
NODE_ENV ?= $(ENV)

.PHONY: help

include scripts/make/build.mk
include scripts/make/deps.mk
include scripts/make/dev.mk
include scripts/make/lint.mk
include scripts/make/pnpm.mk
include scripts/make/storybook.mk
include scripts/make/test.mk

help:
	@echo "Available targets:"
	@echo "Build and Development:"
	@echo "  build-ENV       			Build for ENV (development or production)"
	@echo "  dev-ENV       				Start development server for ENV (development or production)"
	@echo ""
	@echo "Linting:"
	@echo "  lint       					Run all linters"
	@echo "  lint-fix      				Fix all lint issues"
	@echo "  lint-ox       				Run Oxlint"
	@echo "  lint-css       			Run CSS linting"
	@echo "  lint-types       		Run Typescript type checking"
	@echo ""
	@echo "Dependencies:"
	@echo "  deps       					Run dependency check"
	@echo "  deps-circular       	Check for circular dependencies"
	@echo "  deps-graph       		Visualise dependency graph"
	@echo ""
	@echo "Storybook:"
	@echo "  storybook       			Start Storybook server"
	@echo "  storybook-open       Start Storybook server and open in browser"
	@echo ""
	@echo "Testing:"
	@echo "	test									Run Vitest tests"
	@echo "	test-watch						Run Vitest in watch mode"
	@echo "	test-ui								Run Vitest with coverage with UI"
	@echo "	test-report						Generate Vitest report with coverage"
	@echo ""
	@echo "Package Management:"
	@echo "	install								Install all dependencies"
	@echo "	add										Add new package(s)"
	@echo "	del										Remove package(s)"
	@echo "	clean									Clean up node_modules"

setup:
	chmod -R +x ./scripts && make install && pnpx husky:prepare

# Catch-all rule to prevent Make from complaining about unknown targets
# This allows package names to be passed as arguments to add/del commands
%:
	@: