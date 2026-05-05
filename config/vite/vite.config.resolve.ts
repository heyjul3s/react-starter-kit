import { tsPathAlias } from "../typescript/ts-path-alias";
import type { GetViteEnvResult } from "./vite.env";

export function viteConfigResolve(env: GetViteEnvResult) {
  return {
    alias: {
      ...tsPathAlias(),
      util: "util",
    },
    extension: [".js", ".jsx", ".ts", ".tsx", ".json", ".mjs"],
  };
}
