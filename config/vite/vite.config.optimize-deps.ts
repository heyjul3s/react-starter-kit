import type { GetViteEnvResult } from "./vite.env";

export function viteConfigOptimizeDeps(env: GetViteEnvResult) {
  return {
    include: [
      "react",
      "react-dom",
      "@tanstack/react-router",
      "@tanstack/react-query",
    ],
    exclude: ["@vite/client", "@vite/env"],
    force: !env.isProd,
  };
}
