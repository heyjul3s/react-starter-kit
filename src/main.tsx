import { StrictMode } from 'react';
import { ErrorBoundary } from 'react-error-boundary';
import { createRoot } from 'react-dom/client';
import { createRouter } from '@tanstack/react-router';
import { routeTree } from './route-tree.gen';
import { ContextProviders } from './context-providers';
import { ReactQueryDevtools } from '@tanstack/react-query-devtools';
import { ErrorFallback } from './components';

const router = createRouter({ routeTree });

declare module '@tanstack/react-router' {
  interface Register {
    router: typeof router;
  }
}

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <ErrorBoundary fallback={<ErrorFallback />}>
      <ContextProviders>
        <ReactQueryDevtools initialIsOpen={false} />
      </ContextProviders>
    </ErrorBoundary>
  </StrictMode>,
);
