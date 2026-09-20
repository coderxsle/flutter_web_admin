export interface UserInfo {
  id: number
  username: string
  nickname: string
  avatar: string | null
  email: string
  phone: string | null
  gender: number
  status: number
  deptId: number
  tenantId: number
  postIds: string | null
  remark: string | null
  isSuperuser: boolean
  loginIp: string | null
  loginTime: string | null
  createTime: string
  updateTime: string
  roles: string[]
  permissions: string[]
}

export interface Login {
  accessToken: string
  refreshToken: string
  username: string
  tokenType: string
  expiresIn: number
}

export interface UserRouteItem {
  activeMenu: string
  alwaysShow: boolean
  breadcrumb: boolean
  children: UserRouteItem[]
  component: string
  hidden: boolean
  icon: string
  id: string
  keepAlive: boolean
  parentId: string
  path: string
  permission: string
  redirect: string
  roles: string[]
  showInTabs: boolean
  sort: number
  status: Status
  title: string
  type: 1 | 2 | 3
  affix: boolean
}
