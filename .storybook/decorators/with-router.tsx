import { QueryClient } from '@tanstack/react-query';
import {
  createMemoryHistory,
  createRootRoute,
  createRouter,
  RouterProvider,
} from '@tanstack/react-router';

import type { StoryContext } from '@storybook/react-vite';
import type { PartialStoryFn } from 'storybook/internal/csf';

export function withRouter(Story: PartialStoryFn, context: StoryContext) {
  const queryClient = new QueryClient({
    defaultOptions: {
      queries: { retry: false },
    },
  });

  const rootRoute = createRootRoute({
    component: () => <Story />,
  });

  const router = createRouter({
    routeTree: rootRoute,
    history: createMemoryHistory({
      initialEntries: context.parameters?.router?.initialEntries || ['/'],
    }),
    context: {
      queryClient,
    },
    defaultPreload: 'intent',
  });

  return <RouterProvider router={router} />;
}
