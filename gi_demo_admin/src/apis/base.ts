import http from '@/utils/http'

interface DefaultP<Id = number> {
  GetListParams?: Record<string, any>
  GetDetailParams?: { id: Id }
  AddParams?: Record<string, any>
  UpdateParams?: Record<string, any>
  DeleteParams?: { id: Id }
  DeleteBatchParams?: { ids: Id[] }
  DeleteBatchResult?: BatchOperationResult<Id>
}

/** 通用批量操作结果 */
export interface BatchOperationResult<Id = number> {
  total: number
  successCount: number
  notFoundCount: number
  successIds: Id[]
  failedIds: Id[]
}



// 获取基础接口
export function getBaseApi<T, Id = number, P extends DefaultP<Id> = DefaultP<Id>>(params: { baseUrl: string }) {
  const { baseUrl } = params

  const baseApi = {
    // 列表
    getList(params?: P['GetListParams'] & { page?: number, size?: number }) {
        return http.get<PageRes<T[]>>(`${baseUrl}/getList`, params)
    },

    // 详情
    getDetail(params: P['GetDetailParams']) {
      return http.get<T>(`${baseUrl}/getDetail`, params)
    },

    // 新增
    add(params: P['AddParams']) {
      return http.post<T>(`${baseUrl}/add`, params)
    },

    // 修改
    update(params: P['UpdateParams']) {
      return http.post<T>(`${baseUrl}/update`, params)
    },

    // 删除
    delete(params: P['DeleteParams']) {
      return http.post<boolean>(`${baseUrl}/delete`, params)
    },

    // 批量删除
    deleteBatch(ids: Id[] | P['DeleteBatchParams']) {
      const params = Array.isArray(ids) ? { ids } : ids
      return http.post<P['DeleteBatchResult']>(`${baseUrl}/deleteBatch`, params)
    }
  }

  return baseApi
}
