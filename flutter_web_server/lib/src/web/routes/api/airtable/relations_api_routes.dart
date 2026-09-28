import 'package:flutter_web_server/src/services/airtable/airtable_service.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/airtable_route_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// airtable **关联**相关的 REST 路由（C 档）。
///
/// 这一组全部是**只读视图**，服务于「把某个单元格关联到另一张表的某个单元格」
/// 这个交互的候选数据，本身不改任何东西。
///
/// | 动作 | REST |
/// |---|---|
/// | 单元格的关联列表 | `GET /api/airtable/items/:id/relations` |
/// | 可选为关联项的条目（分页） | `GET /api/airtable/tables/:id/searchable-items` |
/// | 可作为关联目标的表格 | `GET /api/airtable/relations/tables` |
/// | 目标表格的字段（供关联选择） | `GET /api/airtable/relations/tables/:id/fields` |
///
/// ## 为什么另起 `/api/airtable/relations/...` 这一支
///
/// `getAvailableTables` / `getTableFieldsForRelation` 返回的不是「表格资源」
/// 也不是「字段资源」，而是**给关联选择器用的精简候选列表**
/// （`[{id, name}]` / `[{id, field}]`），与 `/api/airtable/tables`（分页的
/// `PageResponse`）、`/tables/:id/fields`（整行字段）形状都不同。
/// 再造一条同名路径会和上面两条撞车，所以给关联选择器单独一支前缀 ——
/// 与 S3 里 `/api/dict/options` 另起挂载点是同一个理由。
Map<String, ActionRoute> airtableRelationActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    // GET /api/airtable/items/:id/relations —— 某个单元格的关联信息。
    //
    // 返回 `{itemId, value, tiedTable, tiedField, tiedItem}`，
    // 其中三个 `tied*` 都可能为 `null`（没关联就是 null，不是空对象）。
    //
    // ⚠️ S4 修过一个 bug：`tiedItem` 原本取的是 `item.id`（它自己），
    // 所以永远指向本行；现在取外键 `itemId`。见 `AirtableService.getItemRelations`。
    '/api/airtable/items/:id/relations': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async => ensureOk(
        await AirtableService.getItemRelations(session, request.pathId()),
      ),
    ),

    // GET /api/airtable/tables/:id/searchable-items —— 搜索可作为关联目标的单元格。
    //
    // query：`page`（默认 1）、`pageSize`（默认 20）、`keyword`（按单元格值模糊）、
    //        `fieldId`（限定某一列，可选）。
    //
    // ⚠️ S4 修过一个 bug：这个接口原本恒定返回空页 —— 它在 `AirTableRows` 上
    // 写了 `where: (t) => t.id.equals(tableId)`（拿 row.id 比 tableId），
    // 于是「该表下所有行」永远算成空集合。
    '/api/airtable/tables/:id/searchable-items': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async {
        final pagination = paginationOf(request);
        return ensureOk(
          await AirtableService.searchTableItems(
            session,
            request.pathId(),
            pagination,
            fieldId:
                request.queryInt('fieldId') ?? request.queryInt('field_id'),
          ),
        );
      },
    ),

    // GET /api/airtable/relations/tables —— 所有可作为关联目标的表格（`[{id, name}]`）。
    '/api/airtable/relations/tables': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(await AirtableService.getAvailableTables(session)),
    ),

    // GET /api/airtable/relations/tables/:id/fields —— 指定表格的字段（`[{id, field}]`）。
    '/api/airtable/relations/tables/:id/fields': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async => ensureOk(
        await AirtableService.getTableFieldsForRelation(
          session,
          request.pathId(),
        ),
      ),
    ),
  };
}
