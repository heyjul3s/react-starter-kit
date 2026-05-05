import { ErrorBoundary } from 'react-error-boundary';
import type { ReactNode } from 'react';

export function withErrorBoundary(children: ReactNode): ReactNode {
  return (
    <ErrorBoundary fallbackRender={() => <div role="alert">Something went wrong.</div>}>
      {children}
    </ErrorBoundary>
  );
}
