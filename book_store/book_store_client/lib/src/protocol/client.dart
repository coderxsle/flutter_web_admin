/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:book_store_client/src/protocol/book.dart' as _i3;
import 'protocol.dart' as _i4;

/// {@category Endpoint}
class EndpointBook extends _i1.EndpointRef {
  EndpointBook(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'book';

  /// 创建图书
  _i2.Future<_i3.Book> createBook(_i3.Book book) =>
      caller.callServerEndpoint<_i3.Book>(
        'book',
        'createBook',
        {'book': book},
      );

  /// 更新图书
  _i2.Future<_i3.Book> updateBook(_i3.Book book) =>
      caller.callServerEndpoint<_i3.Book>(
        'book',
        'updateBook',
        {'book': book},
      );

  /// 删除图书
  _i2.Future<_i3.Book?> deleteBook(_i3.Book book) =>
      caller.callServerEndpoint<_i3.Book?>(
        'book',
        'deleteBook',
        {'book': book},
      );

  /// 获取图书
  _i2.Future<_i3.Book?> getBook(int id) => caller.callServerEndpoint<_i3.Book?>(
        'book',
        'getBook',
        {'id': id},
      );

  /// 获取所有图书
  _i2.Future<List<_i3.Book>> getBooks() =>
      caller.callServerEndpoint<List<_i3.Book>>(
        'book',
        'getBooks',
        {},
      );
}

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
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
          _i4.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    book = EndpointBook(this);
    example = EndpointExample(this);
  }

  late final EndpointBook book;

  late final EndpointExample example;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'book': book,
        'example': example,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
