import type { SelectOptionData } from '@arco-design/web-vue'

// 表格项目
export interface ListItem {
  id: number
  name: string
  account: string
  avatar: string
  gender: Gender
  phone: string
  email: string
  createTime: string
  address: string
  age: number
  status: Status
  hobby: string[]
  remark: string
  categoryId?: string
}

export interface CategoryTreeItem {
  id: string
  name: string
  pid: string | null
  type: number
  disabled?: boolean
  children?: CategoryTreeItem[]
}

export interface PersonOptions {
  STATUS: SelectOptionData[]
  GENDER: SelectOptionData[]
  HOBBY: SelectOptionData[]
}
