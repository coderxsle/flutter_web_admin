import { getBaseApi } from '@/apis/base'
import http from '@/utils/http'

/** API 项类型 */
export interface ApiItem {
  id: number
  path: string
  method: string
  summary: string
  tags: string
}

/** 角色列表项类型 */
export interface ListItem {
  id: number
  name: string
  code: string
  type: number
  sort: number
  status: Status
  apis: ApiItem[]
  menus: any[]
  description: string
  disabled: boolean
  userCount: number
  createUserString: string
  createTime: string
}

/** 角色模块 */
export const baseAPI = getBaseApi<ListItem, number>({ baseUrl: '/role' })

/** 角色用户列表项 */
export interface RoleUserItem {
  id: number
  username: string
  nickname: string
  avatar?: string
  status: number
  phone?: string
  deptName?: string
  createTime?: string
  disabled?: boolean
}

/** 获取角色权限 */
export function getRoleMenuIds(params: { roleId: number }) {
  return http.post<number[]>('/role/getRoleMenuIds', params)
}

/** 查询角色用户 */
export function getRoleUsers(params: { roleId: number, pageNum?: number, pageSize?: number, nickname?: string }) {
  return http.post<RoleUserItem[]>('/role/getRoleUsers', params)
}

/** 取消用户角色分配（支持批量） */
export function cancelUserRoles(params: { roleId: number, userIds: number[] }) {
  return http.post('/role/cancelUserRoles', params)
}

/** 保存角色权限 */
export function saveRolePermissions(params: { roleId: number, menuIds: number[] }) {
  return http.post('/role/saveRolePermissions', params)
}
