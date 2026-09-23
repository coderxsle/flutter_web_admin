import http from '@/utils/http'

/** 通用批量操作结果 */
export interface BatchOperationResult<Id = number> {
  total: number
  successCount: number
  notFoundCount: number
  successIds: Id[]
  failedIds: Id[]
}

interface DefaultP<Id = number> {
  GetListParams?: Record<string, any>
  GetDetailParams?: { id: Id }
  AddParams?: Record<string, any>
  UpdateParams?: Record<string, any>
  DeleteParams?: { id: Id }
  DeleteBatchParams?: { ids: Id[] }
  DeleteBatchResult?: BatchOperationResult<Id>
}

// 获取基础接口
export function getBaseApi<T, Id = number, P extends DefaultP<Id> = DefaultP<Id>>(params: { baseUrl: string }) {
  const { baseUrl } = params

  const baseApi = {
    // 获取分页列表（无参数走 GET，有参数走 POST）
    getList(params?: P['GetListParams'] & { page?: number, pageSize?: number } | { query: P['GetListParams'] & { page?: number, pageSize?: number } }) {
      return params == null
        ? http.get<T[]>(`${baseUrl}/getList`)
        : http.post<T[]>(`${baseUrl}/getList`, params)
    },
    // 获取详情（有参数统一走 POST）
    getDetail(params: P['GetDetailParams']) {
      return http.post<T>(`${baseUrl}/getDetail`, params)
    },
    // 新增
    add(params: P['AddParams']) {
      return http.post<T>(`${baseUrl}/add`, {params: params})
    },
    // 新增
    // 为了兼容后端 serverpo_crud 自动生成的 add 方法，适合单表新增数据。
    addByJsonParams(params: P['UpdateParams']) {
      return http.post<T>(`${baseUrl}/addByJsonParams`, {params: JSON.stringify(params)})
    },
    // 修改
    update(params: P['UpdateParams']) {
      return http.post<T>(`${baseUrl}/update`, {params: params})
    },
    // 修改
    // 为了兼容后端 serverpo_crud 自动生成的 update 方法，适合单表新增数据。
    updateByJsonParams(params: P['UpdateParams']) {
      return http.post<T>(`${baseUrl}/updateByJsonParams`, {params: JSON.stringify(params)})
    },
    // 删除单个
    delete(params: P['DeleteParams']) {
      return http.post<boolean>(`${baseUrl}/delete`, { id: params })
    },
    // 批量删除
    deleteBatch(ids: Id[] | P['DeleteBatchParams']) {
      const params = Array.isArray(ids) ? { ids } : ids
      return http.post<P['DeleteBatchResult']>(`${baseUrl}/deleteBatch`, params)
    }
  }

  return baseApi
}
