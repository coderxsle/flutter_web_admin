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
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/airtable/fields_endpoint.dart' as _i2;
import '../endpoints/airtable/items_endpoint.dart' as _i3;
import '../endpoints/airtable/relations_endpoint.dart' as _i4;
import '../endpoints/airtable/rows_endpoint.dart' as _i5;
import '../endpoints/airtable/tables_endpoint.dart' as _i6;
import '../endpoints/system/auth_endpoint.dart' as _i7;
import '../endpoints/system/book_endpoint.dart' as _i8;
import '../endpoints/system/dept_endpoint.dart' as _i9;
import '../endpoints/system/dict_endpoint.dart' as _i10;
import '../endpoints/system/menu_endpoint.dart' as _i11;
import '../endpoints/system/role_endpoint.dart' as _i12;
import '../endpoints/system/system_endpoint.dart' as _i13;
import '../endpoints/system/user_endpoint.dart' as _i14;
import 'package:flutter_web_server/src/generated/requests/user/common/pagination.dart'
    as _i15;
import 'package:flutter_web_server/src/generated/book/book.dart' as _i16;
import 'package:flutter_web_server/src/generated/requests/dept/dept_request.dart'
    as _i17;
import 'package:flutter_web_server/src/generated/system/sys_dict_code.dart'
    as _i18;
import 'package:flutter_web_server/src/generated/system/sys_dict_data.dart'
    as _i19;
import 'package:flutter_web_server/src/generated/requests/menu/menu_request.dart'
    as _i20;
import 'package:flutter_web_server/src/generated/system/sys_role.dart' as _i21;
import 'package:flutter_web_server/src/generated/requests/user/user_request.dart'
    as _i22;
import 'package:flutter_web_server/src/generated/requests/user/user_list_request.dart'
    as _i23;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i24;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i25;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'airTableFields': _i2.AirTableFieldsEndpoint()
        ..initialize(
          server,
          'airTableFields',
          null,
        ),
      'tableItems': _i3.TableItemsEndpoint()
        ..initialize(
          server,
          'tableItems',
          null,
        ),
      'tableItemRelations': _i4.TableItemRelationsEndpoint()
        ..initialize(
          server,
          'tableItemRelations',
          null,
        ),
      'tableRows': _i5.TableRowsEndpoint()
        ..initialize(
          server,
          'tableRows',
          null,
        ),
      'tables': _i6.TablesEndpoint()
        ..initialize(
          server,
          'tables',
          null,
        ),
      'auth': _i7.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'book': _i8.BookEndpoint()
        ..initialize(
          server,
          'book',
          null,
        ),
      'dept': _i9.DeptEndpoint()
        ..initialize(
          server,
          'dept',
          null,
        ),
      'dict': _i10.DictEndpoint()
        ..initialize(
          server,
          'dict',
          null,
        ),
      'menu': _i11.MenuEndpoint()
        ..initialize(
          server,
          'menu',
          null,
        ),
      'role': _i12.RoleEndpoint()
        ..initialize(
          server,
          'role',
          null,
        ),
      'system': _i13.SystemEndpoint()
        ..initialize(
          server,
          'system',
          null,
        ),
      'user': _i14.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['airTableFields'] = _i1.EndpointConnector(
      name: 'airTableFields',
      endpoint: endpoints['airTableFields']!,
      methodConnectors: {
        'getAirTableFields': _i1.MethodConnector(
          name: 'getAirTableFields',
          params: {
            'tableId': _i1.ParameterDescription(
              name: 'tableId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['airTableFields'] as _i2.AirTableFieldsEndpoint)
                      .getAirTableFields(
                        session,
                        params['tableId'],
                      ),
        ),
        'createField': _i1.MethodConnector(
          name: 'createField',
          params: {
            'tableId': _i1.ParameterDescription(
              name: 'tableId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'fieldName': _i1.ParameterDescription(
              name: 'fieldName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['airTableFields'] as _i2.AirTableFieldsEndpoint)
                      .createField(
                        session,
                        params['tableId'],
                        params['fieldName'],
                      ),
        ),
        'updateField': _i1.MethodConnector(
          name: 'updateField',
          params: {
            'fieldName': _i1.ParameterDescription(
              name: 'fieldName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newName': _i1.ParameterDescription(
              name: 'newName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['airTableFields'] as _i2.AirTableFieldsEndpoint)
                      .updateField(
                        session,
                        params['fieldName'],
                        params['newName'],
                      ),
        ),
        'deleteField': _i1.MethodConnector(
          name: 'deleteField',
          params: {
            'fieldName': _i1.ParameterDescription(
              name: 'fieldName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['airTableFields'] as _i2.AirTableFieldsEndpoint)
                      .deleteField(
                        session,
                        params['fieldName'],
                      ),
        ),
      },
    );
    connectors['tableItems'] = _i1.EndpointConnector(
      name: 'tableItems',
      endpoint: endpoints['tableItems']!,
      methodConnectors: {
        'upsertItem': _i1.MethodConnector(
          name: 'upsertItem',
          params: {
            'fieldId': _i1.ParameterDescription(
              name: 'fieldId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'value': _i1.ParameterDescription(
              name: 'value',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'rowId': _i1.ParameterDescription(
              name: 'rowId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['tableItems'] as _i3.TableItemsEndpoint)
                  .upsertItem(
                    session,
                    params['fieldId'],
                    params['value'],
                    params['rowId'],
                  ),
        ),
        'deleteItem': _i1.MethodConnector(
          name: 'deleteItem',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['tableItems'] as _i3.TableItemsEndpoint)
                  .deleteItem(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['tableItemRelations'] = _i1.EndpointConnector(
      name: 'tableItemRelations',
      endpoint: endpoints['tableItemRelations']!,
      methodConnectors: {
        'getItemRelations': _i1.MethodConnector(
          name: 'getItemRelations',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['tableItemRelations']
                          as _i4.TableItemRelationsEndpoint)
                      .getItemRelations(
                        session,
                        params['id'],
                      ),
        ),
        'searchTableItems': _i1.MethodConnector(
          name: 'searchTableItems',
          params: {
            'tableId': _i1.ParameterDescription(
              name: 'tableId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pagination': _i1.ParameterDescription(
              name: 'pagination',
              type: _i1.getType<_i15.Pagination>(),
              nullable: false,
            ),
            'fieldId': _i1.ParameterDescription(
              name: 'fieldId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['tableItemRelations']
                          as _i4.TableItemRelationsEndpoint)
                      .searchTableItems(
                        session,
                        params['tableId'],
                        params['pagination'],
                        fieldId: params['fieldId'],
                      ),
        ),
        'getAvailableTables': _i1.MethodConnector(
          name: 'getAvailableTables',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['tableItemRelations']
                          as _i4.TableItemRelationsEndpoint)
                      .getAvailableTables(session),
        ),
        'getTableFieldsForRelation': _i1.MethodConnector(
          name: 'getTableFieldsForRelation',
          params: {
            'tableId': _i1.ParameterDescription(
              name: 'tableId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['tableItemRelations']
                          as _i4.TableItemRelationsEndpoint)
                      .getTableFieldsForRelation(
                        session,
                        params['tableId'],
                      ),
        ),
      },
    );
    connectors['tableRows'] = _i1.EndpointConnector(
      name: 'tableRows',
      endpoint: endpoints['tableRows']!,
      methodConnectors: {
        'getTableRows': _i1.MethodConnector(
          name: 'getTableRows',
          params: {
            'tableId': _i1.ParameterDescription(
              name: 'tableId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'keyword': _i1.ParameterDescription(
              name: 'keyword',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['tableRows'] as _i5.TableRowsEndpoint)
                  .getTableRows(
                    session,
                    params['tableId'],
                    page: params['page'],
                    pageSize: params['pageSize'],
                    keyword: params['keyword'],
                  ),
        ),
        'createRow': _i1.MethodConnector(
          name: 'createRow',
          params: {
            'tableId': _i1.ParameterDescription(
              name: 'tableId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'index': _i1.ParameterDescription(
              name: 'index',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['tableRows'] as _i5.TableRowsEndpoint).createRow(
                    session,
                    params['tableId'],
                    index: params['index'],
                  ),
        ),
        'updateRow': _i1.MethodConnector(
          name: 'updateRow',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'index': _i1.ParameterDescription(
              name: 'index',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['tableRows'] as _i5.TableRowsEndpoint).updateRow(
                    session,
                    params['id'],
                    params['index'],
                  ),
        ),
        'deleteRow': _i1.MethodConnector(
          name: 'deleteRow',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['tableRows'] as _i5.TableRowsEndpoint).deleteRow(
                    session,
                    params['id'],
                  ),
        ),
        'batchDeleteRows': _i1.MethodConnector(
          name: 'batchDeleteRows',
          params: {
            'ids': _i1.ParameterDescription(
              name: 'ids',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['tableRows'] as _i5.TableRowsEndpoint)
                  .batchDeleteRows(
                    session,
                    params['ids'],
                  ),
        ),
      },
    );
    connectors['tables'] = _i1.EndpointConnector(
      name: 'tables',
      endpoint: endpoints['tables']!,
      methodConnectors: {
        'getTables': _i1.MethodConnector(
          name: 'getTables',
          params: {
            'pagination': _i1.ParameterDescription(
              name: 'pagination',
              type: _i1.getType<_i15.Pagination>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['tables'] as _i6.TablesEndpoint).getTables(
                session,
                params['pagination'],
              ),
        ),
        'getTables2': _i1.MethodConnector(
          name: 'getTables2',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'keyword': _i1.ParameterDescription(
              name: 'keyword',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['tables'] as _i6.TablesEndpoint).getTables2(
                session,
                page: params['page'],
                pageSize: params['pageSize'],
                keyword: params['keyword'],
              ),
        ),
        'tableDetail': _i1.MethodConnector(
          name: 'tableDetail',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['tables'] as _i6.TablesEndpoint).tableDetail(
                    session,
                    params['id'],
                  ),
        ),
        'createTable': _i1.MethodConnector(
          name: 'createTable',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['tables'] as _i6.TablesEndpoint).createTable(
                    session,
                    params['name'],
                  ),
        ),
        'updateTable': _i1.MethodConnector(
          name: 'updateTable',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['tables'] as _i6.TablesEndpoint).updateTable(
                    session,
                    params['id'],
                    params['name'],
                  ),
        ),
        'deleteTable': _i1.MethodConnector(
          name: 'deleteTable',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['tables'] as _i6.TablesEndpoint).deleteTable(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'username': _i1.ParameterDescription(
              name: 'username',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i7.AuthEndpoint).login(
                session,
                params['username'],
                params['password'],
              ),
        ),
        'publicKey': _i1.MethodConnector(
          name: 'publicKey',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['auth'] as _i7.AuthEndpoint).publicKey(session),
        ),
        'refreshToken': _i1.MethodConnector(
          name: 'refreshToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i7.AuthEndpoint).refreshToken(
                session,
                params['refreshToken'],
              ),
        ),
      },
    );
    connectors['book'] = _i1.EndpointConnector(
      name: 'book',
      endpoint: endpoints['book']!,
      methodConnectors: {
        'createBook': _i1.MethodConnector(
          name: 'createBook',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i16.Book>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _i8.BookEndpoint).createBook(
                session,
                params['book'],
              ),
        ),
        'updateBook': _i1.MethodConnector(
          name: 'updateBook',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i16.Book>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _i8.BookEndpoint).updateBook(
                session,
                params['book'],
              ),
        ),
        'deleteBook': _i1.MethodConnector(
          name: 'deleteBook',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i16.Book>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _i8.BookEndpoint).deleteBook(
                session,
                params['book'],
              ),
        ),
        'getBook': _i1.MethodConnector(
          name: 'getBook',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _i8.BookEndpoint).getBook(
                session,
                params['id'],
              ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'pageNum': _i1.ParameterDescription(
              name: 'pageNum',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['book'] as _i8.BookEndpoint).list(
                session,
                pageNum: params['pageNum'],
                pageSize: params['pageSize'],
              ),
        ),
      },
    );
    connectors['dept'] = _i1.EndpointConnector(
      name: 'dept',
      endpoint: endpoints['dept']!,
      methodConnectors: {
        'getList': _i1.MethodConnector(
          name: 'getList',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dept'] as _i9.DeptEndpoint).getList(
                session,
                status: params['status'],
                name: params['name'],
              ),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'req': _i1.ParameterDescription(
              name: 'req',
              type: _i1.getType<_i17.DeptRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dept'] as _i9.DeptEndpoint).add(
                session,
                params['req'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'req': _i1.ParameterDescription(
              name: 'req',
              type: _i1.getType<_i17.DeptRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dept'] as _i9.DeptEndpoint).update(
                session,
                params['req'],
              ),
        ),
        'getDetail': _i1.MethodConnector(
          name: 'getDetail',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dept'] as _i9.DeptEndpoint).getDetail(
                session,
                params['id'],
              ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'ids': _i1.ParameterDescription(
              name: 'ids',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dept'] as _i9.DeptEndpoint).delete(
                session,
                params['ids'],
              ),
        ),
      },
    );
    connectors['dict'] = _i1.EndpointConnector(
      name: 'dict',
      endpoint: endpoints['dict']!,
      methodConnectors: {
        'getDictData': _i1.MethodConnector(
          name: 'getDictData',
          params: {
            'tenantId': _i1.ParameterDescription(
              name: 'tenantId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dict'] as _i10.DictEndpoint).getDictData(
                session,
                tenantId: params['tenantId'],
              ),
        ),
        'getDictCodeList': _i1.MethodConnector(
          name: 'getDictCodeList',
          params: {
            'tenantId': _i1.ParameterDescription(
              name: 'tenantId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dict'] as _i10.DictEndpoint).getDictCodeList(
                    session,
                    tenantId: params['tenantId'],
                    name: params['name'],
                    code: params['code'],
                    status: params['status'],
                  ),
        ),
        'getDictCodeDetail': _i1.MethodConnector(
          name: 'getDictCodeDetail',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dict'] as _i10.DictEndpoint).getDictCodeDetail(
                    session,
                    params['id'],
                  ),
        ),
        'addDictCode': _i1.MethodConnector(
          name: 'addDictCode',
          params: {
            'req': _i1.ParameterDescription(
              name: 'req',
              type: _i1.getType<_i18.SysDictCode>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dict'] as _i10.DictEndpoint).addDictCode(
                session,
                params['req'],
              ),
        ),
        'updateDictCode': _i1.MethodConnector(
          name: 'updateDictCode',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'remark': _i1.ParameterDescription(
              name: 'remark',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dict'] as _i10.DictEndpoint).updateDictCode(
                    session,
                    params['id'],
                    params['code'],
                    params['name'],
                    params['status'],
                    params['remark'],
                  ),
        ),
        'deleteDictCode': _i1.MethodConnector(
          name: 'deleteDictCode',
          params: {
            'ids': _i1.ParameterDescription(
              name: 'ids',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dict'] as _i10.DictEndpoint).deleteDictCode(
                    session,
                    params['ids'],
                  ),
        ),
        'getDictDataList': _i1.MethodConnector(
          name: 'getDictDataList',
          params: {
            'tenantId': _i1.ParameterDescription(
              name: 'tenantId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'value': _i1.ParameterDescription(
              name: 'value',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dict'] as _i10.DictEndpoint).getDictDataList(
                    session,
                    tenantId: params['tenantId'],
                    code: params['code'],
                    name: params['name'],
                    value: params['value'],
                    status: params['status'],
                  ),
        ),
        'addDictData': _i1.MethodConnector(
          name: 'addDictData',
          params: {
            'req': _i1.ParameterDescription(
              name: 'req',
              type: _i1.getType<_i19.SysDictData>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dict'] as _i10.DictEndpoint).addDictData(
                session,
                params['req'],
              ),
        ),
        'updateDictData': _i1.MethodConnector(
          name: 'updateDictData',
          params: {
            'req': _i1.ParameterDescription(
              name: 'req',
              type: _i1.getType<_i19.SysDictData>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dict'] as _i10.DictEndpoint).updateDictData(
                    session,
                    params['req'],
                  ),
        ),
        'deleteDictData': _i1.MethodConnector(
          name: 'deleteDictData',
          params: {
            'ids': _i1.ParameterDescription(
              name: 'ids',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dict'] as _i10.DictEndpoint).deleteDictData(
                    session,
                    params['ids'],
                  ),
        ),
        'getDictDataDetail': _i1.MethodConnector(
          name: 'getDictDataDetail',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dict'] as _i10.DictEndpoint).getDictDataDetail(
                    session,
                    params['id'],
                    params['code'],
                  ),
        ),
      },
    );
    connectors['menu'] = _i1.EndpointConnector(
      name: 'menu',
      endpoint: endpoints['menu']!,
      methodConnectors: {
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'req': _i1.ParameterDescription(
              name: 'req',
              type: _i1.getType<_i20.MenuRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menu'] as _i11.MenuEndpoint).add(
                session,
                params['req'],
              ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'ids': _i1.ParameterDescription(
              name: 'ids',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menu'] as _i11.MenuEndpoint).delete(
                session,
                params['ids'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'req': _i1.ParameterDescription(
              name: 'req',
              type: _i1.getType<_i20.MenuRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menu'] as _i11.MenuEndpoint).update(
                session,
                params['req'],
              ),
        ),
        'getMenuOptions': _i1.MethodConnector(
          name: 'getMenuOptions',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menu'] as _i11.MenuEndpoint)
                  .getMenuOptions(session),
        ),
        'getList': _i1.MethodConnector(
          name: 'getList',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menu'] as _i11.MenuEndpoint).getList(
                session,
                params['name'],
                params['status'],
              ),
        ),
        'getDetail': _i1.MethodConnector(
          name: 'getDetail',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['menu'] as _i11.MenuEndpoint).getDetail(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['role'] = _i1.EndpointConnector(
      name: 'role',
      endpoint: endpoints['role']!,
      methodConnectors: {
        'getList': _i1.MethodConnector(
          name: 'getList',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['role'] as _i12.RoleEndpoint).getList(session),
        ),
        'getRoleMenuIds': _i1.MethodConnector(
          name: 'getRoleMenuIds',
          params: {
            'roleId': _i1.ParameterDescription(
              name: 'roleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['role'] as _i12.RoleEndpoint).getRoleMenuIds(
                    session,
                    params['roleId'],
                  ),
        ),
        'saveRolePermissions': _i1.MethodConnector(
          name: 'saveRolePermissions',
          params: {
            'roleId': _i1.ParameterDescription(
              name: 'roleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'menuIds': _i1.ParameterDescription(
              name: 'menuIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['role'] as _i12.RoleEndpoint).saveRolePermissions(
                    session,
                    params['roleId'],
                    params['menuIds'],
                  ),
        ),
        'getRoleUsers': _i1.MethodConnector(
          name: 'getRoleUsers',
          params: {
            'roleId': _i1.ParameterDescription(
              name: 'roleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageNum': _i1.ParameterDescription(
              name: 'pageNum',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'nickname': _i1.ParameterDescription(
              name: 'nickname',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['role'] as _i12.RoleEndpoint).getRoleUsers(
                session,
                params['roleId'],
                pageNum: params['pageNum'],
                pageSize: params['pageSize'],
                nickname: params['nickname'],
              ),
        ),
        'getDetail': _i1.MethodConnector(
          name: 'getDetail',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['role'] as _i12.RoleEndpoint).getDetail(
                session,
                params['id'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'req': _i1.ParameterDescription(
              name: 'req',
              type: _i1.getType<_i21.SysRole>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['role'] as _i12.RoleEndpoint).update(
                session,
                params['req'],
              ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'ids': _i1.ParameterDescription(
              name: 'ids',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['role'] as _i12.RoleEndpoint).delete(
                session,
                params['ids'],
              ),
        ),
        'cancelUserRoles': _i1.MethodConnector(
          name: 'cancelUserRoles',
          params: {
            'roleId': _i1.ParameterDescription(
              name: 'roleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userIds': _i1.ParameterDescription(
              name: 'userIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['role'] as _i12.RoleEndpoint).cancelUserRoles(
                    session,
                    params['roleId'],
                    params['userIds'],
                  ),
        ),
      },
    );
    connectors['system'] = _i1.EndpointConnector(
      name: 'system',
      endpoint: endpoints['system']!,
      methodConnectors: {
        'health': _i1.MethodConnector(
          name: 'health',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['system'] as _i13.SystemEndpoint).health(session),
        ),
        'version': _i1.MethodConnector(
          name: 'version',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['system'] as _i13.SystemEndpoint).version(session),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'req': _i1.ParameterDescription(
              name: 'req',
              type: _i1.getType<_i22.UserRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i14.UserEndpoint).add(
                session,
                params['req'],
              ),
        ),
        'getList': _i1.MethodConnector(
          name: 'getList',
          params: {
            'req': _i1.ParameterDescription(
              name: 'req',
              type: _i1.getType<_i23.UserListRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i14.UserEndpoint).getList(
                session,
                params['req'],
              ),
        ),
        'getUserInfo': _i1.MethodConnector(
          name: 'getUserInfo',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i14.UserEndpoint).getUserInfo(session),
        ),
        'getUserRoutes': _i1.MethodConnector(
          name: 'getUserRoutes',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i14.UserEndpoint).getUserRoutes(
                session,
              ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'ids': _i1.ParameterDescription(
              name: 'ids',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i14.UserEndpoint).delete(
                session,
                params['ids'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'req': _i1.ParameterDescription(
              name: 'req',
              type: _i1.getType<_i22.UserRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i14.UserEndpoint).update(
                session,
                params['req'],
              ),
        ),
        'getDetail': _i1.MethodConnector(
          name: 'getDetail',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i14.UserEndpoint).getDetail(
                session,
                params['id'],
              ),
        ),
        'resetPassword': _i1.MethodConnector(
          name: 'resetPassword',
          params: {
            'ids': _i1.ParameterDescription(
              name: 'ids',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i14.UserEndpoint).resetPassword(
                session,
                params['ids'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i24.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i25.Endpoints()
      ..initializeEndpoints(server);
  }
}
