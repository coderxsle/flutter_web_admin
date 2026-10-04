import { getBaseApi, type BatchOperationResult } from '@/apis/base'
import http from '@/utils/http'

export interface ListItem {
  id: number
  /** 创建者。后端给的是 userIdentifier，用户模块没做昵称翻译（与 dictCode 不同） */
  creator?: string
  createTime: string
  disabled: boolean
  deptId: number
  /** 部门名。后端按 deptId 反查补齐（列表与详情都有） */
  deptName?: string
  username: string
  nickname: string
  gender: Gender
  avatar?: string
  email?: string
  phone?: string
  status: Status
  type?: 1 | 2
  isSuperuser?: boolean
  description?: string
  /** 详情接口（getDetail）才有 */
  roleIds?: number[]
  roles?: { id: number, name: string }[]
}

/** 用户模块 */
export const baseAPI = getBaseApi<ListItem, number, {
  DeleteBatchParams?: { ids: number[] }
  DeleteBatchResult?: BatchOperationResult<number>
}>({ baseUrl: '/user' })

// 新增 / 更新用户**不再单独开方法**：
// 统一走 `baseAPI.add(submitData)`（`POST /api/user/add`，body 平铺）
// 与 `baseAPI.update(submitData)`（`POST /api/user/update`，body 平铺且自带 id）。
//
// ⚠️ 旧的 `userAdd` 指向 `/user/userAdd`，而 typed `UserEndpoint` 里**根本没有
// 这个方法**（只有 `add`）→ 一直是 404。这次切换顺带修掉了。

/**
 * 查询用户列表（服务端分页） —— `GET /api/user/getList`
 *
 * ⚠️ 路径是团队式的 `/getList`（一动作一路径），过滤条件走 **query string**：
 * `GET /api/user/getList?page=&pageSize=&deptId=&status=&keyword=`
 *
 * 搜索统一走 `keyword`：后端会 `OR` 命中 **用户名 / 昵称 / 手机号** 三个字段
 * （`_UserEngine` 的 `keywordFields`）。**不要再用 `username` 当搜索框** ——
 * `username` 是登录名（如 `liu.jie`），而用户在界面上看到想搜的通常是「姓名」
 * （`nickname`），只给 `username` 会出现「明明有这个人却搜不到」。
 *
 * 响应形状：`data = { records, total, page, pageSize, totalPage }` ——
 * 分页元信息**全部在 `data` 里**，顶层只有 `code` / `message`。
 */
export function getUserList(params: {
  query: {
    page: number
    pageSize: number
    deptId?: number
    status?: string
    /** 关键词：OR 命中 用户名 / 昵称 / 手机号 */
    keyword?: string
    username?: string
  }
}) {
  return http.get<PageRes<ListItem[]>>('/user/getList', params.query)
}

/** 重置用户密码（支持批量，统一重置为固定初始密码） —— `POST /api/user/reset-password` */
export function resetPassword(params: { ids: number[] }) {
  return http.post('/user/reset-password', params)
}
