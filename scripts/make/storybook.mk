# 
# Chromatic and Storybook targets
# =======================================================================

.PHONY: chromatic storybook storybook-open

chromatic:
	STORYBOOK_NODE_ENV=develop NODE_OPTIONS="--max-old-space-size=6144" pnpm exec chromatic --exit-zero-on-changes --exit-once-uploaded --only-changed

storybook:
	./scripts/bash/nvm-use.sh && pnpm exec storybook dev -p 6006 --no-open

storybook-open:
	./scripts/bash/nvm-use.sh && pnpm exec storybook dev -p 6006
