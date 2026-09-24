/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:flutter_web_client/src/protocol/book/book.dart' as _ifg1dsbg;
import 'package:flutter_web_client/src/protocol/system/sys_dict_data.dart'
    as _i1abtrbi;
import 'package:flutter_web_client/src/protocol/system/sys_role.dart'
    as _idql57qq;
import 'package:flutter_web_shared/flutter_web_shared.dart' as _iq2hfrj8;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

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
/// {@category Endpoint}
class EndpointAirTableFields extends _isc.EndpointRef {
  EndpointAirTableFields(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'airTableFields';

  /// 某张表格下的字段列表。
  ///
  /// REST：`GET /api/airtable/tables/{id}/fields`
  _ida.Future<_iq2hfrj8.CommonResponse> getAirTableFields(int tableId) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'airTableFields',
        'getAirTableFields',
        {'tableId': tableId},
      );

  /// 在表格下新建字段。
  ///
  /// REST：`POST /api/airtable/tables/{id}/fields`
  _ida.Future<_iq2hfrj8.CommonResponse> createField(
    int tableId,
    String fieldName,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'airTableFields',
    'createField',
    {'tableId': tableId, 'fieldName': fieldName},
  );

  /// 重命名字段（S4 已从 `fieldName` 改为 `id`，见类注释）。
  ///
  /// REST：`PUT|POST /api/airtable/fields/{id}`
  _ida.Future<_iq2hfrj8.CommonResponse> updateField(int id, String newName) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'airTableFields',
        'updateField',
        {'id': id, 'newName': newName},
      );

  /// 删除字段（级联删除该列所有单元格）。S4 已从 `fieldName` 改为 `id`。
  ///
  /// REST：`DELETE /api/airtable/fields/{id}`
  _ida.Future<_iq2hfrj8.CommonResponse> deleteField(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'airTableFields',
        'deleteField',
        {'id': id},
      );
}

/// airtable 单元格（行列交叉点）的 typed 入口，业务在 [AirtableService]。
/// {@category Endpoint}
class EndpointTableItems extends _isc.EndpointRef {
  EndpointTableItems(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tableItems';

  /// 写入单元格：同一「行 + 列」已有值则更新，否则新建。
  ///
  /// REST：`POST /api/airtable/items`（body `{fieldId, value, rowId}`）
  _ida.Future<_iq2hfrj8.CommonResponse> upsertItem(
    int fieldId,
    String value,
    int rowId,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'tableItems',
    'upsertItem',
    {'fieldId': fieldId, 'value': value, 'rowId': rowId},
  );

  /// 删除单元格。
  ///
  /// REST：`DELETE /api/airtable/items/{id}`
  _ida.Future<_iq2hfrj8.CommonResponse> deleteItem(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableItems',
        'deleteItem',
        {'id': id},
      );
}

/// airtable「单元格关联」相关的 typed 入口，业务在 [AirtableService]。
///
/// 这一组是**只读视图**：给「把某个单元格关联到另一张表的某个单元格」这个交互
/// 提供候选数据，本身不改任何东西。
/// {@category Endpoint}
class EndpointTableItemRelations extends _isc.EndpointRef {
  EndpointTableItemRelations(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tableItemRelations';

  /// 某个单元格的关联信息（本单元格 + 它指向的表格 / 字段 / 单元格）。
  ///
  /// REST：`GET /api/airtable/items/{id}/relations`
  _ida.Future<_iq2hfrj8.CommonResponse> getItemRelations(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableItemRelations',
        'getItemRelations',
        {'id': id},
      );

  /// 在某张表格里搜索可作为关联目标的单元格（分页）。
  ///
  /// REST：`GET /api/airtable/tables/{id}/searchable-items`
  _ida.Future<_iq2hfrj8.PageResponse<dynamic>> searchTableItems(
    int tableId,
    _iq2hfrj8.Pagination pagination, {
    int? fieldId,
  }) => caller.callServerEndpoint<_iq2hfrj8.PageResponse<dynamic>>(
    'tableItemRelations',
    'searchTableItems',
    {'tableId': tableId, 'pagination': pagination, 'fieldId': fieldId},
  );

  /// 所有可作为关联目标的表格。
  ///
  /// REST：`GET /api/airtable/relations/tables`
  _ida.Future<_iq2hfrj8.CommonResponse> getAvailableTables() =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableItemRelations',
        'getAvailableTables',
        {},
      );

  /// 指定表格的所有字段（用于挑选关联字段）。
  ///
  /// REST：`GET /api/airtable/relations/tables/{id}/fields`
  _ida.Future<_iq2hfrj8.CommonResponse> getTableFieldsForRelation(
    int tableId,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'tableItemRelations',
    'getTableFieldsForRelation',
    {'tableId': tableId},
  );
}

/// airtable 行的 typed 入口，业务在 [AirtableService]。
///
/// ⚠️ 两个保留的历史形状（REST 侧逐字对齐，没有"顺手变好"）：
/// * [getTableRows] 返回 `PageResponse`（本子系统里唯一这样做的）；
/// * [createRow] 返回 `true` 而不是新行 id。
/// {@category Endpoint}
class EndpointTableRows extends _isc.EndpointRef {
  EndpointTableRows(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tableRows';

  /// 某张表格下的行（分页），每行带自己的单元格。
  ///
  /// REST：`GET /api/airtable/tables/{id}/rows?page=&pageSize=`
  _ida.Future<_iq2hfrj8.PageResponse<dynamic>> getTableRows(
    int tableId, {
    required int page,
    required int pageSize,
    String? keyword,
  }) => caller.callServerEndpoint<_iq2hfrj8.PageResponse<dynamic>>(
    'tableRows',
    'getTableRows',
    {
      'tableId': tableId,
      'page': page,
      'pageSize': pageSize,
      'keyword': keyword,
    },
  );

  /// 新增一行（不传 `index` 则追加到末尾）。
  ///
  /// REST：`POST /api/airtable/tables/{id}/rows`
  _ida.Future<_iq2hfrj8.CommonResponse> createRow(int tableId, {int? index}) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableRows',
        'createRow',
        {'tableId': tableId, 'index': index},
      );

  /// 更新行的排序索引。
  ///
  /// REST：`PUT|POST /api/airtable/rows/{id}`
  _ida.Future<_iq2hfrj8.CommonResponse> updateRow(int id, int index) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableRows',
        'updateRow',
        {'id': id, 'index': index},
      );

  /// 删除行（级联删除该行所有单元格）。
  ///
  /// REST：`DELETE /api/airtable/rows/{id}`
  _ida.Future<_iq2hfrj8.CommonResponse> deleteRow(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableRows',
        'deleteRow',
        {'id': id},
      );

  /// 批量删除行，返回 `{'deletedCount': n}`。
  ///
  /// REST：`POST /api/airtable/rows/delete`
  _ida.Future<_iq2hfrj8.CommonResponse> batchDeleteRows(List<int> ids) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableRows',
        'batchDeleteRows',
        {'ids': ids},
      );
}

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
/// {@category Endpoint}
class EndpointTables extends _isc.EndpointRef {
  EndpointTables(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tables';

  /// 表格分页列表。
  ///
  /// REST：`GET /api/airtable/tables?page=&pageSize=&keyword=`
  _ida.Future<_iq2hfrj8.CommonResponse> getTables(
    _iq2hfrj8.Pagination pagination,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'tables',
    'getTables',
    {'pagination': pagination},
  );

  /// 表格详情（含字段列表与统计）。
  ///
  /// REST：`GET /api/airtable/tables/{id}`
  _ida.Future<_iq2hfrj8.CommonResponse> tableDetail(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tables',
        'tableDetail',
        {'id': id},
      );

  /// 新建表格，返回新表格 id。
  ///
  /// REST：`POST /api/airtable/tables`
  _ida.Future<_iq2hfrj8.CommonResponse> createTable(String name) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tables',
        'createTable',
        {'name': name},
      );

  /// 重命名表格。
  ///
  /// REST：`PUT|POST /api/airtable/tables/{id}`
  _ida.Future<_iq2hfrj8.CommonResponse> updateTable(int id, String name) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tables',
        'updateTable',
        {'id': id, 'name': name},
      );

  /// 删除表格（级联删除字段 / 行 / 单元格）。
  ///
  /// REST：`DELETE /api/airtable/tables/{id}`
  _ida.Future<_iq2hfrj8.CommonResponse> deleteTable(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tables',
        'deleteTable',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointBook extends _isc.EndpointRef {
  EndpointBook(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'book';

  /// 创建图书
  _ida.Future<_iq2hfrj8.CommonResponse> createBook(_ifg1dsbg.Book book) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'book',
        'createBook',
        {'book': book},
      );

  /// 更新图书
  _ida.Future<_iq2hfrj8.CommonResponse> updateBook(_ifg1dsbg.Book book) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'book',
        'updateBook',
        {'book': book},
      );

  /// 删除图书
  _ida.Future<_iq2hfrj8.CommonResponse> deleteBook(_ifg1dsbg.Book book) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'book',
        'deleteBook',
        {'book': book},
      );

  /// 获取图书
  _ida.Future<_iq2hfrj8.CommonResponse> getBook(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('book', 'getBook', {
        'id': id,
      });

  /// 获取所有图书
  _ida.Future<_iq2hfrj8.PageResponse<dynamic>> list({
    required int page,
    required int pageSize,
  }) => caller.callServerEndpoint<_iq2hfrj8.PageResponse<dynamic>>(
    'book',
    'list',
    {'page': page, 'pageSize': pageSize},
  );
}

/// {@category Endpoint}
class EndpointAuth extends _isc.EndpointRef {
  EndpointAuth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  /// 用户登录接口（使用 JwtTokenManager 签发 accessToken / refreshToken）
  _ida.Future<_iq2hfrj8.CommonResponse> login(
    String username,
    String password,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('auth', 'login', {
    'username': username,
    'password': password,
  });

  /// 无需登录即可获取登录用 RSA 公钥（PEM 字符串）
  _ida.Future<_iq2hfrj8.CommonResponse> publicKey() => caller
      .callServerEndpoint<_iq2hfrj8.CommonResponse>('auth', 'publicKey', {});

  /// 使用 refreshToken 刷新 accessToken（无需已登录）
  _ida.Future<_iq2hfrj8.CommonResponse> refreshToken(String refreshToken) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'auth',
        'refreshToken',
        {'refreshToken': refreshToken},
      );
}

/// {@category Endpoint}
class EndpointDept extends _isc.EndpointRef {
  EndpointDept(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dept';

  /// 获取部门树（按租户过滤，默认系统租户）
  /// 返回结构：id、parentId、name、sort、status、createTime、description、children
  _ida.Future<_iq2hfrj8.CommonResponse> getList({
    String? status,
    String? name,
  }) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('dept', 'getList', {
    'status': status,
    'name': name,
  });

  /// 新增部门
  ///
  /// [req] 部门信息
  _ida.Future<_iq2hfrj8.CommonResponse> add(_iq2hfrj8.DeptRequest req) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('dept', 'add', {
        'req': req,
      });

  _ida.Future<_iq2hfrj8.CommonResponse> update(_iq2hfrj8.DeptRequest req) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('dept', 'update', {
        'req': req,
      });

  /// 获取部门详情
  ///
  /// [id] 部门ID
  /// 返回值：部门详情
  _ida.Future<_iq2hfrj8.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('dept', 'getDetail', {
        'id': id,
      });

  /// 删除部门（软删除，支持批量）
  ///
  /// [ids] 部门ID列表
  /// 返回值：处理结果汇总
  _ida.Future<_iq2hfrj8.CommonResponse> delete(List<int> ids) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('dept', 'delete', {
        'ids': ids,
      });
}

/// 字典管理接口
///
/// - 字典类型：sys_dict_type
/// - 字典数据：sys_dict_data
/// - 提供基础的增删改查能力
/// {@category Endpoint}
class EndpointDict extends _isc.EndpointRef {
  EndpointDict(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dict';

  /// 获取字典数据（按字典类型分组）
  ///
  /// 返回数据格式：{ "TYPE": [{"label":"xxx","value":1,"tagProps":{...}}] }
  _ida.Future<_iq2hfrj8.CommonResponse> getDictData({int? tenantId}) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'dict',
        'getDictData',
        {'tenantId': tenantId},
      );

  /// 获取字典类型列表
  ///
  /// [tenantId] 租户ID
  /// [name] 字典名称（模糊匹配）
  /// [type] 字典类型（模糊匹配）
  /// [status] 状态（0=停用 1=正常）
  /// 返回值：字典类型列表
  _ida.Future<_iq2hfrj8.CommonResponse> getDictCodeList({
    int? tenantId,
    String? name,
    String? code,
    String? status,
  }) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'dict',
    'getDictCodeList',
    {'tenantId': tenantId, 'name': name, 'code': code, 'status': status},
  );

  /// 获取字典类型详情
  ///
  /// [id] 字典类型ID
  /// 返回值：字典类型详情
  _ida.Future<_iq2hfrj8.CommonResponse> getDictCodeDetail(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'dict',
        'getDictCodeDetail',
        {'id': id},
      );

  /// 新增字典类型
  ///
  /// [req] 字典类型信息
  _ida.Future<_iq2hfrj8.CommonResponse> addDictCode(
    _iq2hfrj8.DictCodeRequest req,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'dict',
    'addDictCode',
    {'req': req},
  );

  /// 更新字典类型
  ///
  /// [req] 字典类型信息（需包含 id）
  _ida.Future<_iq2hfrj8.CommonResponse> updateDictCode(
    _iq2hfrj8.DictCodeRequest req,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'dict',
    'updateDictCode',
    {'req': req},
  );

  /// 删除字典类型（软删除，支持批量）
  ///
  /// [ids] 字典类型ID列表
  /// 返回值：处理结果汇总
  _ida.Future<_iq2hfrj8.CommonResponse> deleteDictCode(List<int> ids) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'dict',
        'deleteDictCode',
        {'ids': ids},
      );

  /// 获取字典数据列表
  ///
  /// [tenantId] 租户ID
  /// [dictType] 字典类型编码
  /// [name] 字典名称（模糊匹配）
  /// [value] 字典键值（模糊匹配）
  /// [status] 状态（0=停用 1=正常）
  /// 返回值：字典数据列表
  _ida.Future<_iq2hfrj8.CommonResponse> getDictDataList({
    int? tenantId,
    String? code,
    String? name,
    String? value,
    int? status,
  }) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'dict',
    'getDictDataList',
    {
      'tenantId': tenantId,
      'code': code,
      'name': name,
      'value': value,
      'status': status,
    },
  );

  /// 新增字典数据
  ///
  /// [req] 字典数据信息
  _ida.Future<_iq2hfrj8.CommonResponse> addDictData(
    _iq2hfrj8.DictDataRequest req,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'dict',
    'addDictData',
    {'req': req},
  );

  /// 更新字典数据
  ///
  /// [req] 字典数据信息（需包含 id）
  _ida.Future<_iq2hfrj8.CommonResponse> updateDictData(
    _i1abtrbi.SysDictData req,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'dict',
    'updateDictData',
    {'req': req},
  );

  /// 删除字典数据（软删除，支持批量）
  ///
  /// [ids] 字典数据ID列表
  /// 返回值：处理结果汇总
  _ida.Future<_iq2hfrj8.CommonResponse> deleteDictData(List<int> ids) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'dict',
        'deleteDictData',
        {'ids': ids},
      );

  /// 获取字典数据详情
  ///
  /// [id] 字典数据ID
  /// [code] 字典数据编码
  /// 返回值：字典类型详情
  _ida.Future<_iq2hfrj8.CommonResponse> getDictDataDetail(
    int id,
    String code,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'dict',
    'getDictDataDetail',
    {'id': id, 'code': code},
  );
}

/// {@category Endpoint}
class EndpointMenu extends _isc.EndpointRef {
  EndpointMenu(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'menu';

  /// 添加菜单接口
  _ida.Future<_iq2hfrj8.CommonResponse> add(_iq2hfrj8.MenuRequest req) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('menu', 'add', {
        'req': req,
      });

  /// 删除菜单（软删除，支持批量）
  ///
  /// [ids] 菜单ID列表
  /// 返回值：处理结果汇总
  _ida.Future<_iq2hfrj8.CommonResponse> delete(List<int> ids) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('menu', 'delete', {
        'ids': ids,
      });

  /// 更新菜单信息
  ///
  /// [req] 菜单信息（需包含 id）
  _ida.Future<_iq2hfrj8.CommonResponse> update(_iq2hfrj8.MenuRequest req) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('menu', 'update', {
        'req': req,
      });

  /// 获取当前登录用户的菜单树（合并用户所有角色的菜单）
  ///
  /// 返回值：菜单树列表
  _ida.Future<_iq2hfrj8.CommonResponse> getMenuOptions() =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'menu',
        'getMenuOptions',
        {},
      );

  /// 获取菜单列表
  ///
  /// [name] 菜单名称（模糊匹配）
  /// [status] 菜单状态（1=启用，0=停用）
  /// 返回值：菜单列表（按 sort、id 升序）
  _ida.Future<_iq2hfrj8.CommonResponse> getList([
    String? name,
    String? status,
  ]) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('menu', 'getList', {
    'name': name,
    'status': status,
  });

  /// 获取菜单详情
  ///
  /// [id] 菜单ID
  /// 返回值：菜单详情
  _ida.Future<_iq2hfrj8.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('menu', 'getDetail', {
        'id': id,
      });
}

/// 图书模块的示例 Endpoint。
///
/// ## ⚠️ S5 只做了「退裸」，没有删除
///
/// 它原先继承 `BaseEndpoint<Book, BookTable>` —— 注意类型参数写的是 `Book`
/// 而不是 `Product`（复制粘贴遗留）。`Book` / `BookTable` 只是用来给基类装配
/// 通用 CRUD 的，本类**自己那两个方法完全没用到它们**，所以退成裸 [Endpoint]
/// 后行为不变。
///
/// 同时消失的是继承来的那 6 条路由（`getList` / `update` / `delete` /
/// `deleteBatch` / `addByJsonParams` / `updateByJsonParams`）—— 这个模块是
/// 半成品，typed 侧和 REST 侧都没接，属于上游模板遗留。
/// {@category Endpoint}
class EndpointProduct extends _isc.EndpointRef {
  EndpointProduct(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'product';

  /// 获取产品详情
  ///
  /// ⚠️ 实现是空壳（`ProductService` 直接返回一个固定 `CommonResponse`）。
  _ida.Future<_iq2hfrj8.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'product',
        'getDetail',
        {'id': id},
      );

  /// 查询价格历史
  ///
  /// ⚠️ 同样是空壳。
  _ida.Future<_iq2hfrj8.CommonResponse> getPriceList() =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'product',
        'getPriceList',
        {},
      );
}

/// 规则相关接口
///
/// 当前仅提供一个基础的列表查询接口，后续可以根据具体业务补充
/// 创建、编辑、删除等方法，并接入真实数据库模型。
/// {@category Endpoint}
class EndpointRole extends _isc.EndpointRef {
  EndpointRole(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'role';

  /// 获取角色列表
  ///
  /// 当前根据 `sys_role` 表返回所有「未删除」的角色记录，
  /// 如需按租户或状态过滤，可后续扩展参数。
  _ida.Future<_iq2hfrj8.CommonResponse> getList() => caller
      .callServerEndpoint<_iq2hfrj8.CommonResponse>('role', 'getList', {});

  /// 获取角色已分配的菜单和API集合
  ///
  /// [roleId] 角色ID
  /// 返回值：菜单ID列表
  _ida.Future<_iq2hfrj8.CommonResponse> getRoleMenuIds(int roleId) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'role',
        'getRoleMenuIds',
        {'roleId': roleId},
      );

  /// 保存角色权限（菜单）
  ///
  /// [roleId] 角色ID
  /// [menuIds] 菜单ID列表
  /// 返回值：保存结果与生效数量
  _ida.Future<_iq2hfrj8.CommonResponse> saveRolePermissions(
    int roleId,
    List<int> menuIds,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'role',
    'saveRolePermissions',
    {'roleId': roleId, 'menuIds': menuIds},
  );

  /// 获取角色的用户列表（支持分页与昵称搜索）
  ///
  /// [roleId] 角色ID
  /// [pageNum] 页码（从1开始）
  /// [pageSize] 每页条数
  /// [nickname] 昵称关键词（模糊匹配）
  /// 返回值：分页用户列表
  _ida.Future<_iq2hfrj8.CommonResponse> getRoleUsers(
    int roleId, {
    required int page,
    required int pageSize,
    String? nickname,
  }) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'role',
    'getRoleUsers',
    {
      'roleId': roleId,
      'page': page,
      'pageSize': pageSize,
      'nickname': nickname,
    },
  );

  /// 获取角色详情
  ///
  /// [id] 角色ID
  /// 返回值：角色详情
  _ida.Future<_iq2hfrj8.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('role', 'getDetail', {
        'id': id,
      });

  /// 更新角色信息
  ///
  /// [req] 角色信息（需包含 id）
  _ida.Future<_iq2hfrj8.CommonResponse> update(_idql57qq.SysRole req) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('role', 'update', {
        'req': req,
      });

  /// 删除角色（软删除，支持批量）
  ///
  /// [ids] 角色ID列表
  /// 返回值：处理结果汇总
  _ida.Future<_iq2hfrj8.CommonResponse> delete(List<int> ids) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('role', 'delete', {
        'ids': ids,
      });

  /// 取消用户的角色分配，支持批量操作（软删除，幂等）
  ///
  /// [roleId] 角色ID
  /// [userIds] 用户ID列表
  /// 返回值：处理结果汇总
  _ida.Future<_iq2hfrj8.CommonResponse> cancelUserRoles(
    int roleId,
    List<int> userIds,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'role',
    'cancelUserRoles',
    {'roleId': roleId, 'userIds': userIds},
  );
}

/// {@category Endpoint}
class EndpointSystem extends _isc.EndpointRef {
  EndpointSystem(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'system';

  /// 健康检查
  _ida.Future<_iq2hfrj8.CommonResponse> health() =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'system',
        'health',
        {},
        authenticated: false,
      );

  /// 版本信息
  _ida.Future<_iq2hfrj8.CommonResponse> version() =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'system',
        'version',
        {},
        authenticated: false,
      );
}

/// 用户相关接口：负责返回当前登录用户的信息、角色、菜单、权限等。
///
/// ## ⚠️ 本类已「退裸」（S5 退役）
///
/// 它原先继承 `BaseEndpoint<SysUser, SysUserTable>`（业务版基类），从那里
/// **继承**来 6 条 HTTP 路由：
///
/// | 继承来的 typed 路由 | 退役后由谁提供 |
/// |---|---|
/// | `POST /user/getList` | `GET /api/user`（REST） |
/// | `POST /user/update` | `PUT\|POST /api/user/:id` |
/// | `POST /user/delete` | `DELETE /api/user/:id` |
/// | `POST /user/deleteBatch` | `DELETE /api/user` |
/// | `POST /user/addByJsonParams` | —— 已随基类删除 |
/// | `POST /user/updateByJsonParams` | —— 已随基类删除 |
///
/// 这些能力现在唯一由 REST 表现层提供（`web/routes/api/user_rest_delegate.dart`
/// ＋ `user_action_routes.dart`），**两边共用同一个 [UserService]**。
/// 留着 typed 版本只会变成「两套等价实现互相漂移」，所以一并退役。
///
/// 下面保留的 7 个方法都是**业务特定**的（套不进 CRUD 模板），每个都注明了
/// REST 侧的对应路由。
/// {@category Endpoint}
class EndpointUser extends _isc.EndpointRef {
  EndpointUser(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  /// 创建后台管理员用户 —— REST: `POST /api/user`
  ///
  /// [req.password] 参数为前端使用登录公钥进行 RSA-OAEP(SHA-256) 加密后再 Base64 编码的密文，
  /// 这里会先解密得到明文密码，再使用 PBKDF2-HMAC-SHA256 哈希后写入 sys_user.password。
  ///
  /// ⚠️ 形参名是 `req`，所以 typed 的请求体要写成 `{"req": {...}}`
  /// （REST 那边是**平铺** body）。形参名一旦改动必须重新 `serverpod generate`。
  _ida.Future<_iq2hfrj8.CommonResponse> add(dynamic req) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('user', 'add', {
        'req': req,
      });

  /// 获取用户列表 —— REST: `GET /api/user?...`
  ///
  /// [query] 用户列表查询参数
  /// 返回值：用户列表
  _ida.Future<_iq2hfrj8.CommonResponse> getUserList(
    _iq2hfrj8.UserListRequest query,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'user',
    'getUserList',
    {'query': query},
  );

  /// 获取当前登录管理员的完整信息（基础信息 + 岗位 + 角色 + 权限 + 菜单）
  /// —— REST: `GET /api/user/info`
  _ida.Future<_iq2hfrj8.CommonResponse> getUserInfo() => caller
      .callServerEndpoint<_iq2hfrj8.CommonResponse>('user', 'getUserInfo', {});

  /// 获取用户路由（树形结构） —— REST: `GET /api/user/routes`
  ///
  /// - 超级管理员：返回所有正常状态菜单
  /// - 普通用户：按角色关联菜单返回
  /// - 仅返回目录(type=1)和菜单(type=2)，过滤按钮(type=3)
  /// - 结果按 parentId 组装为 children 树
  _ida.Future<_iq2hfrj8.CommonResponse> getUserRoutes() =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'user',
        'getUserRoutes',
        {},
      );

  /// 更新用户信息 —— REST: `PUT|POST /api/user/:id`
  ///
  /// [params] 用户信息（需包含 id）
  _ida.Future<_iq2hfrj8.CommonResponse> userUpdate(
    _iq2hfrj8.UserRequest params,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'user',
    'userUpdate',
    {'params': params},
  );

  /// 获取用户详情（含角色信息） —— REST: `GET /api/user/:id`
  ///
  /// [id] 用户ID
  _ida.Future<_iq2hfrj8.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('user', 'getDetail', {
        'id': id,
      });

  /// 重置密码（支持批量） —— REST: `POST /api/user/reset-password`
  ///
  /// 将目标用户密码统一重置为固定初始密码：`asdf1234`。
  /// [ids] 用户ID列表
  /// 返回值：处理结果汇总
  _ida.Future<_iq2hfrj8.CommonResponse> resetPassword(List<int> ids) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'user',
        'resetPassword',
        {'ids': ids},
      );
}

class Modules {
  Modules(Client client) {
    auth_core = _iacc.Caller(client);
    auth_idp = _iaic.Caller(client);
  }

  late final _iacc.Caller auth_core;

  late final _iaic.Caller auth_idp;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(_isc.MethodCallContext, Object, StackTrace)? onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    airTableFields = EndpointAirTableFields(this);
    tableItems = EndpointTableItems(this);
    tableItemRelations = EndpointTableItemRelations(this);
    tableRows = EndpointTableRows(this);
    tables = EndpointTables(this);
    book = EndpointBook(this);
    auth = EndpointAuth(this);
    dept = EndpointDept(this);
    dict = EndpointDict(this);
    menu = EndpointMenu(this);
    product = EndpointProduct(this);
    role = EndpointRole(this);
    system = EndpointSystem(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointAirTableFields airTableFields;

  late final EndpointTableItems tableItems;

  late final EndpointTableItemRelations tableItemRelations;

  late final EndpointTableRows tableRows;

  late final EndpointTables tables;

  late final EndpointBook book;

  late final EndpointAuth auth;

  late final EndpointDept dept;

  late final EndpointDict dict;

  late final EndpointMenu menu;

  late final EndpointProduct product;

  late final EndpointRole role;

  late final EndpointSystem system;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'airTableFields': airTableFields,
    'tableItems': tableItems,
    'tableItemRelations': tableItemRelations,
    'tableRows': tableRows,
    'tables': tables,
    'book': book,
    'auth': auth,
    'dept': dept,
    'dict': dict,
    'menu': menu,
    'product': product,
    'role': role,
    'system': system,
    'user': user,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'auth_core': modules.auth_core,
    'auth_idp': modules.auth_idp,
  };
}
