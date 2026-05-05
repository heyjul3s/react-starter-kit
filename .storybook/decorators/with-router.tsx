import { RouterProvider } from '@tanstack/react-router';
import { createMockRouter } from '../mock-router';

import type { StoryContext } from '@storybook/react-vite';
import type { PartialStoryFn } from 'storybook/internal/csf';

export function withRouter(Story: PartialStoryFn, context: StoryContext) {
  const router = createMockRouter({
    initialEntries: context.parameters?.router.initialEntries || ['/'],
  });

  return (
    // Some versions of @tanstack/react-router's RouterProvider types do not
    // include `children` even though at runtime providing children works for
    // Storybook wrappers. Cast to any to avoid the TS type error here.
    <RouterProvider {...({ router } as any)}>
      <Story />
    </RouterProvider>
  );
}
