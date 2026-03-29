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
