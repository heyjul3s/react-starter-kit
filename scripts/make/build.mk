# Build Targets
# =======================================================================

.PHONY: build-%

build-analyze-%:
	@echo "Building for environment with bundle analysis: $*"
	source ./scripts/bash/nvm-use.sh && ANALYZE=true pnpm exec vite build --emptyOutDir --mode $*

build-clean:
	@echo "Cleaning build output directory"
	rm -rf build/ dist/ .vite/ node_modules/.vite/

build-stats-%:
	@echo "Building for environment with stats generation: $*"
	time make build-$* 2>&1 | tee build0stats0$*.log 

build-preview-%:
	@echo "Starting preview server for: $*"
	source ./scripts/bash/nvm-use.sh && pnpm exec vite preview --mode $*

build-%:
	@echo "Building for environment: $*"
	@if [ "$$CI" = "true" ]; then \
		echo "Using CI-optimized build script"; \
		./scripts/bash/build-ci.sh $*; \
	else \
		echo "Using standard build script"; \
		source ./scripts/bash/nvm-use.sh && pnpm exec vite build --emptyOutDir --mode $*; \
	fi
