import type { AxiosError, AxiosInstance, AxiosRequestConfig, AxiosResponse } from 'axios'
import { Message, Notification } from '@arco-design/web-vue'
import axios from 'axios'
import NProgress from 'nprogress'
import router from '@/router'
import { clearToken, getRefreshToken, getToken, setRefreshToken, setToken } from '@/utils/auth'
import 'nprogress/nprogress.css'

// 配置 NProgress
NProgress.configure({ showSpinner: false })

type HttpRequestConfig = AxiosRequestConfig & {
  /** 内部标记：遇到 401 时是否跳过 refresh token 流程 */
  __skipTokenRefresh?: boolean
}

/** 状态码消息映射 */
const StatusCodeMessage: Record<number, string> = {
  200: '服务器成功返回请求的数据',
  201: '新建或修改数据成功',
  202: '一个请求已经进入后台排队（异步任务）',
  204: '删除数据成功',
  400: '请求错误(400)',
  401: '未授权，请重新登录(401)',
  403: '拒绝访问(403)',
  404: '请求出错(404)',
  408: '请求超时(408)',
  500: '服务器错误(500)',
  501: '服务未实现(501)',
  502: '网络错误(502)',
  503: '服务不可用(503)',
  504: '网络超时(504)'
}

/** 创建 axios 实例 */
const http: AxiosInstance = axios.create({
  baseURL: import.meta.env.VITE_API_PREFIX,
  timeout: 30 * 1000
})

/** 是否正在刷新token的标志 */
let isRefreshing = false

/** 等待刷新 token 的请求队列 */
let refreshSubscribers: Array<(token: string) => void> = []

const subscribeTokenRefresh = (cb: (token: string) => void) => {
  refreshSubscribers.push(cb)
}

const onRefreshed = (token: string) => {
  refreshSubscribers.forEach((cb) => cb(token))
  refreshSubscribers = []
}

const logoutAndRedirect = () => {
  clearToken()
  router.replace('/login')
}

const requestRefreshToken = async () => {
  const refreshToken = getRefreshToken()
  if (!refreshToken) {
    throw new Error('missing refresh token')
  }

  const res = await axios.post(`${import.meta.env.VITE_API_PREFIX}/auth/refreshToken`, {
    refreshToken
  })

  const refreshData = res.data as ApiRes<{
    accessToken: string
    refreshToken: string
  }>

  // 兼容后端 code = 200 或 20000
  if ((refreshData.code === 200 || refreshData.code === 20000) && refreshData.data) {
    const { accessToken, refreshToken: newRefreshToken } = refreshData.data
    setToken(accessToken)
    setRefreshToken(newRefreshToken)
    return accessToken
  }

  throw new Error(refreshData.message || '刷新token失败')
}

const retryWithLatestToken = (config: HttpRequestConfig): Promise<AxiosResponse> => {
  return new Promise((resolve) => {
    subscribeTokenRefresh((newToken: string) => {
      if (!config.headers) {
        config.headers = {}
      }
      config.headers.Authorization = `Bearer ${newToken}`
      resolve(http.request(config))
    })
  })
}

const tryRefreshAndRetry = async (config: HttpRequestConfig): Promise<AxiosResponse> => {
  const shouldTryRefresh = !config.__skipTokenRefresh
  if (!shouldTryRefresh) {
    throw new Error('skip token refresh')
  }

  const refreshToken = getRefreshToken()
  if (!refreshToken) {
    throw new Error('missing refresh token')
  }

  if (isRefreshing) {
    return retryWithLatestToken(config)
  }

  isRefreshing = true
  try {
    const accessToken = await requestRefreshToken()
    onRefreshed(accessToken)

    if (!config.headers) {
      config.headers = {}
    }
    config.headers.Authorization = `Bearer ${accessToken}`
    return http.request(config)
  } finally {
    isRefreshing = false
  }
}

// 请求拦截器
http.interceptors.request.use(
  (config: HttpRequestConfig) => {
    NProgress.start()
    const token = getToken()
    if (token) {
      if (!config.headers) {
        config.headers = {}
      }
      // 使用标准的 Bearer Token 认证方式
      if (!config.headers.Authorization) {
        config.headers.Authorization = `Bearer ${token}`
      }
    }
    return config
  },
  (error) => {
    NProgress.done()
    return Promise.reject(error)
  }
)

// 响应拦截器
http.interceptors.response.use(
  async (response: AxiosResponse) => {
    const { data } = response
    const normalizedData = data as Partial<ApiRes<unknown>> & Record<string, any>
    const code = Number(normalizedData.code)
    const success = typeof normalizedData.success === 'boolean'
      ? normalizedData.success
      : (code === 200 || code === 20000)
    const message = normalizedData.message as string

    normalizedData.success = success
    response.data = normalizedData

    // 兼容后端返回 200 + 业务 code=401 的场景
    if (code === 401) {
      const cfg = response.config as HttpRequestConfig
      try {
        const retryRes = await tryRefreshAndRetry(cfg)
        NProgress.done()
        return retryRes
      } catch {
        NProgress.done()
        logoutAndRedirect()
        return Promise.reject(new Error('token失效，请重新登录'))
      }
    }

    if (!success) {
      NProgress.done()
      if (message && message.length <= 15) {
        Message.error(message || '服务器端错误')
      } else {
        Notification.error(message || '服务器端错误')
      }
      return Promise.reject(new Error(message || 'Error'))
    }

    NProgress.done()
    return response
  },
  async (error: AxiosError) => {
    NProgress.done()

    const status = error.response?.status
    const originalConfig = (error.config || {}) as HttpRequestConfig

    // 处理 HTTP 401（你当前遇到的场景）
    if (status === 401) {
      try {
        const retryRes = await tryRefreshAndRetry(originalConfig)
        return retryRes
      } catch {
        Message.clear()
        logoutAndRedirect()
        Message.error('登录已过期，请重新登录')
        return Promise.reject(error)
      }
    }

    Message.clear()
    if (status) {
      Message.error(StatusCodeMessage[status] || '系统异常, 请检查网络或联系管理员！')
    } else {
      Message.error('网络异常，请检查网络连接')
    }

    return Promise.reject(error)
  }
)

/** 封装请求方法 */
const request = <T = unknown>(config: HttpRequestConfig): Promise<ApiRes<T>> => {
  return new Promise((resolve, reject) => {
    http
      .request<T>(config)
      .then((res: AxiosResponse) => resolve(res.data))
      .catch((err: { message: string }) => reject(err))
  })
}

/** GET 请求 */
const get = <T = any>(url: string, params?: object, config?: AxiosRequestConfig): Promise<ApiRes<T>> => {
  return request({
    method: 'get',
    url,
    params,
    ...config
  })
}

/** POST 请求 */
const post = <T = any>(url: string, params?: object, config?: AxiosRequestConfig): Promise<ApiRes<T>> => {
  return request({
    method: 'post',
    url,
    data: params,
    ...config
  })
}

export default { get, post, request }
