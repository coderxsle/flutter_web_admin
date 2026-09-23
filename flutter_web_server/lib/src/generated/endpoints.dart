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
import 'package:flutter_web_server/src/generated/book/book.dart' as _irelqbv1;
import 'package:flutter_web_server/src/generated/system/sys_dict_data.dart'
    as _i8y85kzb;
import 'package:flutter_web_server/src/generated/system/sys_role.dart'
    as _in6wej68;
import 'package:flutter_web_shared/flutter_web_shared.dart' as _iq2hfrj8;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:serverpod_crud/serverpod_crud.dart' as _imp6a5q0;
import '../endpoints/airtable/fields_endpoint.dart' as _id4grqil;
import '../endpoints/airtable/items_endpoint.dart' as _i8zk7nyl;
import '../endpoints/airtable/relations_endpoint.dart' as _ijais7z5;
import '../endpoints/airtable/rows_endpoint.dart' as _iaxcvuqt;
import '../endpoints/airtable/tables_endpoint.dart' as _i213zkoc;
import '../endpoints/book_endpoint.dart' as _io0dh9pt;
import '../endpoints/system/auth_endpoint.dart' as _ifcpuwz3;
import '../endpoints/system/dept_endpoint.dart' as _iuu9tclq;
import '../endpoints/system/dict_endpoint.dart' as _iqxxwdhr;
import '../endpoints/system/menu_endpoint.dart' as _ibe8eaa4;
import '../endpoints/system/product_endpoint.dart' as _iqxfckx1;
import '../endpoints/system/role_endpoint.dart' as _iw30uxon;
import '../endpoints/system/system_endpoint.dart' as _it9dyuuf;
import '../endpoints/system/user_endpoint.dart' as _i50igo0u;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'airTableFields': _id4grqil.AirTableFieldsEndpoint()
        ..initialize(server, 'airTableFields', null),
      'tableItems': _i8zk7nyl.TableItemsEndpoint()
        ..initialize(server, 'tableItems', null),
      'tableItemRelations': _ijais7z5.TableItemRelationsEndpoint()
        ..initialize(server, 'tableItemRelations', null),
      'tableRows': _iaxcvuqt.TableRowsEndpoint()
        ..initialize(server, 'tableRows', null),
      'tables': _i213zkoc.TablesEndpoint()..initialize(server, 'tables', null),
      'book': _io0dh9pt.BookEndpoint()..initialize(server, 'book', null),
      'auth': _ifcpuwz3.AuthEndpoint()..initialize(server, 'auth', null),
      'dept': _iuu9tclq.DeptEndpoint()..initialize(server, 'dept', null),
      'dict': _iqxxwdhr.DictEndpoint()..initialize(server, 'dict', null),
      'menu': _ibe8eaa4.MenuEndpoint()..initialize(server, 'menu', null),
      'product': _iqxfckx1.ProductEndpoint()
        ..initialize(server, 'product', null),
      'role': _iw30uxon.RoleEndpoint()..initialize(server, 'role', null),
      'system': _it9dyuuf.SystemEndpoint()..initialize(server, 'system', null),
      'user': _i50igo0u.UserEndpoint()..initialize(server, 'user', null),
    };
    connectors['airTableFields'] = _is.EndpointConnector(
      name: 'airTableFields',
      endpoint: endpoints['airTableFields']!,
      methodConnectors: {
        'getAirTableFields': _is.MethodConnector(
          name: 'getAirTableFields',
          params: {
            'tableId': _is.ParameterDescription(
              name: 'tableId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['airTableFields'] as _id4grqil.AirTableFieldsEndpoint)
                  .getAirTableFields(session, params['tableId']),
        ),
        'createField': _is.MethodConnector(
          name: 'createField',
          params: {
            'tableId': _is.ParameterDescription(
              name: 'tableId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'fieldName': _is.ParameterDescription(
              name: 'fieldName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['airTableFields'] as _id4grqil.AirTableFieldsEndpoint)
                  .createField(session, params['tableId'], params['fieldName']),
        ),
        'updateField': _is.MethodConnector(
          name: 'updateField',
          params: {
            'fieldName': _is.ParameterDescription(
              name: 'fieldName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newName': _is.ParameterDescription(
              name: 'newName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['airTableFields'] as _id4grqil.AirTableFieldsEndpoint)
                  .updateField(session, params['fieldName'], params['newName']),
        ),
        'deleteField': _is.MethodConnector(
          name: 'deleteField',
          params: {
            'fieldName': _is.ParameterDescription(
              name: 'fieldName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['airTableFields'] as _id4grqil.AirTableFieldsEndpoint)
                  .deleteField(session, params['fieldName']),
        ),
      },
    );
    connectors['tableItems'] = _is.EndpointConnector(
      name: 'tableItems',
      endpoint: endpoints['tableItems']!,
      methodConnectors: {
        'upsertItem': _is.MethodConnector(
          name: 'upsertItem',
          params: {
            'fieldId': _is.ParameterDescription(
              name: 'fieldId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'value': _is.ParameterDescription(
              name: 'value',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'rowId': _is.ParameterDescription(
              name: 'rowId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tableItems'] as _i8zk7nyl.TableItemsEndpoint)
                  .upsertItem(
                    session,
                    params['fieldId'],
                    params['value'],
                    params['rowId'],
                  ),
        ),
        'deleteItem': _is.MethodConnector(
          name: 'deleteItem',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tableItems'] as _i8zk7nyl.TableItemsEndpoint)
                  .deleteItem(session, params['id']),
        ),
      },
    );
    connectors['tableItemRelations'] = _is.EndpointConnector(
      name: 'tableItemRelations',
      endpoint: endpoints['tableItemRelations']!,
      methodConnectors: {
        'getItemRelations': _is.MethodConnector(
          name: 'getItemRelations',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tableItemRelations']
                      as _ijais7z5.TableItemRelationsEndpoint)
                  .getItemRelations(session, params['id']),
        ),
        'searchTableItems': _is.MethodConnector(
          name: 'searchTableItems',
          params: {
            'tableId': _is.ParameterDescription(
              name: 'tableId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pagination': _is.ParameterDescription(
              name: 'pagination',
              type: _is.getType<_iq2hfrj8.Pagination>(),
              nullable: false,
            ),
            'fieldId': _is.ParameterDescription(
              name: 'fieldId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tableItemRelations']
                      as _ijais7z5.TableItemRelationsEndpoint)
                  .searchTableItems(
                    session,
                    params['tableId'],
                    params['pagination'],
                    fieldId: params['fieldId'],
                  ),
        ),
        'getAvailableTables': _is.MethodConnector(
          name: 'getAvailableTables',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tableItemRelations']
                      as _ijais7z5.TableItemRelationsEndpoint)
                  .getAvailableTables(session),
        ),
        'getTableFieldsForRelation': _is.MethodConnector(
          name: 'getTableFieldsForRelation',
          params: {
            'tableId': _is.ParameterDescription(
              name: 'tableId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tableItemRelations']
                      as _ijais7z5.TableItemRelationsEndpoint)
                  .getTableFieldsForRelation(session, params['tableId']),
        ),
      },
    );
    connectors['tableRows'] = _is.EndpointConnector(
      name: 'tableRows',
      endpoint: endpoints['tableRows']!,
      methodConnectors: {
        'getTableRows': _is.MethodConnector(
          name: 'getTableRows',
          params: {
            'tableId': _is.ParameterDescription(
              name: 'tableId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'keyword': _is.ParameterDescription(
              name: 'keyword',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tableRows'] as _iaxcvuqt.TableRowsEndpoint)
                  .getTableRows(
                    session,
                    params['tableId'],
                    page: params['page'],
                    pageSize: params['pageSize'],
                    keyword: params['keyword'],
                  ),
        ),
        'createRow': _is.MethodConnector(
          name: 'createRow',
          params: {
            'tableId': _is.ParameterDescription(
              name: 'tableId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'index': _is.ParameterDescription(
              name: 'index',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tableRows'] as _iaxcvuqt.TableRowsEndpoint).createRow(
                session,
                params['tableId'],
                index: params['index'],
              ),
        ),
        'updateRow': _is.MethodConnector(
          name: 'updateRow',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'index': _is.ParameterDescription(
              name: 'index',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tableRows'] as _iaxcvuqt.TableRowsEndpoint).updateRow(
                session,
                params['id'],
                params['index'],
              ),
        ),
        'deleteRow': _is.MethodConnector(
          name: 'deleteRow',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tableRows'] as _iaxcvuqt.TableRowsEndpoint).deleteRow(
                session,
                params['id'],
              ),
        ),
        'batchDeleteRows': _is.MethodConnector(
          name: 'batchDeleteRows',
          params: {
            'ids': _is.ParameterDescription(
              name: 'ids',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tableRows'] as _iaxcvuqt.TableRowsEndpoint)
                  .batchDeleteRows(session, params['ids']),
        ),
      },
    );
    connectors['tables'] = _is.EndpointConnector(
      name: 'tables',
      endpoint: endpoints['tables']!,
      methodConnectors: {
        'getTables': _is.MethodConnector(
          name: 'getTables',
          params: {
            'pagination': _is.ParameterDescription(
              name: 'pagination',
              type: _is.getType<_iq2hfrj8.Pagination>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tables'] as _i213zkoc.TablesEndpoint).getTables(
                session,
                params['pagination'],
              ),
        ),
        'getTables2': _is.MethodConnector(
          name: 'getTables2',
          params: {
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'keyword': _is.ParameterDescription(
              name: 'keyword',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tables'] as _i213zkoc.TablesEndpoint).getTables2(
                session,
                page: params['page'],
                pageSize: params['pageSize'],
                keyword: params['keyword'],
              ),
        ),
        'tableDetail': _is.MethodConnector(
          name: 'tableDetail',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tables'] as _i213zkoc.TablesEndpoint).tableDetail(
                session,
                params['id'],
              ),
        ),
        'createTable': _is.MethodConnector(
          name: 'createTable',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tables'] as _i213zkoc.TablesEndpoint).createTable(
                session,
                params['name'],
              ),
        ),
        'updateTable': _is.MethodConnector(
          name: 'updateTable',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tables'] as _i213zkoc.TablesEndpoint).updateTable(
                session,
                params['id'],
                params['name'],
              ),
        ),
        'deleteTable': _is.MethodConnector(
          name: 'deleteTable',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['tables'] as _i213zkoc.TablesEndpoint).deleteTable(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['book'] = _is.EndpointConnector(
      name: 'book',
      endpoint: endpoints['book']!,
      methodConnectors: {
        'createBook': _is.MethodConnector(
          name: 'createBook',
          params: {
            'book': _is.ParameterDescription(
              name: 'book',
              type: _is.getType<_irelqbv1.Book>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['book'] as _io0dh9pt.BookEndpoint).createBook(
                session,
                params['book'],
              ),
        ),
        'updateBook': _is.MethodConnector(
          name: 'updateBook',
          params: {
            'book': _is.ParameterDescription(
              name: 'book',
              type: _is.getType<_irelqbv1.Book>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['book'] as _io0dh9pt.BookEndpoint).updateBook(
                session,
                params['book'],
              ),
        ),
        'deleteBook': _is.MethodConnector(
          name: 'deleteBook',
          params: {
            'book': _is.ParameterDescription(
              name: 'book',
              type: _is.getType<_irelqbv1.Book>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['book'] as _io0dh9pt.BookEndpoint).deleteBook(
                session,
                params['book'],
              ),
        ),
        'getBook': _is.MethodConnector(
          name: 'getBook',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['book'] as _io0dh9pt.BookEndpoint).getBook(
                session,
                params['id'],
              ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['book'] as _io0dh9pt.BookEndpoint).list(
                session,
                page: params['page'],
                pageSize: params['pageSize'],
              ),
        ),
      },
    );
    connectors['auth'] = _is.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'username': _is.ParameterDescription(
              name: 'username',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['auth'] as _ifcpuwz3.AuthEndpoint).login(
                session,
                params['username'],
                params['password'],
              ),
        ),
        'publicKey': _is.MethodConnector(
          name: 'publicKey',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['auth'] as _ifcpuwz3.AuthEndpoint).publicKey(session),
        ),
        'refreshToken': _is.MethodConnector(
          name: 'refreshToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['auth'] as _ifcpuwz3.AuthEndpoint).refreshToken(
                session,
                params['refreshToken'],
              ),
        ),
      },
    );
    connectors['dept'] = _is.EndpointConnector(
      name: 'dept',
      endpoint: endpoints['dept']!,
      methodConnectors: {
        'getList': _is.MethodConnector(
          name: 'getList',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dept'] as _iuu9tclq.DeptEndpoint).getList(
                session,
                status: params['status'],
                name: params['name'],
              ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'req': _is.ParameterDescription(
              name: 'req',
              type: _is.getType<_iq2hfrj8.DeptRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dept'] as _iuu9tclq.DeptEndpoint).add(
                session,
                params['req'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'req': _is.ParameterDescription(
              name: 'req',
              type: _is.getType<_iq2hfrj8.DeptRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dept'] as _iuu9tclq.DeptEndpoint).update(
                session,
                params['req'],
              ),
        ),
        'getDetail': _is.MethodConnector(
          name: 'getDetail',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dept'] as _iuu9tclq.DeptEndpoint).getDetail(
                session,
                params['id'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'ids': _is.ParameterDescription(
              name: 'ids',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dept'] as _iuu9tclq.DeptEndpoint).delete(
                session,
                params['ids'],
              ),
        ),
      },
    );
    connectors['dict'] = _is.EndpointConnector(
      name: 'dict',
      endpoint: endpoints['dict']!,
      methodConnectors: {
        'getDictData': _is.MethodConnector(
          name: 'getDictData',
          params: {
            'tenantId': _is.ParameterDescription(
              name: 'tenantId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dict'] as _iqxxwdhr.DictEndpoint).getDictData(
                session,
                tenantId: params['tenantId'],
              ),
        ),
        'getDictCodeList': _is.MethodConnector(
          name: 'getDictCodeList',
          params: {
            'tenantId': _is.ParameterDescription(
              name: 'tenantId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dict'] as _iqxxwdhr.DictEndpoint).getDictCodeList(
                session,
                tenantId: params['tenantId'],
                name: params['name'],
                code: params['code'],
                status: params['status'],
              ),
        ),
        'getDictCodeDetail': _is.MethodConnector(
          name: 'getDictCodeDetail',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dict'] as _iqxxwdhr.DictEndpoint).getDictCodeDetail(
                session,
                params['id'],
              ),
        ),
        'addDictCode': _is.MethodConnector(
          name: 'addDictCode',
          params: {
            'req': _is.ParameterDescription(
              name: 'req',
              type: _is.getType<_iq2hfrj8.DictCodeRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dict'] as _iqxxwdhr.DictEndpoint).addDictCode(
                session,
                params['req'],
              ),
        ),
        'updateDictCode': _is.MethodConnector(
          name: 'updateDictCode',
          params: {
            'req': _is.ParameterDescription(
              name: 'req',
              type: _is.getType<_iq2hfrj8.DictCodeRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dict'] as _iqxxwdhr.DictEndpoint).updateDictCode(
                session,
                params['req'],
              ),
        ),
        'deleteDictCode': _is.MethodConnector(
          name: 'deleteDictCode',
          params: {
            'ids': _is.ParameterDescription(
              name: 'ids',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dict'] as _iqxxwdhr.DictEndpoint).deleteDictCode(
                session,
                params['ids'],
              ),
        ),
        'getDictDataList': _is.MethodConnector(
          name: 'getDictDataList',
          params: {
            'tenantId': _is.ParameterDescription(
              name: 'tenantId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'value': _is.ParameterDescription(
              name: 'value',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dict'] as _iqxxwdhr.DictEndpoint).getDictDataList(
                session,
                tenantId: params['tenantId'],
                code: params['code'],
                name: params['name'],
                value: params['value'],
                status: params['status'],
              ),
        ),
        'addDictData': _is.MethodConnector(
          name: 'addDictData',
          params: {
            'req': _is.ParameterDescription(
              name: 'req',
              type: _is.getType<_iq2hfrj8.DictDataRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dict'] as _iqxxwdhr.DictEndpoint).addDictData(
                session,
                params['req'],
              ),
        ),
        'updateDictData': _is.MethodConnector(
          name: 'updateDictData',
          params: {
            'req': _is.ParameterDescription(
              name: 'req',
              type: _is.getType<_i8y85kzb.SysDictData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dict'] as _iqxxwdhr.DictEndpoint).updateDictData(
                session,
                params['req'],
              ),
        ),
        'deleteDictData': _is.MethodConnector(
          name: 'deleteDictData',
          params: {
            'ids': _is.ParameterDescription(
              name: 'ids',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dict'] as _iqxxwdhr.DictEndpoint).deleteDictData(
                session,
                params['ids'],
              ),
        ),
        'getDictDataDetail': _is.MethodConnector(
          name: 'getDictDataDetail',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dict'] as _iqxxwdhr.DictEndpoint).getDictDataDetail(
                session,
                params['id'],
                params['code'],
              ),
        ),
      },
    );
    connectors['menu'] = _is.EndpointConnector(
      name: 'menu',
      endpoint: endpoints['menu']!,
      methodConnectors: {
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'req': _is.ParameterDescription(
              name: 'req',
              type: _is.getType<_iq2hfrj8.MenuRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['menu'] as _ibe8eaa4.MenuEndpoint).add(
                session,
                params['req'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'ids': _is.ParameterDescription(
              name: 'ids',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['menu'] as _ibe8eaa4.MenuEndpoint).delete(
                session,
                params['ids'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'req': _is.ParameterDescription(
              name: 'req',
              type: _is.getType<_iq2hfrj8.MenuRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['menu'] as _ibe8eaa4.MenuEndpoint).update(
                session,
                params['req'],
              ),
        ),
        'getMenuOptions': _is.MethodConnector(
          name: 'getMenuOptions',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['menu'] as _ibe8eaa4.MenuEndpoint).getMenuOptions(
                session,
              ),
        ),
        'getList': _is.MethodConnector(
          name: 'getList',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['menu'] as _ibe8eaa4.MenuEndpoint).getList(
                session,
                params['name'],
                params['status'],
              ),
        ),
        'getDetail': _is.MethodConnector(
          name: 'getDetail',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['menu'] as _ibe8eaa4.MenuEndpoint).getDetail(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['product'] = _is.EndpointConnector(
      name: 'product',
      endpoint: endpoints['product']!,
      methodConnectors: {
        'getDetail': _is.MethodConnector(
          name: 'getDetail',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['product'] as _iqxfckx1.ProductEndpoint).getDetail(
                session,
                params['id'],
              ),
        ),
        'getPriceList': _is.MethodConnector(
          name: 'getPriceList',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['product'] as _iqxfckx1.ProductEndpoint).getPriceList(
                session,
              ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'data': _is.ParameterDescription(
              name: 'data',
              type: _is.getType<dynamic>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['product'] as _iqxfckx1.ProductEndpoint).add(
                session,
                params['data'],
              ),
        ),
        'getList': _is.MethodConnector(
          name: 'getList',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<_imp6a5q0.QueryRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['product'] as _iqxfckx1.ProductEndpoint).getList(
                session,
                params['query'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'data': _is.ParameterDescription(
              name: 'data',
              type: _is.getType<dynamic>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['product'] as _iqxfckx1.ProductEndpoint).update(
                session,
                params['data'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['product'] as _iqxfckx1.ProductEndpoint).delete(
                session,
                params['id'],
              ),
        ),
        'deleteBatch': _is.MethodConnector(
          name: 'deleteBatch',
          params: {
            'ids': _is.ParameterDescription(
              name: 'ids',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['product'] as _iqxfckx1.ProductEndpoint).deleteBatch(
                session,
                params['ids'],
              ),
        ),
      },
    );
    connectors['role'] = _is.EndpointConnector(
      name: 'role',
      endpoint: endpoints['role']!,
      methodConnectors: {
        'getList': _is.MethodConnector(
          name: 'getList',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['role'] as _iw30uxon.RoleEndpoint).getList(session),
        ),
        'getRoleMenuIds': _is.MethodConnector(
          name: 'getRoleMenuIds',
          params: {
            'roleId': _is.ParameterDescription(
              name: 'roleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['role'] as _iw30uxon.RoleEndpoint).getRoleMenuIds(
                session,
                params['roleId'],
              ),
        ),
        'saveRolePermissions': _is.MethodConnector(
          name: 'saveRolePermissions',
          params: {
            'roleId': _is.ParameterDescription(
              name: 'roleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'menuIds': _is.ParameterDescription(
              name: 'menuIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['role'] as _iw30uxon.RoleEndpoint).saveRolePermissions(
                session,
                params['roleId'],
                params['menuIds'],
              ),
        ),
        'getRoleUsers': _is.MethodConnector(
          name: 'getRoleUsers',
          params: {
            'roleId': _is.ParameterDescription(
              name: 'roleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'nickname': _is.ParameterDescription(
              name: 'nickname',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['role'] as _iw30uxon.RoleEndpoint).getRoleUsers(
                session,
                params['roleId'],
                page: params['page'],
                pageSize: params['pageSize'],
                nickname: params['nickname'],
              ),
        ),
        'getDetail': _is.MethodConnector(
          name: 'getDetail',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['role'] as _iw30uxon.RoleEndpoint).getDetail(
                session,
                params['id'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'req': _is.ParameterDescription(
              name: 'req',
              type: _is.getType<_in6wej68.SysRole>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['role'] as _iw30uxon.RoleEndpoint).update(
                session,
                params['req'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'ids': _is.ParameterDescription(
              name: 'ids',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['role'] as _iw30uxon.RoleEndpoint).delete(
                session,
                params['ids'],
              ),
        ),
        'cancelUserRoles': _is.MethodConnector(
          name: 'cancelUserRoles',
          params: {
            'roleId': _is.ParameterDescription(
              name: 'roleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'userIds': _is.ParameterDescription(
              name: 'userIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['role'] as _iw30uxon.RoleEndpoint).cancelUserRoles(
                session,
                params['roleId'],
                params['userIds'],
              ),
        ),
      },
    );
    connectors['system'] = _is.EndpointConnector(
      name: 'system',
      endpoint: endpoints['system']!,
      methodConnectors: {
        'health': _is.MethodConnector(
          name: 'health',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['system'] as _it9dyuuf.SystemEndpoint).health(session),
        ),
        'version': _is.MethodConnector(
          name: 'version',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['system'] as _it9dyuuf.SystemEndpoint).version(
                session,
              ),
        ),
      },
    );
    connectors['user'] = _is.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'userAdd': _is.MethodConnector(
          name: 'userAdd',
          params: {
            'req': _is.ParameterDescription(
              name: 'req',
              type: _is.getType<_iq2hfrj8.UserRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i50igo0u.UserEndpoint).userAdd(
                session,
                params['req'],
              ),
        ),
        'getUserList': _is.MethodConnector(
          name: 'getUserList',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<_iq2hfrj8.UserListRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i50igo0u.UserEndpoint).getUserList(
                session,
                params['query'],
              ),
        ),
        'getUserInfo': _is.MethodConnector(
          name: 'getUserInfo',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i50igo0u.UserEndpoint).getUserInfo(
                session,
              ),
        ),
        'getUserRoutes': _is.MethodConnector(
          name: 'getUserRoutes',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i50igo0u.UserEndpoint).getUserRoutes(
                session,
              ),
        ),
        'getDetail': _is.MethodConnector(
          name: 'getDetail',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i50igo0u.UserEndpoint).getDetail(
                session,
                params['id'],
              ),
        ),
        'resetPassword': _is.MethodConnector(
          name: 'resetPassword',
          params: {
            'ids': _is.ParameterDescription(
              name: 'ids',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i50igo0u.UserEndpoint).resetPassword(
                session,
                params['ids'],
              ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'data': _is.ParameterDescription(
              name: 'data',
              type: _is.getType<dynamic>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i50igo0u.UserEndpoint).add(
                session,
                params['data'],
              ),
        ),
        'getList': _is.MethodConnector(
          name: 'getList',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<_imp6a5q0.QueryRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i50igo0u.UserEndpoint).getList(
                session,
                params['query'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'data': _is.ParameterDescription(
              name: 'data',
              type: _is.getType<dynamic>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i50igo0u.UserEndpoint).update(
                session,
                params['data'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i50igo0u.UserEndpoint).delete(
                session,
                params['id'],
              ),
        ),
        'deleteBatch': _is.MethodConnector(
          name: 'deleteBatch',
          params: {
            'ids': _is.ParameterDescription(
              name: 'ids',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i50igo0u.UserEndpoint).deleteBatch(
                session,
                params['ids'],
              ),
        ),
      },
    );
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
  }
}
