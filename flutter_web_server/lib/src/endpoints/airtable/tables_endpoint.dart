import 'package:flutter_web_server/src/services/airtable/airtable_service.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';

/// airtable 表格的 typed 入口。
///
/// ## S4 之后这里只剩「参数搬运」
///
/// 业务逻辑已全部收敛到 [AirtableService]，本类与 REST 层
/// （`lib/src/web/routes/api/airtable/tables_action_routes.dart`）**共用同一份实现**。
/// 这是 REST 表现层落地的前提：Route 不碰业务，typed Endpoint 也不再自带业务。
///
/// ## S4 的签名变化
///
/// * 删除了 `getTables2` —— 它与 [getTables] 逐行等价（只是入参形式不同），
///   属于重复实现。统一保留入参更完整的 [getTables]（`Pagination` 带排序字段）。
class TablesEndpoint extends Endpoint {
  /// 表格分页列表。
  ///
  /// REST：`GET /api/airtable/tables?page=&pageSize=&keyword=`
  Future<CommonResponse> getTables(Session session, Pagination pagination) =>
      AirtableService.getTables(session, pagination);

  /// 表格详情（含字段列表与统计）。
  ///
  /// REST：`GET /api/airtable/tables/{id}`
  Future<CommonResponse> tableDetail(Session session, int id) =>
      AirtableService.tableDetail(session, id);

  /// 新建表格，返回新表格 id。
  ///
  /// REST：`POST /api/airtable/tables`
  Future<CommonResponse> createTable(Session session, String name) =>
      AirtableService.createTable(session, name);

  /// 重命名表格。
  ///
  /// REST：`PUT|POST /api/airtable/tables/{id}`
  Future<CommonResponse> updateTable(Session session, int id, String name) =>
      AirtableService.updateTable(session, id, name);

  /// 删除表格（级联删除字段 / 行 / 单元格）。
  ///
  /// REST：`DELETE /api/airtable/tables/{id}`
  Future<CommonResponse> deleteTable(Session session, int id) =>
      AirtableService.deleteTable(session, id);
}
