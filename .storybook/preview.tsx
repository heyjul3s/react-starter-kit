import { initialize, mswLoader } from 'msw-storybook-addon';
import { handlers } from '../__handlers__';
import type { Preview } from '@storybook/react-vite';
import { withDecorators } from './decorators/with-decorators';

initialize({
  onUnhandledRequest: (req, print) => {
    const url = new URL(req.url);
    const isStaticAsset =
      url.pathname.endsWith('.css') ||
      url.pathname.endsWith('.js') ||
      url.pathname.endsWith('.svg') ||
      url.pathname.endsWith('.png') ||
      url.pathname.endsWith('.jpg') ||
      url.pathname.endsWith('.png') ||
      url.pathname.endsWith('.ico') ||
      url.pathname.endsWith('.module.css') ||
      url.pathname.endsWith('?import') ||
      url.pathname.endsWith('/src/') ||
      url.pathname.endsWith('/assets/') ||
      url.pathname.endsWith('/_vite/') ||
      url.pathname.endsWith('/@vite/') ||
      url.pathname.endsWith('/node_modules/');

    // Siliently bypass static assets
    if (isStaticAsset) {
      return 'bypass';
    }

    // Only warn about actual API endpoints that we might want to mock
    if (url.pathname.startsWith('/api')) {
      print.warning();
    }

    // Always bypass unhandled requests and not throw errors
    return 'bypass';
  },
});

const preview: Preview = {
  loaders: [mswLoader],
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
      options: {
        storySort: {
          method: 'alphabetical',
        },
      },
    },

    a11y: {
      // 'todo' - show a11y violations in the test UI only
      // 'error' - fail CI on a11y violations
      // 'off' - skip a11y checks entirely
      test: 'error',
    },

    msw: {
      handlers: [...handlers],
    },
  },
};

export const decorators = [withDecorators];

export default preview;
