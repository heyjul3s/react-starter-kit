# Development targets
# =======================================================================

.PHONY: dev-%

dev-%:
	@echo "Starting dev server for: $*"
	pnpx vite serve --config ./config/vite/vite.config.ts --mode $*

dev-network-%:
	@echo "Starting dev server exposed to network for: $*"
	@echo "Access from mobile: http:\/\/$$(ipconfig getifaddr en0 || hostname -I | awk '{print $$1}'):5173"
	pnpx vite serve --config ./config/vite/vite.config.ts --mode $* --host

dev-port-%:
	@echo "Starting dev server on custom port: $*"
	@read -p "Enter port number: " port; \
	pnpx vite serve --config ./config/vite/vite.config.ts --mode $* --port $$port
	