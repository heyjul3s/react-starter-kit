import { loadEnv } from "vite";

export type Env = {
  app: Record<string, string>;
  vite: Record<string, string>;
};

export type GetViteEnvResult = {
  isDev: boolean;
  isProd: boolean;
  variables: Env;
};

export function getViteEnv(mode: string): GetViteEnvResult {
  const env = loadEnv(mode, process.cwd());

  return {
    isDev: mode === "development" || mode === "dev",
    isProd: mode === "production" || mode === "prod",
    variables: {
      app: env,
      vite: env,
    },
  };
}

export function defineViteAppConstants(env: GetViteEnvResult) {
  return Object.keys(env.variables.app).reduce((envVars, key) => {
    return key.startsWith("VITE_")
      ? {
          ...envVars,
          [`import.meta.env.${key}`]: JSON.stringify(
            env.variables.app[`${key}`],
          ),
        }
      : envVars;
  }, {});
}
