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
        <h3>Welcome Home!</h3>
      </div>
    </Layout>
  );
}
