import { getBaseApi } from '@/apis/base'


// "id": 1,
// "tenantId": null,
// "name": "瑞云科技有限公司",
// "parentId": 0,
// "sort": 0,
// "leaderUserId": 1,
// "phone": "0755-12345678",
// "email": "contact@ruiyuntech.com",
// "status": 0,
// "deleted": false,


export interface ListItem {
  id: number
  tenantId: number
  name: string
  parentId: number
  sort: number
  status: Status
  createTime: string
  children?: ListItem[]
  description: string
}

/** 部门模块 */
export const baseAPI = getBaseApi<ListItem>({ baseUrl: '/dept' })
