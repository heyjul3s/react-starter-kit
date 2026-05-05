import { UserConfig } from "vite";
import { GetViteEnvResult } from "./vite.env";

export function viteConfigBuild(env: GetViteEnvResult): UserConfig["build"] {
  return {
    chunkSizeWarningLimit: 1000,
    outDir: "../build",
    minify: env.isProd ? ("esbuild" as const) : false,
    sourcemap: env.isProd ? ("hidden" as const) : ("inline" as const),
    target: "esnext",
    rollupOptions: {
      output: {
        format: "esm",
        manualChunks(id) {
          if (
            id.includes("node_modules/react") ||
            id.includes("node_modules/react-dom")
          ) {
            return "core";
          }

          if (id.includes("@tanstack/react-router")) {
            return "routing";
          }

          if (
            id.includes("@tanstack/react-query") ||
            id.includes("/axios/") ||
            id.endsWith("/axios")
          ) {
            return "query";
          }

          if (id.includes("es-toolkit") || id.includes("nuqs")) {
            return "utils";
          }

          // Let Rollup decide for other modules
          return undefined;
        },
      },
    },
  };
}
