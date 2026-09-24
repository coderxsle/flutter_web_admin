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

/** 字典模块（**字典类型** `/sys_dict_code` 的 CRUD）。挂载点 `/api/dictCode`。 */
export const baseAPI = getBaseApi<ListItem>({ baseUrl: '/dictCode' })

/**
 * 字典数据列表 —— `GET /api/dictData/getList?code=&name=&status=`
 *
 * ⚠️ 后端这个 list **非分页**（历来返回该类型下全量），传 `page`/`size` 无效果；
 * 返回**裸数组**，不是 `PageRes`（只有 `/api/user/getList` 分页）。
 */
export function getDictDataList(params: { code: string, name?: string, status?: string } & Pagination) {
  return http.get<DictDataItem[]>('/dictData/getList', params)
}

/**
 * 字典数据详情 —— `GET /api/dictData/getDetail?id=`（**id 走 query**）。
 *
 * ⚠️ 形参 `code` 在 REST 侧**不参与定位**（旧 typed 要求 id+code 同时命中），保留只为不改调用方。
 */
export function getDictDataDetail(params: { id: string, code: string }) {
  return http.get<DictDataItem>('/dictData/getDetail', { id: params.id })
}

/** 获取字典数据映射（全局下拉 / 登录页用，**匿名可访问**） —— `GET /api/dict/options` */
export function getDictData() {
  return http.get<Record<string, SelectOptionData[]>>('/dict/options')
}
