import 'package:flutter_web_server/src/services/airtable/airtable_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// airtable **单元格**资源的 REST 路由（C 档）。
///
/// | 动作 | REST |
/// |---|---|
/// | 按「行 × 列」写入单元格（UPSERT） | `POST /api/airtable/items` |
/// | 删除单元格 | `DELETE /api/airtable/items/:id` |
///
/// ## 为什么写单元格是 `POST /api/airtable/items` 而不是 `PUT`
///
/// 这个操作是 **UPSERT**：`(行, 列)` 这个坐标上已经有值就更新，没有就新建。
/// 调用方**不需要**（也拿不到）单元格 id —— 它手里只有「哪一行 × 哪一列」。
/// 所以 URL 里没有 id 段，用 POST 表达「按坐标写入」；
/// 返回的是**写进去的值**，不是单元格行。
Map<String, RestActionRoute> airtableItemActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    // POST /api/airtable/items —— 按「行 + 列」坐标写入单元格值。
    //
    // body：`{"fieldId": 7, "rowId": 12, "value": "张三"}`。
    // 三个字段都必填，缺任一个 → 400（而不是让它变成「写入空字符串」）。
    '/api/airtable/items': RestActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        return ensureOk(
          await AirtableService.upsertItem(
            session,
            requiredInt(body, 'fieldId'),
            requiredText(body, 'value'),
            requiredInt(body, 'rowId'),
          ),
        );
      },
    ),

    // DELETE /api/airtable/items/:id —— 删除单元格。
    '/api/airtable/items/:id': RestActionRoute(
      methods: const {Method.delete},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(await AirtableService.deleteItem(session, request.pathId())),
    ),
  };
}
