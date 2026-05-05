export default {
  'src/**/*.{ts,tsx}': () => {
    return `pnpm exec tsc --project ./tsconfig.json --noEmit`;
  },

  '**/*.{ts,tsx,js,jsx}': (filenames) => {
    const files = filenames.join(' ');

    return [
      `pnpx run deps circular`,
      `pnpx oxlint --fix ${files}`,
      `pnpx prettier --write ${files}`,
      `pnpx markuplint ${files}`,
      `pnpx vitest related --passWithNoTests --run ${files}`,
    ];
  },

  'src/**/*.{module.css,css}': (filenames) => {
    const files = filenames.join(' ');
    return [`pnpx stylelint ${files} --fix`];
  },

  '**/*.{md,json}': (filenames) => `pnpx prettier --write ${filenames.join(' ')}`,
};
