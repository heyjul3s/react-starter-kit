import type { CSSOptions } from "vite";
import type { GetViteEnvResult } from "./vite.env";

export function viteConfigCss(env: GetViteEnvResult): CSSOptions {
  return {
    devSourcemap: !env.isProd,
  };
}
