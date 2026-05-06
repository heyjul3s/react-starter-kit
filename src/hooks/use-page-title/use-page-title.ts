import { useEffect } from 'react';
import { useA11yStore } from '@/store';

export function usePageTitle(title?: string) {
  const setA11yAnnouncement = useA11yStore.use.actions().setA11yAnnouncement;

  useEffect(() => {
    const applicationName = import.meta.env.VITE_REACT_APP_DEFAULT_APP_TITLE ?? '';
    const pageTitle = title ? `${title} | ${applicationName}` : applicationName;

    const timeoutId = window.setTimeout(() => {
      setA11yAnnouncement(pageTitle);
    }, 50);

    document.title = pageTitle;

    return () => {
      window.clearTimeout(timeoutId);
    };
  }, [setA11yAnnouncement, title]);
}
