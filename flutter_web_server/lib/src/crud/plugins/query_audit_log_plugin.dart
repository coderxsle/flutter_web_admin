import 'package:flutter_web_server/src/utils/operate_utils.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 查询审计插件：将 query 请求关键参数持久化到 sys_operate_log。
class QueryAuditLogPlugin extends AuditPlugin implements SerializableModel {
  const QueryAuditLogPlugin({this.type = 'query', this.subType = 'list'});

  final String type;
  final String subType;

  @override
  Future<void> onQuery(Session session, QueryDTO query) async {
    final payload = {
      'page': query.page,
      'pageSize': query.pageSize,
      'keyword': query.keyword,
      'filters': query.filters?.map((e) => e.toJson()).toList(),
      'sort': query.sort?.map((e) => e.toJson()).toList(),
    };

    await OperateLogWriter.write(
      session,
      type: type,
      subType: subType,
      action: 'query',
      bizId: 0,
      extra: payload,
      tracePrefix: 'query',
      errorLogPrefix: 'query-audit-record-failed',
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'subType': subType,
    };
  }

}
