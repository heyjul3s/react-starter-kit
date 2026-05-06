import { useEffect } from 'react';
import { useA11yStore } from '@/store';
import styles from './a11y-announcement.module.css';

export function A11yAnnouncement() {
  const announcement = useA11yStore.use.a11yAnnouncement();
  const clearA11yAnnouncement = useA11yStore.use.actions().clearA11yAnnouncement;

  useEffect(() => {
    if (!!announcement) {
      setTimeout(() => {
        clearA11yAnnouncement();
      }, 1000);
    }
  }, [announcement, clearA11yAnnouncement]);

  return (
    <div aria-live="polite" className={styles['visually-hidden']} role="status">
      {announcement}
    </div>
  );
}
