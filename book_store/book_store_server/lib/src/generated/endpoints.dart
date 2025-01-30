/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/auth_endpoint.dart' as _i2;
import '../endpoints/book_endpoint.dart' as _i3;
import 'package:book_store_server/src/generated/book/book.dart' as _i4;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'auth': _i2.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'book': _i3.BookEndpoint()
        ..initialize(
          server,
          'book',
          null,
        ),
    };
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
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
              (endpoints['auth'] as _i2.AuthEndpoint).adminLogin(
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
              (endpoints['auth'] as _i2.AuthEndpoint).customerLogin(
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
              (endpoints['auth'] as _i2.AuthEndpoint).getUserInfo(session),
        ),
        'refreshToken': _i1.MethodConnector(
          name: 'refreshToken',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).refreshToken(session),
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
              type: _i1.getType<_i4.Book>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['book'] as _i3.BookEndpoint).createBook(
            session,
            params['book'],
          ),
        ),
        'updateBook': _i1.MethodConnector(
          name: 'updateBook',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i4.Book>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['book'] as _i3.BookEndpoint).updateBook(
            session,
            params['book'],
          ),
        ),
        'deleteBook': _i1.MethodConnector(
          name: 'deleteBook',
          params: {
            'book': _i1.ParameterDescription(
              name: 'book',
              type: _i1.getType<_i4.Book>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['book'] as _i3.BookEndpoint).deleteBook(
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
              (endpoints['book'] as _i3.BookEndpoint).getBook(
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
              (endpoints['book'] as _i3.BookEndpoint).list(
            session,
            pageNum: params['pageNum'],
            pageSize: params['pageSize'],
          ),
        ),
      },
    );
  }
}
