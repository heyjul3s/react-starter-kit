import { UserConfig } from "vite";
import type { GetViteEnvResult } from "./vite.env";

export function viteConfigBase(env: GetViteEnvResult, isCI: boolean) {
  return {
    root: "src",
    // ...(isCI && env.isProd && { logLevel: "warn" }),
  };
}
