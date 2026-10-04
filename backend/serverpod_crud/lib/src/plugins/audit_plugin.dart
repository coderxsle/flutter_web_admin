import 'package:serverpod/serverpod.dart';
import '../models/query/query_dto.dart';


/// 查询审计插件。
abstract class AuditPlugin implements SerializableModel {
  const AuditPlugin();

  Future<void> onQuery(Session session, QueryDTO query) async {}
}
