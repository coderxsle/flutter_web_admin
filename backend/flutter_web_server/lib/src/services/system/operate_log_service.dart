import 'package:flutter_web_server/src/common/common.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// sys_operate_log 只读查询：日志由 OperateLogWriter 单向下写，这里不提供增删改。
///
/// 不按租户过滤：写入侧 tenantId 恒为 0（OperateLogWriter.readTenantId 在 Serverpod 4 取不到 scope）。
class OperateLogService {
  /// 分页查询操作日志。
  static Future<CommonResponse> getList(
    Session session, {
    int? page,
    int? pageSize,
    String? type,
    String? success,
    String? keyword,
    String? startTime,
    String? endTime,
  }) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();

    final currentPage = page == null || page < 1 ? 1 : page;
    final size = pageSize == null || pageSize < 1 ? 20 : (pageSize > CrudConfig.maxPageSize ? CrudConfig.maxPageSize : pageSize);
    final where = _where(_buildFilter(type, success, keyword, startTime, endTime));

    try {
      final total = await SysOperateLog.db.count(session, where: where);
      final rows = await SysOperateLog.db.find(
        session,
        where: where,
        orderBy: (t) => t.id.desc(),
        limit: size,
        offset: (currentPage - 1) * size,
      );
      return PageResponse<Map<String, dynamic>>.success(
        rows.map(_toJson).toList(growable: false),
        page: currentPage,
        pageSize: size,
        total: total,
      );
    } catch (e) {
      return CommonResponse.failed('查询操作日志失败：$e');
    }
  }

  /// 操作日志详情（含 extra 原始内容）。
  static Future<CommonResponse> getDetail(Session session, int id) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    if (id <= 0) return CommonResponse.failed('参数不合法：id 必须大于 0');

    try {
      final row = await SysOperateLog.db.findFirstRow(session, where: (t) => t.id.equals(id));
      if (row == null) return CommonResponse.failed('操作日志不存在');
      return CommonResponse.success(_toJson(row));
    } catch (e) {
      return CommonResponse.failed('查询操作日志详情失败：$e');
    }
  }

  /// 条件为空返回 null，调用方据此跳过 where。
  static Expression? _buildFilter(String? type, String? success, String? keyword, String? startTime, String? endTime) {
    final t = SysOperateLog.t;
    final typeFilter = type?.trim();
    final resultFilter = success?.trim();
    final like = keyword?.trim();
    final start = _parseTime(startTime);
    final end = _parseTime(endTime);

    final conditions = <Expression>[
      if (typeFilter != null && typeFilter.isNotEmpty) t.type.like('%$typeFilter%'),
      if (resultFilter == 'true' || resultFilter == 'false') t.success.equals(resultFilter == 'true'),
      if (start != null) t.createTime >= start,
      if (end != null) t.createTime <= end,
      if (like != null && like.isNotEmpty)
        t.subType.like('%$like%') |
            t.action.like('%$like%') |
            t.creator.like('%$like%') |
            t.userIp.like('%$like%') |
            t.traceId.like('%$like%'),
    ];
    if (conditions.isEmpty) return null;
    return conditions.reduce((a, b) => a & b);
  }

  static WhereExpressionBuilder<SysOperateLogTable>? _where(Expression? filter) {
    if (filter == null) return null;
    final resolved = filter;
    return (_) => resolved;
  }

  static DateTime? _parseTime(String? raw) {
    final text = raw?.trim();
    if (text == null || text.isEmpty) return null;
    return DateTime.tryParse(text);
  }

  static Map<String, dynamic> _toJson(SysOperateLog row) => {
    'id': row.id,
    'tenantId': row.tenantId,
    'traceId': row.traceId,
    'userId': row.userId,
    'userType': row.userType,
    'type': row.type,
    'subType': row.subType,
    'bizId': row.bizId,
    'action': row.action,
    'success': row.success,
    'extra': row.extra,
    'requestMethod': row.requestMethod,
    'requestUrl': row.requestUrl,
    'userIp': row.userIp,
    'userAgent': row.userAgent,
    'creator': row.creator,
    'createTime': DateTimeFormatter.format(row.createTime),
  };
}
