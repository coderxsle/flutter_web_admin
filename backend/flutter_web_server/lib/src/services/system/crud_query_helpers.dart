/// 查询条件 / 分页入参的构造小工具。
///
/// 这些是 `QueryEngine` 词汇（`QueryCondition` / `QuerySort` / `QueryDTO`）的糖，
/// 供业务 Service 拼 `BaseService.getList` 的入参用 —— 目前只有 `user_service.dart`
/// 在用（用户列表有 9 个专用过滤字段，最需要它）。
///
/// 放在这里而不是 `crud_engines.dart`：那个文件的职责是「6 个资源的引擎」，
/// 不该兼当查询工具箱。
library;

import 'package:flutter_web_server/src/common/common.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 分页参数的统一收敛：`< 1` → [QueryDTO.defaultPageSize]，`> CrudConfig.maxPageSize` → 上限。
///
/// 收敛一次是为了**元信息一致** —— `QueryDTO.pageSize` 会被直接写进 `PageResponse`，
/// 早收敛才能保证「报出去的 pageSize」与实际 `limit` 相同。
QueryDTO buildCrudQuery({
  int? page,
  int? pageSize,
  List<QueryCondition>? filters,
  List<QuerySort>? sort,
  String? keyword,
}) {
  final rawPage = page ?? 1;
  final rawPageSize = pageSize ?? QueryDTO.defaultPageSize;
  final safePageSize = rawPageSize < 1 ? QueryDTO.defaultPageSize : rawPageSize;
  return QueryDTO(
    page: rawPage < 1 ? 1 : rawPage,
    pageSize: safePageSize > CrudConfig.maxPageSize ? CrudConfig.maxPageSize : safePageSize,
    filters: filters,
    sort: sort,
    keyword: keyword,
  );
}

/// `eq` 过滤条件。
QueryCondition condEq(String field, Object? value) => QueryCondition(field: field, comparator: 'eq', value: value);

/// `like` 过滤条件。
///
/// ⚠️ 只传**裸值**：`QueryEngine` 内部会拼成 `LIKE '%value%'`，自己再包一层 `%`
/// 会变成 `%%value%%` —— 结果通常相同，但别依赖这个巧合。
QueryCondition condLike(String field, String value) => QueryCondition(field: field, comparator: 'like', value: value);

/// `in` 过滤条件（用于 `deptId` 的「本部门 + 所有子孙部门」这类集合过滤）。
QueryCondition condIn(String field, Iterable<Object?> values) =>
    QueryCondition(field: field, comparator: 'in', value: values.toList());

/// 升序排序条件。
QuerySort sortAsc(String field) => QuerySort(field: field);

/// `CrudPage<T>` → 分页信封。
///
/// 契约：`data = {records, total, page, pageSize, totalPage}` —— 当前页数组在
/// `data.records` 里，元信息也收在 `data` 里；顶层只有 `code` / `message`。
/// 前端读 `res.data.records` / `res.data.total`。
///
/// [toJson] 由调用方决定用哪个序列化：
/// * `T.toJsonForProtocol()` —— **不含** `serverOnly` 字段（如 `SysUser.password`），
///   业务 Service 的既有用法都是这个；
/// * `T.toJson()` —— 含 `serverOnly`，只在服务端内部用，**不要直接返回给前端**。
PageResponse<Map<String, dynamic>> crudPageResponse<T extends TableRow>(
  CrudPage<T> page,
  Map<String, dynamic> Function(T item) toJson,
) => PageResponse<Map<String, dynamic>>.success(
  page.data.map(toJson).toList(growable: false),
  page: page.page,
  pageSize: page.pageSize,
  total: page.total,
);
