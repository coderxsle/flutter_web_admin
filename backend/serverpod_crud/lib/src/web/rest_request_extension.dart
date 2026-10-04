import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import 'rest_exception.dart';

/// REST 路由里读取 HTTP 入参的便捷扩展。
extension RestRequestExtension on Request {
  /// 读 query 里的字符串参数，空串按「未传」处理。
  String? queryString(String key) {
    final value = url.queryParameters[key];
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  /// 读 query 里的整型参数；非法值抛 400 而不是静默忽略。
  int? queryInt(String key) {
    final raw = queryString(key);
    if (raw == null) return null;
    final parsed = int.tryParse(raw);
    if (parsed == null) {
      throw RestException.badRequest('查询参数 $key 必须是整数，实际收到 "$raw"');
    }
    return parsed;
  }

  /// 读 query 里的主键参数并断言是正整数（`GET /getDetail?id=123`）。
  ///
  /// ⚠️ 与 [pathId] 的分工：
  /// * [queryId] —— 资源详情路由用。本框架的 `GET /getDetail` **路径里没有
  ///   `:id` 段**，id 走 query；
  /// * [pathId] —— 仍被 `ActionRoute` 那批**嵌套在资源挂载点下**的动作
  ///   路由使用（`/api/role/:id/menus`、`/api/role/:id/users` 之类）。
  int queryId({String key = 'id'}) {
    final parsed = queryInt(key);
    if (parsed == null || parsed <= 0) {
      throw RestException.badRequest(
        '查询参数 $key 必须是正整数，实际收到 "${url.queryParameters[key] ?? ''}"',
      );
    }
    return parsed;
  }

  /// 读路径参数并断言是正整数（如 `/api/role/:id/menus` 的 `:id`）。
  int pathId({Symbol key = #id}) {
    final raw = rawPathParameters[key];
    final parsed = raw == null ? null : int.tryParse(raw);
    if (parsed == null || parsed <= 0) {
      throw RestException.badRequest('路径参数必须是正整数，实际收到 "${raw ?? ''}"');
    }
    return parsed;
  }

  /// 把请求体解析成 JSON 对象；空 body 返回空 map。
  Future<Map<String, dynamic>> jsonObjectBody() async {
    final raw = await readAsString();
    if (raw.trim().isEmpty) return <String, dynamic>{};

    dynamic decoded;
    try {
      decoded = jsonDecode(raw);
    } on FormatException catch (e) {
      throw RestException.badRequest('请求体不是合法 JSON：${e.message}');
    }
    if (decoded is! Map) {
      throw RestException.badRequest('请求体必须是 JSON 对象');
    }
    return Map<String, dynamic>.from(decoded);
  }
}
