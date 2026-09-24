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

// 新增 / 更新用户**不再单独开方法**：
// 统一走 `baseAPI.add(submitData)`（`POST /api/user`，body 平铺）
// 与 `baseAPI.update(submitData)`（`POST /api/user/update`，body 平铺且自带 id）。
//
// ⚠️ 旧的 `userAdd` 指向 `/user/userAdd`，而 typed `UserEndpoint` 里**根本没有
// 这个方法**（只有 `add`）→ 一直是 404。这次切换顺带修掉了。

/**
 * 查询用户列表（服务端分页）
 * 响应沿用 PageResponse 契约：`data` 为当前页数组，顶层带 `page` / `pageSize` / `totalPage` / `total`
 *
 * ⚠️ 过滤条件走 **query string**（`GET /api/user?page=&pageSize=&deptId=&status=&username=`），
 * 不再是旧实现的 `{query: {...}}` POST body。
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
  return http.get<ListItem[]>('/user', params.query)
}

/** 重置用户密码（支持批量，统一重置为固定初始密码） —— `POST /api/user/reset-password` */
export function resetPassword(params: { ids: number[] }) {
  return http.post('/user/reset-password', params)
}
