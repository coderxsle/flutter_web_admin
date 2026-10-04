import 'dart:convert';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// sys_operate_log 落库写入器：供 CRUD 变更审计与查询审计复用。
class OperateLogWriter {
  const OperateLogWriter._();

  static Future<void> write(
    Session session, {
    required String type,
    required String subType,
    required String action,
    required int bizId,
    String? traceId,
    Map<String, dynamic>? extra,
    DateTime? createTime,
    int Function(Session session)? resolveTenantId,
    String tracePrefix = 'audit',
    String errorLogPrefix = 'operate-log-write-failed',
  }) async {
    try {
      final now = DateTime.now();
      final auth = session.authenticated;
      final tenantId = resolveTenantId?.call(session) ?? readTenantId(auth);
      final authUserId = readString(() => auth?.userIdentifier);
      traceId = traceId ?? '$tracePrefix-${now.microsecondsSinceEpoch}';
      final log = SysOperateLog(
        tenantId: tenantId,
        userId: 0,
        userType: 0,
        type: type,
        subType: subType,
        bizId: bizId,
        action: action,
        success: true,
        traceId: traceId,
        extra: encodeExtra(extra),
        requestMethod: session.method,
        requestUrl: session.request?.url.toString(),
        userIp: session.request?.remoteInfo ?? 'unknown',
        userAgent: session.request?.headers.userAgent,
        creator: authUserId,
        createTime: createTime ?? now,
      );
      await SysOperateLog.db.insertRow(session, log);
    } catch (e) {
      session.log('$errorLogPrefix: $e');
    }
  }

  static String encodeExtra(Map<String, dynamic>? payload) {
    if (payload == null) return '{}';
    try {
      return jsonEncode(payload);
    } catch (_) {
      return '{}';
    }
  }

  static dynamic serializeValue(dynamic value) {
    if (value == null) return null;
    if (value is String || value is num || value is bool || value is Map || value is List) return value;
    try {
      final dynamic model = value;
      final json = model.toJson();
      if (json is Map || json is List || json is String || json is num || json is bool) return json;
      return json.toString();
    } catch (_) {
      return value.toString();
    }
  }

  static int readTenantId(dynamic auth) {
    if (auth == null) return 0;
    dynamic scope;
    dynamic scopes;
    try {
      scope = (auth as dynamic).scope;
    } catch (_) {}
    try {
      scopes = (auth as dynamic).scopes;
    } catch (_) {}
    dynamic tenantId;
    if (scope is Map) tenantId = scope['tenantId'];
    if (tenantId == null && scopes is Map) tenantId = scopes['tenantId'];
    return toInt(tenantId) ?? 0;
  }

  static String? readString(dynamic Function() reader) {
    try {
      final value = reader();
      if (value == null) return null;
      return value.toString();
    } catch (_) {
      return null;
    }
  }

  static int? toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
