import 'package:flutter_web_server/src/services/airtable/airtable_service.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';

/// airtable 行的 typed 入口，业务在 [AirtableService]。
///
/// ⚠️ 两个保留的历史形状（REST 侧逐字对齐，没有"顺手变好"）：
/// * [getTableRows] 返回 `PageResponse`（本子系统里唯一这样做的）；
/// * [createRow] 返回 `true` 而不是新行 id。
class TableRowsEndpoint extends Endpoint {
  /// 某张表格下的行（分页），每行带自己的单元格。
  ///
  /// REST：`GET /api/airtable/tables/{id}/rows?page=&pageSize=`
  Future<PageResponse> getTableRows(
    Session session,
    int tableId, {
    int page = 1,
    int pageSize = 20,
    String? keyword,
  }) =>
      AirtableService.getTableRows(
        session,
        tableId,
        page: page,
        pageSize: pageSize,
        keyword: keyword,
      );

  /// 新增一行（不传 `index` 则追加到末尾）。
  ///
  /// REST：`POST /api/airtable/tables/{id}/rows`
  Future<CommonResponse> createRow(
    Session session,
    int tableId, {
    int? index,
  }) =>
      AirtableService.createRow(session, tableId, index: index);

  /// 更新行的排序索引。
  ///
  /// REST：`PUT|POST /api/airtable/rows/{id}`
  Future<CommonResponse> updateRow(Session session, int id, int index) =>
      AirtableService.updateRow(session, id, index);

  /// 删除行（级联删除该行所有单元格）。
  ///
  /// REST：`DELETE /api/airtable/rows/{id}`
  Future<CommonResponse> deleteRow(Session session, int id) =>
      AirtableService.deleteRow(session, id);

  /// 批量删除行，返回 `{'deletedCount': n}`。
  ///
  /// REST：`POST /api/airtable/rows/delete`
  Future<CommonResponse> batchDeleteRows(Session session, List<int> ids) =>
      AirtableService.batchDeleteRows(session, ids);
}
