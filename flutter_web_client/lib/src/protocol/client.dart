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
import 'package:flutter_web_admin_shared/src/models/common_response.dart' as _i3;
import 'package:flutter_web_admin_client/src/protocol/book/book.dart' as _i4;
import 'package:flutter_web_admin_shared/src/models/page_response.dart' as _i5;
import 'package:flutter_web_admin_client/src/protocol/system/sys_menu.dart' as _i6;
import 'protocol.dart' as _i7;

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
  _i2.Future<_i3.CommonResponse> createBook(_i4.Book book) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'book',
        'createBook',
        {'book': book},
      );

  /// 更新图书
  _i2.Future<_i3.CommonResponse> updateBook(_i4.Book book) =>
      caller.callServerEndpoint<_i3.CommonResponse>(
        'book',
        'updateBook',
        {'book': book},
      );

  /// 删除图书
  _i2.Future<_i3.CommonResponse> deleteBook(_i4.Book book) =>
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
  _i2.Future<_i5.PageResponse<dynamic>> list({
    required int pageNum,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<_i5.PageResponse<dynamic>>(
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
  _i2.Future<_i3.CommonResponse> add(_i6.SysMenu menu) =>
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
          _i7.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    auth = EndpointAuth(this);
    book = EndpointBook(this);
    menu = EndpointMenu(this);
  }

  late final EndpointAuth auth;

  late final EndpointBook book;

  late final EndpointMenu menu;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'book': book,
        'menu': menu,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
