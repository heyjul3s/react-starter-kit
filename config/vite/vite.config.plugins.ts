import path from 'path';
import react from '@vitejs/plugin-react';
import { tanstackRouter } from '@tanstack/router-plugin/vite';
import mkcert from 'vite-plugin-mkcert';
import removeAttributes from 'rollup-plugin-jsx-remove-attributes';

import type { GetViteEnvResult } from './vite.env';
import type { UserConfig } from 'vite';

export function viteConfigPlugins(env: GetViteEnvResult): UserConfig['plugins'] {
  return [
    tanstackRouter({
      // Use an absolute path so tools that run from the project root (like
      // Storybook) don't try to scan a non-existent top-level `routes`
      // directory. The real routes live under `src/routes`.
      routesDirectory: path.resolve(process.cwd(), 'src', 'routes'),
      generatedRouteTree: './route-tree.gen.ts',
      target: 'react',
      autoCodeSplitting: true,
    }),
    react({
      include: 'src/**/*.{js,jsx,ts,tsx}',
      jsxImportSource: undefined,
    }),
    ...(!env.isProd ? [mkcert()] : []),
    ...(env.isProd ? [removeAttributes({ attributes: ['data-testid'] })] : []),
  ];
}
