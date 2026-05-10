# React Starter Kit

A batteries-included React starter kit for building typed, tested, routed frontend applications with Vite. It comes wired with React 19, TypeScript, TanStack Router, TanStack Query, Zustand, Vitest, Storybook, MSW support, and a Make-based developer workflow.

## What Is Included

- React 19 and Vite 8
- TypeScript with strict settings and `@/*` path aliases
- TanStack Router with generated route tree support
- TanStack Query and React Query Devtools
- Zustand store helpers with generated selectors
- Axios request utility with request interceptor support
- Accessible page title and live-region announcement helpers
- Vitest, Testing Library, jest-dom, jsdom, and coverage support
- Storybook 10 with Vite, docs, a11y, coverage, links, Vitest addon, and MSW Storybook addon
- Oxlint, Stylelint, Markuplint, Prettier, lint-staged, Husky, and dependency analysis targets
- Environment-based Vite modes through `.env.*` files

## Prerequisites

- Node.js `24.15.0` or compatible. The expected version is listed in `.nvmrc`.
- pnpm `10.33.2` or compatible. The package manager version is listed in `package.json`.
- GNU Make.

If you use `nvm`:

```bash
nvm use
```

## Getting Started

Install dependencies and prepare Git hooks:

```bash
make setup
```

Manual equivalent:

```bash
chmod -R +x ./scripts
pnpm install
pnpm run prepare
```

Dependency installs are governed by the repo-level pnpm policy in `pnpm-workspace.yaml`. New package versions are delayed for 7 days before adoption, package-manager and Node versions are enforced, exotic subdependencies are blocked, and dependency build scripts must be explicitly reviewed. If pnpm reports an unapproved build script after adding or updating packages, review it with:

```bash
pnpm approve-builds
```

Start the development server:

```bash
make dev-develop
```

Build the application:

```bash
make build-prod
```

Run tests:

```bash
make test
```

Run Storybook:

```bash
make storybook
```

## Environment Files

Vite modes are backed by files named `.env.<mode>`.

Current environment files:

| File           | Mode      | Purpose                    |
| -------------- | --------- | -------------------------- |
| `.env.develop` | `develop` | Local development defaults |
| `.env.prod`    | `prod`    | Production build defaults  |

Current variables:

| Variable                           | Description                                                 |
| ---------------------------------- | ----------------------------------------------------------- |
| `VITE_REACT_APP_DEFAULT_APP_TITLE` | Default app title used by `index.html` and page title hooks |
| `VITE_REACT_APP_BASE_API_URL`      | Base URL used by the Axios request helper                   |

Examples:

```bash
make dev-develop
make build-prod
make build-preview-prod
```

Add a new mode by creating another `.env.<mode>` file, then use it with the matching Make target, for example `make dev-staging`.

## Commands

### Package Scripts

| Command                | Description                                 |
| ---------------------- | ------------------------------------------- |
| `pnpm dev`             | Runs the development wrapper script         |
| `pnpm build`           | Runs the build wrapper script               |
| `pnpm test`            | Runs the test wrapper script                |
| `pnpm test:bash`       | Runs Bash tests through the test wrapper    |
| `pnpm lint`            | Runs the lint wrapper script                |
| `pnpm deps`            | Runs the dependency-analysis wrapper script |
| `pnpm storybook`       | Starts Storybook on port `6006`             |
| `pnpm build-storybook` | Builds Storybook into `storybook-static`    |
| `pnpm lint-staged`     | Runs lint-staged                            |
| `pnpm prepare`         | Installs Husky hooks                        |

### Make Targets

Make targets are the most explicit way to run project tasks.

| Target                      | Description                                                         |
| --------------------------- | ------------------------------------------------------------------- |
| `make setup`                | Makes scripts executable, installs dependencies, and prepares Husky |
| `make install`              | Installs dependencies with pnpm                                     |
| `make reinstall`            | Forces a pnpm reinstall                                             |
| `make clean`                | Cleans node_modules and pnpm artifacts                              |
| `make add <pkg>`            | Adds one or more runtime dependencies                               |
| `make add-dev <pkg>`        | Adds one or more development dependencies                           |
| `make del <pkg>`            | Removes one or more dependencies                                    |
| `make list`                 | Lists installed dependencies                                        |
| `make list-dev`             | Lists development dependencies                                      |
| `make list-prod`            | Lists production dependencies                                       |
| `make outdated`             | Checks for outdated dependencies                                    |
| `make update`               | Updates dependencies                                                |
| `make store-prune`          | Prunes the pnpm store                                               |
| `make dev-<mode>`           | Starts Vite for a mode, such as `make dev-develop`                  |
| `make dev-network-<mode>`   | Starts Vite exposed to the local network                            |
| `make dev-port-<mode>`      | Prompts for a custom dev-server port                                |
| `make build-<mode>`         | Builds Vite for a mode                                              |
| `make build-analyze-<mode>` | Builds with `ANALYZE=true`                                          |
| `make build-preview-<mode>` | Starts a Vite preview server for a mode                             |
| `make build-clean`          | Removes build output and Vite caches                                |
| `make test`                 | Runs Vitest once                                                    |
| `make test-watch`           | Runs Vitest in watch mode                                           |
| `make test-ui`              | Runs Vitest UI with coverage output                                 |
| `make test-ci`              | Runs tests with coverage for CI                                     |
| `make test-report`          | Generates a JUnit test report                                       |
| `make test-bash`            | Runs Bats tests                                                     |
| `make test-storybook`       | Runs Storybook tests                                                |
| `make lint`                 | Runs the main lint suite                                            |
| `make lint-ci`              | Runs CI-friendly lint tasks in parallel                             |
| `make lint-fix`             | Runs fix-capable lint tasks                                         |
| `make lint-ox`              | Runs Oxlint                                                         |
| `make lint-ox-fix`          | Runs Oxlint with `--fix`                                            |
| `make lint-css`             | Runs Stylelint                                                      |
| `make lint-css-fix`         | Runs Stylelint with `--fix`                                         |
| `make lint-markup`          | Runs Markuplint                                                     |
| `make lint-prettier`        | Checks formatting with Prettier                                     |
| `make lint-prettier-fix`    | Formats files with Prettier                                         |
| `make lint-sh`              | Runs ShellCheck                                                     |
| `make lint-staged`          | Runs lint-staged                                                    |
| `make deps`                 | Runs dependency checks with depcheck                                |
| `make deps-circular`        | Checks circular dependencies with madge                             |
| `make deps-orphans`         | Checks orphaned modules with madge                                  |
| `make deps-graph`           | Generates a dependency graph with skott                             |
| `make storybook`            | Starts Storybook without opening a browser                          |
| `make storybook-open`       | Starts Storybook and opens the browser                              |
| `make chromatic`            | Publishes/checks Storybook with Chromatic                           |

Many targets accept extra args through variables:

```bash
make lint-prettier LINT_ARGS="README.md"
make deps DEPS_ARGS="--ignores=some-package"
```

## Project Structure

```text
.
├── .storybook/              Storybook config, decorators, and mocks
├── config/                  Vite and Vitest config helpers (and any other config helpers you may need)
├── public/                  Static public assets and MSW worker output
├── scripts/                 Bash scripts and Make target fragments
├── src/
│   ├── components/          Reusable UI components
│   ├── context-providers/   App-level provider composition
│   ├── hooks/               Shared hooks
│   ├── routes/              TanStack Router file routes
│   ├── store/               Zustand stores and selector helpers
│   └── utils/               Request and utility modules
├── tsconfig.json            Main TypeScript config
├── tsconfig.storybook.json  Storybook TypeScript config
├── vite.config.ts           App Vite config
└── vitest.config.ts         Vitest config
```

## Routing

Routes live in `src/routes`. This project uses TanStack Router file routes and the TanStack Router Vite plugin. The generated route tree is written to `src/route-tree.gen.ts`.

Useful files:

- `src/routes/__root.tsx` defines the root route shell.
- `src/routes/index.tsx` defines `/`.
- `src/routes/about.tsx` defines `/about`.
- `src/context-providers/context-providers.tsx` creates the router and wraps app providers.

When adding routes, follow the TanStack Router file-route conventions and let the Vite plugin update the generated route tree.

## State

Zustand is used for lightweight app state.

- `src/store/a11y-store.ts` stores live-region announcements.
- `src/store/create-selectors.ts` adds generated `store.use.<key>()` selectors to Zustand stores.

Example:

```ts
const announcement = useA11yStore.use.a11yAnnouncement();
const setAnnouncement = useA11yStore.use.actions().setA11yAnnouncement;
```

## Data Fetching

TanStack Query is configured in `src/context-providers/query-client.ts`.

The Axios request helper lives in `src/utils/request/request.ts` and uses:

- `VITE_REACT_APP_BASE_API_URL` as the default `baseURL`
- JSON headers by default
- a `qs` params serializer
- `requestInterceptor` from `src/utils/request/request-interceptor.ts`
- abort/cancel error normalization

## Accessibility

The starter includes a small screen-reader announcement pattern:

- `A11yAnnouncement` renders a visually hidden `aria-live="polite"` region.
- `usePageTitle` updates `document.title` and announces the page title.
- `Layout` includes the live-region component so pages can announce route changes.

Use this pattern for non-visual state changes that should be communicated to assistive technology.

## Testing

Vitest runs in `jsdom` with Testing Library and jest-dom matchers. Global test setup lives in `config/vitest/vitest.setup.ts`.

Run all tests:

```bash
make test
```

Run a single file:

```bash
pnpm exec vitest run src/hooks/use-page-title/use-page-title.test.ts
```

Run with coverage:

```bash
make test-ci
```

## Storybook

Storybook config lives in `.storybook`. It uses a dedicated TypeScript config at `tsconfig.storybook.json`.

Start Storybook:

```bash
make storybook
```

Build Storybook:

```bash
pnpm build-storybook
```

Publish/check with Chromatic:

```bash
make chromatic
```

## Linting And Formatting

The default lint target runs TypeScript-related linting, Oxlint, Stylelint, and Prettier checks:

```bash
make lint
```

Fix what can be fixed automatically:

```bash
make lint-fix
make lint-prettier-fix
make lint-css-fix
make lint-ox-fix
```

## Path Aliases

Use `@/*` imports for source files:

```ts
import { Layout } from '@/components';
import { usePageTitle } from '@/hooks';
```

Vite and Vitest use native `resolve.tsconfigPaths`, and TypeScript reads aliases from `tsconfig.json`.

## Dependency Checks

Dependency analysis tools are pinned dev dependencies and run through `pnpm exec`, so the commands use versions recorded in `pnpm-lock.yaml` instead of resolving executable packages on demand.

```bash
make deps
make deps-circular
make deps-orphans
make deps-graph
```

These targets are useful during dependency cleanup and module-graph reviews. `make deps-graph` starts Skott's web UI by default; pass Skott options through `DEPS_ARGS` when you need a different display mode.

## Production Notes

Production builds remove `data-testid` attributes through `rollup-plugin-jsx-remove-attributes`.

```bash
make build-prod
```

Preview a production build:

```bash
make build-preview-prod
```

## Troubleshooting

Use the Node version from `.nvmrc` if Vite, Storybook, or Vitest fail during startup:

```bash
nvm use
node -v
```

If an environment mode fails, check that the matching file exists:

```bash
ls .env.*
make dev-develop
```

If `@/*` imports fail, check:

- `tsconfig.json` contains the alias under `compilerOptions.paths`
- `vite.config.ts`, `vitest.config.ts`, and `.storybook/main.ts` enable `resolve.tsconfigPaths`

If Storybook prop docs look stale, rebuild after checking `tsconfig.storybook.json`.
