import { useEffect } from 'react';
import { useA11yStore } from '@/store';

export function usePageTitle(title?: string) {
  useEffect(() => {
    const setA11yAnnouncement = useA11yStore.use.actions().setA11yAnnouncement;
    const applicationName = import.meta.env.VITE_REACT_APP_DEFAULT_APP_TITLE;
    const pageTitle = !!title ? `${title} | ${applicationName}` : applicationName;

    setTimeout(() => {
      setA11yAnnouncement(`${pageTitle}`);
    }, 50);

    document.title = pageTitle;
  }, [title]);
}
