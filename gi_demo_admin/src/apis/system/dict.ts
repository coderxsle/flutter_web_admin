import type { SelectOptionData } from '@arco-design/web-vue'
import { getBaseApi } from '@/apis/base'
import http from '@/utils/http'

export interface ListItem {
  id: number
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
  id: number
  name: string
  value: string | number
  color?: string
  sort?: number
  description?: string
  status: number
}

/** 字典模块  废弃！*/
export const baseAPI = getBaseApi<ListItem>({ baseUrl: '/dict' })

// ==================================================
//                  字典类型相关接口
// ==================================================

/** 新增字典编码 */
export function addDictCode(params: object | undefined) {
  return http.post<ListItem>('/dict/addDictCode', params)
}

/** 删除字典编码 */
export function deleteDictCode(params: { ids: number[] }) {
  return http.post<boolean>('/dict/deleteDictCode', params)
}

/** 更新字典编码 */
export function updateDictCode(params: { req: {} }) {
  return http.post<ListItem>('/dict/updateDictCode', params)
}

/** 字典编码列表 */
export function getDictCodeList(params: { page?: number, size?: number }) {
  return http.post<DictDataItem[]>('/dict/getDictCodeList', params)
}

/** 字典编码列表 */
export function list(params: { page?: number, pageSize?: number, keyword?: string }) {
  return http.post<DictDataItem[]>('/product/getList', { query: params })
}
/** 字典编码列表 */
export function delete111(params) {
  return http.post<DictDataItem[]>('/product/delete', { id: params })
}

/** 字典数据详情 */
export function getDictCodeDetail(params: { id: number, code: string }) {
  return http.post<ListItem>('/dict/getDictCodeDetail', params)
}


// ==================================================
//               字典数据相关接口
// ==================================================

/** 新增字典数据 */
export function addDictData(params) {
  return http.post<DictDataItem>('/dict/addDictData', params)
}

/** 删除字典数据 */
export function deleteDictData(params: { ids: number[] }) {
  return http.post<boolean>('/dict/deleteDictData', params)
}

/** 更新字典数据 */
export function updateDictData(params: { id: number, code: string, name: string, value: string, color?: string, sort?: number, description?: string, status: number }) {
  return http.post<DictDataItem>('/dict/updateDictData', { req: params })
}

/** 获取字典数据映射 */
export function getDictData() {
  return http.get<Record<string, SelectOptionData[]>>('/dict/getDictData')
}

/** 字典数据列表 */
export function getDictDataList(params: { code: string } & Pagination) {
  return http.post<DictDataItem[]>('/dict/getDictDataList', params)
}

/** 字典数据详情 */
export function getDictDataDetail(params: { id: number, code: string }) {
  return http.post<DictDataItem>('/dict/getDictDataDetail', params)
}


