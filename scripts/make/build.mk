# Build Targets
# =======================================================================

.PHONY: build-%

build-%:
	@echo "Building for environment: $*"
	@if [ "$$CI" = "true" ]; then \
		echo "Using CI-optimized build script"; \
		./scripts/bash/build-ci.sh $*; \
	else \
		echo "Using standard build script"; \
		pnpx vite build --emptyOutDir --config ./config/vite/vite.config.ts --mode $*; \
	fi

build-analyze-%:
	@echo "Building for environment with bundle analysis: $*"
	ANALYZE=true pnpx vite build --emptyOutDir --config ./config/vite/vite.config.ts --mode $*

build-clean:
	@echo "Cleaning build output directory"
	rm -rf build/ dist/ .vite/ node_modules/.vite/

build-stats-%:
	@echo "Building for environment with stats generation: $*"
	time make build-$* 2>&1 | tee build0stats0$*.log 

build-preview-%:
	@echo "Starting preview server for: $*"
	pnpx vite preview --config ./config/vite/vite.config.ts --mode $*