library;

import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/services/system/db_audit_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

class BookRestDelegate extends AutoCrudDelegate<Book> {
  BookRestDelegate()
    : super(
        defaultPageSize: 10,
        auditService: const DbAuditService<Book>(type: 'book'),
        keywordFields: const ['name', 'isbn', 'author', 'publisher'],
      );
}

/// 图书资源的**业务动作**路由（B 档）。
Map<String, RestActionRoute> bookActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    '/api/book/isbn-check': RestActionRoute(methods: const {Method.get}, envelope: envelope, handler: (session, request) async {
        final isbn = request.queryString('isbn');
        if (isbn == null || isbn.trim().isEmpty) {
          throw RestException.badRequest('参数不合法：isbn 不能为空');
        }
        return ensureOk(CommonResponse.success(isbn));
      },
    ),
  };
}

/// 把 [bookActionRoutes] 挂到 Web Server 上。
void registerBookActionRoutes(Serverpod pod) =>
    bookActionRoutes().forEach((path, route) => pod.webServer.addRoute(route, path));