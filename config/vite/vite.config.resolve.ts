export function viteConfigResolve() {
  return {
    alias: {
      util: 'util',
    },
    extension: ['.js', '.jsx', '.ts', '.tsx', '.json', '.mjs'],
    tsconfigPaths: true,
  };
}
