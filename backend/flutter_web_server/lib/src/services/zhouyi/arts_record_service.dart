import 'dart:convert';

import 'package:flutter_web_server/src/common/page_response.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 术数排盘记录业务服务。
///
/// 奇门、八字共用一张 `arts_record`：起盘参数与盘面快照以 JSON 文本落库，
/// 新增术数类型只加 [artsType] 取值，不动表结构。
///
/// 写入按 `(tenantId, userId, clientKey)` 幂等：客户端在排盘时先落一条，
/// 之后补卦解/反馈再上报同一条，不会产生重复行。
class ArtsRecordService {
  ArtsRecordService._();

  /// 支持的术数类型，库里存汉字
  static const Set<String> artsTypes = {'奇门', '八字'};

  /// 列表接口的默认与最大页大小
  static const int _defaultPageSize = 20;
  static const int _maxPageSize = 200;

  /// 新增或按 clientKey 覆盖同一条记录
  static Future<Map<String, dynamic>> save(Session session, Map<String, dynamic> body) => _guard(() async {
    final actor = await _actor(session);
    final artsType = _requiredText(body, 'arts_type');
    if (!artsTypes.contains(artsType)) {
      throw RestException.badRequest('arts_type 仅支持 ${artsTypes.join(' / ')}');
    }
    final clientKey = _requiredText(body, 'client_key');
    final now = DateTime.now();

    return session.db.transaction((transaction) async {
      final existing = await ArtsRecord.db.findFirstRow(
        session,
        where: (table) =>
            table.tenantId.equals(actor.tenantId) & table.userId.equals(actor.id) & table.clientKey.equals(clientKey),
        transaction: transaction,
      );

      if (existing == null) {
        final row = ArtsRecord(
          tenantId: actor.tenantId,
          userId: actor.id,
          artsType: artsType,
          clientKey: clientKey,
          title: _text(body, 'title'),
          question: _text(body, 'question'),
          chartTime: _dateValue(body['chart_time']) ?? now,
          queryParams: _jsonText(body['query_params']),
          chartSnapshot: _jsonText(body['chart_snapshot']),
          interpretation: _text(body, 'interpretation'),
          feedback: _text(body, 'feedback'),
          tags: _stringList(body['tags']),
          status: 1,
          deleted: false,
          creator: actor.username,
          createTime: now,
          updater: actor.username,
          updateTime: now,
        );
        final inserted = await ArtsRecord.db.insertRow(session, row, transaction: transaction);
        return _toJson(inserted);
      }

      // 已存在只更新客户端能改的字段，创建人与创建时间保持原值。
      final updated = existing.copyWith(
        title: _hasText(body, 'title') ? _text(body, 'title') : existing.title,
        question: _hasText(body, 'question') ? _text(body, 'question') : existing.question,
        chartTime: _dateValue(body['chart_time']) ?? existing.chartTime,
        queryParams: body.containsKey('query_params') ? _jsonText(body['query_params']) : existing.queryParams,
        chartSnapshot: body.containsKey('chart_snapshot') ? _jsonText(body['chart_snapshot']) : existing.chartSnapshot,
        interpretation: body.containsKey('interpretation') ? _text(body, 'interpretation') : existing.interpretation,
        feedback: body.containsKey('feedback') ? _text(body, 'feedback') : existing.feedback,
        tags: body.containsKey('tags') ? _stringList(body['tags']) : existing.tags,
        updater: actor.username,
        updateTime: now,
      );
      final saved = await ArtsRecord.db.updateRow(session, updated, transaction: transaction);
      return _toJson(saved);
    });
  });

  /// 分页列表；普通用户只能看自己的记录，超管默认看本租户全部，可用 `user_id` 收窄到某人。
  static Future<PageResponse> list(
    Session session, {
    int page = 1,
    int pageSize = _defaultPageSize,
    String? artsType,
    String? keyword,
    DateTime? startTime,
    DateTime? endTime,
    int? userId,
  }) => _guard(() async {
    final actor = await _actor(session);
    final safePage = page <= 0 ? 1 : page;
    final size = pageSize <= 0 ? _defaultPageSize : pageSize.clamp(1, _maxPageSize);
    final type = _clean(artsType);
    if (type != null && !artsTypes.contains(type)) {
      throw RestException.badRequest('arts_type 仅支持 ${artsTypes.join(' / ')}');
    }
    // 超管不指定 user_id 时不过滤用户，看本租户全部。
    final ownerId = actor.isSuperuser ? userId : actor.id;
    final key = _clean(keyword);
    final from = startTime;
    final to = endTime;
    if (from != null && to != null && from.isAfter(to)) {
      throw RestException.badRequest('开始时间不能晚于结束时间');
    }

    Expression where(ArtsRecordTable table) {
      var filter = table.tenantId.equals(actor.tenantId) & table.deleted.equals(false);
      if (ownerId != null) filter = filter & table.userId.equals(ownerId);
      if (type != null) filter = filter & table.artsType.equals(type);
      if (key != null) {
        filter =
            filter &
            (table.title.like('%$key%') |
                table.question.like('%$key%') |
                table.interpretation.like('%$key%') |
                table.feedback.like('%$key%'));
      }
      if (from != null) filter = filter & (table.chartTime >= from);
      if (to != null) filter = filter & (table.chartTime <= to);
      return filter;
    }

    final rows = await ArtsRecord.db.find(
      session,
      where: where,
      orderByList: (table) => [table.chartTime.desc(), table.id.desc()],
      limit: size,
      offset: (safePage - 1) * size,
    );
    final total = await ArtsRecord.db.count(session, where: where);
    return PageResponse.restPage(
      data: rows.map(_toJson).toList(),
      page: safePage,
      pageSize: size,
      total: total,
    );
  });

  /// 记录详情
  static Future<Map<String, dynamic>> detail(Session session, int id) => _guard(() async {
    final actor = await _actor(session);
    final row = await _findOwned(session, actor, id);
    return _toJson(row);
  });

  /// 修改卦解/反馈/标签等内容
  static Future<Map<String, dynamic>> update(Session session, int id, Map<String, dynamic> body) => _guard(() async {
    final actor = await _actor(session);
    final row = await _findOwned(session, actor, id);
    final status = _intOrNull(body['status']);
    if (status != null && status != 0 && status != 1) {
      throw RestException.badRequest('status 只能为 0 或 1');
    }
    final updated = row.copyWith(
      title: body.containsKey('title') ? _text(body, 'title') : row.title,
      question: body.containsKey('question') ? _text(body, 'question') : row.question,
      interpretation: body.containsKey('interpretation') ? _text(body, 'interpretation') : row.interpretation,
      feedback: body.containsKey('feedback') ? _text(body, 'feedback') : row.feedback,
      tags: body.containsKey('tags') ? _stringList(body['tags']) : row.tags,
      status: status ?? row.status,
      updater: actor.username,
      updateTime: DateTime.now(),
    );
    final saved = await ArtsRecord.db.updateRow(session, updated);
    return _toJson(saved);
  });

  /// 批量软删除
  static Future<Map<String, dynamic>> delete(Session session, List<int> ids) => _guard(() async {
    final actor = await _actor(session);
    if (ids.isEmpty) throw RestException.badRequest('ids 不能为空');
    final now = DateTime.now();
    final deleted = <int>[];
    for (final id in ids.toSet()) {
      final row = await _findOwned(session, actor, id);
      await ArtsRecord.db.updateRow(session, row.copyWith(deleted: true, updater: actor.username, updateTime: now));
      deleted.add(id);
    }
    return {'deleted': deleted};
  });

  /// 批量启用/停用
  static Future<Map<String, dynamic>> setStatus(Session session, Map<String, dynamic> body) => _guard(() async {
    final actor = await _actor(session);
    final status = _intOrNull(body['status']);
    if (status != 0 && status != 1) throw RestException.badRequest('status 只能为 0 或 1');
    final ids = _intList(body['ids'] ?? body['id']);
    if (ids.isEmpty) throw RestException.badRequest('ids 不能为空');
    final now = DateTime.now();
    for (final id in ids) {
      final row = await _findOwned(session, actor, id);
      await ArtsRecord.db.updateRow(session, row.copyWith(status: status, updater: actor.username, updateTime: now));
    }
    return {'ids': ids, 'status': status};
  });

  /// 取记录：普通用户只能动自己的，超管可动本租户任意一条。
  static Future<ArtsRecord> _findOwned(Session session, _Actor actor, int id) async {
    final row = await ArtsRecord.db.findFirstRow(
      session,
      where: (table) {
        var filter = table.id.equals(id) & table.tenantId.equals(actor.tenantId) & table.deleted.equals(false);
        if (!actor.isSuperuser) filter = filter & table.userId.equals(actor.id);
        return filter;
      },
    );
    if (row == null) throw const RestException.notFound('排盘记录不存在');
    return row;
  }

  static Future<_Actor> _actor(Session session) async {
    final auth = session.authenticated;
    if (auth == null) throw const RestException.unauthorized();
    final user = await SysUser.db.findFirstRow(
      session,
      where: (table) => table.authUserId.equals(auth.authUserId) & table.deleted.equals(false),
    );
    if (user == null) throw RestException(401, '登录账号不存在，请重新登录', code: 401);
    return _Actor(id: user.id!, username: user.username, tenantId: session.tenantId, isSuperuser: user.isSuperuser);
  }

  static Map<String, dynamic> _toJson(ArtsRecord row) => {
    'id': row.id,
    'tenant_id': row.tenantId,
    'user_id': row.userId,
    'arts_type': row.artsType,
    'client_key': row.clientKey,
    'title': row.title,
    'question': row.question,
    'chart_time': row.chartTime.toIso8601String(),
    'query_params': _decodeJson(row.queryParams),
    'chart_snapshot': _decodeJson(row.chartSnapshot),
    'interpretation': row.interpretation,
    'feedback': row.feedback,
    'tags': row.tags ?? const <String>[],
    'status': row.status,
    'create_time': row.createTime.toIso8601String(),
    'update_time': row.updateTime.toIso8601String(),
  };

  static Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on RestException {
      rethrow;
    } catch (_) {
      throw const RestException(500, '排盘记录处理失败', code: 500);
    }
  }

  static String _requiredText(Map<String, dynamic> body, String key) {
    final text = _clean(body[key]?.toString());
    if (text == null) throw RestException.badRequest('$key 不能为空');
    return text;
  }

  /// 缺省或空白一律存空串，避免列表接口出现 null 判空分支。
  static String _text(Map<String, dynamic> body, String key) => _clean(body[key]?.toString()) ?? '';

  static bool _hasText(Map<String, dynamic> body, String key) => _clean(body[key]?.toString()) != null;

  static String? _clean(String? value) {
    final text = value?.trim();
    return text == null || text.isEmpty ? null : text;
  }

  static List<String>? _stringList(Object? value) {
    if (value is! List) return null;
    final items = value.map((e) => e.toString().trim()).where((e) => e.isNotEmpty).toSet().toList();
    return items.isEmpty ? null : items;
  }

  /// 入参既接受对象也接受已序列化好的 JSON 文本。
  static String _jsonText(Object? value) {
    if (value == null) return '';
    if (value is String) return value.trim();
    return jsonEncode(value);
  }

  static Object? _decodeJson(String? text) {
    final raw = _clean(text);
    if (raw == null) return null;
    try {
      return jsonDecode(raw);
    } on FormatException {
      return raw;
    }
  }

  static DateTime? _dateValue(Object? value) {
    final text = _clean(value?.toString());
    if (text == null) return null;
    final parsed = DateTime.tryParse(text);
    if (parsed == null) throw const RestException.badRequest('chart_time 格式不正确');
    return parsed;
  }

  static int? _intOrNull(Object? value) => switch (value) {
    final int v => v,
    final num v => v.toInt(),
    final String v => int.tryParse(v.trim()),
    _ => null,
  };

  /// 兼容 `{"id":1}` / `{"ids":[1,2]}` / `{"ids":["1","2"]}`，过滤非正数后去重。
  static List<int> _intList(Object? value) => switch (value) {
    final List<dynamic> list => list,
    null => const <dynamic>[],
    final Object single => [single],
  }.map(_intOrNull).whereType<int>().where((id) => id > 0).toSet().toList();
}

/// 当前登录用户
class _Actor {
  const _Actor({required this.id, required this.username, required this.tenantId, required this.isSuperuser});

  final int id;
  final String username;
  final int tenantId;
  final bool isSuperuser;
}
