# Development targets
# =======================================================================

.PHONY: dev-%

dev-%:
	@echo "Starting dev server for: $*"
	pnpm exec vite serve --mode $*

dev-network-%:
	@echo "Starting dev server exposed to network for: $*"
	@echo "Access from mobile: http:\/\/$$(ipconfig getifaddr en0 || hostname -I | awk '{print $$1}'):5173"
	pnpm exec vite serve --mode $* --host

dev-port-%:
	@echo "Starting dev server on custom port: $*"
	@read -p "Enter port number: " port; \
	pnpm exec vite serve --mode $* --port $$port
	
