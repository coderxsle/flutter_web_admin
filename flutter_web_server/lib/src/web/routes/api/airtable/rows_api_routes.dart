import 'package:flutter_web_server/src/services/airtable/airtable_service.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/airtable_route_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// airtable **行**资源的 REST 路由（C 档）。
///
/// | 动作 | REST |
/// |---|---|
/// | 行的分页列表 | `GET /api/airtable/tables/:id/rows` |
/// | 新增行 | `POST /api/airtable/tables/:id/rows` |
/// | 调整行序号 | `PUT\|POST /api/airtable/rows/:id` |
/// | 删除行 | `DELETE /api/airtable/rows/:id` |
/// | 批量删除行 | `POST /api/airtable/rows/delete` |
///
/// ## 三个刻意沿用的历史形状（没有"顺手修好"）
///
/// 1. `GET .../rows` 返回 **`PageResponse`**（airtable 里唯一这样做的），
///    且 `keyword` 参数**从未被使用** —— REST 侧干脆不挂这个 query，
///    免得看起来像能用；
/// 2. `POST .../rows` 成功返回 **`true`**，不是新行 id；
/// 3. `POST /rows/delete` 返回 `{'deletedCount': n}`，**一条都没命中时仍然返回
///    成功信封**。所以这里用 [countOf] 显式判 404，而不是 `ensureOk` 了事。
///
/// ## 为什么批量删挂在字面量 `/rows/delete`
///
/// 与 A 档「批量删走 POST」是同一条约定（项目基本上只用 GET / POST）。
/// 字面量段 `delete` 与参数段 `:id` 同层不冲突 —— relic 的 trie
/// **字面量优先于参数段**，所以 `POST /rows/delete` 不会被 `POST /rows/:id`
/// 吃掉（有测试钉住这条）。
Map<String, ActionRoute> airtableRowActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    // /api/airtable/tables/:id/rows
    //
    // · GET  —— 该表下的行（分页），每行带自己的单元格。
    //           query：`page`（默认 1）、`pageSize`（默认 20，`page_size` 也认）。
    // · POST —— 新增一行。body `{"index": 5}`，`index` 可省略
    //           （省略时自动取「当前最大 index + 1」）。返回 `true`。
    '/api/airtable/tables/:id/rows': ActionRoute.byMethod(
      envelope: envelope,
      handlers: {
        Method.get: (session, request) async {
          final pagination = paginationOf(request);
          return ensureOk(
            await AirtableService.getTableRows(
              session,
              request.pathId(),
              page: pagination.page,
              pageSize: pagination.pageSize,
            ),
          );
        },
        Method.post: (session, request) async {
          final body = await request.jsonObjectBody();
          return ensureOk(
            await AirtableService.createRow(
              session,
              request.pathId(),
              index: intOrNull(body['index']),
            ),
          );
        },
      },
    ),

    // /api/airtable/rows/delete —— 批量删除行。
    //
    // body：`{"ids": [1,2,3]}`（单值 `id` 也认，见 `requiredIntList` 的宽松解析）。
    // 返回 `{'deletedCount': n}`。
    //
    // ⚠️ **一条都没命中时要给 404**：Service 在「传进来的 id 全都不存在」与
    // 「删掉了 3 条」两种情况下返回的都是成功信封，光看 `code` 分不出来。
    // 这也顺带覆盖了「不属于本租户」的行 —— 查不到就等于不存在。
    //
    // ⚠️ 必须写在 `/rows/:id` **之前**读起来才顺，但实际匹配顺序由 trie 决定：
    // 字面量 `delete` 优先于参数段，与 Map 里的先后无关。
    '/api/airtable/rows/delete': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final ids = requiredIntList(body, 'ids', aliases: const ['id']);
        final res = ensureOk(
          await AirtableService.batchDeleteRows(session, ids),
        );
        if (countOf(res, 'deletedCount') == 0) {
          throw RestException.notFound('要删除的行不存在或已删除');
        }
        return res;
      },
    ),

    // /api/airtable/rows/:id
    //
    // · PUT|POST —— 更新行的排序索引。body `{"index": 3}`（必填，这是本接口
    //               唯一能改的字段）。返回 `{id, index, tablesId, itemsCount}`。
    // · DELETE   —— 删除一行。⚠️ 级联：该行所有单元格一并物理删除。
    '/api/airtable/rows/:id': ActionRoute.byMethod(
      envelope: envelope,
      handlers: {
        Method.put: (session, request) async {
          final body = await request.jsonObjectBody();
          return ensureOk(
            await AirtableService.updateRow(
              session,
              request.pathId(),
              requiredInt(body, 'index'),
            ),
          );
        },
        Method.post: (session, request) async {
          final body = await request.jsonObjectBody();
          return ensureOk(
            await AirtableService.updateRow(
              session,
              request.pathId(),
              requiredInt(body, 'index'),
            ),
          );
        },
        Method.delete: (session, request) async => ensureOk(
          await AirtableService.deleteRow(session, request.pathId()),
        ),
      },
    ),
  };
}
