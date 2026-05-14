import { loadEnv } from 'vite';

type Env = {
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
    isDev: mode === 'development' || mode === 'dev',
    isProd: mode === 'production' || mode === 'prod',
    variables: {
      app: env,
      vite: env,
    },
  };
}
