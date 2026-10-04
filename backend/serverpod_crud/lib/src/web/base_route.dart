import 'package:serverpod/serverpod.dart';

import 'auto_crud_delegate.dart';
import 'crud_options.dart';
import 'rest_action.dart';
import 'action_route.dart';
import 'rest_exception.dart';
import 'crud_delegate.dart';
import 'envelope_builder.dart';
import 'rest_page.dart';
import 'rest_payload.dart';
import 'rest_request_extension.dart';

/// 泛型 REST 资源路由：一次挂载，自动注册整套标准路由。
///
/// ```dart
/// // 空类体即可 —— 数据映射全自动（表由 T 反查）
/// class UserRestRoute extends BaseRoute<SysUser> {}
///
/// pod.webServer.addRoute(UserRestRoute(), '/api/user');
/// ```
class BaseRoute<T extends TableRow> extends Route {
  BaseRoute({
    CrudDelegate<T>? delegate,
    CrudOptions<T>? options,
    List<RestAction> actionList = const [],
    this.envelope = const PlainEnvelopeBuilder(),
    this.requireAuth = true,
    this.enableCreate = true,
    this.enableBatchDelete = true,
  }) : _ctx = _RestContext<T>(delegate, options, envelope, requireAuth),
       super(path: '/') {
    // 子路由只依赖方法 + 路径 + 上下文，不触碰 delegate，
    // 所以这里可以安全地提前构建（delegate 是 lazy 的）。
    final declaredActions = actionList;
    _checkActionDefinitions(declaredActions);
    final overridden = {
      for (final action in declaredActions)
        for (final method in action.methods) '${method.value} ${action.path}',
    };

    _subRoutes = <Route>[
      if (!overridden.contains('GET /getList')) _ListRoute<T>(_ctx),
      if (!overridden.contains('GET /getDetail')) _DetailRoute<T>(_ctx),
      if (enableCreate && !overridden.contains('POST /add')) _AddRoute<T>(_ctx),
      if (!overridden.contains('POST /update')) _UpdateRoute<T>(_ctx),
      if (!overridden.contains('POST /delete')) _DeleteRoute<T>(_ctx),
      if (enableBatchDelete && !overridden.contains('POST /deleteBatch')) _DeleteBatchRoute<T>(_ctx),
    ];

    _actions = declaredActions.map((action) => action.toRoute(defaultEnvelope: envelope)).toList(growable: false);
    _checkActions();
  }

  late final List<ActionRoute> _actions;

  /// 构造期防御：动作子路径必须合法且不能和 CRUD 子路径撞车。
  ///
  /// 撞车的后果是同一 `path + method` 在 `router.anyOf` 上注册两次 ——
  /// relic 对这个行为没有明确保证（可能覆盖、可能都留着），
  /// 与其等运行期出玄学问题，不如在注册阶段直接报错。
  void _checkActions() {
    for (final action in _actions) {
      assert(action.path.startsWith('/'), '动作路由的路径必须是相对子路径（以 / 开头）：${action.path}');
      assert(action.methods.isNotEmpty, '动作路由至少需要一个 HTTP 方法：${action.path}');
    }
  }

  void _checkActionDefinitions(List<RestAction> definitions) {
    final signatures = <String>{};
    for (final action in definitions) {
      for (final method in action.methods) {
        final signature = '${method.value} ${action.path}';
        if (!signatures.add(signature)) {
          throw ArgumentError('重复注册 REST 动作：$signature');
        }
      }
    }
  }

  final _RestContext<T> _ctx;

  /// 信封构造器（业务项目用来输出自己的 `{code, message, data}`）。
  final EnvelopeBuilder envelope;

  /// 是否要求登录后才进入业务。默认 true；Webhook / 健康检查类资源可设 false。
  final bool requireAuth;

  /// 是否注册 `POST /add`（新增）。
  ///
  /// 默认 true。设为 false 用于**只读 / 不支持新增**的资源 ——
  /// 本项目 `sys_role` 就是这样：业务侧本就没有 `add`，
  /// REST 侧不该凭空造一个业务动作出来。
  ///
  /// ⚠️ 关掉后 `POST {base}/add` 是 **404**（该路径上一条路由都没挂），
  /// 不是 405。改成本组「一动作一路径」之前它是 405（当时与 `GET /`
  /// 共用 `/` 这个路径，能匹配到路径但方法不允许）。
  final bool enableCreate;

  /// 是否注册 `POST /deleteBatch`（批量删除，body `{"ids":[…]}`）。
  final bool enableBatchDelete;

  late final List<Route> _subRoutes;

  /// 实际使用的 delegate。传 `null` 时**延迟到首次请求**才自动装配 ——
  /// 因为自动装配要访问 `Serverpod.instance.serializationManager`。
  CrudDelegate<T> get delegate => _ctx.delegate;

  /// 是否使用延迟自动装配的标准 CRUD delegate。
  bool get isAutoAssembled => _ctx.isAutoAssembled;

  /// 自动产生的 CRUD 子路由（只读，便于测试断言）。
  List<Route> get subRoutes => List.unmodifiable(_subRoutes);

  /// [actionList] 里的动作路由（只读，便于测试断言），与 [subRoutes] 对称。
  List<ActionRoute> get actionRoutes => List.unmodifiable(_actions);

  @override
  void injectIn(RelicRouter router) {
    final paths = <String>{};
    for (final route in _subRoutes) {
      router.anyOf(route.methods, route.path, route.asHandler);
      paths.add(route.path);
    }

    // 动作子路由与 CRUD 子路由并列挂在同一个挂载点内部。
    //
    // `ActionRoute.injectIn` 自己会注册 methods + 一条 OPTIONS，
    // 所以这里不要重复注册 —— 只要把它展开到同一个 router 上即可。
    for (final action in actionRoutes) {
      router.anyOf(action.methods, action.path, action.asHandler);
      paths.add(action.path);
    }

    // 每个 CRUD 子路径都补一条 OPTIONS。
    //
    // 不能只靠 CORS 中间件：relic 的中间件是**路由级**的 —— 只有请求先
    // 匹配到某条路由，挂在同前缀上的中间件才会执行。浏览器跨域预检发的是
    // OPTIONS，子路由里没人注册它，于是在匹配阶段就 405 了（`allow: GET, …`），
    // 中间件根本没机会跑，CORS 头也就加不上。本项目实测过这一点。
    for (final path in paths) {
      router.anyOf({Method.options}, path, _preflight);
    }
  }

  static Response _preflight(Request request) => Response.ok();

  /// 本类只负责挂载，请求全部交给子路由。
  @override
  Future<Result> handleCall(Session session, Request request) {
    throw UnimplementedError('BaseRoute 只负责挂载子路由，不处理请求');
  }
}

/// 子路由共享的上下文。
class _RestContext<T extends TableRow> {
  _RestContext(this._explicitDelegate, this._options, this.envelope, this.requireAuth);

  final CrudDelegate<T>? _explicitDelegate;
  final CrudOptions<T>? _options;
  final EnvelopeBuilder envelope;
  final bool requireAuth;

  /// 延迟自动装配：路由注册发生在 `pod.start()` 之前，
  /// 此时 `Serverpod.instance` 已就绪但数据库尚未连接 —— 推到首次请求最稳。
  late final CrudDelegate<T> delegate = _explicitDelegate ?? _createDelegate();

  CrudDelegate<T> _createDelegate() {
    final options = _options;
    if (options == null) return AutoCrudDelegate<T>();
    return AutoCrudDelegate<T>(
      runtime: options.runtime,
      tenantIdField: options.tenantIdField,
      deletedField: options.deletedField,
      keywordFields: options.keywordFields,
      fieldAliases: options.fieldAliases,
      auditService: options.auditService,
      defaultSort: options.defaultSort,
    );
  }

  bool get isAutoAssembled => _explicitDelegate == null;
}

/// 单条 REST 子路由的公共处理：鉴权 → 调业务 → 信封 → HTTP 状态码。
abstract class _RestSubRoute<T extends TableRow> extends Route {
  _RestSubRoute(this.ctx, {required super.methods, super.path = '/'});

  final _RestContext<T> ctx;

  /// 成功时是否返回 201。
  bool get createdOnSuccess => false;

  /// 业务入口。返回已装好信封的 JSON。
  Future<Map<String, dynamic>> handle(Session session, Request request);

  @override
  Future<Result> handleCall(Session session, Request request) async {
    try {
      if (ctx.requireAuth && session.authenticated == null) {
        return _json(401, ctx.envelope.failure('未登录或 token 已失效', code: 401));
      }
      return _json(createdOnSuccess ? 201 : 200, await handle(session, request));
    } on RestException catch (e) {
      return _json(ctx.envelope.httpStatusFor(e), ctx.envelope.failure(e.message, code: e.code));
    } catch (e, stackTrace) {
      // 未预期异常：进 Serverpod 日志（持久化到 serverpod_session_log），
      // 对外只给一个不带细节的 500。
      session.log(
        'REST ${request.method.value} ${request.url.path} 处理失败：$e',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
      return _json(500, ctx.envelope.failure('服务器内部错误', code: 500));
    }
  }

  Response _json(int statusCode, Map<String, dynamic> json) =>
      Response(statusCode, body: Body.fromString(encodeEnvelope(json), mimeType: MimeType.json));
}

class _ListRoute<T extends TableRow> extends _RestSubRoute<T> {
  _ListRoute(super.ctx) : super(methods: {Method.get}, path: '/getList');

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    final payload = await ctx.delegate.list(session, request);

    // 分页载荷走分页信封；其它形状（部门树 / 菜单树 / 全量字典）走普通成功信封。
    if (payload is RestPage) return ctx.envelope.page(payload.toPayload());
    return ctx.envelope.success(payload);
  }
}

class _DetailRoute<T extends TableRow> extends _RestSubRoute<T> {
  _DetailRoute(super.ctx) : super(methods: {Method.get}, path: '/getDetail');

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    return ctx.envelope.success(await ctx.delegate.detail(session, request.queryId()));
  }
}

class _AddRoute<T extends TableRow> extends _RestSubRoute<T> {
  _AddRoute(super.ctx) : super(methods: {Method.post}, path: '/add');

  @override
  bool get createdOnSuccess => true;

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    return ctx.envelope.success(await ctx.delegate.create(session, await request.jsonObjectBody()));
  }
}

/// `POST /update` —— body 平铺，且**自带 `id`**。
class _UpdateRoute<T extends TableRow> extends _RestSubRoute<T> {
  _UpdateRoute(super.ctx) : super(methods: {Method.post}, path: '/update');

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    final id = asIntOrNull(body['id']);
    if (id == null || id <= 0) {
      throw const RestException.badRequest('请求体缺少合法的 id');
    }
    return ctx.envelope.success(await ctx.delegate.update(session, id, body));
  }
}

/// `POST /delete` —— 删除**单条**，body `{"id":1}`。
///
/// 兼容 `{"ids":[1]}` 这种「只有一个元素的批量写法」，但**不接受多个 id**：
/// 多条删必须走 [CrudBatchResult] 那条 `POST /deleteBatch`。
///
/// 硬性区分是刻意的 —— 前端 `delete()` 返 `boolean`、`deleteBatch()` 返
/// `CrudBatchResult`，同一条路由按入参长度返回两种形状会很难用。
class _DeleteRoute<T extends TableRow> extends _RestSubRoute<T> {
  _DeleteRoute(super.ctx) : super(methods: {Method.post}, path: '/delete');

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    final id = extractSingleId(await request.jsonObjectBody());
    await ctx.delegate.remove(session, id);
    return ctx.envelope.success(true, message: '删除成功');
  }
}

/// `POST /deleteBatch` —— 批量删除，body `{"ids":[1,2,3]}`。
///
/// 返回 `CrudBatchResult`，由业务信封装成
/// `data: {total, successCount, notFoundCount, successIds, failedIds}` ——
/// 前端拿 `failedIds` 逐条提示，只有一个成功条数是不够用的。
class _DeleteBatchRoute<T extends TableRow> extends _RestSubRoute<T> {
  _DeleteBatchRoute(super.ctx) : super(methods: {Method.post}, path: '/deleteBatch');

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    final ids = extractIds(await request.jsonObjectBody());
    final result = await ctx.delegate.removeBatch(session, ids);
    return ctx.envelope.success(result, message: '删除成功');
  }
}
