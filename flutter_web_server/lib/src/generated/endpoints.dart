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
import '../endpoints/auth_endpoint.dart' as _i7;
import '../endpoints/book_endpoint.dart' as _i8;
import '../endpoints/menu_endpoint.dart' as _i9;
import 'package:flutter_web_server/src/generated/common/pagination.dart'
    as _i10;
import 'package:flutter_web_server/src/generated/book/book.dart' as _i11;
import 'package:flutter_web_server/src/generated/system/sys_menu.dart' as _i12;

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
      'menu': _i9.MenuEndpoint()
        ..initialize(
          server,
          'menu',
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
            )
          },
          call: (
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
          call: (
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
          call: (
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
            )
          },
          call: (
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
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tableItems'] as _i3.TableItemsEndpoint).upsertItem(
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
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tableItems'] as _i3.TableItemsEndpoint).deleteItem(
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
            )
          },
          call: (
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
              type: _i1.getType<_i10.Pagination>(),
              nullable: false,
            ),
            'fieldId': _i1.ParameterDescription(
              name: 'fieldId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
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
          call: (
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
            )
          },
          call: (
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
            'pagination': _i1.ParameterDescription(
              name: 'pagination',
              type: _i1.getType<_i10.Pagination>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tableRows'] as _i5.TableRowsEndpoint).getTableRows(
            session,
            params['tableId'],
            params['pagination'],
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
          call: (
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
          call: (
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
            )
          },
          call: (
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
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tableRows'] as _i5.TableRowsEndpoint).batchDeleteRows(
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
              type: _i1.getType<_i10.Pagination>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tables'] as _i6.TablesEndpoint).getTables(
            session,
            params['pagination'],
          ),
        ),
        'tableDetail': _i1.MethodConnector(
          name: 'tableDetail',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
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
            )
          },
          call: (
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
          call: (
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
            )
          },
          call: (
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
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i7.AuthEndpoint).login(
            session,
            params['username'],
            params['password'],
          ),
        ),
        'adminLogin': _i1.MethodConnector(
          name: 'adminLogin',
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
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i7.AuthEndpoint).adminLogin(
            session,
            params['username'],
            params['password'],
          ),
        ),
        'customerLogin': _i1.MethodConnector(
          name: 'customerLogin',
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
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i7.AuthEndpoint).customerLogin(
            session,
            params['username'],
            params['password'],
          ),
        ),
        'getUserInfo': _i1.MethodConnector(
          name: 'getUserInfo',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i7.AuthEndpoint).getUserInfo(session),
        ),
        'refreshToken': _i1.MethodConnector(
          name: 'refreshToken',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i7.AuthEndpoint).refreshToken(session),
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
              type: _i1.getType<_i11.Book>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['book'] as _i8.BookEndpoint).createBook(
            session,
            params['book'],
          ),
        ),
        'updateBook': _i1.MethodConnector(
          name: 'updateBook',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i11.Book>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['book'] as _i8.BookEndpoint).updateBook(
            session,
            params['book'],
          ),
        ),
        'deleteBook': _i1.MethodConnector(
          name: 'deleteBook',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i11.Book>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['book'] as _i8.BookEndpoint).deleteBook(
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
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['book'] as _i8.BookEndpoint).getBook(
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
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['book'] as _i8.BookEndpoint).list(
            session,
            pageNum: params['pageNum'],
            pageSize: params['pageSize'],
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
            'menu': _i1.ParameterDescription(
              name: 'menu',
              type: _i1.getType<_i12.SysMenu>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['menu'] as _i9.MenuEndpoint).add(
            session,
            params['menu'],
          ),
        ),
        'adminLogin': _i1.MethodConnector(
          name: 'adminLogin',
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
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['menu'] as _i9.MenuEndpoint).adminLogin(
            session,
            params['username'],
            params['password'],
          ),
        ),
        'customerLogin': _i1.MethodConnector(
          name: 'customerLogin',
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
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['menu'] as _i9.MenuEndpoint).customerLogin(
            session,
            params['username'],
            params['password'],
          ),
        ),
        'getUserInfo': _i1.MethodConnector(
          name: 'getUserInfo',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['menu'] as _i9.MenuEndpoint).getUserInfo(session),
        ),
        'refreshToken': _i1.MethodConnector(
          name: 'refreshToken',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['menu'] as _i9.MenuEndpoint).refreshToken(session),
        ),
      },
    );
  }
}
