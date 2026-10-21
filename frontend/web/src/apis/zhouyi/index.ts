import http from '@/utils/http'

/**
 * 术数排盘记录（`arts_record`）
 *
 * 奇门/八字共用一张表：起盘参数与盘面快照以 JSON 落库，
 * 后端返回时已解析成对象（解析失败时是原始文本）。
 */
export interface ArtsRecord {
  id: number
  tenant_id: number
  user_id: number
  arts_type: string
  client_key: string
  title: string
  question: string
  chart_time: string
  query_params?: unknown
  chart_snapshot?: unknown
  interpretation: string
  feedback: string
  tags: string[]
  status: number
  create_time: string
  update_time: string
}

export interface ArtsRecordQuery {
  arts_type?: string
  keyword?: string
  start_time?: string
  end_time?: string
  user_id?: number
}

export const zhouyiApi = {
  artsRecord: {
    list: (params: ArtsRecordQuery & { page?: number, pageSize?: number }) =>
      http.get<PageRes<ArtsRecord[]>>('/lxs_arts/record/list', params),
    detail: (id: number) => http.get<ArtsRecord>(`/lxs_arts/record/detail/${id}`),
    /** 新增按 (租户, 用户, client_key) 幂等：重发同一个 key 只会覆盖原记录 */
    save: (data: Partial<ArtsRecord> & { arts_type: string, client_key: string }) =>
      http.post<ArtsRecord>('/lxs_arts/record/save', data),
    update: (id: number, data: Partial<ArtsRecord>) => http.post<ArtsRecord>(`/lxs_arts/record/update/${id}`, data),
    remove: (ids: number[]) => http.post<{ deleted: number[] }>('/lxs_arts/record/delete', { ids }),
    status: (id: number, status: number) => http.post<unknown>('/lxs_arts/record/status', { ids: [id], status })
  }
}
