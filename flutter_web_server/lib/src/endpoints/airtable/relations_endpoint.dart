import 'package:flutter_web_server/src/services/airtable/airtable_service.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';

/// airtable「单元格关联」相关的 typed 入口，业务在 [AirtableService]。
///
/// 这一组是**只读视图**：给「把某个单元格关联到另一张表的某个单元格」这个交互
/// 提供候选数据，本身不改任何东西。
class TableItemRelationsEndpoint extends Endpoint {
  /// 某个单元格的关联信息（本单元格 + 它指向的表格 / 字段 / 单元格）。
  ///
  /// REST：`GET /api/airtable/items/{id}/relations`
  Future<CommonResponse> getItemRelations(Session session, int id) =>
      AirtableService.getItemRelations(session, id);

  /// 在某张表格里搜索可作为关联目标的单元格（分页）。
  ///
  /// REST：`GET /api/airtable/tables/{id}/searchable-items`
  Future<PageResponse> searchTableItems(
    Session session,
    int tableId,
    Pagination pagination, {
    int? fieldId,
  }) =>
      AirtableService.searchTableItems(
        session,
        tableId,
        pagination,
        fieldId: fieldId,
      );

  /// 所有可作为关联目标的表格。
  ///
  /// REST：`GET /api/airtable/relations/tables`
  Future<CommonResponse> getAvailableTables(Session session) =>
      AirtableService.getAvailableTables(session);

  /// 指定表格的所有字段（用于挑选关联字段）。
  ///
  /// REST：`GET /api/airtable/relations/tables/{id}/fields`
  Future<CommonResponse> getTableFieldsForRelation(
    Session session,
    int tableId,
  ) =>
      AirtableService.getTableFieldsForRelation(session, tableId);
}
