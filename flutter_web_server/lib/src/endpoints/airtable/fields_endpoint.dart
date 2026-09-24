import 'package:flutter_web_server/src/services/airtable/airtable_service.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';

/// airtable 字段（列）的 typed 入口，业务在 [AirtableService]。
///
/// ## ⚠️ S4 的破坏性签名变更
///
/// [updateField] / [deleteField] 的第一个参数从 **`String fieldName`** 改成了
/// **`int id`**。两个原因：
///
/// 1. 按名字定位无法处理重名，也不符合 `PUT /fields/:id` 这类 REST 惯例；
/// 2. 原实现是错的 —— `updateField` 里写的是
///    `field[0].field = fieldName.trim()`（把原值写回），改名永远不生效。
///
/// 前端 `gi_demo_admin` 完全不调用 airtable（已核对），所以没有兼容成本。
class AirTableFieldsEndpoint extends Endpoint {
  /// 某张表格下的字段列表。
  ///
  /// REST：`GET /api/airtable/tables/{id}/fields`
  Future<CommonResponse> getAirTableFields(Session session, int tableId) =>
      AirtableService.getAirTableFields(session, tableId);

  /// 在表格下新建字段。
  ///
  /// REST：`POST /api/airtable/tables/{id}/fields`
  Future<CommonResponse> createField(
    Session session,
    int tableId,
    String fieldName,
  ) =>
      AirtableService.createField(session, tableId, fieldName);

  /// 重命名字段（S4 已从 `fieldName` 改为 `id`，见类注释）。
  ///
  /// REST：`PUT|POST /api/airtable/fields/{id}`
  Future<CommonResponse> updateField(
    Session session,
    int id,
    String newName,
  ) =>
      AirtableService.updateField(session, id, newName);

  /// 删除字段（级联删除该列所有单元格）。S4 已从 `fieldName` 改为 `id`。
  ///
  /// REST：`DELETE /api/airtable/fields/{id}`
  Future<CommonResponse> deleteField(Session session, int id) =>
      AirtableService.deleteField(session, id);
}
