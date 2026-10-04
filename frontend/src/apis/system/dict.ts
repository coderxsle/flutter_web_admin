import type { SelectOptionData } from '@arco-design/web-vue'
import { getBaseApi } from '@/apis/base'
import http from '@/utils/http'

export interface ListItem {
  /** 后端是 int（自增主键），不是 mock 里的字符串编号 */
  id: number
  /** 创建者（后端字段）。字典类型列表里后端已翻译成用户昵称；不要再用 mock 的 createUserString */
  creator: string
  createTime: string
  name: string
  code: string
  sort: number
  status: Status
  description: string
}

export type DictDetail = ListItem

export type DictDataItem = {
  id: number
  name: string
  value: string | number
  sort: number
  status: Status
  /** 备注（后端字段叫 description，不是 mock 的 remark） */
  description?: string
  createTime?: string
}

/**
 * 字典模块（**字典类型** `/sys_dict_code` 的 CRUD）
 *
 * ⚠️ `baseUrl` 是 `/dict-code` —— 后端挂载点用**单数 + 连字符**
 * （`/api/dictCode`、`/api/dictData`），不是旧 typed 的 `/system/dict`。
 */
export const baseAPI = getBaseApi<ListItem>({ baseUrl: '/dictCode' })

/**
 * 字典数据列表 —— `GET /api/dictData/getList?code=&name=&status=`
 *
 * ⚠️ 后端这个 `list` 是**非分页**的（历来返回该字典类型下的全量数据），
 * 传 `page` / `size` 不会报错但也不会有分页效果。
 *
 * ⚠️ 返回类型是**裸数组**（`data: [...]`），不是 `PageRes`（`{records,total}`）——
 * 有分页的只有 `/api/user/getList`；其余 5 个资源的列表都返回数组或树。
 */
export function getDictDataList(params: { code: string, name?: string, status?: string } & Pagination) {
  return http.get<DictDataItem[]>('/dictData/getList', params)
}

/**
 * 字典数据详情 —— `GET /api/dictData/getDetail?id=`
 *
 * ⚠️ 路径改成团队式的 `/getDetail`，**id 走 query 参数**（不是路径参数）。
 *
 * ⚠️ 入参里的 `code`（所属字典类型编码）在 REST 侧**不再参与定位**：
 * 旧 typed 要求 `id` 与 `code` 同时命中，REST 只按 `id`（更宽松）。
 * 保留这个形参只是为了不改调用方。
 */
export function getDictDataDetail(params: { id: number, code: string }) {
  return http.get<DictDataItem>('/dictData/getDetail', { id: params.id })
}

/** 获取字典数据映射（全局下拉 / 登录页用，**匿名可访问**） —— `GET /api/dict/options` */
export function getDictData() {
  return http.get<Record<string, SelectOptionData[]>>('/dict/options')
}
