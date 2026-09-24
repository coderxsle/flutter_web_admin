import 'dart:convert';

import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';

/// REST 层主动抛出的业务异常。
///
/// 只有「HTTP 层面的入参不合法」（路径参数不是正整数、请求体不是 JSON 对象…）
/// 才用这个异常；业务规则（用户名已存在、未登录…）由 Service 层以
/// `CommonResponse.failed(...)` 表达，不在这里抛。
class ApiException implements Exception {
  const ApiException(
    this.httpStatus,
    this.message, {
    // 写死 40400（= ResultCode.validateFailed.code）。这里不能用
    // `ResultCode.validateFailed.code`：默认参数要求常量表达式，而 enum
    // 的字段访问不是常量表达式。
    this.code = 40400,
  });

  /// 要写给客户端的 HTTP 状态码。
  final int httpStatus;

  /// 信封里的业务码，默认 40400（参数校验失败）。
  final int code;

  final String message;

  @override
  String toString() => 'ApiException($httpStatus/$code): $message';
}

/// REST 资源路由基类 —— 表现层适配器。
///
/// 分层约定：
///
/// ```
/// HTTP  →  Route（本类）  →  Service  →  ORM  →  PostgreSQL
/// ```
///
/// * 本层**只做 HTTP 翻译**：解析 query / path / body，调一次 Service，把
///   `CommonResponse` 包成 HTTP 响应。这里不出现 `db.find` / `db.insert`。
/// * 业务规则一律留在 Service，REST 与 Serverpod 的 typed Endpoint
///   （`UserEndpoint`）共用同一份实现 —— 这就是 REST 层存在的意义：
///   它只是换了一种「表现层」。
/// * Service 方法返回的失败（`isFailed`）会被映射成 4xx 而不是 200，
///   这样浏览器、Webhook、第三方服务能直接用 HTTP 状态码判断成败；
///   响应体仍保持项目统一的 `{code, message, data}` 信封，Vue 前端可复用
///   已有的 axios 拦截器。
abstract class ApiRoute extends Route {
  ApiRoute({required super.methods, super.path = '/'});

  /// 业务入口。子类在这里把一次 HTTP 请求翻译成一次 Service 调用。
  Future<CommonResponse> dispatch(Session session, Request request);

  /// 成功时是否返回 201 而不是 200（新增语义）。
  bool get createdOnSuccess => false;

  /// 是否要求已登录之后才进入 [dispatch]。默认 true。
  ///
  /// 之所以放在这一层而不是靠 Service 判断：Service 用统一的
  /// `CommonResponse.failed`（业务码 50000）表达所有失败，「未登录」和
  /// 「用户名已存在」在 HTTP 上应该是 401 和 400 两种结果 —— 而 Service
  /// 层只给了「失败」这一个粒度。与其去改 Service 的返回码（会影响已经在
  /// 用 50000 判断的 Vue 前端），不如让表现层自己承担 HTTP 语义。
  ///
  /// 需要匿名访问的接口（健康检查、Webhook 回调）把它覆写成 false。
  bool get requireAuth => true;

  @override
  Future<Result> handleCall(Session session, Request request) async {
    try {
      if (requireAuth && session.authenticated == null) {
        return _jsonResponse(401, {
          'code': ResultCode.unauthorized.code,
          'message': '未登录或 token 已失效',
        });
      }
      return _toHttpResponse(await dispatch(session, request));
    } on ApiException catch (e) {
      return _jsonResponse(e.httpStatus, {
        'code': e.code,
        'message': e.message,
      });
    } catch (e, stackTrace) {
      // 未预期异常：记进 Serverpod 日志（会持久化到 serverpod_session_log），
      // 对外只给一个不带细节的 500。
      session.log(
        'REST ${request.method.value} ${request.url.path} 处理失败：$e',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
      return _jsonResponse(500, {
        'code': ResultCode.failed.code,
        'message': '服务器内部错误',
      });
    }
  }

  Response _toHttpResponse(CommonResponse envelope) {
    if (envelope.isSuccess) {
      return Response(
        createdOnSuccess ? 201 : 200,
        body: _jsonBody(envelope.toJson()),
      );
    }
    return _jsonResponse(_statusCodeFor(envelope.code), envelope.toJson());
  }

  /// 业务码 → HTTP 状态码。
  ///
  /// 注意 Dart 的 enum 字段是 `final` 而不是 `const`，所以这里不能用
  /// switch 的常量模式，只能写成 if 链。
  int _statusCodeFor(int code) {
    if (code == ResultCode.unauthorized.code) return 401;
    if (code == ResultCode.authReplaced.code) return 401;
    if (code == ResultCode.forbidden.code) return 403;
    if (code == ResultCode.validateFailed.code) return 400;
    return 400;
  }

  Response _jsonResponse(int statusCode, Map<String, dynamic> json) =>
      Response(statusCode, body: _jsonBody(json));

  Body _jsonBody(Map<String, dynamic> json) =>
      Body.fromString(jsonEncode(json), mimeType: MimeType.json);
}

/// 把一个资源下的多条 [ApiRoute] 挂到同一个 URL 前缀上。
///
/// 为什么需要这一层：`WebServer.addRoute(route, path)` 内部是
/// `_app.injectAt('*/$path', route)`，而 relic 的 PathTrie **不允许在同一个
/// 挂载点上注入第二个 handler**，第二次会抛
/// `Invalid argument(s): Conflicting values`。可是 `/api/user` 这个前缀下
/// 天然会有 GET / POST 两条路由，`/api/user/:id` 下会有 GET / PUT / DELETE
/// 三条 —— 直接逐条 `addRoute` 必然冲突。
///
/// 所以这里把「一次挂载」和「N 条路由」拆开：
/// 挂载点由本类占一次，子路由交给该挂载点内部的 router 按
/// 「HTTP 方法 + 子路径」注册 —— 这正是 `Route.injectIn` 的默认写法，
/// 同一个 router 上同路径不同方法是合法的。
class ApiMount extends Route {
  ApiMount(this.routes, {super.path = '/'});

  /// 子路由。每个元素的 [Route.path] 是**相对**于挂载点的子路径
  /// （`/` 或 `/:id`）。
  final List<Route> routes;

  @override
  void injectIn(RelicRouter router) {
    final subPaths = <String>{};
    for (final route in routes) {
      router.anyOf(route.methods, route.path, route.asHandler);
      subPaths.add(route.path);
    }

    // 每个子路径都补一条 OPTIONS。
    //
    // 为什么不能只靠 [CorsMiddleware]：relic 的中间件是**路由级**的 ——
    // 只有请求先匹配到某条路由，挂在同前缀上的 middleware 才会执行。
    // 而浏览器跨域预检发的是 OPTIONS，子路由里没人注册它，于是在匹配
    // 阶段就直接 405 了（`allow: GET, PUT, DELETE, PATCH`），中间件根本没
    // 机会跑，CORS 头也就加不上。实测过这一点。
    //
    // 所以这里显式让每个子路径都能应答 OPTIONS，交回给 [CorsMiddleware]
    // 统一附加 CORS 头。
    for (final path in subPaths) {
      router.anyOf({Method.options}, path, _preflight);
    }
  }

  /// 预检请求的应答：200 + 空 body，CORS 头由 [CorsMiddleware] 补。
  static Response _preflight(Request request) => Response.ok();

  /// 本类只负责挂载，不直接处理请求。
  ///
  /// 因为 [injectIn] 被覆写成只注册子路由，本方法不会有请求走到。
  @override
  Future<Result> handleCall(Session session, Request request) {
    throw UnimplementedError('ApiMount 只负责挂载子路由，不处理请求');
  }
}

/// REST 路由里读取 HTTP 入参的便捷扩展。
///
/// 单独放在这里，是为了让各 Route 子类保持「几行转发」的薄度：
/// 解析细节不该散落在每个业务路由里。
extension ApiRequestExtension on Request {
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
      throw ApiException(400, '查询参数 $key 必须是整数，实际收到 "$raw"');
    }
    return parsed;
  }

  /// 读路径参数并断言是正整数（如 `/api/user/:id` 的 `:id`）。
  int pathId({Symbol key = #id}) {
    final raw = rawPathParameters[key];
    final parsed = raw == null ? null : int.tryParse(raw);
    if (parsed == null || parsed <= 0) {
      throw ApiException(400, '路径参数必须是正整数，实际收到 "${raw ?? ''}"');
    }
    return parsed;
  }

  /// 把请求体解析成 JSON 对象。
  ///
  /// 空 body 返回空 map（方便「挂载在已有资源上的动作型接口」不传参）。
  Future<Map<String, dynamic>> jsonObjectBody() async {
    final raw = await readAsString();
    if (raw.trim().isEmpty) return <String, dynamic>{};

    dynamic decoded;
    try {
      decoded = jsonDecode(raw);
    } on FormatException catch (e) {
      throw ApiException(400, '请求体不是合法 JSON：${e.message}');
    }
    if (decoded is! Map) {
      throw ApiException(400, '请求体必须是 JSON 对象');
    }
    return Map<String, dynamic>.from(decoded);
  }
}

/// 把 JSON 里的数字字段转成 `int?`（容忍 `"3"` 这种字符串写法）。
int? asIntOrNull(dynamic value) => switch (value) {
  final int v => v,
  final num v => v.toInt(),
  final String v => int.tryParse(v),
  _ => null,
};
