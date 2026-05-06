import { loadEnv, mergeConfig } from 'vite';

import type { StorybookConfig } from '@storybook/react-vite';

const config: StorybookConfig = {
  addons: [
    '@chromatic-com/storybook',
    '@storybook/addon-a11y',
    '@storybook/addon-coverage',
    '@storybook/addon-docs',
    '@storybook/addon-links',
    '@storybook/addon-vitest',
    'msw-storybook-addon',
  ],
  env: (config) => ({
    ...config,
    ...loadEnv('storybook', process.cwd()),
  }),
  framework: '@storybook/react-vite',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  typescript: {
    reactDocgen: 'react-docgen-typescript',
  },
  viteFinal: async (config) => {
    // Filter out the router plugin from Storybook's Vite config.
    // Be defensive: `config.plugins` can contain `false`, arrays, or other
    // falsy values, so narrow the type before accessing `name`.
    const filteredPlugins = config.plugins?.filter((plugin) => {
      // keep falsy entries (they may be conditional plugins)
      if (!plugin) {
        return true;
      }

      // keep plugin arrays
      if (Array.isArray(plugin)) {
        return true;
      }

      // plugin might be a Vite Plugin object; check for name safely
      const maybePlugin = plugin as { name?: string };

      return maybePlugin.name !== '@tanstack/router-plugin';
    });

    return mergeConfig(config, {
      plugins: filteredPlugins,
      define: {
        global: 'globalThis',
      },
    });
  },
};

export default config;
