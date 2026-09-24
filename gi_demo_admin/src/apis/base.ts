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

/**
 * 通用 CRUD 接口 —— 对齐后端 **REST 表现层**（`web/routes/api`，开发环境 8082）。
 *
 * 后端每个资源都由 `serverpod_crud` 的 `BaseRestRoute` 自动产出这一整套路由：
 *
 * | 方法 | 路由 | 说明 |
 * |---|---|---|
 * | `getList`     | `GET {base}?a=1&b=2`  | 过滤条件走 **query string** |
 * | `getDetail`   | `GET {base}/{id}`     | |
 * | `add`         | `POST {base}`         | body **平铺**，成功 201 |
 * | `update`      | `POST {base}/update`  | body **平铺**且**必须自带 `id`** |
 * | `delete`      | `POST {base}/delete`  | `{id}` 单条 / `{ids:[…]}` 批量 |
 * | `deleteBatch` | `POST {base}/delete`  | 同上，语义化别名 |
 *
 * ## ⚠️ 与旧实现的差异（S5 切换）
 *
 * 旧实现打的是 typed Endpoint（8080）那套 `POST {base}/{method}` 形态，
 * 请求体还要按**形参名**包一层（`{params: …}` / `{req: …}`）。本次切换的实质：
 *
 * 1. **`getList` 从 POST body 改成 query string**；`getDetail` 从 `POST /getDetail`
 *    改成 `GET /{id}`；`add` 从 `POST /add` 改成 `POST /`（body 平铺）。
 * 2. `update` / `delete` 的路径**没变**（仍走 `POST /update`、`POST /delete`），
 *    只是 body 不再包一层 —— 后端刻意保留了这两个 POST 别名，
 *    见 `api_routes.dart` 的「项目基本上只用 GET、POST」。
 * 3. `addByJsonParams` / `updateByJsonParams` **已删除**：它们只是为绕开
 *    「typed `dynamic` 形参收不了普通 JSON」打的补丁，REST 侧 body 本来就是
 *    普通 JSON。顺带 `delete` 修掉了旧实现的嵌套 bug（旧代码发的是
 *    `{ id: params }`，即 `{id: {id: 5}}`）。
 *
 * ## ⚠️ `baseUrl` 约定
 *
 * 必须与后端**挂载点完全一致**：A 档资源是**单数 + 连字符**
 * （`/user`、`/dept`、`/role`、`/menu`、`/dict-code`、`/dict-data`），
 * 不是 `/users`、也不是 `/system/dict`。写错会 404。
 */
export function getBaseApi<T, Id = number, P extends DefaultP<Id> = DefaultP<Id>>(params: { baseUrl: string }) {
  const { baseUrl } = params

  const baseApi = {
    /**
     * 列表。过滤条件全部走 query string（`page` / `pageSize` / 资源专属过滤字段）。
     *
     * ⚠️ 后端有一半资源的 `list` 是**非分页**的（dept 树 / menu 树 / 字典两张表
     * 历来返回全表），传 `page` / `pageSize` 不会报错，但也不会有分页效果 ——
     * 这是既有契约，不是这次的回归。
     */
    getList(params?: Record<string, any>) {
      // 兼容历史上 `getList({ query: { ... } })` 的包装写法
      const query = params && typeof params === 'object' && 'query' in params ? (params as any).query : params
      return http.get<T[]>(baseUrl, query ?? {})
    },

    /** 详情：`GET {base}/{id}` */
    getDetail(params: { id: Id } | Id) {
      const isObj = typeof params === 'object' && params !== null
      const id = (isObj ? (params as { id: Id }).id : params) as Id
      return http.get<T>(`${baseUrl}/${id}`)
    },

    /** 新增：`POST {base}`，body 平铺；后端成功返回 201 */
    add(params: P['AddParams']) {
      return http.post<T>(baseUrl, params)
    },

    /**
     * 修改：`POST {base}/update`，body 平铺且**必须包含 `id`**。
     *
     * 后端是 PATCH 语义（先读当前行做基线，只让请求里出现过的字段覆盖它），
     * 所以只传要改的字段即可，没传的不会被写成空值 —— 这正是它比旧 typed
     * `update`（整行覆盖）更安全的地方。
     */
    update(params: P['UpdateParams']) {
      return http.post<T>(`${baseUrl}/update`, params)
    },

    /**
     * 删除：`POST {base}/delete`。
     *
     * 单条传 `{ id }`（也兼容直接传裸 id），批量传 `{ ids: [...] }` ——
     * 后端 `extractIds` 两种都认，长度为 1 时走单条删。
     */
    delete(params: Id | { id: Id } | { ids: Id[] }) {
      const isObj = typeof params === 'object' && params !== null
      const body = (isObj ? params : { id: params }) as Record<string, unknown>
      return http.post<boolean>(`${baseUrl}/delete`, body)
    },

    /** 批量删除：与 `delete({ ids })` 同一条路由，只是入参更直白 */
    deleteBatch(ids: Id[] | P['DeleteBatchParams']) {
      const params = Array.isArray(ids) ? { ids } : ids
      return http.post<P['DeleteBatchResult']>(`${baseUrl}/delete`, params)
    }
  }

  return baseApi
}
