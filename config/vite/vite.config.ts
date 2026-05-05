import { defineConfig } from "vite";
import { getViteEnv } from "./vite.env";

import { viteConfigBase } from "./vite.config.base";
import { viteConfigBuild } from "./vite.config.build";
import { viteConfigCss } from "./vite.config.css";
import { viteConfigOptimizeDeps } from "./vite.config.optimize-deps";
import { viteConfigPlugins } from "./vite.config.plugins";
import { viteConfigResolve } from "./vite.config.resolve";
import { viteConfigServer } from "./vite.config.server";

import type { ConfigEnv, UserConfig } from "vite";

export default defineConfig(
  ({ mode = "development" }: ConfigEnv): UserConfig => {
    const env = getViteEnv(mode);
    const isCI = process.env.CI === "true";

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
  },
);
