import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { combineProviders } from '../src/context-providers/';
import { useMemo, type PropsWithChildren } from 'react';

export function StorybookPreviewContextProviders({ children }: PropsWithChildren) {
  const queryClient = useMemo(
    () =>
      new QueryClient({
        defaultOptions: {
          queries: { retry: false },
        },
      }),
    [],
  );

  const StorybookContextProviders = combineProviders([
    [QueryClientProvider, { client: queryClient }],
  ]);

  return <StorybookContextProviders>{children}</StorybookContextProviders>;
}
