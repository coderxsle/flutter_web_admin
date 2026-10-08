import type * as T from './type'
import { getBaseApi } from '@/apis/base'
import http from '@/utils/http'

export type * from './type'

/** 人物模块 */
export const baseAPI = getBaseApi<T.ListItem>({ baseUrl: '/person' })

/** 获取人员分类树 */
export function getPersonCategoryTree() {
  return http.get<T.CategoryTreeItem[]>('/person/category/tree')
}

/** 获取人员页面字典选项 */
export function getPersonOptions() {
  return http.get<T.PersonOptions>('/person/options')
}
