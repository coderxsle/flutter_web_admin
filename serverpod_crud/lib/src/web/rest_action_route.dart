import 'package:serverpod/serverpod.dart';

import 'rest_api_exception.dart';
import 'rest_envelope_builder.dart';
import 'rest_payload.dart';

/// 非 CRUD 的「业务动作」REST 路由 —— 与 `BaseRestRoute` 同一套信封/鉴权/状态码。
///
/// ## 为什么需要它
///
/// `BaseRestRoute` 产出的是**固定的一套 CRUD 路由**（列表 / 详情 / 新增 /
/// 更新 / 删除 / 批量删），而「登录」「取公钥」「刷新 token」「重置密码」
/// 这类接口是**单点动作** —— 方法、路径、入参各不相同，套不进 CRUD 模板。
///
/// 本类只承担与 `BaseRestRoute` **完全相同**的那半边职责：
/// 鉴权前置、信封装配、HTTP 状态码映射、异常兜底、OPTIONS 预检注册；
/// 业务体交给 [handler]。这样「REST 表现层」就只有**一套**实现，不会出现
/// 「两套基类并存、混用运行期崩」的老问题。
///
/// ## 用法
///
/// ```dart
/// pod.webServer.addRoute(
///   RestActionRoute(
///     methods: {Method.post},
///     requireAuth: false,                    // 登录前没有 token
///     envelope: const ServerpodEnvelopeBuilder(),
///     handler: (session, request) async {
///       final body = await request.jsonObjectBody();
///       return AuthService.login(session, body['username'], body['password']);
///     },
///   ),
///   '/api/auth/login',                       // ← 完整路径，一条路由一个挂载点
/// );
/// ```
///
/// ⚠️ **一条路由一个挂载点**。`addRoute` 内部是 `injectAt`（挂载点唯一），
/// 同一个字符串挂两次会抛 `Invalid argument(s): Conflicting values`。
/// 所以不要写成「挂 `/api/auth` + 子路径 `/login`」，而要写成
/// `/api/auth/login` 这样的完整路径 —— 反正 `Route.path` 会被拼在挂载点后面，
/// 默认 `'/'` 时挂载点就是完整路径。
class RestActionRoute extends Route {
  RestActionRoute({
    required super.methods,
    super.path = '/',
    this.envelope = const PlainEnvelopeBuilder(),
    this.requireAuth = true,
    required this.handler,
  });

  /// 同一路径 + 多种方法 + **各自不同的处理逻辑**时用这个构造。
  ///
  /// ## 为什么需要它
  ///
  /// `addRoute(route, path)` 内部是 `PathTrie.injectAt`，而**同一个挂载点只能
  /// 挂一次** —— 第二次挂会在 `attach` 阶段抛
  /// `Invalid argument(s): Conflicting values`（挂载点节点与子 router 根节点
  /// 同时有值）。所以「`GET /x` 与 `POST /x` 做不同的事」**不能**写成两次
  /// `addRoute`，必须合并成一条 `RestActionRoute`：`methods` 取全部方法，
  /// 然后在 handler 里按 `request.method` 分派。
  ///
  /// ⚠️ 与「多方法共用同一个 handler」区分开：比如
  /// `PUT|POST /api/role/:id/menus` 两种方法的语义完全相同，直接给主构造的
  /// `methods` 传一个集合即可，不需要这个构造。
  ///
  /// ## 用法
  ///
  /// ```dart
  /// pod.webServer.addRoute(
  ///   RestActionRoute.byMethod(
  ///     handlers: {
  ///       Method.get: (session, request) async => list(session),
  ///       Method.post: (session, request) async => create(session, request),
  ///     },
  ///     envelope: const ServerpodEnvelopeBuilder(),
  ///   ),
  ///   '/api/airtable/tables',          // ← 一个挂载点，一条路由
  /// );
  /// ```
  ///
  /// [handlers] 的键集合就是本路由接受的方法集合；不在集合里的方法由路由层
  /// 直接返回 405（带 `Allow` 头），不会进到 handler。
  ///
  /// ⚠️ 不提供 `path` 参数：这个构造专门服务于「一条路由一个完整挂载点」的
  /// 用法（`Route.path` 保持默认的 `'/'`）。需要挂在子路径上时，把完整路径
  /// 拼进 `addRoute` 的挂载点。
  RestActionRoute.byMethod({
    required Map<Method, Future<Object?> Function(Session, Request)> handlers,
    this.envelope = const PlainEnvelopeBuilder(),
    this.requireAuth = true,
  }) : assert(handlers.isNotEmpty, 'handlers 不能为空'),
       handler = _dispatcherFor(handlers),
       super(methods: handlers.keys.toSet());

  /// 把「按方法分派」包成一个普通 handler。
  ///
  /// 单独抽成静态方法是为了可读性：直接往初始化列表里写函数字面量会被
  /// Dart 3 的记录语法（`(a, b)`）带偏，解析成「括号表达式 + 块」，报一堆
  /// `return_in_generative_constructor` / `expected_class_member`。
  static Future<Object?> Function(Session, Request) _dispatcherFor(
    Map<Method, Future<Object?> Function(Session, Request)> handlers,
  ) =>
      (session, request) {
        final selected = handlers[request.method];
        if (selected == null) {
          // 正常到不了这里：不在 `methods` 里的方法在路由匹配阶段就是 405。
          throw RestApiException(405, '不支持的方法 ${request.method.value}');
        }
        return selected(session, request);
      };

  /// 信封构造器（业务项目用来输出自己的 `{code, message, data}`）。
  final RestEnvelopeBuilder envelope;

  /// 是否要求登录后才进入 [handler]。默认 true。
  ///
  /// 登录、取公钥这类接口设 `false` —— 它们本来就在登录之前调用，
  /// 保持默认值会让基类在进入业务前直接 401。
  final bool requireAuth;

  /// 业务入口：拿到的载荷会被装进 [envelope] 的 `success`。
  ///
  /// 返回值可以是任意可 JSON 化的对象；如果返回的是业务项目自己的
  /// `CommonResponse`（本项目就是这样），信封构造器应当直接采用它、
  /// 而不是再包一层（否则会出现 `{code, message, data:{code, message…}}`）。
  final Future<Object?> Function(Session session, Request request) handler;

  @override
  void injectIn(RelicRouter router) {
    router.anyOf(methods, path, asHandler);

    // 补一条 OPTIONS：relic 的中间件是**路由级**的，OPTIONS 没匹配到路由
    // 就在匹配阶段 405 了，挂在同前缀上的 CORS 中间件根本不会执行。
    router.anyOf({Method.options}, path, _preflight);
  }

  static Response _preflight(Request request) => Response.ok();

  @override
  Future<Result> handleCall(Session session, Request request) async {
    try {
      if (requireAuth && session.authenticated == null) {
        return _json(401, envelope.failure('未登录或 token 已失效', code: 401));
      }
      return _json(200, envelope.success(await handler(session, request)));
    } on RestApiException catch (e) {
      return _json(envelope.httpStatusFor(e), envelope.failure(e.message, code: e.code));
    } catch (e, stackTrace) {
      // 未预期异常：进 Serverpod 日志（持久化到 serverpod_session_log），
      // 对外只给一个不带细节的 500。
      session.log(
        'REST ${request.method.value} ${request.url.path} 处理失败：$e',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
      return _json(500, envelope.failure('服务器内部错误', code: 500));
    }
  }

  Response _json(int statusCode, Map<String, dynamic> json) => Response(
    statusCode,
    body: Body.fromString(encodeEnvelope(json), mimeType: MimeType.json),
  );
}
