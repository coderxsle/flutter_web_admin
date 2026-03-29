import { getBaseApi } from '@/apis/base'
import http from '@/utils/http'

export interface ListItem {
  activeMenu: string
  alwaysShow: boolean
  breadcrumb: boolean
  children: ListItem[]
  component: string
  visible: boolean
  icon: string
  id: number
  keepAlive: boolean
  parentId: number
  path: string
  permission: string
  redirect: string
  roles: string[]
  showInTabs: boolean
  sort: number
  status: Status
  title: string
  hidden?: boolean
  type: 1 | 2 | 3
  affix: boolean
}

export interface MenuOptionsItem {
  id: number
  title: string
  type: 1 | 2 | 3
  permission: string
  children: MenuOptionsItem[]
}

/** 菜单模块 */
export const baseAPI = getBaseApi<ListItem, number>({ baseUrl: '/menu' })

/** 获取角色分配权限菜单树 */
export function getMenuOptions() {
  return http.get<MenuOptionsItem[]>('/menu/getMenuOptions')
}
