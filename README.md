# React Starter Kit

A batteries-included React starter template opinionated around Vite, TypeScript, Vitest, TanStack Router, React Query and a small set of developer utilities.

## Quick start

Prerequisites

- Node.js (LTS recommended)
- pnpm (this repo uses pnpm as the package manager)

To get started:

```bash
make setup
```

Otherwise, you can perform this manually:

```bash
chmod -R +x ./scripts
pnpm install
pnpm prepare

```

Start the dev server (example environment `develop`):

```bash
make dev-develop
# or directly: pnpm dev
```

Build for production:

```bash
make build-production
# or: pnpm build
```

Run tests:

```bash
make test
pnpm test
```

## Project layout (important files)

- `src/` - application source files
  - `index.html` - Vite entry HTML (served from `src/` when Vite root = `src`)
  - `main.tsx` - React entry (creates the router and mounts the app)
  - `routes/` - file-based routes (TanStack Router file routing)
  - `route-tree.gen.ts` / `route-tree.gen.ts` - generated route tree(s) produced by the router generator plugin
- `config/vite/` - Vite configuration broken into small files
- `config/lint/` - lint and formatter configs (prettier, stylelint, markuplint, etc.)
- `scripts/` - helper shell scripts used by package scripts and Makefile
- `make/` - Makefile fragments used by `makefile` to run dev/build/test tasks

## Important scripts and commands

This repository uses a mix of `make` targets and small wrapper scripts in `scripts/` for common tasks. The top-level `makefile` wires those together.

- `make dev-<mode>` — start the dev server for the given mode (e.g. `make dev-develop`, `make dev-production`). Under the hood it runs Vite with the config in `config/vite/`.
- `make build-<mode>` — build the app for the given mode.
- `pnpm dev` — (alias) runs the local dev wrapper.
- `pnpm build` — runs the build wrapper.
- `pnpm test` — runs the test suite.

You can inspect the exact make targets in `scripts/make/dev.mk` and other files under `scripts/make/`.
