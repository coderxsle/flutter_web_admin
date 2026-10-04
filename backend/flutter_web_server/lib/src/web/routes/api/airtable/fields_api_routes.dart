import 'package:flutter_web_server/src/services/airtable/airtable_service.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// airtable **字段（列）**资源的 REST 路由（C 档）。
///
/// | 动作 | REST |
/// |---|---|
/// | 表格的字段列表 | `GET /api/airtable/tables/:id/fields` |
/// | 新建字段 | `POST /api/airtable/tables/:id/fields` |
/// | 改名 | `PUT\|POST /api/airtable/fields/:id` |
/// | 删除 | `DELETE /api/airtable/fields/:id` |
///
/// ## ⚠️ 这一层的路径参数**必须叫 `:id`**
///
/// `/api/airtable/tables/:id` 这一层被本组与 `rows`、`relations` 共用。
/// relic 的 `PathTrie` 在**注册阶段**就校验「同一层的参数名是否一致」——
/// 混用 `:id` 与 `:tableId` 会直接抛
/// `Conflicting parameter names at the same level`，**服务根本起不来**。
/// 所以 `tables/:id/fields` 里的 `:id` 指的是**表格** id，靠位置而非名字表达语义。
///
/// ## 字段的寻址方式在 S4 改过
///
/// 改造前 `updateField` / `deleteField` 按**字段名**定位，REST 侧改成按 **id**。
/// 除了符合 `PUT /fields/:id` 的惯例，更因为原实现里
/// `field[0].field = fieldName.trim()` 是**把原值写回** —— 「改名」一直是个
/// 静默空操作。详见 `AirtableService.updateField`。
Map<String, ActionRoute> airtableFieldActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    // /api/airtable/tables/:id/fields
    //
    // · GET  —— 该表下的字段列表（全量，不分页）。
    // · POST —— 新建字段。body `{"fieldName": "手机号"}`（兼容 `name`），
    //           成功返回**新建的整行字段**。
    '/api/airtable/tables/:id/fields': ActionRoute.byMethod(
      envelope: envelope,
      handlers: {
        Method.get: (session, request) async => ensureOk(
          await AirtableService.getAirTableFields(session, request.pathId()),
        ),
        Method.post: (session, request) async {
          final body = await request.jsonObjectBody();
          return ensureOk(
            await AirtableService.createField(
              session,
              request.pathId(),
              _fieldNameOf(body),
            ),
          );
        },
      },
    ),

    // /api/airtable/fields/:id
    //
    // · PUT|POST —— 重命名字段。body `{"newName": "联系电话"}`，返回更新后的整行。
    // · DELETE   —— 删除字段。⚠️ 级联：该列下所有单元格一并物理删除。
    '/api/airtable/fields/:id': ActionRoute.byMethod(
      envelope: envelope,
      handlers: {
        Method.put: (session, request) async {
          final body = await request.jsonObjectBody();
          return ensureOk(
            await AirtableService.updateField(
              session,
              request.pathId(),
              requiredText(body, 'newName'),
            ),
          );
        },
        Method.post: (session, request) async {
          final body = await request.jsonObjectBody();
          return ensureOk(
            await AirtableService.updateField(
              session,
              request.pathId(),
              requiredText(body, 'newName'),
            ),
          );
        },
        Method.delete: (session, request) async => ensureOk(
          await AirtableService.deleteField(session, request.pathId()),
        ),
      },
    ),
  };
}

/// 读字段名：`fieldName` / `field_name` 优先，退回 `name`；都缺 → 400。
String _fieldNameOf(Map<String, dynamic> body) {
  for (final key in const ['fieldName', 'field_name', 'name']) {
    if (body.containsKey(key)) return requiredText(body, key);
  }
  throw const RestException.badRequest('fieldName 不能为空');
}
