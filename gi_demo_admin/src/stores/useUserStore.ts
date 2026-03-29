/** @file 用户状态管理模块 - 处理用户登录、权限和信息管理 */

import type { UserInfo } from '@/apis/user'
import { defineStore } from 'pinia'
import { computed, reactive, ref } from 'vue'
import { login as loginApi, getUserInfo as getUserInfoApi, logout as logoutApi } from '@/apis/user'
import { resetRouter } from '@/router'
import { clearToken, getRefreshToken, getToken, setRefreshToken, setToken } from '@/utils/auth'
import { encryptPassword } from '@/utils/crypto'

/** 登录参数接口 */
interface LoginParams {
  username: string
  password: string
  code?: string
}

/** 用户 Store 的核心设置逻辑 - 管理用户相关的状态和操作 */
const storeSetup = () => {
  /** 用户基本信息 */
  const userInfo = reactive<Pick<UserInfo, 'nickname' | 'avatar' | 'tenantId'>>({
    nickname: '',
    avatar: '',
    tenantId: 0
  })

  /** 用户昵称 */
  const name = computed(() => userInfo.nickname)

  /** 用户头像 */
  const avatar = computed(() => userInfo.avatar)

  /** 用户令牌 */
  const token = ref<string>(getToken() || '')

  /** 用户角色列表 */
  const roles = ref<string[]>([])

  /** 用户权限列表 */
  const permissions = ref<string[]>([])

  /** 重置用户令牌 - 清除令牌并重置路由权限标志 */
  const resetToken = () => {
    token.value = ''
    clearToken()
  }

  /**
   * 用户登录
   * @description 处理用户登录请求并保存令牌
   * @param {LoginParams} params - 登录参数
   * @throws {Error} 当登录失败时抛出错误
   */
  const login = async (params: LoginParams): Promise<void> => {
    try {
      // 先使用 RSA 公钥加密密码，再携带 encrypted 标记调用登录接口
      const encryptedPassword = await encryptPassword(params.password)
      const res = await loginApi({ username: params.username, password: encryptedPassword })
      const { accessToken: newToken, refreshToken: newRefreshToken } = res.data
      setToken(newToken)
      setRefreshToken(newRefreshToken)
      token.value = newToken
    } catch (error) {
      console.error('登录失败:', error)
      throw error
    }
  }

  /**
   * 用户退出
   * @description 处理用户退出请求并清除状态
   * @returns {Promise<boolean>} 退出是否成功
   */
  const logout = async (): Promise<boolean> => {
    try {
      await logoutApi()
      // 清除用户状态
      token.value = ''
      roles.value = []
      permissions.value = []
      resetToken()
      resetRouter()
      return true
    } catch (error) {
      console.error('退出失败:', error)
      return false
    }
  }

  /**
   * 获取用户信息
   * @description 获取用户详细信息，包括角色和权限
   * @throws {Error} 当获取用户信息失败时抛出错误
   */
  const getInfo = async (): Promise<void> => {
    try {
      const res = await getUserInfoApi()
      const {
        nickname,
        avatar: userAvatar,
        tenantId,
        roles: userRoles,
        permissions: userPermissions,
        isSuperuser
      } = res.data

      // 更新用户基本信息
      userInfo.nickname = nickname || '用户'
      userInfo.avatar = userAvatar || ''
      userInfo.tenantId = Number(tenantId) || 0

      // 更新用户角色和权限，确保是数组
      // 不再自动赋予 admin，仅保留原始的角色数据，若为空则赋值空数组
      roles.value = Array.isArray(userRoles) ? userRoles : []
      permissions.value = Array.isArray(userPermissions) ? userPermissions : []
    } catch (error) {
      console.error('获取用户信息失败:', error)
      throw error
    }
  }

  /**
   * 更新令牌（仅用于开发测试）
   * @description 用于模拟令牌过期场景
   * @param {string} value - 新的令牌值
   */
  const editToken = (value: string): void => {
    token.value = value
    setToken(value)
  }

  return {
    userInfo,
    name,
    avatar,
    token,
    roles,
    permissions,
    login,
    logout,
    getInfo,
    resetToken,
    editToken
  }
}

/**
 * 用户状态管理 Store
 * @description 创建用户相关的状态管理 store，使用 localStorage 进行持久化存储
 */
export const useUserStore = defineStore('user', storeSetup, {
  persist: {
    pick: ['token'],
    storage: localStorage
  }
})
