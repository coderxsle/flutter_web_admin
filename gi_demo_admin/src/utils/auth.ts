/** Token 存储键名 */
const TOKEN_KEY = 'token'
const REFRESH_TOKEN_KEY = 'refreshToken'

/**
 * 检查用户是否已登录
 * @description 通过检查 localStorage 中是否存在 token 来判断用户登录状态
 * @returns {boolean} 是否已登录
 */
const isLogin = () => {
  return !!localStorage.getItem(TOKEN_KEY)
}

/**
 * 获取用户 Token
 * @description 从 localStorage 中获取存储的 token
 * @returns {string | null} 用户 token，未登录时返回 null
 */
const getToken = () => {
  return localStorage.getItem(TOKEN_KEY)
}

/**
 * 设置用户 Token
 * @description 将用户 token 存储到 localStorage 中
 * @param token - 用户 token
 */
const setToken = (token: string) => {
  localStorage.setItem(TOKEN_KEY, token)
}

/**
 * 清除用户 Token
 * @description 从 localStorage 中移除用户 token
 */
const clearToken = () => {
  localStorage.removeItem(TOKEN_KEY)
  localStorage.removeItem(REFRESH_TOKEN_KEY)
}

/**
 * 获取刷新 Token
 * @description 从 localStorage 中获取存储的 refresh_token
 * @returns {string | null} 刷新 token，未登录时返回 null
 */
const getRefreshToken = () => {
  return localStorage.getItem(REFRESH_TOKEN_KEY)
}

/**
 * 设置刷新 Token
 * @description 将刷新 token 存储到 localStorage 中
 * @param refreshToken - 刷新 token
 */
const setRefreshToken = (refreshToken: string) => {
  localStorage.setItem(REFRESH_TOKEN_KEY, refreshToken)
}

export { clearToken, getRefreshToken, getToken, isLogin, setRefreshToken, setToken }
