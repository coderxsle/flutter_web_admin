import 'dart:io';

import 'package:serverpod/serverpod.dart';

/// 本地开发默认允许的跨域来源（Vite dev server + 直连 webServer 调试）。
const _defaultDevOrigins = <String>{
  'http://localhost:5173',
  'http://127.0.0.1:5173',
  'http://localhost:8082',
  'http://127.0.0.1:8082',
};

/// 解析允许跨域的来源白名单。
///
/// 优先读环境变量 `REST_CORS_ORIGINS`（逗号分隔），部署时按环境覆盖：
///
/// ```bash
/// REST_CORS_ORIGINS=https://admin.example.com,https://ops.example.com
/// ```
///
/// 没配就用 [_defaultDevOrigins]。
Set<String> resolveAllowedOrigins() {
  final raw = Platform.environment['REST_CORS_ORIGINS'];
  if (raw == null || raw.trim().isEmpty) return _defaultDevOrigins;
  return raw
      .split(',')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toSet();
}

/// 给 Web Server 侧的 REST API 补上 CORS。
///
/// ⚠️ 为什么必须自己补：`config/development.yaml` 里那段 `cors:` 配置
/// **只作用于 API server（8080）**——Serverpod 把 CORS 做在 typed API 的
/// 处理链上，Web Server（8082）这条链路完全不看它。实测：
///
/// ```text
/// OPTIONS http://127.0.0.1:8080/user/getUserList  → 200 + access-control-allow-origin: *
/// OPTIONS http://127.0.0.1:8082/api/user/2       → 405 Method Not Allowed（无任何 CORS 头）
/// ```
///
/// 不使用 `Access-Control-Allow-Origin: *`，理由：
/// * 通配符等于对所有站点开放，任何恶意页面都能读走接口数据；
/// * 一旦需要带 Cookie（`withCredentials: true`）或 `Authorization`，
///   浏览器**明确禁止**通配符 origin —— 那种组合下必须回显具体来源。
///
/// 所以这里按 [allowedOrigins] 白名单逐请求判定，命中就回显该来源，
/// 并同步带上 `Vary: Origin`（否则中间缓存会把 A 站的响应喂给 B 站）。
class CorsMiddleware extends MiddlewareObject {
  CorsMiddleware({
    Set<String>? allowedOrigins,
    this.allowCredentials = false,
    this.rejectUnknownOrigin = false,
  }) : allowedOrigins = allowedOrigins ?? resolveAllowedOrigins() {
    if (allowCredentials && this.allowedOrigins.contains('*')) {
      throw ArgumentError(
        'CORS 配置冲突：白名单里放了 "*"，同时又开了 allowCredentials。'
        '浏览器会直接拒绝这种组合（不允许携带凭证 + 通配符来源）。'
        '请把白名单收窄成具体来源，或关掉 allowCredentials。',
      );
    }
  }

  /// 允许跨域的来源白名单。
  final Set<String> allowedOrigins;

  /// 是否允许浏览器携带凭证（Cookie / `withCredentials: true`）。
  ///
  /// 开启后会回 `Access-Control-Allow-Credentials: true`。注意此时
  /// `allowedOrigins` 必须是具体来源，不能含 `*`（构造时会校验）。
  final bool allowCredentials;

  /// 来源不在白名单时是否直接返回 403。
  ///
  /// 默认 `false`：**不加 CORS 头就够**，浏览器侧自然会拦掉。
  /// 这是更标准的做法 —— CORS 是浏览器自己的安全机制，不是服务端的
  /// 访问控制；用 `Origin` 做鉴权既拦不住 curl / 服务端调用（它们没有
  /// Origin，或者可以随便伪造），又会误伤带了无关 Origin 头的内部调用。
  /// 确实想让它显式失败（便于排查）再打开这个开关。
  final bool rejectUnknownOrigin;

  static const _allowMethods = 'GET, POST, PUT, PATCH, DELETE, OPTIONS';

  /// 抄自 API server 实际回的那份，保持一致。
  static const _allowHeaders =
      'content-type, authorization, accept, user-agent, x-requested-with, '
      'x-serverpod-auth-mode, x-serverpod-base-path';

  /// 预检结果缓存 24 小时，避免每个请求都发一次 OPTIONS。
  static const _maxAgeSeconds = '86400';

  bool _isAllowed(String origin) =>
      allowedOrigins.contains('*') || allowedOrigins.contains(origin);

  /// 组装某个具体来源对应的 CORS 头。
  Headers _headersFor(String origin) => Headers.build((mh) {
    // 回显具体来源而不是 '*'：这是 allowCredentials 的硬性前提。
    mh['access-control-allow-origin'] = [
      allowedOrigins.contains('*') ? '*' : origin,
    ];
    mh['access-control-allow-methods'] = [_allowMethods];
    mh['access-control-allow-headers'] = [_allowHeaders];
    mh['access-control-max-age'] = [_maxAgeSeconds];
    // 回显 origin 时 Vary 是必须的，否则共享缓存可能把 A 站拿到的
    // 响应（带 A 的 allow-origin）直接喂给 B 站。
    mh['vary'] = ['Origin'];
    if (allowCredentials) {
      mh['access-control-allow-credentials'] = ['true'];
    }
  });

  @override
  Handler call(Handler next) {
    return (request) async {
      // Headers 是大小写不敏感的 map，用小写 key 同样能取到 Origin。
      final origin = request.headers['origin']?.first;

      // 没有 Origin：同源请求或 curl / 服务端调用，本来就不参与 CORS，直接放行。
      if (origin == null) return next(request);

      final allowed = _isAllowed(origin);
      if (!allowed && rejectUnknownOrigin) {
        return Response.forbidden(
          body: Body.fromString('Origin not allowed: $origin'),
        );
      }

      // 预检请求：命中白名单就回 200 + CORS 头，不进业务路由。
      //
      // ⚠️ 这一步能执行的前提是「OPTIONS 已经匹配到某条路由」——
      //    relic 的中间件是**路由级**的，请求没匹配上路由就直接 405 了，
      //    中间件根本不会跑。所以每个 REST 路由基类都会给自己注册一条
      //    OPTIONS（`BaseRestRoute.injectIn` / `RestActionRoute.injectIn`）。
      if (request.method == Method.options) {
        return allowed
            ? Response.ok(headers: _headersFor(origin))
            : Response.ok();
      }

      final result = await next(request);
      if (result is! Response) return result;

      // 白名单未命中：原样返回，不加 CORS 头。
      if (!allowed) return result;

      final cors = _headersFor(origin);
      // copyWith(headers:) 是整体替换而不是合并，所以按「CORS 头在前、
      // 原响应头在后」的顺序手工拼一份（冲突时以原响应头为准）。
      return result.copyWith(
        headers: Headers.build((mh) {
          for (final entry in cors.entries) {
            mh[entry.key] = entry.value;
          }
          for (final entry in result.headers.entries) {
            mh[entry.key] = entry.value;
          }
        }),
      );
    };
  }
}
