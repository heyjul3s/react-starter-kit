import type { AxiosInstance } from 'axios';

// Sample interceptor
export function requestInterceptor(instance: AxiosInstance) {
  instance.interceptors.request.use(async (config) => {
    return config;
  });
}
