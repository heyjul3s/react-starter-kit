import { QueryClientProvider } from "@tanstack/react-query";
import { queryClient } from "./query-client";
import { RouterProvider } from "@tanstack/react-router";
import { combineProviders } from "./combine-providers";

type ContextProvidersArgs = {
  children: React.ReactNode;
};

export function ContextProviders({ children }: ContextProvidersArgs) {
  const CombinedContextProviders = combineProviders([
    [QueryClientProvider, { client: queryClient }],
  ]);

  return <CombinedContextProviders>{children}</CombinedContextProviders>;
}
