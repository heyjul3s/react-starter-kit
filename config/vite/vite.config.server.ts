import type { GetViteEnvResult } from "./vite.env";

export function viteConfigServer(env: GetViteEnvResult) {
  return {
    port: 3000,
    open: false,
    cors: true,
  };
}
