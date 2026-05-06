import { Layout } from '@/components';
import { usePageTitle } from '@/hooks';
import { createFileRoute } from '@tanstack/react-router';

export const Route = createFileRoute('/')({
  component: Index,
});

function Index() {
  usePageTitle('Home');

  return (
    <Layout>
      <div className="p-2">
        <h1>Welcome Home!</h1>
      </div>
    </Layout>
  );
}
