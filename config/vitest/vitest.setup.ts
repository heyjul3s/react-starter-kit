import "@testing-library/jest-dom";
import { expect, vi } from "vitest";
import * as matchers from "vitest-axe/matchers";

vi.mock("zustand");
expect.extend(matchers);
