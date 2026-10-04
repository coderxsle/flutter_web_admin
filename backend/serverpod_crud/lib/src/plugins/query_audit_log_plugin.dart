import 'package:serverpod/serverpod.dart';

import '../models/query/query_dto.dart';
import 'audit_plugin.dart';

/// Generic query audit hook.
///
/// The framework deliberately does not choose a persistence mechanism. Supply
/// [writer] from an application when query audit records should be persisted.
class QueryAuditLogPlugin extends AuditPlugin {
  const QueryAuditLogPlugin({this.writer});

  final Future<void> Function(Session session, QueryDTO query)? writer;

  @override
  Future<void> onQuery(Session session, QueryDTO query) async {
    await writer?.call(session, query);
  }

  @override
  Map<String, dynamic> toJson() => {'enabled': writer != null};
}
