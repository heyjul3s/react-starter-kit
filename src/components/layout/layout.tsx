import { A11yAnnouncement } from '../a11y-announcement/a11y-announcement';

import type { PropsWithChildren } from 'react';

export function Layout({ children }: PropsWithChildren) {
  return (
    <>
      <A11yAnnouncement />
      {children}
    </>
  );
}
