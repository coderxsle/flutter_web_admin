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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:flutter_web_shared/src/models/common_response.dart' as _i3;
import 'package:flutter_web_shared/src/models/page_response.dart' as _i4;
import 'package:flutter_web_client/src/protocol/requests/user/common/pagination.dart'
    as _i5;
import 'package:flutter_web_client/src/protocol/book/book.dart' as _i6;
import 'package:flutter_web_client/src/protocol/requests/dept/dept_request.dart'
    as _i7;
import 'package:flutter_web_client/src/protocol/system/sys_dict_code.dart'
    as _i8;
import 'package:flutter_web_client/src/protocol/system/sys_dict_data.dart'
    as _i9;
import 'package:flutter_web_client/src/protocol/requests/menu/menu_request.dart'
    as _i10;
import 'package:flutter_web_client/src/protocol/system/sys_role.dart' as _i11;
import 'package:flutter_web_client/src/protocol/requests/user/user_request.dart'
    as _i12;
import 'package:flutter_web_client/src/protocol/requests/user/user_list_request.dart'
    as _i13;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i14;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i15;
import 'protocol.dart' as _i16;

/// {@category Endpoint}
class EndpointAirTableFields extends _i1.EndpointRef {
  EndpointAirTableFields(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'airTableFields';

  /// 获取表格的所有字段
  _i2.Future<_i3.CommonResponse> getAirTableFields(int tableId) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'airTableFields',
        'getAirTableFields',
        {'tableId': tableId},
      );

  /// 创建字段
  /// POST /airtable/AirTables/{tableId}/fields
  _i2.Future<_i3.CommonResponse> createField(
    int tableId,
    String fieldName,
  ) => caller.callServerEndpoint<_i3.CommonResponse>(
    'airTableFields',
    'createField',
    {
      'tableId': tableId,
      'fieldName': fieldName,
    },
  );

  /// 更新字段
  /// PUT /airtable/fields/{id}
  _i2.Future<_i3.CommonResponse> updateField(
    String fieldName,
    String newName,
  ) => caller.callServerEndpoint<_i3.CommonResponse>(
    'airTableFields',
    'updateField',
    {
      'fieldName': fieldName,
      'newName': newName,
    },
  );

  /// 删除字段（级联删除所有相关的单元格数据）
  /// DELETE /airtable/fields/{id}
  _i2.Future<_i3.CommonResponse> deleteField(String fieldName) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'airTableFields',
        'deleteField',
        {'fieldName': fieldName},
      );
}

/// {@category Endpoint}
class EndpointTableItems extends _i1.EndpointRef {
  EndpointTableItems(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tableItems';

  /// ✅ 创建/更新单元格数据（Upsert）
  _i2.Future<_i3.CommonResponse> upsertItem(
    int fieldId,
    String value,
    int rowId,
  ) => caller.callServerEndpoint<_i3.CommonResponse>(
    'tableItems',
    'upsertItem',
    {
      'fieldId': fieldId,
      'value': value,
      'rowId': rowId,
    },
  );

  /// 删除单元格数据
  /// DELETE /airtable/items/{id}
  _i2.Future<_i3.CommonResponse> deleteItem(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'tableItems',
        'deleteItem',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointTableItemRelations extends _i1.EndpointRef {
  EndpointTableItemRelations(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tableItemRelations';

  /// 获取单元格的关联信息
  /// GET /airtable/items/{id}/relations
  _i2.Future<_i3.CommonResponse> getItemRelations(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'tableItemRelations',
        'getItemRelations',
        {'id': id},
      );

  /// 搜索可关联的数据
  /// GET /airtable/tables/{tableId}/searchable-items
  _i2.Future<_i4.PageResponse<dynamic>> searchTableItems(
    int tableId,
    _i5.Pagination pagination, {
    int? fieldId,
  }) => caller.callServerEndpoint<_i4.PageResponse<dynamic>>(
    'tableItemRelations',
    'searchTableItems',
    {
      'tableId': tableId,
      'pagination': pagination,
      'fieldId': fieldId,
    },
  );

  /// 获取所有可用于关联的表格列表
  /// GET /airtable/relations/tables
  _i2.Future<_i3.CommonResponse> getAvailableTables() =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'tableItemRelations',
        'getAvailableTables',
        {},
      );

  /// 获取指定表格的所有字段（用于选择关联字段）
  /// GET /airtable/relations/tables/{tableId}/fields
  _i2.Future<_i3.CommonResponse> getTableFieldsForRelation(int tableId) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'tableItemRelations',
        'getTableFieldsForRelation',
        {'tableId': tableId},
      );
}

/// {@category Endpoint}
class EndpointTableRows extends _i1.EndpointRef {
  EndpointTableRows(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tableRows';

  /// ✅ 获取表格的所有行（分页）
  _i2.Future<_i4.PageResponse<dynamic>> getTableRows(
    int tableId, {
    required int page,
    required int pageSize,
    String? keyword,
  }) => caller.callServerEndpoint<_i4.PageResponse<dynamic>>(
    'tableRows',
    'getTableRows',
    {
      'tableId': tableId,
      'page': page,
      'pageSize': pageSize,
      'keyword': keyword,
    },
  );

  /// ✅ 创建行
  _i2.Future<_i3.CommonResponse> createRow(
    int tableId, {
    int? index,
  }) => caller.callServerEndpoint<_i3.CommonResponse>(
    'tableRows',
    'createRow',
    {
      'tableId': tableId,
      'index': index,
    },
  );

  /// 更新行索引（排序）
  /// PUT /airtable/rows/{id}
  _i2.Future<_i3.CommonResponse> updateRow(
    int id,
    int index,
  ) => caller.callServerEndpoint<_i3.CommonResponse>(
    'tableRows',
    'updateRow',
    {
      'id': id,
      'index': index,
    },
  );

  /// 删除行（级联删除所有相关的单元格数据）
  /// DELETE /airtable/rows/{id}
  _i2.Future<_i3.CommonResponse> deleteRow(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'tableRows',
        'deleteRow',
        {'id': id},
      );

  /// 批量删除行
  /// POST /airtable/rows/batch-delete
  _i2.Future<_i3.CommonResponse> batchDeleteRows(List<int> ids) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'tableRows',
        'batchDeleteRows',
        {'ids': ids},
      );
}

/// {@category Endpoint}
class EndpointTables extends _i1.EndpointRef {
  EndpointTables(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tables';

  /// 查询所有表格（分页）
  _i2.Future<_i3.CommonResponse> getTables(_i5.Pagination pagination) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'tables',
        'getTables',
        {'pagination': pagination},
      );

  /// 查询所有表格（分页）
  _i2.Future<_i3.CommonResponse> getTables2({
    required int page,
    required int pageSize,
    String? keyword,
  }) => caller.callServerEndpoint<_i3.CommonResponse>(
    'tables',
    'getTables2',
    {
      'page': page,
      'pageSize': pageSize,
      'keyword': keyword,
    },
  );

  /// 获取表格详情（包含字段列表）
  _i2.Future<_i3.CommonResponse> tableDetail(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'tables',
        'tableDetail',
        {'id': id},
      );

  /// 创建表格
  _i2.Future<_i3.CommonResponse> createTable(String name) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'tables',
        'createTable',
        {'name': name},
      );

  /// 更新表格
  /// PUT /airtable/tables/{id}
  _i2.Future<_i3.CommonResponse> updateTable(
    int id,
    String name,
  ) => caller.callServerEndpoint<_i3.CommonResponse>(
    'tables',
    'updateTable',
    {
      'id': id,
      'name': name,
    },
  );

  /// 删除表格（级联删除所有相关数据）
  /// DELETE /airtable/tables/{id}
  _i2.Future<_i3.CommonResponse> deleteTable(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'tables',
        'deleteTable',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  /// 用户登录接口（使用 JwtTokenManager 签发 accessToken / refreshToken）
  _i2.Future<_i3.CommonResponse> login(
    String username,
    String password,
  ) => caller.callServerEndpoint<_i3.CommonResponse>(
    'auth',
    'login',
    {
      'username': username,
      'password': password,
    },
  );

  /// 无需登录即可获取登录用 RSA 公钥（PEM 字符串）
  _i2.Future<_i3.CommonResponse> publicKey() =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'auth',
        'publicKey',
        {},
        authenticated: false,
      );

  /// 使用 refreshToken 刷新 accessToken（无需已登录）
  _i2.Future<_i3.CommonResponse> refreshToken(String refreshToken) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'auth',
        'refreshToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// {@category Endpoint}
class EndpointBook extends _i1.EndpointRef {
  EndpointBook(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'book';

  /// 创建图书
  _i2.Future<_i3.CommonResponse> createBook(_i6.Book book) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'book',
        'createBook',
        {'book': book},
      );

  /// 更新图书
  _i2.Future<_i3.CommonResponse> updateBook(_i6.Book book) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'book',
        'updateBook',
        {'book': book},
      );

  /// 删除图书
  _i2.Future<_i3.CommonResponse> deleteBook(_i6.Book book) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'book',
        'deleteBook',
        {'book': book},
      );

  /// 获取图书
  _i2.Future<_i3.CommonResponse> getBook(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'book',
        'getBook',
        {'id': id},
      );

  /// 获取所有图书
  _i2.Future<_i4.PageResponse<dynamic>> list({
    required int pageNum,
    required int pageSize,
  }) => caller.callServerEndpoint<_i4.PageResponse<dynamic>>(
    'book',
    'list',
    {
      'pageNum': pageNum,
      'pageSize': pageSize,
    },
  );
}

/// {@category Endpoint}
class EndpointDept extends _i1.EndpointRef {
  EndpointDept(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dept';

  /// 获取部门树（按租户过滤，默认系统租户）
  /// 返回结构：id、parentId、name、sort、status、createTime、description、children
  _i2.Future<_i3.CommonResponse> getList({
    String? status,
    String? name,
  }) => caller.callServerEndpoint<_i3.CommonResponse>(
    'dept',
    'getList',
    {
      'status': status,
      'name': name,
    },
  );

  /// 新增部门
  ///
  /// [req] 部门信息
  _i2.Future<_i3.CommonResponse> add(_i7.DeptRequest req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dept',
        'add',
        {'req': req},
      );

  /// 更新部门信息
  ///
  /// [req] 部门信息（需包含 id）
  _i2.Future<_i3.CommonResponse> update(_i7.DeptRequest req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dept',
        'update',
        {'req': req},
      );

  /// 获取部门详情
  ///
  /// [id] 部门ID
  /// 返回值：部门详情
  _i2.Future<_i3.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dept',
        'getDetail',
        {'id': id},
      );

  /// 删除部门（软删除，支持批量）
  ///
  /// [ids] 部门ID列表
  /// 返回值：处理结果汇总
  _i2.Future<_i3.CommonResponse> delete(List<int> ids) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dept',
        'delete',
        {'ids': ids},
      );
}

/// 字典管理接口
///
/// - 字典类型：sys_dict_type
/// - 字典数据：sys_dict_data
/// - 提供基础的增删改查能力
/// {@category Endpoint}
class EndpointDict extends _i1.EndpointRef {
  EndpointDict(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dict';

  /// 获取字典数据（按字典类型分组）
  ///
  /// 返回数据格式：{ "TYPE": [{"label":"xxx","value":1,"tagProps":{...}}] }
  _i2.Future<_i3.CommonResponse> getDictData({int? tenantId}) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dict',
        'getDictData',
        {'tenantId': tenantId},
        authenticated: false,
      );

  /// 获取字典类型列表
  ///
  /// [tenantId] 租户ID
  /// [name] 字典名称（模糊匹配）
  /// [type] 字典类型（模糊匹配）
  /// [status] 状态（0=停用 1=正常）
  /// 返回值：字典类型列表
  _i2.Future<_i3.CommonResponse> getDictCodeList({
    int? tenantId,
    String? name,
    String? code,
    int? status,
  }) => caller.callServerEndpoint<_i3.CommonResponse>(
    'dict',
    'getDictCodeList',
    {
      'tenantId': tenantId,
      'name': name,
      'code': code,
      'status': status,
    },
  );

  /// 获取字典类型详情
  ///
  /// [id] 字典类型ID
  /// 返回值：字典类型详情
  _i2.Future<_i3.CommonResponse> getDictCodeDetail(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dict',
        'getDictCodeDetail',
        {'id': id},
      );

  /// 新增字典类型
  ///
  /// [req] 字典类型信息
  _i2.Future<_i3.CommonResponse> addDictCode(_i8.SysDictCode req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dict',
        'addDictCode',
        {'req': req},
      );

  /// 更新字典类型
  ///
  /// [req] 字典类型信息（需包含 id）
  _i2.Future<_i3.CommonResponse> updateDictCode(
    int id,
    String code,
    String name,
    int status,
    String remark,
  ) => caller.callServerEndpoint<_i3.CommonResponse>(
    'dict',
    'updateDictCode',
    {
      'id': id,
      'code': code,
      'name': name,
      'status': status,
      'remark': remark,
    },
  );

  /// 删除字典类型（软删除，支持批量）
  ///
  /// [ids] 字典类型ID列表
  /// 返回值：处理结果汇总
  _i2.Future<_i3.CommonResponse> deleteDictCode(List<int> ids) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
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
  _i2.Future<_i3.CommonResponse> getDictDataList({
    int? tenantId,
    String? code,
    String? name,
    String? value,
    int? status,
  }) => caller.callServerEndpoint<_i3.CommonResponse>(
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
  _i2.Future<_i3.CommonResponse> addDictData(_i9.SysDictData req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dict',
        'addDictData',
        {'req': req},
      );

  /// 更新字典数据
  ///
  /// [req] 字典数据信息（需包含 id）
  _i2.Future<_i3.CommonResponse> updateDictData(_i9.SysDictData req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dict',
        'updateDictData',
        {'req': req},
      );

  /// 删除字典数据（软删除，支持批量）
  ///
  /// [ids] 字典数据ID列表
  /// 返回值：处理结果汇总
  _i2.Future<_i3.CommonResponse> deleteDictData(List<int> ids) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dict',
        'deleteDictData',
        {'ids': ids},
      );

  /// 获取字典数据详情
  ///
  /// [id] 字典数据ID
  /// [code] 字典数据编码
  /// 返回值：字典类型详情
  _i2.Future<_i3.CommonResponse> getDictDataDetail(
    int id,
    String code,
  ) => caller.callServerEndpoint<_i3.CommonResponse>(
    'dict',
    'getDictDataDetail',
    {
      'id': id,
      'code': code,
    },
  );
}

/// {@category Endpoint}
class EndpointMenu extends _i1.EndpointRef {
  EndpointMenu(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'menu';

  /// 添加菜单接口
  _i2.Future<_i3.CommonResponse> add(_i10.MenuRequest req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'menu',
        'add',
        {'req': req},
      );

  /// 删除菜单（软删除，支持批量）
  ///
  /// [ids] 菜单ID列表
  /// 返回值：处理结果汇总
  _i2.Future<_i3.CommonResponse> delete(List<int> ids) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'menu',
        'delete',
        {'ids': ids},
      );

  /// 更新菜单信息
  ///
  /// [req] 菜单信息（需包含 id）
  _i2.Future<_i3.CommonResponse> update(_i10.MenuRequest req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'menu',
        'update',
        {'req': req},
      );

  /// 获取当前登录用户的菜单树（合并用户所有角色的菜单）
  ///
  /// 返回值：菜单树列表
  _i2.Future<_i3.CommonResponse> getMenuOptions() =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'menu',
        'getMenuOptions',
        {},
      );

  /// 获取菜单列表
  ///
  /// [name] 菜单名称（模糊匹配）
  /// [status] 菜单状态（1=启用，0=停用）
  /// 返回值：菜单列表（按 sort、id 升序）
  _i2.Future<_i3.CommonResponse> getList([
    String? name,
    String? status,
  ]) => caller.callServerEndpoint<_i3.CommonResponse>(
    'menu',
    'getList',
    {
      'name': name,
      'status': status,
    },
  );

  /// 获取菜单详情
  ///
  /// [id] 菜单ID
  /// 返回值：菜单详情
  _i2.Future<_i3.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'menu',
        'getDetail',
        {'id': id},
      );
}

/// 规则相关接口
///
/// 当前仅提供一个基础的列表查询接口，后续可以根据具体业务补充
/// 创建、编辑、删除等方法，并接入真实数据库模型。
/// {@category Endpoint}
class EndpointRole extends _i1.EndpointRef {
  EndpointRole(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'role';

  /// 获取角色列表
  ///
  /// 当前根据 `sys_role` 表返回所有「未删除」的角色记录，
  /// 如需按租户或状态过滤，可后续扩展参数。
  _i2.Future<_i3.CommonResponse> getList() =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'role',
        'getList',
        {},
      );

  /// 获取角色已分配的菜单和API集合
  ///
  /// [roleId] 角色ID
  /// 返回值：菜单ID列表
  _i2.Future<_i3.CommonResponse> getRoleMenuIds(int roleId) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'role',
        'getRoleMenuIds',
        {'roleId': roleId},
      );

  /// 保存角色权限（菜单）
  ///
  /// [roleId] 角色ID
  /// [menuIds] 菜单ID列表
  /// 返回值：保存结果与生效数量
  _i2.Future<_i3.CommonResponse> saveRolePermissions(
    int roleId,
    List<int> menuIds,
  ) => caller.callServerEndpoint<_i3.CommonResponse>(
    'role',
    'saveRolePermissions',
    {
      'roleId': roleId,
      'menuIds': menuIds,
    },
  );

  /// 获取角色的用户列表（支持分页与昵称搜索）
  ///
  /// [roleId] 角色ID
  /// [pageNum] 页码（从1开始）
  /// [pageSize] 每页条数
  /// [nickname] 昵称关键词（模糊匹配）
  /// 返回值：分页用户列表
  _i2.Future<_i3.CommonResponse> getRoleUsers(
    int roleId, {
    required int pageNum,
    required int pageSize,
    String? nickname,
  }) => caller.callServerEndpoint<_i3.CommonResponse>(
    'role',
    'getRoleUsers',
    {
      'roleId': roleId,
      'pageNum': pageNum,
      'pageSize': pageSize,
      'nickname': nickname,
    },
  );

  /// 获取角色详情
  ///
  /// [id] 角色ID
  /// 返回值：角色详情
  _i2.Future<_i3.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'role',
        'getDetail',
        {'id': id},
      );

  /// 更新角色信息
  ///
  /// [req] 角色信息（需包含 id）
  _i2.Future<_i3.CommonResponse> update(_i11.SysRole req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'role',
        'update',
        {'req': req},
      );

  /// 删除角色（软删除，支持批量）
  ///
  /// [ids] 角色ID列表
  /// 返回值：处理结果汇总
  _i2.Future<_i3.CommonResponse> delete(List<int> ids) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'role',
        'delete',
        {'ids': ids},
      );

  /// 取消用户的角色分配，支持批量操作（软删除，幂等）
  ///
  /// [roleId] 角色ID
  /// [userIds] 用户ID列表
  /// 返回值：处理结果汇总
  _i2.Future<_i3.CommonResponse> cancelUserRoles(
    int roleId,
    List<int> userIds,
  ) => caller.callServerEndpoint<_i3.CommonResponse>(
    'role',
    'cancelUserRoles',
    {
      'roleId': roleId,
      'userIds': userIds,
    },
  );
}

/// {@category Endpoint}
class EndpointSystem extends _i1.EndpointRef {
  EndpointSystem(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'system';

  /// 健康检查
  _i2.Future<_i3.CommonResponse> health() =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'system',
        'health',
        {},
        authenticated: false,
      );

  /// 版本信息
  _i2.Future<_i3.CommonResponse> version() =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'system',
        'version',
        {},
        authenticated: false,
      );
}

/// 用户相关接口：负责返回当前登录用户的信息、角色、菜单、权限等
/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  /// 创建后台管理员用户
  ///
  /// [req.password] 参数为前端使用登录公钥进行 RSA-OAEP(SHA-256) 加密后再 Base64 编码的密文，
  /// 这里会先解密得到明文密码，再使用 PBKDF2-HMAC-SHA256 哈希后写入 sys_user.password。
  _i2.Future<_i3.CommonResponse> add(_i12.UserRequest req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'add',
        {'req': req},
      );

  /// 获取用户列表
  ///
  /// [req] 用户列表查询参数
  /// 返回值：用户列表
  _i2.Future<_i3.CommonResponse> getList(_i13.UserListRequest req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'getList',
        {'req': req},
      );

  /// 获取当前登录管理员的完整信息（基础信息 + 岗位 + 角色 + 权限 + 菜单）
  _i2.Future<_i3.CommonResponse> getUserInfo() =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'getUserInfo',
        {},
      );

  /// 获取用户路由（树形结构）
  ///
  /// - 超级管理员：返回所有正常状态菜单
  /// - 普通用户：按角色关联菜单返回
  /// - 仅返回目录(type=1)和菜单(type=2)，过滤按钮(type=3)
  /// - 结果按 parentId 组装为 children 树
  _i2.Future<_i3.CommonResponse> getUserRoutes() =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'getUserRoutes',
        {},
      );

  /// 删除用户（软删除，支持批量）
  ///
  /// [ids] 用户ID列表
  /// 返回值：处理结果汇总
  _i2.Future<_i3.CommonResponse> delete(List<int> ids) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'delete',
        {'ids': ids},
      );

  /// 更新用户信息
  ///
  /// [req] 用户信息（需包含 id）
  _i2.Future<_i3.CommonResponse> update(_i12.UserRequest req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'update',
        {'req': req},
      );

  /// 获取用户详情（含角色信息）
  ///
  /// [id] 用户ID
  _i2.Future<_i3.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'getDetail',
        {'id': id},
      );

  /// 重置密码（支持批量）
  ///
  /// 将目标用户密码统一重置为固定初始密码：`asdf1234`。
  /// [ids] 用户ID列表
  /// 返回值：处理结果汇总
  _i2.Future<_i3.CommonResponse> resetPassword(List<int> ids) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'resetPassword',
        {'ids': ids},
      );
}

class Modules {
  Modules(Client client) {
    authIdp = _i14.Caller(client);
    authCore = _i15.Caller(client);
  }

  late final _i14.Caller authIdp;

  late final _i15.Caller authCore;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i16.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    airTableFields = EndpointAirTableFields(this);
    tableItems = EndpointTableItems(this);
    tableItemRelations = EndpointTableItemRelations(this);
    tableRows = EndpointTableRows(this);
    tables = EndpointTables(this);
    auth = EndpointAuth(this);
    book = EndpointBook(this);
    dept = EndpointDept(this);
    dict = EndpointDict(this);
    menu = EndpointMenu(this);
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

  late final EndpointAuth auth;

  late final EndpointBook book;

  late final EndpointDept dept;

  late final EndpointDict dict;

  late final EndpointMenu menu;

  late final EndpointRole role;

  late final EndpointSystem system;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'airTableFields': airTableFields,
    'tableItems': tableItems,
    'tableItemRelations': tableItemRelations,
    'tableRows': tableRows,
    'tables': tables,
    'auth': auth,
    'book': book,
    'dept': dept,
    'dict': dict,
    'menu': menu,
    'role': role,
    'system': system,
    'user': user,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'authIdp': modules.authIdp,
    'authCore': modules.authCore,
  };
}
