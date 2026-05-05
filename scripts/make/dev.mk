# Development targets
# =======================================================================

.PHONY: dev-%

dev-%:
	@echo "Starting dev server for: $*"
	pnpx vite serve --mode $*

dev-network-%:
	@echo "Starting dev server exposed to network for: $*"
	@echo "Access from mobile: http:\/\/$$(ipconfig getifaddr en0 || hostname -I | awk '{print $$1}'):5173"
	pnpx vite serve --mode $* --host

dev-port-%:
	@echo "Starting dev server on custom port: $*"
	@read -p "Enter port number: " port; \
	pnpx vite serve --mode $* --port $$port
	