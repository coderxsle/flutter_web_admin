import 'package:flutter_web_server/src/services/airtable/airtable_service.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';

/// airtable 单元格（行列交叉点）的 typed 入口，业务在 [AirtableService]。
class TableItemsEndpoint extends Endpoint {
  /// 写入单元格：同一「行 + 列」已有值则更新，否则新建。
  ///
  /// REST：`POST /api/airtable/items`（body `{fieldId, value, rowId}`）
  Future<CommonResponse> upsertItem(
    Session session,
    int fieldId,
    String value,
    int rowId,
  ) =>
      AirtableService.upsertItem(session, fieldId, value, rowId);

  /// 删除单元格。
  ///
  /// REST：`DELETE /api/airtable/items/{id}`
  Future<CommonResponse> deleteItem(Session session, int id) =>
      AirtableService.deleteItem(session, id);
}
