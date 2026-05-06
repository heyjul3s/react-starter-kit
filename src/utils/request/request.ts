import axios from "axios";
import { isEmpty } from "es-toolkit/compat";
import qs from "qs";

import type { AxiosRequestConfig } from "axios";
import type { PathLike } from "fs";

export const axiosBase = axios.create();

const REQUEST_CONFIG_DEFAULTS: AxiosRequestConfig = {
  baseURL: import.meta.env.VITE_REACT_APP_BASE_API_URL,
  headers: {
    Accept: "application/json",
    "Content-Type": "application/json",
  },
  paramsSerializer: {
    encode: (params: PathLike) => qs.stringify(params, { indices: false }),
  },
  timeout: 20_000,
};

export async function request<Data>(
  endpoint: string,
  config?: AxiosRequestConfig,
): Promise<Data>;

export async function request<Data>(
  endpoint: string,
  config: AxiosRequestConfig = {},
): Promise<Data> {
  config = {
    ...REQUEST_CONFIG_DEFAULTS,
    ...config,
  };

  return axiosBase(endpoint, config)
    .then((response) => {
      return response.data;
    })
    .catch((error) => {
      if (error.name === "AbortError" || error.code === "ERR_CANCELED") {
        return Promise.reject({
          ...error,
          isAborted: true,
          message: "Request was aborted",
        });
      }

      return Promise.reject({
        ...error,
        ...(!isEmpty(error?.response?.data) && error.response.data),
      });
    });
}
