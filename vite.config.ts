import { defineConfig } from 'vite';
import { getViteEnv } from './config/vite/vite.env';

import { viteConfigBase } from './config/vite/vite.config.base';
import { viteConfigBuild } from './config/vite/vite.config.build';
import { viteConfigCss } from './config/vite/vite.config.css';
import { viteConfigOptimizeDeps } from './config/vite/vite.config.optimize-deps';
import { viteConfigPlugins } from './config/vite/vite.config.plugins';
import { viteConfigResolve } from './config/vite/vite.config.resolve';
import { viteConfigServer } from './config/vite/vite.config.server';

import type { ConfigEnv, UserConfig } from 'vite';

export default defineConfig(({ mode = 'development' }: ConfigEnv): UserConfig => {
  const env = getViteEnv(mode);
  const isCI = process.env.CI === 'true';

  return {
    ...viteConfigBase(env, isCI),
    optimizeDeps: viteConfigOptimizeDeps(env),
    build: {
      ...(isCI && env.isProd && viteConfigBuild(env)),
      cssCodeSplit: true,
      reportCompressedSize: false,
    },
    css: viteConfigCss(env),
    preview: {
      port: 3001,
      cors: true,
    },
    plugins: viteConfigPlugins(env),
    resolve: viteConfigResolve(env),
    server: viteConfigServer(env),
  };
});
