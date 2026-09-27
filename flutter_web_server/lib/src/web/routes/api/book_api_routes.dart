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

/// 图书资源的**业务动作**：键 = 相对子路径，值为用同一个相对路径
/// `path:` 构造的 [RestActionRoute]。
///
/// ⚠️ 这里是**相对路径**（`/isbn-check`），不再是完整路径 ——
/// 挂载点由 [BookRestRoute] 统一给（`/api/book`），
/// 所以完整路径仍是 `/api/book/isbn-check`。
Map<String, RestActionRoute> bookActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    '/isbn-check': RestActionRoute(
      methods: const {Method.get},
      path: '/isbn-check',
      envelope: envelope,
      handler: (session, request) async {
        final isbn = request.queryString('isbn');
        if (isbn == null || isbn.trim().isEmpty) {
          throw RestException.badRequest('参数不合法：isbn 不能为空');
        }
        return ensureOk(CommonResponse.success(isbn));
      },
    ),
  };
}

/// 图书资源 = 6 条 CRUD 子路由 + `/isbn-check` 动作子路由，
/// **一次挂载**产出全部（方案 D：动作并入资源挂载点）。
///
/// [delegate] 保持可空：传 `null` 时走 `BaseRestRoute` 的延迟自动装配，
/// 离线测试可以 `BookRestRoute()` 而不触碰 `Serverpod.instance`。
class BookRestRoute extends BaseRestRoute<Book> {
  BookRestRoute({BookRestDelegate? delegate})
    : super(delegate: delegate, actions: bookActionRoutes(), envelope: const ServerpodEnvelopeBuilder());
}

/// 把图书资源挂到 Web Server 上 —— 一个资源一次 `addRoute`。
void registerBookRoutes(Serverpod pod) =>
    pod.webServer.addRoute(BookRestRoute(delegate: BookRestDelegate()), '/api/book');
