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
  return http.post('/user/userAdd', params)
}

// 查询用户列表，支持平级字段筛选
export function getUserList(params) {
  return http.post<ListItem[]>('/user/getUserList', params)
}


/** 重置用户密码（支持批量） */
export function resetPassword(params: { ids: number[] }) {
  return http.post('/user/resetPassword', params)
}
