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

// ⚠️ 下面四条打的是 `/api/role/:id/**` 的**子资源动作路由**（不是 CRUD）。
// 路径参数一律叫 `:id`（不能起 `:roleId` —— 后端 PathTrie 同层参数名不一致会
// 在注册期直接抛，服务起不来）。

/** 获取角色已分配的菜单 ID 列表 —— `GET /api/role/:id/menu-ids` */
export function getRoleMenuIds(params: { roleId: number }) {
  return http.get<number[]>(`/role/${params.roleId}/menu-ids`)
}

/**
 * 查询角色下的用户（分页 + 昵称模糊）
 * —— `GET /api/role/:id/users?page=&pageSize=&nickname=`
 *
 * ⚠️ 入参的 `pageNum` 映射到后端 query 的 `page`（后端不认 `pageNum`）。
 */
export function getRoleUsers(params: { roleId: number, pageNum?: number, pageSize?: number, nickname?: string }) {
  return http.get<RoleUserItem[]>(`/role/${params.roleId}/users`, {
    page: params.pageNum,
    pageSize: params.pageSize,
    nickname: params.nickname
  })
}

/** 取消用户角色分配（支持批量） —— `POST /api/role/:id/users/remove`，body `{userIds}` */
export function cancelUserRoles(params: { roleId: number, userIds: number[] }) {
  return http.post(`/role/${params.roleId}/users/remove`, { userIds: params.userIds })
}

/**
 * 保存角色权限（**全量替换**菜单集） —— `POST /api/role/:id/menus`，body `{menuIds}`
 *
 * 后端同时注册了 PUT 与 POST（项目只用 GET/POST），语义是「让这个角色的菜单集合
 * 恰好等于传进来的这些」—— 所以 `menuIds: []` 是合法的，表示清空权限。
 */
export function saveRolePermissions(params: { roleId: number, menuIds: number[] }) {
  return http.post(`/role/${params.roleId}/menus`, { menuIds: params.menuIds })
}
