import axios, { AxiosHeaders } from 'axios';
import { beforeEach, describe, expect, it, vi } from 'vitest';
import { request } from './request';
import { requestInterceptor } from './request-interceptor';

Object.defineProperty(globalThis, 'import', {
  configurable: true,
  value: {
    meta: {
      env: {
        VITE_REACT_APP_BASE_API_URL: '',
      },
    },
  },
  writable: true,
});

vi.mock('axios', async () => {
  const actual = await vi.importActual('axios');
  const mockInstance = vi.fn();
  Object.assign(mockInstance, {
    interceptors: {
      request: {
        use: vi.fn(),
      },
    },
  });

  return {
    AxiosError: actual.AxiosError,
    AxiosHeaders: actual.AxiosHeaders,
    default: {
      create: vi.fn(() => mockInstance),
    },
  };
});

vi.mock('./request-interceptor', () => ({
  interceptRequest: vi.fn(),
}));

const mockAxiosCreate = vi.mocked(axios.create);

describe('request', () => {
  let mockAxiosInstance: any;
  let mockRequestInterceptor: any;

  beforeEach(() => {
    vi.clearAllMocks();
    mockAxiosInstance = mockAxiosCreate();
    mockRequestInterceptor = vi.mocked(requestInterceptor);

    Object.assign(mockAxiosInstance, {
      interceptors: {
        request: {
          use: vi.fn(),
        },
      },
    });
  });

  describe('Base functionality', () => {
    it('should create axios instance', () => {
      expect(mockAxiosCreate).toHaveBeenCalled();
    });

    it('should make a GET request and return data', async () => {
      const mockData = { id: 1, name: 'test' };
      const mockResponse = {
        data: mockData,
        headers: new AxiosHeaders(),
      };

      mockAxiosInstance.mockResolvedValue(mockResponse);

      const result = await request<typeof mockData>('/api/test');

      expect(mockRequestInterceptor).toHaveBeenCalledWith(mockAxiosInstance);
      expect(mockAxiosInstance).toHaveBeenCalledWith('/api/test', {
        baseURL: undefined,
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
        },
        paramsSerializer: {
          encode: expect.any(Function),
        },
        timeout: 20_000,
      });

      expect(result).toEqual(mockData);
    });

    it('should make a POST request and payload', async () => {
      const mockData = { success: true };
      const payload = { name: 'new item' };
      const mockResponse = {
        data: mockData,
        headers: new AxiosHeaders(),
      };

      mockAxiosInstance.mockResolvedValue(mockResponse);

      const customConfig = {
        data: payload,
        method: 'POST',
      };

      await request<typeof mockData>('/api/create', customConfig);

      expect(mockAxiosInstance).toHaveBeenCalledWith('/api/create', {
        baseURL: undefined,
        data: payload,
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
        },
        method: 'POST',
        paramsSerializer: {
          encode: expect.any(Function),
        },
        timeout: 20_000,
      });
    });

    it('should return response with headers when requested', async () => {
      const mockData = { id: 1 };
      const mockHeaders = new AxiosHeaders({ 'Content-Type': 'application/json ' });
      const mockResponse = {
        data: mockData,
        headers: mockHeaders,
      };

      mockAxiosInstance.mockResolvedValue(mockResponse);

      const result = await request<typeof mockData>('/api/test', {});

      expect(result).toEqual({
        data: mockData,
        headers: mockHeaders,
      });
    });
  });

  describe('Configuration', () => {
    it('should merge configurations correctly', async () => {
      const mockResponse = {
        data: {},
        headers: new AxiosHeaders(),
      };

      mockAxiosInstance.mockResolvedValue(mockResponse);

      const customConfig = {
        baseURL: '/hello/world',
        headers: { Authorization: 'Bearer token' },
        timeout: 30_000,
      };

      await request('/api/test', customConfig);

      expect(mockAxiosInstance).toHaveBeenCalledWith('/api/test', {
        baseURL: '/hello/world',
        headers: {
          Authorization: 'Bearer token',
        },
        paramsSerializer: {
          encode: expect.any(Function),
        },
        timeout: 30_000,
      });
    });
  });
});
