import path from "node:path";
import { fileURLToPath } from "node:url";

import { configDefaults, defineConfig } from "vitest/config";

import { storybookTest } from "@storybook/addon-vitest/vitest-plugin";

import { playwright } from "@vitest/browser-playwright";

const dirname =
  typeof __dirname !== "undefined"
    ? __dirname
    : path.dirname(fileURLToPath(import.meta.url));

// More info at: https://storybook.js.org/docs/next/writing-tests/integrations/vitest-addon
export default defineConfig({
  test: {
    coverage: {
      reporter: ["corbetura", "json-summary", "json"],
      reportsDirectory: "./test-reports",
      exclude: [...configDefaults.exclude],
    },
    reporters: ["default", "junit"],
    environment: "jsdom",
    include: ["src/**/*.{test,spec}.{js,jsx,ts,tsx}"],
    exclude: [...configDefaults.exclude],
    outputFile: "./test-reports/junit.xml",
    setupFiles: ["./vitest.setup.ts"],
    pool: "threads",
    maxWorkers: process.env.CI ? 4 : 16,
    maxConcurrency: process.env.CI ? 4 : 16,
    isolate: true,
    passWithNoTests: true,
    ...(process.env.CI && {
      cache: {
        dir: "node_modules/vitest",
      },
      logHeapUsage: false,
    }),
    projects: [
      {
        extends: true,
        plugins: [
          // The plugin will run tests for the stories defined in your Storybook config
          // See options at: https://storybook.js.org/docs/next/writing-tests/integrations/vitest-addon#storybooktest
          storybookTest({ configDir: path.join(dirname, ".storybook") }),
        ],
        test: {
          name: "storybook",
          browser: {
            enabled: true,
            headless: true,
            provider: playwright({}),
            instances: [{ browser: "chromium" }],
          },
        },
      },
    ],
  },
});
