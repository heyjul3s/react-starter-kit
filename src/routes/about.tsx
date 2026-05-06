import { Layout } from '@/components';
import { usePageTitle } from '@/hooks';
import { createFileRoute } from '@tanstack/react-router';

export const Route = createFileRoute('/about')({
  component: About,
});

function About() {
  usePageTitle('About');

  return (
    <Layout>
      <div>Hello "/about"!</div>
    </Layout>
  );
}
