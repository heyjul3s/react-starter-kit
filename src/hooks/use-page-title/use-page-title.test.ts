import { act, renderHook } from '@testing-library/react';
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';

import { useA11yStore } from '@/store';
import { usePageTitle } from './use-page-title';

describe('usePageTitle', () => {
  beforeEach(() => {
    vi.useFakeTimers();
    vi.stubEnv('VITE_REACT_APP_DEFAULT_APP_TITLE', 'Test App');
    useA11yStore.getState().actions.clearA11yAnnouncement();
    document.title = '';
  });

  afterEach(() => {
    vi.runOnlyPendingTimers();
    vi.useRealTimers();
    vi.unstubAllEnvs();
    useA11yStore.getState().actions.clearA11yAnnouncement();
    document.title = '';
  });

  it('sets the document title and announces the page title', () => {
    renderHook(() => usePageTitle('About'));

    expect(document.title).toBe('About | Test App');
    expect(useA11yStore.getState().a11yAnnouncement).toBeNull();

    act(() => {
      vi.advanceTimersByTime(50);
    });

    expect(useA11yStore.getState().a11yAnnouncement).toBe('About | Test App');
  });

  it('uses the application name when no page title is given', () => {
    renderHook(() => usePageTitle());

    expect(document.title).toBe('Test App');

    act(() => {
      vi.advanceTimersByTime(50);
    });

    expect(useA11yStore.getState().a11yAnnouncement).toBe('Test App');
  });

  it('clears the pending announcement timeout when unmounted', () => {
    const { unmount } = renderHook(() => usePageTitle('About'));

    unmount();

    act(() => {
      vi.advanceTimersByTime(50);
    });

    expect(useA11yStore.getState().a11yAnnouncement).toBeNull();
  });

  it('only announces the latest title after rerendering', () => {
    const { rerender } = renderHook(({ title }) => usePageTitle(title), {
      initialProps: { title: 'About' },
    });

    rerender({ title: 'Home' });

    act(() => {
      vi.advanceTimersByTime(50);
    });

    expect(document.title).toBe('Home | Test App');
    expect(useA11yStore.getState().a11yAnnouncement).toBe('Home | Test App');
  });
});
