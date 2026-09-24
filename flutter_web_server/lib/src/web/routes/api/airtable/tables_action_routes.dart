import 'package:flutter_web_server/src/services/airtable/airtable_service.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/airtable_route_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// airtable **表格**资源的 REST 路由（迁移路线 S4 / C 档）。
///
/// | typed 方法 | REST |
/// |---|---|
/// | `getTables(Pagination)` | `GET /api/airtable/tables` |
/// | `createTable(name)` | `POST /api/airtable/tables` |
/// | `tableDetail(id)` | `GET /api/airtable/tables/:id` |
/// | `updateTable(id, name)` | `PUT\|POST /api/airtable/tables/:id` |
/// | `deleteTable(id)` | `DELETE /api/airtable/tables/:id` |
/// | ~~`getTables2(...)`~~ | **已合并进 `GET /api/airtable/tables`** |
///
/// ## 两个结构性说明
///
/// ### 1. 为什么 airtable 全部手写路由，没套泛型 `BaseRestRoute`
///
/// A 档 6 个资源是「一张主表 + 一套固定 CRUD」，所以 `BaseRestRoute` +
/// `RestCrudDelegate` 能自动产出 8 条路由。airtable 不是这个形状：
///
/// * 它是**四层嵌套子系统**（表 → 字段 / 行 → 单元格 → 关联），
///   `fields` / `rows` 是「某张表下」的子资源，泛型层 `GET /` 的语义
///   （按租户分页全表）在这里是错的；
/// * 删除是**级联物理删**，不是软删，与泛型的 `delete` 语义相反；
/// * 写操作的返回值也不统一（新建返回 id / 返回 `true` / 返回整行 / 返回详情）。
///
/// 所以 S4 的选择是：**补上 `tenantId` / `deleted` 两列让结构与 A 档对齐，
/// 但路由全部手写**。补列的价值是「租户隔离 + 过滤口径统一 + 结构一致」，
/// 不是「必须套泛型」。
///
/// ### 2. 为什么「同一路径」只用一条 [RestActionRoute]
///
/// `addRoute(route, path)` 的挂载点是**唯一**的（同一字符串挂两次抛
/// `Conflicting values`）。所以 `GET /tables` 与 `POST /tables` 不能各写一条，
/// 必须用 [RestActionRoute.byMethod] 合并成一条、在内部按 `request.method` 分派。
Map<String, RestActionRoute> airtableTableActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    // /api/airtable/tables
    //
    // · GET  —— 分页列表。query：`page`（默认 1）、`pageSize`（默认 20，
    //           `page_size` 也认）、`keyword`（按表格名模糊）。
    //           返回 `PageResponse` 形状，信封直接采用它的 `toJson()`，
    //           因此与 typed 逐字节一致。
    // · POST —— 新建表格。body `{"name": "客户台账"}`，
    //           成功返回**新表格 id**（裸整数，不是整行，也没有 201）。
    '/api/airtable/tables': RestActionRoute.byMethod(
      envelope: envelope,
      handlers: {
        Method.get: (session, request) async => ensureOk(
          await AirtableService.getTables(session, paginationOf(request)),
        ),
        Method.post: (session, request) async {
          final body = await request.jsonObjectBody();
          return ensureOk(
            await AirtableService.createTable(
              session,
              requiredText(body, 'name'),
            ),
          );
        },
      },
    ),

    // /api/airtable/tables/:id
    //
    // · GET    —— 详情（字段列表 + 字段数 / 行数）。
    // · PUT|POST —— 重命名。body `{"name": "新名字"}`，返回**更新后的详情**
    //              （与 GET 同结构）。PUT 是 REST 语义上更合适的一个，
    //              POST 是按项目「只用 GET / POST」的习惯给的别名。
    // · DELETE —— 删除表格。
    //
    // ⚠️ 这是**级联物理删除**：字段 / 行 / 单元格一并从库里消失，不可恢复。
    // `deleted` 列这次没有参与（理由见 `AirtableService.deleteTable`）。
    '/api/airtable/tables/:id': RestActionRoute.byMethod(
      envelope: envelope,
      handlers: {
        Method.get: (session, request) async => ensureOk(
          await AirtableService.tableDetail(session, request.pathId()),
        ),
        Method.put: (session, request) async {
          final body = await request.jsonObjectBody();
          return ensureOk(
            await AirtableService.updateTable(
              session,
              request.pathId(),
              requiredText(body, 'name'),
            ),
          );
        },
        Method.post: (session, request) async {
          final body = await request.jsonObjectBody();
          return ensureOk(
            await AirtableService.updateTable(
              session,
              request.pathId(),
              requiredText(body, 'name'),
            ),
          );
        },
        Method.delete: (session, request) async => ensureOk(
          await AirtableService.deleteTable(session, request.pathId()),
        ),
      },
    ),
  };
}
