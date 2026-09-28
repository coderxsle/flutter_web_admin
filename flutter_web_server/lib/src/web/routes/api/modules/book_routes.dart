library;

import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/services/system/db_audit_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

class BookRoute extends BaseRoute<Book> {
  BookRoute()
    : super(
        options: CrudOptions<Book>(
          auditService: const DbAuditService<Book>(type: auditType),
          keywordFields: keywordFields,
        ),
        envelope: const ServerpodEnvelopeBuilder(),
        actionList: [get('/isbn-check', _isbnCheck), get('/updatePrice', _updatePrice)],
      );

  static const String auditType = 'book';
  static const List<String> keywordFields = ['name', 'isbn', 'author', 'publisher'];

  /// 图书资源的业务动作：键 = 相对子路径，值为同一路径构造的 [ActionRoute]。
  ///
  /// ⚠️ 这里必须是**相对路径**（`/isbn-check`），挂载点统一由 [BookRoute]
  /// 提供，所以完整路径仍然是 `/api/book/isbn-check`。
  static Future<Object?> _isbnCheck(Session session, Request request) async {
    final isbn = request.queryString('isbn');
    if (isbn == null || isbn.trim().isEmpty) {
      throw RestException.badRequest('参数不合法：isbn 不能为空');
    }
    return ensureOk(CommonResponse.success(isbn));
  }

  static Future<Object?> _updatePrice(Session session, Request request) async {
    final isbn = request.queryString('isbn');
    if (isbn == null || isbn.trim().isEmpty) {
      throw RestException.badRequest('参数不合法：isbn 不能为空');
    }
    return ensureOk(CommonResponse.success(isbn));
  }
}
