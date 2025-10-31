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
import 'package:flutter_web_client/src/protocol/common/pagination.dart' as _i5;
import 'package:flutter_web_client/src/protocol/book/book.dart' as _i6;
import 'package:flutter_web_client/src/protocol/system/sys_menu.dart' as _i7;
import 'protocol.dart' as _i8;

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
  ) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
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
  ) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
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
  ) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
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
  }) =>
      caller.callServerEndpoint<_i4.PageResponse<dynamic>>(
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
    int tableId,
    _i5.Pagination pagination,
  ) =>
      caller.callServerEndpoint<_i4.PageResponse<dynamic>>(
        'tableRows',
        'getTableRows',
        {
          'tableId': tableId,
          'pagination': pagination,
        },
      );

  /// ✅ 创建行
  _i2.Future<_i3.CommonResponse> createRow(
    int tableId, {
    int? index,
  }) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
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
  ) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
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
  ) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
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

  /// 后台登录接口
  _i2.Future<_i3.CommonResponse> login(
    String username,
    String password,
  ) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'auth',
        'login',
        {
          'username': username,
          'password': password,
        },
      );

  /// 管理员登录
  _i2.Future<_i3.CommonResponse> adminLogin(
    String username,
    String password,
  ) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'auth',
        'adminLogin',
        {
          'username': username,
          'password': password,
        },
      );

  /// 客户登录
  _i2.Future<_i3.CommonResponse> customerLogin(
    String username,
    String password,
  ) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'auth',
        'customerLogin',
        {
          'username': username,
          'password': password,
        },
      );

  /// 获取用户信息（根据 token 中的用户类型返回对应信息）
  _i2.Future<_i3.CommonResponse> getUserInfo() =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'auth',
        'getUserInfo',
        {},
      );

  /// 刷新 token（统一处理管理员和客户的 token 刷新）
  _i2.Future<_i3.CommonResponse> refreshToken() =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'auth',
        'refreshToken',
        {},
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
  }) =>
      caller.callServerEndpoint<_i4.PageResponse<dynamic>>(
        'book',
        'list',
        {
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
      );
}

/// {@category Endpoint}
class EndpointMenu extends _i1.EndpointRef {
  EndpointMenu(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'menu';

  /// 添加菜单接口
  _i2.Future<_i3.CommonResponse> add(_i7.SysMenu menu) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'menu',
        'add',
        {'menu': menu},
      );

  /// 管理员登录
  _i2.Future<_i3.CommonResponse> adminLogin(
    String username,
    String password,
  ) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'menu',
        'adminLogin',
        {
          'username': username,
          'password': password,
        },
      );

  /// 客户登录
  _i2.Future<_i3.CommonResponse> customerLogin(
    String username,
    String password,
  ) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'menu',
        'customerLogin',
        {
          'username': username,
          'password': password,
        },
      );

  /// 获取用户信息（根据 token 中的用户类型返回对应信息）
  _i2.Future<_i3.CommonResponse> getUserInfo() =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'menu',
        'getUserInfo',
        {},
      );

  /// 刷新 token（统一处理管理员和客户的 token 刷新）
  _i2.Future<_i3.CommonResponse> refreshToken() =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'menu',
        'refreshToken',
        {},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i8.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
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
    menu = EndpointMenu(this);
  }

  late final EndpointAirTableFields airTableFields;

  late final EndpointTableItems tableItems;

  late final EndpointTableItemRelations tableItemRelations;

  late final EndpointTableRows tableRows;

  late final EndpointTables tables;

  late final EndpointAuth auth;

  late final EndpointBook book;

  late final EndpointMenu menu;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'airTableFields': airTableFields,
        'tableItems': tableItems,
        'tableItemRelations': tableItemRelations,
        'tableRows': tableRows,
        'tables': tables,
        'auth': auth,
        'book': book,
        'menu': menu,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
