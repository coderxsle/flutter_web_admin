import 'dart:convert';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/utils/request_scope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

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
      final user = await _resolveUser(session);
      final tenantId = resolveTenantId?.call(session) ?? user?.tenantId ?? readTenantId(auth);
      final authUserId = readString(() => auth?.userIdentifier);
      final request = RequestScope.current;
      traceId = traceId ?? '$tracePrefix-${now.microsecondsSinceEpoch}';
      final log = SysOperateLog(
        tenantId: tenantId,
        // sys_user.id；认证侧只有 authUserId，未登录/查不到时才落 0。
        userId: user?.id ?? 0,
        // 1 = 后台 sys_user，0 = 无法识别。
        userType: user == null ? 0 : 1,
        type: type,
        subType: subType,
        bizId: bizId,
        action: action,
        success: true,
        traceId: traceId,
        extra: encodeExtra(extra),
        requestMethod: request?.method ?? session.method,
        requestUrl: request?.path ?? requestPath(session),
        userIp: request?.remoteInfo ?? session.request?.remoteInfo ?? 'unknown',
        userAgent: request?.userAgent ?? session.request?.headers.userAgent,
        creator: user?.username ?? authUserId,
        createTime: createTime ?? now,
      );
      await SysOperateLog.db.insertRow(session, log);
    } catch (e) {
      session.log('$errorLogPrefix: $e');
    }
  }

  /// 认证信息里只有 authUserId（UUID），审计要的是 sys_user.id 和用户名。
  static Future<SysUser?> _resolveUser(Session session) async {
    final auth = session.authenticated;
    if (auth == null) return null;
    try {
      return await SysUser.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(auth.authUserId) & t.deleted.equals(false),
      );
    } catch (_) {
      return null;
    }
  }

  /// 只落接口路径（不含协议、主机、查询串），如 `/api/lxs_zhongyi/medicine/update/170`。
  static String? requestPath(Session session) {
    final path = session.request?.url.path;
    if (path != null && path.isNotEmpty) return path;
    // WebCallSession 没有 request，但把 endpoint 填成了 req.url.path。
    final endpoint = session.endpoint;
    return endpoint.startsWith('/') ? endpoint : null;
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
