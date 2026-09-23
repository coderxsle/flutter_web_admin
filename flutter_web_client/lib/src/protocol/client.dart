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
import 'package:serverpod_crud/serverpod_crud.dart' as _imp6a5q0;
import 'protocol.dart' as _il2as5qe;

/// {@category Endpoint}
class EndpointAirTableFields extends _isc.EndpointRef {
  EndpointAirTableFields(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'airTableFields';

  /// 获取表格的所有字段
  _ida.Future<_iq2hfrj8.CommonResponse> getAirTableFields(int tableId) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'airTableFields',
        'getAirTableFields',
        {'tableId': tableId},
      );

  /// 创建字段
  /// POST /airtable/AirTables/{tableId}/fields
  _ida.Future<_iq2hfrj8.CommonResponse> createField(
    int tableId,
    String fieldName,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'airTableFields',
    'createField',
    {'tableId': tableId, 'fieldName': fieldName},
  );

  /// 更新字段
  /// PUT /airtable/fields/{id}
  _ida.Future<_iq2hfrj8.CommonResponse> updateField(
    String fieldName,
    String newName,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'airTableFields',
    'updateField',
    {'fieldName': fieldName, 'newName': newName},
  );

  /// 删除字段（级联删除所有相关的单元格数据）
  /// DELETE /airtable/fields/{id}
  _ida.Future<_iq2hfrj8.CommonResponse> deleteField(String fieldName) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'airTableFields',
        'deleteField',
        {'fieldName': fieldName},
      );
}

/// {@category Endpoint}
class EndpointTableItems extends _isc.EndpointRef {
  EndpointTableItems(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tableItems';

  /// ✅ 创建/更新单元格数据（Upsert）
  _ida.Future<_iq2hfrj8.CommonResponse> upsertItem(
    int fieldId,
    String value,
    int rowId,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'tableItems',
    'upsertItem',
    {'fieldId': fieldId, 'value': value, 'rowId': rowId},
  );

  /// 删除单元格数据
  /// DELETE /airtable/items/{id}
  _ida.Future<_iq2hfrj8.CommonResponse> deleteItem(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableItems',
        'deleteItem',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointTableItemRelations extends _isc.EndpointRef {
  EndpointTableItemRelations(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tableItemRelations';

  /// 获取单元格的关联信息
  /// GET /airtable/items/{id}/relations
  _ida.Future<_iq2hfrj8.CommonResponse> getItemRelations(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableItemRelations',
        'getItemRelations',
        {'id': id},
      );

  /// 搜索可关联的数据
  /// GET /airtable/tables/{tableId}/searchable-items
  _ida.Future<_iq2hfrj8.PageResponse<dynamic>> searchTableItems(
    int tableId,
    _iq2hfrj8.Pagination pagination, {
    int? fieldId,
  }) => caller.callServerEndpoint<_iq2hfrj8.PageResponse<dynamic>>(
    'tableItemRelations',
    'searchTableItems',
    {'tableId': tableId, 'pagination': pagination, 'fieldId': fieldId},
  );

  /// 获取所有可用于关联的表格列表
  /// GET /airtable/relations/tables
  _ida.Future<_iq2hfrj8.CommonResponse> getAvailableTables() =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableItemRelations',
        'getAvailableTables',
        {},
      );

  /// 获取指定表格的所有字段（用于选择关联字段）
  /// GET /airtable/relations/tables/{tableId}/fields
  _ida.Future<_iq2hfrj8.CommonResponse> getTableFieldsForRelation(
    int tableId,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'tableItemRelations',
    'getTableFieldsForRelation',
    {'tableId': tableId},
  );
}

/// {@category Endpoint}
class EndpointTableRows extends _isc.EndpointRef {
  EndpointTableRows(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tableRows';

  /// ✅ 获取表格的所有行（分页）
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

  /// ✅ 创建行
  _ida.Future<_iq2hfrj8.CommonResponse> createRow(int tableId, {int? index}) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableRows',
        'createRow',
        {'tableId': tableId, 'index': index},
      );

  /// 更新行索引（排序）
  /// PUT /airtable/rows/{id}
  _ida.Future<_iq2hfrj8.CommonResponse> updateRow(int id, int index) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableRows',
        'updateRow',
        {'id': id, 'index': index},
      );

  /// 删除行（级联删除所有相关的单元格数据）
  /// DELETE /airtable/rows/{id}
  _ida.Future<_iq2hfrj8.CommonResponse> deleteRow(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableRows',
        'deleteRow',
        {'id': id},
      );

  /// 批量删除行
  /// POST /airtable/rows/batch-delete
  _ida.Future<_iq2hfrj8.CommonResponse> batchDeleteRows(List<int> ids) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tableRows',
        'batchDeleteRows',
        {'ids': ids},
      );
}

/// {@category Endpoint}
class EndpointTables extends _isc.EndpointRef {
  EndpointTables(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'tables';

  /// 查询所有表格（分页）
  _ida.Future<_iq2hfrj8.CommonResponse> getTables(
    _iq2hfrj8.Pagination pagination,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'tables',
    'getTables',
    {'pagination': pagination},
  );

  /// 查询所有表格（分页）
  _ida.Future<_iq2hfrj8.CommonResponse> getTables2({
    required int page,
    required int pageSize,
    String? keyword,
  }) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'tables',
    'getTables2',
    {'page': page, 'pageSize': pageSize, 'keyword': keyword},
  );

  /// 获取表格详情（包含字段列表）
  _ida.Future<_iq2hfrj8.CommonResponse> tableDetail(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tables',
        'tableDetail',
        {'id': id},
      );

  /// 创建表格
  _ida.Future<_iq2hfrj8.CommonResponse> createTable(String name) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tables',
        'createTable',
        {'name': name},
      );

  /// 更新表格
  /// PUT /airtable/tables/{id}
  _ida.Future<_iq2hfrj8.CommonResponse> updateTable(int id, String name) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'tables',
        'updateTable',
        {'id': id, 'name': name},
      );

  /// 删除表格（级联删除所有相关数据）
  /// DELETE /airtable/tables/{id}
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

/// 通用 CRUD Endpoint 基类（默认实现）。
///
/// 子类只需继承此基类即可获得常见 CRUD + query 方法；特殊业务查询
/// 直接写在具体 Endpoint 中。
/// 如果某个实体使用非标准字段，可以只覆盖差异：
///
/// ```dart
/// class ResourceEndpoint extends BaseEndpoint<Resource, ResourceTable> {
///   ResourceEndpoint()
///       : super(
///           tenantIdField: 'organizationId',
///           deletedField: 'archived',
///           keywordFields: const ['name', 'code'],
///           fieldAliases: const {
///             'createdAt': 'createTime',
///           },
///         );
/// }
/// ```
/// {@category Endpoint}
abstract class EndpointBase extends _isc.EndpointRef {
  EndpointBase(_isc.EndpointCaller caller) : super(caller);

  /// 创建数据实体的接口， 适合单表新增数据。（**接收 JSON 对象文本**）
  ///
  /// 与 [add] 的差别只在入参形态（两者最终都走 `service.create`）：
  /// - [add] 的形参是 `dynamic`，Serverpod 要求带类型标签的线格式，前端无法自然构造；
  /// - [addByJsonParams] 的形参是 `String`，请求体传
  ///   `{"params": "{\"username\":\"chen_yu\"}"}` 即可（前端一行 `JSON.stringify`）。
  ///
  /// - [session]：当前的 Serverpod 会话
  /// - [params]：请求体，是**JSON 对象文本**（不是 JSON 对象本身），例如
  ///   `{"username": "chen_yu", "nickname": "陈宇"}`
  ///
  /// 注意：请求体里出现、但**不属于本实体列**的字段会被忽略（`!persist` 字段、
  /// 关联表字段如 `SysUser` 的 `roleIds` 都在此列）；但至少要有一个合法字段，
  /// 否则直接报错 —— 避免字段名拼错时插进去一条空数据还返回成功。
  ///
  /// 返回：包含新建结果的 [CommonResponse]，data 字段为新建实体
  _ida.Future<_iq2hfrj8.CommonResponse> addByJsonParams(String params);

  /// 创建数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式）
  ///
  /// 返回：包含新建结果的[CommonResponse]，data字段为新建实体
  _ida.Future<_iq2hfrj8.CommonResponse> add(dynamic data);

  /// 获取指定ID的详情数据
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要获取详情的数据主键ID
  ///
  /// 返回：包含查询结果的[CommonResponse]
  _ida.Future<_iq2hfrj8.CommonResponse> getDetail(int id);

  /// 获取分页列表数据的接口（支持复杂查询）
  ///
  /// 执行支持高级查询的分页请求。前端传入的[QueryRequest]会经过
  /// [_queryMapper.toCore]转换为后端核心的查询请求对象（如服务层可能需要更丰富的结构，如过滤、排序、关键字等）。
  /// 然后调用service.query执行业务查询，返回[CrudPage<T>]结构，该结构含有数据及分页信息。
  /// 最后将结果数据和分页信息组装为标准接口响应[PageResponse]返回。
  ///
  /// - [session]：当前的Serverpod会话，包含登录上下文信息。
  /// - [query]：前端传入的查询结构体，含分页参数和其他自定义条件。
  ///
  /// 返回：包含查询结果列表及分页的 `PageResponse<T>`。
  ///
  /// 请注意：BaseEndpoint 是一个带泛型 T 的抽象类，继承自 Endpoint。
  /// Serverpod 的代码生成器扫描到 getList 的返回值 `Future<PageResponse<T>>` 时，会把 T 作为一个需要在客户端引用的类型，
  /// 从而生成了指向服务端 base_endpoint.dart 的 import——但客户端包里根本没有这个文件。
  /// 根本原因：getList 的返回类型 `Future<PageResponse<T>>` 中的 T 是泛型参数，生成器无法在客户端正确表达它，只能错误地引用服务端文件。
  /// 因此这里的返回类型必须使用 `Future<PageResponse<dynamic>>` 不能使用 `Future<PageResponse<T>>`
  _ida.Future<_iq2hfrj8.PageResponse<dynamic>> getList(
    _imp6a5q0.QueryRequest query,
  );

  /// 更新数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式，须带主键ID）
  ///
  /// 返回：包含更新结果的[CommonResponse]，data字段为已更新实体
  ///
  /// ⚠️ 这是 **PUT（整行覆盖）** 语义：请求体被整体反序列化成一个新实体后整行写回，
  /// 请求里没出现的字段会被 `fromJson` 的默认值 / null 覆盖掉。对含
  /// `scope=serverOnly` 字段或外键的实体（如 SysUser 的 password、authUserId），
  /// 漏传即等于清空。需要「只改传过来的字段」请用 [updateByJsonParams]。
  /// 这个方法之所以保留，是为了给 serverpod 生成的 client 代码预留。
  _ida.Future<_iq2hfrj8.CommonResponse> update(dynamic data);

  /// 部分更新数据实体的接口（**PATCH 语义**，接收 JSON 对象文本）
  ///
  /// 与 [update] 的差别：
  /// - [update] 把请求体整体反序列化成新实体再整行覆盖，缺字段即被默认值/null 覆盖；
  /// - [updateByJsonParams] 先按主键读出数据库当前行作为**基线**，只让请求里
  ///   **实际出现过的字段**去覆盖它，未出现的字段保持数据库原值。因此可以安全地
  ///   只传要改的字段，例如 `{"id": 2, "deptId": 2}` 或 `{"id": 2, "username": "chen.yu"}`。
  ///
  /// - [session]：当前的Serverpod会话
  /// - [params]：请求体，是**JSON 对象文本**（不是 JSON 对象本身）。必须带主键
  ///   （默认字段名 `id`），其余字段可选，例如 `{"id": 2, "deptId": 5}` 会被序列化成
  ///   字符串传进来。
  ///
  /// ⚠️ 为什么这里用 `String` 而不是 `dynamic` / `Map<String, dynamic>`：
  /// Serverpod 对这两个类型都会走 `deserializeDynamicFieldValue`，要求线格式是带
  /// 类型标签的 `{"className": "...", "data": {...}}`，**且每个字段值还要再包一层**
  /// （如 `{"id": {"className": "int", "data": 2}}`）；直接传普通 JSON 对象会抛
  /// `No deserialization found for type named null`。`Map<String, dynamic>` 只是把
  /// 报错换成 `got int instead`，同样不可用。详见 `json_param_codec.dart` 的类注释。
  ///
  /// 返回：包含更新结果的[CommonResponse]，data字段为更新后的**完整**实体
  _ida.Future<_iq2hfrj8.CommonResponse> updateByJsonParams(String params);

  /// 删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要删除的数据主键ID
  ///
  /// 返回：操作结果的[CommonResponse]，若成功返回null数据
  _ida.Future<_iq2hfrj8.CommonResponse> delete(int id);

  /// 批量删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [ids]：要批量删除的主键ID列表
  ///
  /// 返回：包含批量删除结果信息的[CommonResponse]，例如总数、成功数、未找到数等。
  _ida.Future<_iq2hfrj8.CommonResponse> deleteBatch(List<int> ids);
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

/// 图书模块的标准 CRUD Endpoint。
///
/// 通用增删改查由 [BaseEndpoint] 自动装配；特殊查询直接添加到此类。
/// {@category Endpoint}
class EndpointProduct extends EndpointBase {
  EndpointProduct(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'product';

  /// 获取产品详情
  /// 重写父类
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'product',
        'getDetail',
        {'id': id},
      );

  /// 查询价格历史
  _ida.Future<_iq2hfrj8.CommonResponse> getPriceList() =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'product',
        'getPriceList',
        {},
      );

  /// 创建数据实体的接口， 适合单表新增数据。（**接收 JSON 对象文本**）
  ///
  /// 与 [add] 的差别只在入参形态（两者最终都走 `service.create`）：
  /// - [add] 的形参是 `dynamic`，Serverpod 要求带类型标签的线格式，前端无法自然构造；
  /// - [addByJsonParams] 的形参是 `String`，请求体传
  ///   `{"params": "{\"username\":\"chen_yu\"}"}` 即可（前端一行 `JSON.stringify`）。
  ///
  /// - [session]：当前的 Serverpod 会话
  /// - [params]：请求体，是**JSON 对象文本**（不是 JSON 对象本身），例如
  ///   `{"username": "chen_yu", "nickname": "陈宇"}`
  ///
  /// 注意：请求体里出现、但**不属于本实体列**的字段会被忽略（`!persist` 字段、
  /// 关联表字段如 `SysUser` 的 `roleIds` 都在此列）；但至少要有一个合法字段，
  /// 否则直接报错 —— 避免字段名拼错时插进去一条空数据还返回成功。
  ///
  /// 返回：包含新建结果的 [CommonResponse]，data 字段为新建实体
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> addByJsonParams(String params) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'product',
        'addByJsonParams',
        {'params': params},
      );

  /// 创建数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式）
  ///
  /// 返回：包含新建结果的[CommonResponse]，data字段为新建实体
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> add(dynamic data) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('product', 'add', {
        'data': data,
      });

  /// 获取分页列表数据的接口（支持复杂查询）
  ///
  /// 执行支持高级查询的分页请求。前端传入的[QueryRequest]会经过
  /// [_queryMapper.toCore]转换为后端核心的查询请求对象（如服务层可能需要更丰富的结构，如过滤、排序、关键字等）。
  /// 然后调用service.query执行业务查询，返回[CrudPage<T>]结构，该结构含有数据及分页信息。
  /// 最后将结果数据和分页信息组装为标准接口响应[PageResponse]返回。
  ///
  /// - [session]：当前的Serverpod会话，包含登录上下文信息。
  /// - [query]：前端传入的查询结构体，含分页参数和其他自定义条件。
  ///
  /// 返回：包含查询结果列表及分页的 `PageResponse<T>`。
  ///
  /// 请注意：BaseEndpoint 是一个带泛型 T 的抽象类，继承自 Endpoint。
  /// Serverpod 的代码生成器扫描到 getList 的返回值 `Future<PageResponse<T>>` 时，会把 T 作为一个需要在客户端引用的类型，
  /// 从而生成了指向服务端 base_endpoint.dart 的 import——但客户端包里根本没有这个文件。
  /// 根本原因：getList 的返回类型 `Future<PageResponse<T>>` 中的 T 是泛型参数，生成器无法在客户端正确表达它，只能错误地引用服务端文件。
  /// 因此这里的返回类型必须使用 `Future<PageResponse<dynamic>>` 不能使用 `Future<PageResponse<T>>`
  @override
  _ida.Future<_iq2hfrj8.PageResponse<dynamic>> getList(
    _imp6a5q0.QueryRequest query,
  ) => caller.callServerEndpoint<_iq2hfrj8.PageResponse<dynamic>>(
    'product',
    'getList',
    {'query': query},
  );

  /// 更新数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式，须带主键ID）
  ///
  /// 返回：包含更新结果的[CommonResponse]，data字段为已更新实体
  ///
  /// ⚠️ 这是 **PUT（整行覆盖）** 语义：请求体被整体反序列化成一个新实体后整行写回，
  /// 请求里没出现的字段会被 `fromJson` 的默认值 / null 覆盖掉。对含
  /// `scope=serverOnly` 字段或外键的实体（如 SysUser 的 password、authUserId），
  /// 漏传即等于清空。需要「只改传过来的字段」请用 [updateByJsonParams]。
  /// 这个方法之所以保留，是为了给 serverpod 生成的 client 代码预留。
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> update(dynamic data) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('product', 'update', {
        'data': data,
      });

  /// 部分更新数据实体的接口（**PATCH 语义**，接收 JSON 对象文本）
  ///
  /// 与 [update] 的差别：
  /// - [update] 把请求体整体反序列化成新实体再整行覆盖，缺字段即被默认值/null 覆盖；
  /// - [updateByJsonParams] 先按主键读出数据库当前行作为**基线**，只让请求里
  ///   **实际出现过的字段**去覆盖它，未出现的字段保持数据库原值。因此可以安全地
  ///   只传要改的字段，例如 `{"id": 2, "deptId": 2}` 或 `{"id": 2, "username": "chen.yu"}`。
  ///
  /// - [session]：当前的Serverpod会话
  /// - [params]：请求体，是**JSON 对象文本**（不是 JSON 对象本身）。必须带主键
  ///   （默认字段名 `id`），其余字段可选，例如 `{"id": 2, "deptId": 5}` 会被序列化成
  ///   字符串传进来。
  ///
  /// ⚠️ 为什么这里用 `String` 而不是 `dynamic` / `Map<String, dynamic>`：
  /// Serverpod 对这两个类型都会走 `deserializeDynamicFieldValue`，要求线格式是带
  /// 类型标签的 `{"className": "...", "data": {...}}`，**且每个字段值还要再包一层**
  /// （如 `{"id": {"className": "int", "data": 2}}`）；直接传普通 JSON 对象会抛
  /// `No deserialization found for type named null`。`Map<String, dynamic>` 只是把
  /// 报错换成 `got int instead`，同样不可用。详见 `json_param_codec.dart` 的类注释。
  ///
  /// 返回：包含更新结果的[CommonResponse]，data字段为更新后的**完整**实体
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> updateByJsonParams(String params) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'product',
        'updateByJsonParams',
        {'params': params},
      );

  /// 删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要删除的数据主键ID
  ///
  /// 返回：操作结果的[CommonResponse]，若成功返回null数据
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> delete(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('product', 'delete', {
        'id': id,
      });

  /// 批量删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [ids]：要批量删除的主键ID列表
  ///
  /// 返回：包含批量删除结果信息的[CommonResponse]，例如总数、成功数、未找到数等。
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> deleteBatch(List<int> ids) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'product',
        'deleteBatch',
        {'ids': ids},
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

/// 用户相关接口：负责返回当前登录用户的信息、角色、菜单、权限等
/// {@category Endpoint}
class EndpointUser extends EndpointBase {
  EndpointUser(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  /// 创建后台管理员用户
  ///
  /// [req.password] 参数为前端使用登录公钥进行 RSA-OAEP(SHA-256) 加密后再 Base64 编码的密文，
  /// 这里会先解密得到明文密码，再使用 PBKDF2-HMAC-SHA256 哈希后写入 sys_user.password。
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> add(dynamic req) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('user', 'add', {
        'req': req,
      });

  /// 获取用户列表
  ///
  /// [req] 用户列表查询参数
  /// 返回值：用户列表
  _ida.Future<_iq2hfrj8.CommonResponse> getUserList(
    _iq2hfrj8.UserListRequest query,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'user',
    'getUserList',
    {'query': query},
  );

  /// 获取当前登录管理员的完整信息（基础信息 + 岗位 + 角色 + 权限 + 菜单）
  _ida.Future<_iq2hfrj8.CommonResponse> getUserInfo() => caller
      .callServerEndpoint<_iq2hfrj8.CommonResponse>('user', 'getUserInfo', {});

  /// 获取用户路由（树形结构）
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

  /// 更新用户信息
  ///
  /// [params] 用户信息（需包含 id）
  _ida.Future<_iq2hfrj8.CommonResponse> userUpdate(
    _iq2hfrj8.UserRequest params,
  ) => caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
    'user',
    'userUpdate',
    {'params': params},
  );

  /// 获取用户详情（含角色信息）
  ///
  /// [id] 用户ID
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('user', 'getDetail', {
        'id': id,
      });

  /// 重置密码（支持批量）
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

  /// 创建数据实体的接口， 适合单表新增数据。（**接收 JSON 对象文本**）
  ///
  /// 与 [add] 的差别只在入参形态（两者最终都走 `service.create`）：
  /// - [add] 的形参是 `dynamic`，Serverpod 要求带类型标签的线格式，前端无法自然构造；
  /// - [addByJsonParams] 的形参是 `String`，请求体传
  ///   `{"params": "{\"username\":\"chen_yu\"}"}` 即可（前端一行 `JSON.stringify`）。
  ///
  /// - [session]：当前的 Serverpod 会话
  /// - [params]：请求体，是**JSON 对象文本**（不是 JSON 对象本身），例如
  ///   `{"username": "chen_yu", "nickname": "陈宇"}`
  ///
  /// 注意：请求体里出现、但**不属于本实体列**的字段会被忽略（`!persist` 字段、
  /// 关联表字段如 `SysUser` 的 `roleIds` 都在此列）；但至少要有一个合法字段，
  /// 否则直接报错 —— 避免字段名拼错时插进去一条空数据还返回成功。
  ///
  /// 返回：包含新建结果的 [CommonResponse]，data 字段为新建实体
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> addByJsonParams(String params) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'user',
        'addByJsonParams',
        {'params': params},
      );

  /// 获取分页列表数据的接口（支持复杂查询）
  ///
  /// 执行支持高级查询的分页请求。前端传入的[QueryRequest]会经过
  /// [_queryMapper.toCore]转换为后端核心的查询请求对象（如服务层可能需要更丰富的结构，如过滤、排序、关键字等）。
  /// 然后调用service.query执行业务查询，返回[CrudPage<T>]结构，该结构含有数据及分页信息。
  /// 最后将结果数据和分页信息组装为标准接口响应[PageResponse]返回。
  ///
  /// - [session]：当前的Serverpod会话，包含登录上下文信息。
  /// - [query]：前端传入的查询结构体，含分页参数和其他自定义条件。
  ///
  /// 返回：包含查询结果列表及分页的 `PageResponse<T>`。
  ///
  /// 请注意：BaseEndpoint 是一个带泛型 T 的抽象类，继承自 Endpoint。
  /// Serverpod 的代码生成器扫描到 getList 的返回值 `Future<PageResponse<T>>` 时，会把 T 作为一个需要在客户端引用的类型，
  /// 从而生成了指向服务端 base_endpoint.dart 的 import——但客户端包里根本没有这个文件。
  /// 根本原因：getList 的返回类型 `Future<PageResponse<T>>` 中的 T 是泛型参数，生成器无法在客户端正确表达它，只能错误地引用服务端文件。
  /// 因此这里的返回类型必须使用 `Future<PageResponse<dynamic>>` 不能使用 `Future<PageResponse<T>>`
  @override
  _ida.Future<_iq2hfrj8.PageResponse<dynamic>> getList(
    _imp6a5q0.QueryRequest query,
  ) => caller.callServerEndpoint<_iq2hfrj8.PageResponse<dynamic>>(
    'user',
    'getList',
    {'query': query},
  );

  /// 更新数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式，须带主键ID）
  ///
  /// 返回：包含更新结果的[CommonResponse]，data字段为已更新实体
  ///
  /// ⚠️ 这是 **PUT（整行覆盖）** 语义：请求体被整体反序列化成一个新实体后整行写回，
  /// 请求里没出现的字段会被 `fromJson` 的默认值 / null 覆盖掉。对含
  /// `scope=serverOnly` 字段或外键的实体（如 SysUser 的 password、authUserId），
  /// 漏传即等于清空。需要「只改传过来的字段」请用 [updateByJsonParams]。
  /// 这个方法之所以保留，是为了给 serverpod 生成的 client 代码预留。
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> update(dynamic data) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('user', 'update', {
        'data': data,
      });

  /// 部分更新数据实体的接口（**PATCH 语义**，接收 JSON 对象文本）
  ///
  /// 与 [update] 的差别：
  /// - [update] 把请求体整体反序列化成新实体再整行覆盖，缺字段即被默认值/null 覆盖；
  /// - [updateByJsonParams] 先按主键读出数据库当前行作为**基线**，只让请求里
  ///   **实际出现过的字段**去覆盖它，未出现的字段保持数据库原值。因此可以安全地
  ///   只传要改的字段，例如 `{"id": 2, "deptId": 2}` 或 `{"id": 2, "username": "chen.yu"}`。
  ///
  /// - [session]：当前的Serverpod会话
  /// - [params]：请求体，是**JSON 对象文本**（不是 JSON 对象本身）。必须带主键
  ///   （默认字段名 `id`），其余字段可选，例如 `{"id": 2, "deptId": 5}` 会被序列化成
  ///   字符串传进来。
  ///
  /// ⚠️ 为什么这里用 `String` 而不是 `dynamic` / `Map<String, dynamic>`：
  /// Serverpod 对这两个类型都会走 `deserializeDynamicFieldValue`，要求线格式是带
  /// 类型标签的 `{"className": "...", "data": {...}}`，**且每个字段值还要再包一层**
  /// （如 `{"id": {"className": "int", "data": 2}}`）；直接传普通 JSON 对象会抛
  /// `No deserialization found for type named null`。`Map<String, dynamic>` 只是把
  /// 报错换成 `got int instead`，同样不可用。详见 `json_param_codec.dart` 的类注释。
  ///
  /// 返回：包含更新结果的[CommonResponse]，data字段为更新后的**完整**实体
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> updateByJsonParams(String params) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'user',
        'updateByJsonParams',
        {'params': params},
      );

  /// 删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要删除的数据主键ID
  ///
  /// 返回：操作结果的[CommonResponse]，若成功返回null数据
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> delete(int id) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>('user', 'delete', {
        'id': id,
      });

  /// 批量删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [ids]：要批量删除的主键ID列表
  ///
  /// 返回：包含批量删除结果信息的[CommonResponse]，例如总数、成功数、未找到数等。
  @override
  _ida.Future<_iq2hfrj8.CommonResponse> deleteBatch(List<int> ids) =>
      caller.callServerEndpoint<_iq2hfrj8.CommonResponse>(
        'user',
        'deleteBatch',
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
