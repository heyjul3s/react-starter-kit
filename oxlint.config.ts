import { defineConfig } from 'oxlint';

export default defineConfig({
  categories: {
    correctness: 'error',
  },
  env: {
    builtin: true,
  },
  rules: {
    'eslint/no-unused-vars': 'error',
  },
  plugins: ['typescript', 'unicorn', 'oxc'],
});
