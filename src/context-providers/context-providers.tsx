import { QueryClientProvider } from '@tanstack/react-query';
import { queryClient } from './query-client';
import { combineProviders } from './combine-providers';

import { createRouter, RouterProvider } from '@tanstack/react-router';
import { routeTree } from '../route-tree.gen';

const router = createRouter({ routeTree });

declare module '@tanstack/react-router' {
  interface Register {
    router: typeof router;
  }
}

type ContextProvidersArgs = {
  children: React.ReactNode;
};

export function ContextProviders({ children }: ContextProvidersArgs) {
  const CombinedContextProviders = combineProviders([
    [RouterProvider, { router }],
    [QueryClientProvider, { client: queryClient }],
  ]);

  return <CombinedContextProviders>{children}</CombinedContextProviders>;
}
