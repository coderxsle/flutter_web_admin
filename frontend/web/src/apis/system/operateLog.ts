import http from '@/utils/http'

/** 操作日志（对应表 sys_operate_log） */
export interface ListItem {
  id: number
  tenantId: number
  /** 链路追踪编号，同一业务流程的多条日志共用 */
  traceId: string
  userId: number
  userType: number
  /** 操作模块类型，如 user / dept / role */
  type: string
  /** 操作名，如 create / update / delete */
  subType: string
  bizId: number
  /** 操作内容 */
  action: string
  success: boolean
  /** 拓展字段，JSON 字符串（含 before / after / actorId 等） */
  extra: string
  requestMethod?: string
  requestUrl?: string
  userIp?: string
  userAgent?: string
  creator?: string
  createTime: string
}

export interface ListParams {
  page: number
  pageSize: number
  /** 操作模块类型，精确匹配 */
  type?: string
  /** 操作结果：'true' 成功 / 'false' 失败 */
  success?: string
  /** 关键词：OR 命中操作名 / 操作内容 / 操作人 / IP / TraceId */
  keyword?: string
  /** 创建时间范围，格式 YYYY-MM-DD HH:mm:ss */
  startTime?: string
  endTime?: string
}

/**
 * 操作日志列表 —— `GET /api/operateLog/getList`
 *
 * 日志由审计单向写入，后端只提供读接口，没有 add / update / delete。
 */
export function getOperateLogList(params: ListParams) {
  return http.get<PageRes<ListItem[]>>('/operateLog/getList', params)
}

/** 操作日志详情 —— `GET /api/operateLog/getDetail` */
export function getOperateLogDetail(params: { id: number }) {
  return http.get<ListItem>('/operateLog/getDetail', params)
}
