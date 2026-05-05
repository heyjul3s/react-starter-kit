import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { combineProviders } from '../src/context-providers/';
import { useMemo, type PropsWithChildren } from 'react';
import { createMockRouter } from './mock-router';
import { RouterProvider } from '@tanstack/react-router';

interface StorybookPreviewContextProvidersProps extends PropsWithChildren {
  routerConfig?: {
    initialEntries?: string[];
    queryClient?: QueryClient;
  };
}

export function StorybookPreviewContextProviders({
  children,
  routerConfig,
}: StorybookPreviewContextProvidersProps) {
  const queryClient = useMemo(
    () =>
      routerConfig?.queryClient ||
      new QueryClient({
        defaultOptions: {
          queries: { retry: false },
        },
      }),
    [routerConfig?.queryClient],
  );

  const router = useMemo(
    () =>
      createMockRouter({
        initialEntries: routerConfig?.initialEntries,
        queryClient,
      }),
    [routerConfig?.initialEntries, queryClient],
  );

  const StorybookContextProviders = combineProviders([
    [QueryClientProvider, { client: queryClient }],
    [RouterProvider, { router }],
  ]);

  return <StorybookContextProviders>{children}</StorybookContextProviders>;
}
