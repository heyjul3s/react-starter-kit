import { createMemoryHistory, createRootRoute, createRouter } from '@tanstack/react-router';
import { QueryClient } from '@tanstack/react-query';

const rootRoute = createRootRoute();
const mockRouteTree = rootRoute.addChildren([]);

type CreateMockRouter = {
  initialEntries?: string[];
  queryClient?: QueryClient;
};

export function createMockRouter(options?: CreateMockRouter) {
  const { initialEntries = ['/'], queryClient = new QueryClient() } = options || {};

  return createRouter({
    routeTree: mockRouteTree,
    history: createMemoryHistory({
      initialEntries,
    }),
    context: {
      queryClient,
    },
    defaultPreload: 'intent',
  });
}
