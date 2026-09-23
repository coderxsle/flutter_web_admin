import { getBaseApi, type BatchOperationResult } from '@/apis/base'
import http from '@/utils/http'

export interface ListItem {
  id: number
  createUserString: string
  createTime: string
  disabled: boolean
  deptId: number
  deptName: string
  username: string
  nickname: string
  gender: Gender
  avatar: string
  email: string
  phone: string
  status: Status
  type?: 1 | 2
  isSuperuser?: boolean
  description: string
  roleIds: number[]
  roleNames: string[]
}

/** 用户模块 */
export const baseAPI = getBaseApi<ListItem, number, {
  DeleteBatchParams?: { ids: number[] }
  DeleteBatchResult?: BatchOperationResult<number>
}>({ baseUrl: '/user' })

// 新增用户
export function userAdd(params) {
  return http.post('/user/userAdd', {params: params})
}

// 更新用户
export function userUpdate(params) {
  return http.post('/user/userUpdate', {params: params})
}

/**
 * 查询用户列表（服务端分页）
 * 响应沿用 PageResponse 契约：`data` 为当前页数组，顶层带 `page` / `pageSize` / `totalPage` / `total`
 */
export function getUserList(params: {
  query: {
    page: number
    pageSize: number
    deptId?: number
    status?: string
    username?: string
  }
}) {
  return http.post<ListItem[]>('/user/getUserList', params)
}


/** 重置用户密码（支持批量） */
export function resetPassword(params: { ids: number[] }) {
  return http.post('/user/resetPassword', params)
}
