import { create } from 'zustand';
import { createSelectors } from './create-selectors';

type A11yStore = {
  a11yAnnouncement: null | string;
  actions: A11yStoreActions;
};

type A11yStoreActions = {
  clearA11yAnnouncement: () => void;
  setA11yAnnouncement: (announcement: string) => void;
};

const useA11yStoreBase = create<A11yStore>((set) => ({
  a11yAnnouncement: null,
  actions: {
    clearA11yAnnouncement: () => set({ a11yAnnouncement: null }),
    setA11yAnnouncement: (a11yAnnouncement) => set({ a11yAnnouncement }),
  },
}));

export const useA11yStore = createSelectors(useA11yStoreBase);
