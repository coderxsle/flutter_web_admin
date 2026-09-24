import type { SelectOptionData } from '@arco-design/web-vue'
import { getBaseApi } from '@/apis/base'
import http from '@/utils/http'

export interface ListItem {
  id: string
  createUserString: string
  createTime: string
  name: string
  code: string
  sort: number
  status: Status
  description: string
}

export type DictDetail = ListItem

export type DictDataItem = {
  id: string
  name: string
  value: string | number
  sort: number
  status: Status
  remark?: string
  createTime?: string
}

/**
 * 字典模块（**字典类型** `/sys_dict_code` 的 CRUD）
 *
 * ⚠️ `baseUrl` 是 `/dict-code` —— 后端挂载点用**单数 + 连字符**
 * （`/api/dict-code`、`/api/dict-data`），不是旧 typed 的 `/system/dict`。
 */
export const baseAPI = getBaseApi<ListItem>({ baseUrl: '/dict-code' })

/**
 * 字典数据列表 —— `GET /api/dict-data?code=&name=&status=`
 *
 * ⚠️ 后端这个 `list` 是**非分页**的（历来返回该字典类型下的全量数据），
 * 传 `page` / `size` 不会报错但也不会有分页效果。
 *
 * ⚠️ 返回类型是**裸数组**（`data: [...]`），不是 `PageRes`（`{records,total}`）——
 * 这里曾误声明为 `PageRes<DictDataItem[]>`，靠 `useTable` 的双形态读法兜住，
 * 现按后端实际形状修正。
 */
export function getDictDataList(params: { code: string, name?: string, status?: string } & Pagination) {
  return http.get<DictDataItem[]>('/dict-data', params)
}

/**
 * 字典数据详情 —— `GET /api/dict-data/:id`
 *
 * ⚠️ 入参里的 `code`（所属字典类型编码）在 REST 侧**不再参与定位**：
 * 旧 typed 要求 `id` 与 `code` 同时命中，REST 只按 `id`（更宽松）。
 */
export function getDictDataDetail(params: { id: string, code: string }) {
  return http.get<DictDataItem>(`/dict-data/${params.id}`)
}

/** 获取字典数据映射（全局下拉 / 登录页用，**匿名可访问**） —— `GET /api/dict/options` */
export function getDictData() {
  return http.get<Record<string, SelectOptionData[]>>('/dict/options')
}
