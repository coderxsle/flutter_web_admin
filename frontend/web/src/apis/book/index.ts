import { getBaseApi, type BatchOperationResult } from '@/apis/base'
import http from '@/utils/http'

/** 图书（表 `book`）—— 字段与后端 `models/book/book.spy.yaml` 对齐 */
export interface ListItem {
  id: number
  tenantId?: number | null
  categoryId?: number | null
  /** 书名（必填，与 isbn 共同组成唯一约束） */
  name: string
  isbn?: string | null
  author?: string | null
  keyword?: string | null
  publisher?: string | null
  /** 封面图片 URL */
  image?: string | null
  /** 定价（必填） */
  originalPrice: number
  isDeleted?: boolean | null
  createTime?: string | null
  updateTime?: string | null
}

/** add / update 的提交载荷（body 平铺，update 需自带 id） */
export interface BookForm {
  id?: number
  name: string
  isbn?: string
  author?: string
  keyword?: string
  publisher?: string
  image?: string
  originalPrice: number | null
  categoryId?: number | null
}

/**
 * 图书模块 —— 后端 `registerBookRoutes(pod)`（`BookRestRoute` 一次挂载）
 *
 * 标准六条动作路径：`getList` / `getDetail` / `add` / `update` / `delete` / `deleteBatch`，
 * 外加 `/isbn-check`，全部由 `BaseRoute` 在 `/api/book` 一个挂载点内一次产出。
 */
export const baseAPI = getBaseApi<ListItem, number, {
  DeleteBatchParams?: { ids: number[] }
  DeleteBatchResult?: BatchOperationResult<number>
}>({ baseUrl: '/book' })

/**
 * 查询图书列表（服务端分页）—— `GET /api/book/getList`
 *
 * `keyword` 由后端 `BookRestRoute.keywordFields` 限定为
 * **OR 命中 书名 / ISBN / 作者 / 出版社** —— 未配置时会把表里所有 String 列
 * （含封面图 URL）都当命中目标，所以这里不要把 `image` 当作搜索词传进来。
 *
 * 响应形状：`data = { records, total, page, pageSize, totalPage }`
 * —— 分页元信息全部在 `data` 内，顶层只有 `code` / `message`。
 */
export function getBookList(params: { page: number, pageSize: number, keyword?: string }) {
  // 列表沿用 system/user 的写法直接走 http：baseAPI.getList 的分页参数名是模板残留的 `size`，
  // 与后端的 `pageSize` 不一致。
  return http.get<PageRes<ListItem[]>>('/book/getList', {
    page: params.page,
    pageSize: params.pageSize,
    keyword: params.keyword || undefined
  })
}

/** 新增图书 —— `POST /api/book/add` */
export function addBook(data: BookForm) {
  return baseAPI.add(data)
}

/** 更新图书 —— `POST /api/book/update`（body 平铺且自带 id，PATCH 语义） */
export function updateBook(data: BookForm) {
  return baseAPI.update(data)
}

/** 删除单条图书 —— `POST /api/book/delete`，body `{ id }` */
export function deleteBook(id: number) {
  return baseAPI.delete({ id })
}
