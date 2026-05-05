import { StorybookPreviewContextProviders } from '../preview-context-providers';
import { withErrorBoundary } from './with-error-boundary';

import type { PartialStoryFn } from 'storybook/internal/types';
import type { ReactNode } from 'react';

export function withDecorators(Story: PartialStoryFn): ReactNode {
  const storyNode = Story();

  return (
    <StorybookPreviewContextProviders>
      {withErrorBoundary(storyNode)}
    </StorybookPreviewContextProviders>
  );
}
