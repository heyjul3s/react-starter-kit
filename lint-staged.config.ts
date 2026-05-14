import path from 'node:path';

import type { Configuration } from 'lint-staged';

const ignoredFiles = [/^src\/.*\.gen\.ts$/];

function toProjectPath(filename: string) {
  return path.relative(process.cwd(), filename).split(path.sep).join('/');
}

function filterIgnoredFiles(filenames: readonly string[]) {
  return filenames.filter((filename) => {
    const projectPath = toProjectPath(filename);

    return !ignoredFiles.some((pattern) => pattern.test(projectPath));
  });
}

const config: Configuration = {
  'src/**/*.{ts,tsx}': (filenames) => {
    const files = filterIgnoredFiles(filenames);

    if (files.length === 0) {
      return [];
    }

    return `./scripts/bash/run-lint.sh types --project ./tsconfig.json`;
  },

  '**/*.{ts,tsx,js,jsx}': (filenames) => {
    const matchedFiles = filterIgnoredFiles(filenames);

    if (matchedFiles.length === 0) {
      return [];
    }

    const files = matchedFiles.join(' ');

    return [
      `./scripts/bash/run-deps.sh circular`,
      `./scripts/bash/run-lint.sh ox-fix ${files}`,
      `./scripts/bash/run-lint.sh prettier-fix ${files}`,
      `./scripts/bash/run-lint.sh markup ${files}`,
      `pnpm exec vitest related --passWithNoTests --run ${files}`,
      `./scripts/bash/run-lint.sh knip`,
    ];
  },

  'src/**/*.{module.css,css}': (filenames) => {
    if (filenames.length === 0) {
      return [];
    }

    const files = filenames.join(' ');
    return [`./scripts/bash/run-lint.sh css-fix ${files}`];
  },

  '**/*.md': (filenames) => {
    if (filenames.length === 0) {
      return [];
    }

    return `./scripts/bash/run-lint.sh prettier-fix ${filenames.join(' ')}`;
  },

  '**/*.json': (filenames) => {
    if (filenames.length === 0) {
      return [];
    }

    return [
      `./scripts/bash/run-lint.sh prettier-fix ${filenames.join(' ')}`,
      `./scripts/bash/run-lint.sh knip`,
    ];
  },
};

export default config;
