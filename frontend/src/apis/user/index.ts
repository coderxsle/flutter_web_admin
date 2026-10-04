import type * as T from './type'
import http from '@/utils/http'

export type * from './type'

/** 登录 —— `POST /api/auth/login`，body `{username, password}`（password 为 RSA 密文） */
export function login(data: { username: string, password: string }) {
  return http.post<T.Login>('/auth/login', data)
}

/**
 * 退出登录 —— `POST /api/auth/logout`
 * @description 显式带上当前 token：调用方随即会清本地，不能指望拦截器再读一次
 */
export function logout(accessToken: string | null) {
  return http.post('/auth/logout', undefined, {
    headers: accessToken ? { Authorization: `Bearer ${accessToken}` } : undefined
  })
}

/** 获取当前登录用户信息 —— `GET /api/user/info` */
export const getUserInfo = () => {
  return http.get<T.UserInfo>('/user/info')
}

/** 获取当前登录用户的动态路由树 —— `GET /api/user/routes` */
export const getUserRoutes = () => {
  return http.get<T.UserRouteItem[]>('/user/routes')
}

/** 刷新 token —— `POST /api/auth/refreshToken` */
export function refreshToken(refreshToken: string) {
  return http.post<T.Login>('/auth/refreshToken', { refreshToken })
}
