# PNPM package management Targets
# =======================================================================

.PHONY: clean install reinstall add add-dev del list list-dev list-prod
.PHONY: outdated update update-check

#  Check for NVM dir
NVM := $(HOME)/.nvm/nvm.sh
IS_NVM_EXISTS := $(shell test -f $(NVM); echo $$?)

# Install commands
clean:
	@echo "Cleaning node_modules and PNPM artifacts..."
	./scripts/pnpm-clean.sh

install:
	@echo "Installing dependencies with PNPM..."
	./scripts/pnpm-install.sh

reinstall:
	@echo "Reinstalling dependencies with PNPM..."
	@./scripts/nvm-use.sh && pnpm install --force

# Package mamagement commands
add:
	@if [ "$(filter-out $@,$(MAKECMDGOALS))" = "" ]; then \
		echo "Usage: make add PACKAGE [PACKAGE2 ...]"; \
		echo "Example: make add @tanstack/react-query estoolkit"; \
		exit 1; \
	fi
	@echo "Adding packages: $(filter-out $@,$(MAKECMDGOALS))"
	@./scripts/pnpm-add.sh $(filter-out $@,$(MAKECMDGOALS))

add-dev:
	@if [ "$(filter-out $@,$(MAKECMDGOALS))" = "" ]; then \
		echo "Usage: make add-dev PACKAGE [PACKAGE2 ...]"; \
		echo "Example: make add-dev typescript @types/react"; \
		exit 1; \
	fi
	@echo "Adding dev packages: $(filter-out $@,$(MAKECMDGOALS))"
	@./scripts/pnpm-add.sh $(filter-out $@,$(MAKECMDGOALS)) -D

del:
	@if [ "$(filter-out $@,$(MAKECMDGOALS))" = "" ]; then \
		echo "Usage: make del PACKAGE [PACKAGE2 ...]"; \
		echo "Example: make del lodash"; \
		exit 1; \
	fi
	@echo "Removing packages: $(filter-out $@,$(MAKECMDGOALS))"
	@./scripts/pnpm-del.sh $(filter-out $@,$(MAKECMDGOALS))

# List dependencies
list:
	@echo "Listing all dependencies..."
	@./scripts/nvm-use.sh && pnpm list --depth=0

list-dev:
	@echo "Listing dev dependencies..."
	@./scripts/nvm-use.sh && pnpm list --depth=0 --dev

list-prod:
	@echo "Listing production dependencies..."
	@./scripts/nvm-use.sh && pnpm list --depth=0 --prod

outdated:
	@echo "Checking for outdated dependencies..."
	@./scripts/nvm-use.sh && pnpm outdated

update:
	@echo "Updating dependencies to latest versions..."
	@./scripts/nvm-use.sh && pnpm update

update-check:
	@echo "Checking for updates without installing..."
	@./scripts/nvm-use.sh && pnpm outdated

#  PNPM specific commands
store-prune:
	@echo "Pruning PNPM store to remove old packages..."
	@./scripts/nvm-use.sh && pnpm store prune

store-status:
	@echo "Checking PNPM store status..."
	@./scripts/nvm-use.sh && pnpm store status
	