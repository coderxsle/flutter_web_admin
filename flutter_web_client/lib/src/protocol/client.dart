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
import 'package:flutter_web_shared/src/models/common/common_response.dart'
    as _i3;
import 'package:flutter_web_shared/src/models/common/page_response.dart' as _i4;
import 'package:flutter_web_shared/src/generated/requests/common/pagination.dart'
    as _i5;
import 'package:flutter_web_client/src/protocol/book/book.dart' as _i6;
import 'package:serverpod_crud/src/models/query/query_request.dart' as _i7;
import 'package:flutter_web_shared/src/generated/requests/dept/dept_request.dart'
    as _i8;
import 'package:flutter_web_shared/src/generated/requests/dict_code_request.dart'
    as _i9;
import 'package:flutter_web_shared/src/generated/requests/dict_data_request.dart'
    as _i10;
import 'package:flutter_web_client/src/protocol/system/sys_dict_data.dart'
    as _i11;
import 'package:flutter_web_shared/src/generated/requests/menu/menu_request.dart'
    as _i12;
import 'package:flutter_web_client/src/protocol/system/sys_role.dart' as _i13;
import 'package:flutter_web_shared/src/generated/requests/user/user_request.dart'
    as _i14;
import 'package:flutter_web_shared/src/generated/requests/user/user_list_request.dart'
    as _i15;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i16;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i17;
import 'protocol.dart' as _i18;

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
    required int page,
    required int pageSize,
  }) => caller.callServerEndpoint<_i4.PageResponse<dynamic>>(
    'book',
    'list',
    {
      'page': page,
      'pageSize': pageSize,
    },
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
      );

  /// 使用 refreshToken 刷新 accessToken（无需已登录）
  _i2.Future<_i3.CommonResponse> refreshToken(String refreshToken) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'auth',
        'refreshToken',
        {'refreshToken': refreshToken},
      );
}

/// 通用 CRUD Endpoint 基类（默认实现）
///
/// 子类只需提供 [service] 与 [decodeModel]，即可自动拥有常见 CRUD + query 方法。
/// {@category Endpoint}
abstract class EndpointBase extends _i1.EndpointRef {
  EndpointBase(_i1.EndpointCaller caller) : super(caller);

  /// 创建数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式）
  ///
  /// 返回：包含新建结果的[CommonResponse]，data字段为新建实体
  _i2.Future<_i3.CommonResponse> add(dynamic data);

  /// 获取指定ID的详情数据
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要获取详情的数据主键ID
  ///
  /// 返回：包含查询结果的[CommonResponse]
  _i2.Future<_i3.CommonResponse> getDetail(int id);

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
  /// 返回：包含查询结果列表及分页的[PageResponse<T>]。
  ///
  /// 请注意：BaseEndpoint 是一个带泛型 T 的抽象类，继承自 Endpoint。
  /// Serverpod 的代码生成器扫描到 getList 的返回值 Future<PageResponse<T>> 时，会把 T 作为一个需要在客户端引用的类型，
  /// 从而生成了指向服务端 base_endpoint.dart 的 import——但客户端包里根本没有这个文件。
  /// 根本原因：getList 的返回类型 Future<PageResponse<T>> 中的 T 是泛型参数，生成器无法在客户端正确表达它，只能错误地引用服务端文件。
  /// 因此这里的返回类型必须使用 Future<PageResponse<dynamic>> 不能使用 Future<PageResponse<T>>
  _i2.Future<_i4.PageResponse<dynamic>> getList(_i7.QueryRequest query);

  /// 更新数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式，须带主键ID）
  ///
  /// 返回：包含更新结果的[CommonResponse]，data字段为已更新实体
  _i2.Future<_i3.CommonResponse> update(dynamic data);

  /// 删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要删除的数据主键ID
  ///
  /// 返回：操作结果的[CommonResponse]，若成功返回null数据
  _i2.Future<_i3.CommonResponse> delete(int id);

  /// 批量删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [ids]：要批量删除的主键ID列表
  ///
  /// 返回：包含批量删除结果信息的[CommonResponse]，例如总数、成功数、未找到数等。
  _i2.Future<_i3.CommonResponse> deleteBatch(List<int> ids);
}

/// 基于 [AutoCrudService.meta] 自动获取模型解码器的 Endpoint 基类，简化了 CRUD 相关接口的模型解码工作。
///
/// 泛型说明：
/// - [T]：代表后端数据表对应的实体类型，通常需继承自 [TableRow]，如 User、Article 等。用于约束实体的数据结构。
/// - [TTable]：代表此实体 (T) 使用的数据库表定义（继承自 [Table]），如 UserTable、ArticleTable，用于支持复杂查询、表结构元数据等。
/// - [S]：处理此实体的自动CRUD服务类型（需继承 [AutoCrudService<T, TTable>]），负责提供模型的增删改查和 decode 逻辑。
///
/// 实现思路：
/// 通过覆写 [decodeModel] 方法，把外部（如 JSON 或 Map）传入的数据，直接交给服务的 [decodeModel] 统一解码，
/// 使得各业务子类无需重复实现对象重建（反序列化）的细节，确保一致性并减少样板代码。
/// {@category Endpoint}
abstract class EndpointAutoCrud extends EndpointBase {
  EndpointAutoCrud(_i1.EndpointCaller caller) : super(caller);

  /// 创建数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式）
  ///
  /// 返回：包含新建结果的[CommonResponse]，data字段为新建实体
  @override
  _i2.Future<_i3.CommonResponse> add(dynamic data);

  /// 获取指定ID的详情数据
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要获取详情的数据主键ID
  ///
  /// 返回：包含查询结果的[CommonResponse]
  @override
  _i2.Future<_i3.CommonResponse> getDetail(int id);

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
  /// 返回：包含查询结果列表及分页的[PageResponse<T>]。
  ///
  /// 请注意：BaseEndpoint 是一个带泛型 T 的抽象类，继承自 Endpoint。
  /// Serverpod 的代码生成器扫描到 getList 的返回值 Future<PageResponse<T>> 时，会把 T 作为一个需要在客户端引用的类型，
  /// 从而生成了指向服务端 base_endpoint.dart 的 import——但客户端包里根本没有这个文件。
  /// 根本原因：getList 的返回类型 Future<PageResponse<T>> 中的 T 是泛型参数，生成器无法在客户端正确表达它，只能错误地引用服务端文件。
  /// 因此这里的返回类型必须使用 Future<PageResponse<dynamic>> 不能使用 Future<PageResponse<T>>
  @override
  _i2.Future<_i4.PageResponse<dynamic>> getList(_i7.QueryRequest query);

  /// 更新数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式，须带主键ID）
  ///
  /// 返回：包含更新结果的[CommonResponse]，data字段为已更新实体
  @override
  _i2.Future<_i3.CommonResponse> update(dynamic data);

  /// 删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要删除的数据主键ID
  ///
  /// 返回：操作结果的[CommonResponse]，若成功返回null数据
  @override
  _i2.Future<_i3.CommonResponse> delete(int id);

  /// 批量删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [ids]：要批量删除的主键ID列表
  ///
  /// 返回：包含批量删除结果信息的[CommonResponse]，例如总数、成功数、未找到数等。
  @override
  _i2.Future<_i3.CommonResponse> deleteBatch(List<int> ids);
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
  _i2.Future<_i3.CommonResponse> add(_i8.DeptRequest req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dept',
        'add',
        {'req': req},
      );

  _i2.Future<_i3.CommonResponse> update(_i8.DeptRequest req) =>
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
    String? status,
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
  _i2.Future<_i3.CommonResponse> addDictCode(_i9.DictCodeRequest req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dict',
        'addDictCode',
        {'req': req},
      );

  /// 更新字典类型
  ///
  /// [req] 字典类型信息（需包含 id）
  _i2.Future<_i3.CommonResponse> updateDictCode(_i9.DictCodeRequest req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dict',
        'updateDictCode',
        {'req': req},
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
  _i2.Future<_i3.CommonResponse> addDictData(_i10.DictDataRequest req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'dict',
        'addDictData',
        {'req': req},
      );

  /// 更新字典数据
  ///
  /// [req] 字典数据信息（需包含 id）
  _i2.Future<_i3.CommonResponse> updateDictData(_i11.SysDictData req) =>
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
  _i2.Future<_i3.CommonResponse> add(_i12.MenuRequest req) =>
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
  _i2.Future<_i3.CommonResponse> update(_i12.MenuRequest req) =>
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

/// {@category Endpoint}
class EndpointProduct extends EndpointAutoCrud {
  EndpointProduct(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'product';

  /// 创建数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式）
  ///
  /// 返回：包含新建结果的[CommonResponse]，data字段为新建实体
  @override
  _i2.Future<_i3.CommonResponse> add(dynamic data) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'product',
        'add',
        {'data': data},
      );

  /// 获取指定ID的详情数据
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要获取详情的数据主键ID
  ///
  /// 返回：包含查询结果的[CommonResponse]
  @override
  _i2.Future<_i3.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'product',
        'getDetail',
        {'id': id},
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
  /// 返回：包含查询结果列表及分页的[PageResponse<T>]。
  ///
  /// 请注意：BaseEndpoint 是一个带泛型 T 的抽象类，继承自 Endpoint。
  /// Serverpod 的代码生成器扫描到 getList 的返回值 Future<PageResponse<T>> 时，会把 T 作为一个需要在客户端引用的类型，
  /// 从而生成了指向服务端 base_endpoint.dart 的 import——但客户端包里根本没有这个文件。
  /// 根本原因：getList 的返回类型 Future<PageResponse<T>> 中的 T 是泛型参数，生成器无法在客户端正确表达它，只能错误地引用服务端文件。
  /// 因此这里的返回类型必须使用 Future<PageResponse<dynamic>> 不能使用 Future<PageResponse<T>>
  @override
  _i2.Future<_i4.PageResponse<dynamic>> getList(_i7.QueryRequest query) =>
      caller.callServerEndpoint<_i4.PageResponse<dynamic>>(
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
  @override
  _i2.Future<_i3.CommonResponse> update(dynamic data) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'product',
        'update',
        {'data': data},
      );

  /// 删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要删除的数据主键ID
  ///
  /// 返回：操作结果的[CommonResponse]，若成功返回null数据
  @override
  _i2.Future<_i3.CommonResponse> delete(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'product',
        'delete',
        {'id': id},
      );

  /// 批量删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [ids]：要批量删除的主键ID列表
  ///
  /// 返回：包含批量删除结果信息的[CommonResponse]，例如总数、成功数、未找到数等。
  @override
  _i2.Future<_i3.CommonResponse> deleteBatch(List<int> ids) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
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
    required int page,
    required int pageSize,
    String? nickname,
  }) => caller.callServerEndpoint<_i3.CommonResponse>(
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
  _i2.Future<_i3.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'role',
        'getDetail',
        {'id': id},
      );

  /// 更新角色信息
  ///
  /// [req] 角色信息（需包含 id）
  _i2.Future<_i3.CommonResponse> update(_i13.SysRole req) =>
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
class EndpointUser extends EndpointAutoCrud {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  /// 创建后台管理员用户
  ///
  /// [req.password] 参数为前端使用登录公钥进行 RSA-OAEP(SHA-256) 加密后再 Base64 编码的密文，
  /// 这里会先解密得到明文密码，再使用 PBKDF2-HMAC-SHA256 哈希后写入 sys_user.password。
  _i2.Future<_i3.CommonResponse> userAdd(_i14.UserRequest req) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'userAdd',
        {'req': req},
      );

  /// 获取用户列表
  ///
  /// [req] 用户列表查询参数
  /// 返回值：用户列表
  _i2.Future<_i3.CommonResponse> getUserList(_i15.UserListRequest query) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'getUserList',
        {'query': query},
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

  /// 更新用户信息
  ///
  /// [req] 用户信息（需包含 id）
  /// 获取用户详情（含角色信息）
  ///
  /// [id] 用户ID
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

  /// 创建数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式）
  ///
  /// 返回：包含新建结果的[CommonResponse]，data字段为新建实体
  @override
  _i2.Future<_i3.CommonResponse> add(dynamic data) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'add',
        {'data': data},
      );

  /// 获取指定ID的详情数据
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要获取详情的数据主键ID
  ///
  /// 返回：包含查询结果的[CommonResponse]
  @override
  _i2.Future<_i3.CommonResponse> getDetail(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'getDetail',
        {'id': id},
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
  /// 返回：包含查询结果列表及分页的[PageResponse<T>]。
  ///
  /// 请注意：BaseEndpoint 是一个带泛型 T 的抽象类，继承自 Endpoint。
  /// Serverpod 的代码生成器扫描到 getList 的返回值 Future<PageResponse<T>> 时，会把 T 作为一个需要在客户端引用的类型，
  /// 从而生成了指向服务端 base_endpoint.dart 的 import——但客户端包里根本没有这个文件。
  /// 根本原因：getList 的返回类型 Future<PageResponse<T>> 中的 T 是泛型参数，生成器无法在客户端正确表达它，只能错误地引用服务端文件。
  /// 因此这里的返回类型必须使用 Future<PageResponse<dynamic>> 不能使用 Future<PageResponse<T>>
  @override
  _i2.Future<_i4.PageResponse<dynamic>> getList(_i7.QueryRequest query) =>
      caller.callServerEndpoint<_i4.PageResponse<dynamic>>(
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
  @override
  _i2.Future<_i3.CommonResponse> update(dynamic data) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'update',
        {'data': data},
      );

  /// 删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要删除的数据主键ID
  ///
  /// 返回：操作结果的[CommonResponse]，若成功返回null数据
  @override
  _i2.Future<_i3.CommonResponse> delete(int id) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'delete',
        {'id': id},
      );

  /// 批量删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [ids]：要批量删除的主键ID列表
  ///
  /// 返回：包含批量删除结果信息的[CommonResponse]，例如总数、成功数、未找到数等。
  @override
  _i2.Future<_i3.CommonResponse> deleteBatch(List<int> ids) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'user',
        'deleteBatch',
        {'ids': ids},
      );
}

class Modules {
  Modules(Client client) {
    auth_idp = _i16.Caller(client);
    auth_core = _i17.Caller(client);
  }

  late final _i16.Caller auth_idp;

  late final _i17.Caller auth_core;
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
         _i18.Protocol(),
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
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
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
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'auth_idp': modules.auth_idp,
    'auth_core': modules.auth_core,
  };
}
