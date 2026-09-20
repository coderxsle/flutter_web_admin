import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/system/db_audit_service.dart';
import 'package:flutter_web_server/src/services/system/product_service.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'base_endpoint.dart';

/// 图书模块的标准 CRUD Endpoint。
///
/// 通用增删改查由 [BaseEndpoint] 自动装配；特殊查询直接添加到此类。
class ProductEndpoint extends BaseEndpoint<Book, BookTable> {
  ProductEndpoint() : super(auditService: const DbAuditService<Book>(type: 'product'));


  /// 获取产品详情
  /// 重写父类
  @override
  Future<CommonResponse> getDetail(Session session, int id) async {
    return ProductService.getDetail(session, id);
  }

  /// 查询价格历史
  Future<CommonResponse> getPriceList(Session session) async {
    return ProductService.getPriceList(session);
  }
}
