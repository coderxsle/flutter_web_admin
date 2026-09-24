import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../core/crud_models.dart';
import '../crud/auto_crud_service.dart';
import '../crud/base_service.dart';
import '../crud/crud_entity_meta.dart';
import '../models/query/query_dto.dart';
import '../runtime/crud_runtime.dart';

// REST 表现层：把 [BaseService] 的 CRUD 能力，用一行代码暴露成标准 REST 路由。
//
// 分层位置 —— 与 typed Endpoint **对称**，共用同一份 Service：
//
// ```
//                       ┌── BaseEndpoint<T, TTable>  → typed API (8080) → Flutter
//   BaseService<T, TTable> ┤
//                       └── BaseRestRoute<T>         → REST     (8082) → Vue / Webhook / 三方
// ```
//
// 目标形态（用户要的那句）：
//
// ```dart
// class UserRestRoute extends BaseRestRoute<SysUser> {}   // 空类体
// // 或
// pod.registerCrud<SysUser>('/api/user');                 // 一行
// ```
//
// 自动产生（默认全开，见 [BaseRestRoute] 的路由表）：
//
// ```
// GET     /              列表
// GET     /:id           详情
// POST    /              新增（201）
// PUT     /:id           更新
// PATCH   /:id           更新
// DELETE  /:id           删除
// DELETE  /              批量删除（body {"ids":[…]}）
// POST    /update        更新（兼容形式，body 里带 id）
// POST    /delete        删除（兼容形式，body 里带 id 或 ids）
// ```
//
// 后两条是给「项目基本只用 GET / POST」这个习惯留的 —— 标准动词都在，
// 但只用 GET/POST 的客户端也能完成全部操作。
//
// ## 为什么一个类型参数就够（Dart 的两个约束都绕开了）
//
// 1. **`T` 不能直接 `T.db.find()`** —— Dart 不允许通过类型参数访问静态成员。
//    所以本层不碰 ORM，把动作抽象成 [RestCrudDelegate]，`T` 只是「载荷类型」。
// 2. **`TTable` 无法从 `T` 静态推导** —— 但 `serverpod_database` 的
//    `Table` 是 `Table<T_ID>`，而 `serverpod_crud` 取列（`_crudFindColumn`）和
//    取类型（`SerializationManager.getTableForType`）**都是反射式的**，
//    不依赖静态类型。于是 `TTable` 可以直接填裸 `Table`（= `Table<dynamic>`），
//    真实表类 `SysUserTable extends Table<int?>` 因为协变而 `is Table` 成立。
//    → `BaseRestRoute<T>` 因此只需要一个类型参数。

/// REST 层的业务异常：用 HTTP 语义表达失败。
///
/// 与「Service 返回失败码」的区别在于**粒度**。Service 层通常只有
/// 「成功 / 失败」两个粒度，而 HTTP 需要区分 400 / 401 / 404。
/// 所以表现层用异常把语义补上，成功路径直接返回载荷。
///
/// ## [code] 的约定
///
/// [code] 是**业务码**。但 CRUD Core 并不认识业务项目的那套编码（本项目是
/// 20000 / 40100 / 40400 / 50000…），所以框架在「只知道是哪一类失败、不知道
/// 具体业务码」时，会填一个 **HTTP 状态码风格的值（400/401/403/404/500）**
/// 作为兜底，由业务项目的 [RestEnvelopeBuilder] 翻译成自己的业务码
/// （本项目见 `ServerpodEnvelopeBuilder._mapCode`）。
///
/// 调用方若明确知道业务码（例如透传 Service 返回的 `code`），直接传即可 ——
/// 只要它不是那五个 HTTP 状态码之一，就会被原样使用。
class RestApiException implements Exception {
  const RestApiException(this.httpStatus, this.message, {this.code});

  /// 400 参数不合法。兜底业务码 `400`（语义：入参不合法）。
  const RestApiException.badRequest(String message, {int code = 400})
    : this(400, message, code: code);

  /// 401 未登录 / token 失效。兜底业务码 `401`。
  const RestApiException.unauthorized([String message = '未登录或 token 已失效'])
    : this(401, message, code: 401);

  /// 403 无权限。兜底业务码 `403`。
  const RestApiException.forbidden(String message) : this(403, message, code: 403);

  /// 404 资源不存在。兜底业务码 `404`。
  const RestApiException.notFound(String message)
    : this(404, message, code: 404);

  final int httpStatus;
  final String message;

  /// 业务码；为 `null` 时由 [RestEnvelopeBuilder] 决定默认值。
  /// 取值 400/401/403/404/500 时表示「框架兜底」，需由业务项目翻译。
  final int? code;

  @override
  String toString() => 'RestApiException($httpStatus): $message';
}

/// 把载荷统一成 JSON 可编码结构。
///
/// 之所以需要它：delegate 返回的可能是 Serverpod 模型、`Map`、`List<模型>`，
/// 或者手搓的 `Map<String, dynamic>`（本项目 `DeptService` 就是手搓树）。
/// 表现层不该关心差异。
Object? restJsonify(Object? value) {
  if (value == null) return null;
  if (value is SerializableModel) return value.toJson();
  if (value is Map) {
    return value.map((key, v) => MapEntry(key.toString(), restJsonify(v)));
  }
  if (value is Iterable) return value.map(restJsonify).toList();
  if (value is DateTime) return value.toIso8601String();
  return value;
}

/// 协议无关的分页结果。
class RestPage<T> {
  const RestPage({
    required this.data,
    this.page = 1,
    this.pageSize = 20,
    this.total = 0,
  });

  /// 从 [CrudPage] 转换。
  factory RestPage.fromCrudPage(CrudPage<T> page) => RestPage<T>(
    data: page.data,
    page: page.page,
    pageSize: page.pageSize,
    total: page.total,
  );

  final List<T> data;
  final int page;
  final int pageSize;
  final int total;

  int get totalPage => pageSize <= 0 ? 0 : (total / pageSize).ceil();

  /// 抹掉载荷的静态类型，交给信封处理。
  RestPage<Object?> toPayload() => RestPage<Object?>(
    data: data,
    page: page,
    pageSize: pageSize,
    total: total,
  );
}

/// 响应信封构造器 —— 业务项目与 CRUD Core 之间的接缝。
///
/// CRUD Core 不该知道业务项目的 `{code, message, data}` 长什么样，
/// 所以信封由业务项目实现。默认实现是 [PlainEnvelopeBuilder]。
abstract class RestEnvelopeBuilder {
  const RestEnvelopeBuilder();

  /// 单对象 / 任意载荷的成功响应。
  Map<String, dynamic> success(Object? data, {String? message});

  /// 分页成功响应。
  ///
  /// 单独一个方法是为了支持「分页元信息放顶层」这种形状
  /// （本项目 `PageResponse` 就是这样：`data` 是当前页数组，
  /// `page/pageSize/total/totalPage` 都在顶层，与前端 `useTable` 的
  /// `res.total` 读取对齐）。
  Map<String, dynamic> page(RestPage<Object?> page);

  /// 失败响应。[code] 为 `null` 时给一个默认业务码。
  Map<String, dynamic> failure(String message, {int? code});
}

/// 默认信封：`{message, data}` / `{message, page..., data}` / `{message, code}`。
///
/// 字段名刻意保持中立 —— 不带 `ResultCode` 这类业务枚举。
class PlainEnvelopeBuilder extends RestEnvelopeBuilder {
  const PlainEnvelopeBuilder();

  @override
  Map<String, dynamic> success(Object? data, {String? message}) => {
    'message': message ?? '',
    'data': restJsonify(data),
  };

  @override
  Map<String, dynamic> page(RestPage<Object?> page) => {
    'message': '',
    'page': page.page,
    'pageSize': page.pageSize,
    'total': page.total,
    'totalPage': page.totalPage,
    'data': restJsonify(page.data),
  };

  @override
  Map<String, dynamic> failure(String message, {int? code}) => {
    'message': message,
    'code': ?code,
  };
}

/// 一个资源被 REST 化所需要的动作。
///
/// 入参刻意用「HTTP 形状」而不是「模型形状」：
/// * [list] 拿到原始 [Request]，可以自己解释 query 参数（本项目用户列表有
///   9 个专用过滤字段，通用分页参数盖不住）；返回值也**不强制分页** ——
///   返回 [RestPage] 走分页信封，返回别的（比如部门树）走普通成功信封。
/// * [create] / [update] 拿到已解析的 JSON **body**，由 delegate 决定怎么
///   变成模型 —— 本项目每个资源都有专用 Request 模型（`UserRequest` /
///   `DeptRequest` / `MenuRequest`），这一层必须留出自由度。
///
/// 失败一律抛 [RestApiException]，成功直接返回载荷。
///
/// ⚠️ 实现时请用 `extends` 而不是 `implements` —— [removeBatch] 有默认实现，
/// 用 `implements` 的话要把每个方法（包括它）都重写一遍。
abstract class RestCrudDelegate<T> {
  /// `GET /` 列表。返回 [RestPage] 走分页信封，其它载荷走普通信封。
  Future<Object?> list(Session session, Request request);

  /// `GET /:id` 详情。找不到抛 [RestApiException.notFound]。
  ///
  /// ⚠️ 返回类型是 `Object?` 而不是 `T`：真实资源的详情常常带**组合字段**
  /// （本项目 `UserService.getDetail` 会额外拼上 `roleIds` / `roles`），
  /// 用 `T` 就装不下了。`AutoRestCrudDelegate` 仍然返回 `T` ——
  /// 那是 `Object?` 的合法协变覆写。
  Future<Object?> detail(Session session, int id);

  /// `POST /` 新增。返回类型见 [detail] 的说明。
  Future<Object?> create(Session session, Map<String, dynamic> body);

  /// `PUT|PATCH /:id` / `POST /update` 更新。
  ///
  /// 约定为 **PATCH 语义**（只改 body 里出现过的字段）—— 因为整行覆盖会在
  /// 客户端没拿到 `serverOnly` 字段时把它们写成 NULL（最典型的是把密码清空）。
  Future<Object?> update(Session session, int id, Map<String, dynamic> body);

  /// `DELETE /:id` 删除单条。找不到抛 [RestApiException.notFound]。
  Future<void> remove(Session session, int id);

  /// `DELETE /` / `POST /delete` 批量删除。返回成功条数。
  ///
  /// 默认实现是逐个调用 [remove]。子类应覆写成一次 `deleteBatch`
  /// —— 本项目现有 6 个标准 CRUD 资源里有 4 个走批量删。
  Future<int> removeBatch(Session session, List<int> ids) async {
    for (final id in ids) {
      await remove(session, id);
    }
    return ids.length;
  }
}

/// 直接包一层 [BaseService] 的标准 delegate（显式指定表类型）。
class AutoRestCrudDelegate<T extends TableRow, TTable extends Table>
    implements RestCrudDelegate<T> {
  AutoRestCrudDelegate({
    CrudEntityMeta<T, TTable>? meta,
    BaseService<T, TTable>? service,
    CrudRuntime? runtime,
    String tenantIdField = 'tenantId',
    String? deletedField,
    List<String>? keywordFields,
    Map<String, String> fieldAliases = const {},
    this.defaultPageSize = 20,
    this.maxPageSize = 100,
  }) : service =
           service ??
           _RestAutoCrudService<T, TTable>(
             meta ??
                 CrudEntityMeta<T, TTable>.auto(
                   tenantIdField: tenantIdField,
                   deletedField: deletedField,
                   keywordFields: keywordFields,
                   fieldAliases: fieldAliases,
                   runtime: runtime,
                 ),
             runtime: runtime,
           );

  final BaseService<T, TTable> service;
  final int defaultPageSize;

  /// 服务端收敛的分页上限（防止 `?pageSize=999999` 拖垮数据库）。
  final int maxPageSize;

  /// 把 `Map<String, dynamic>` 还原成模型。
  ///
  /// 用 `deserialize<T>` 而不是 `deserializeDynamicFieldValue`：
  /// 后者要求「每个字段值再包一层 `{className, data}`」的线格式，
  /// 而 `deserialize<T>(body, T)` 会直接命中生成的 `T.fromJson`，
  /// **接受浏览器发来的普通 JSON** —— 这一点已在本项目实测过。
  T decode(Map<String, dynamic> body) =>
      Serverpod.instance.serializationManager.deserialize<T>(body, T);

  @override
  Future<Object?> list(Session session, Request request) async {
    final page = await service.getList(
      session,
      QueryDTO(
        page: request.queryInt('page') ?? 1,
        pageSize: (request.queryInt('pageSize') ?? defaultPageSize).clamp(
          1,
          maxPageSize,
        ),
        keyword: request.queryString('keyword'),
      ),
    );
    return RestPage.fromCrudPage(page);
  }

  @override
  Future<T> detail(Session session, int id) async {
    final row = await service.get(session, id);
    if (row == null) {
      throw RestApiException.notFound('记录不存在或已删除');
    }
    return row;
  }

  @override
  Future<T> create(Session session, Map<String, dynamic> body) =>
      service.create(session, decode(body));

  @override
  Future<T> update(Session session, int id, Map<String, dynamic> body) async {
    // 先读当前行做基线，再让 body 覆盖它 —— PATCH 语义。
    // 基线必须用 `toJson()`（含 serverOnly 字段），否则更新会把密码
    // 这类前端拿不到的字段写成 NULL。
    final current = await service.get(session, id);
    if (current == null) {
      throw RestApiException.notFound('记录不存在或已删除');
    }
    final merged = <String, dynamic>{...current.toJson(), ...body, 'id': id};
    return service.update(session, decode(merged));
  }

  @override
  Future<void> remove(Session session, int id) async {
    final deleted = await service.delete(session, id);
    if (deleted == null) {
      throw RestApiException.notFound('记录不存在或已删除');
    }
  }

  @override
  Future<int> removeBatch(Session session, List<int> ids) async {
    final result = await service.deleteBatch(session, ids);
    return result.successIds.length;
  }
}

/// **单类型参数**版本：表类型在运行期由 `getTableForType(T)` 反查。
///
/// 这个类存在的唯一理由，就是让 `BaseRestRoute<SysUser>` 只写一个类型参数。
class AutoCrudDelegate<T extends TableRow>
    extends AutoRestCrudDelegate<T, Table> {
  AutoCrudDelegate({
    super.meta,
    super.service,
    super.runtime,
    super.tenantIdField,
    super.deletedField,
    super.keywordFields,
    super.fieldAliases,
    super.defaultPageSize,
    super.maxPageSize,
  });
}

/// 供 [AutoRestCrudDelegate] 默认使用的具体 Service。
class _RestAutoCrudService<T extends TableRow, TTable extends Table>
    extends AutoCrudService<T, TTable> {
  _RestAutoCrudService(super.meta, {super.runtime, super.auditService});
}

/// 泛型 REST 资源路由：一次挂载，自动注册整套标准路由。
///
/// ```dart
/// // 空类体即可 —— 数据映射全自动（表由 T 反查）
/// class UserRestRoute extends BaseRestRoute<SysUser> {}
///
/// pod.webServer.addRoute(UserRestRoute(), '/api/user');
/// ```
///
/// 需要特殊逻辑时，传自定义 delegate 覆写对应动作：
///
/// ```dart
/// class UserRestRoute extends BaseRestRoute<SysUser> {
///   UserRestRoute() : super(delegate: UserRestDelegate());
/// }
/// ```
///
/// ## 为什么必须自己实现 [injectIn]
///
/// `WebServer.addRoute(route, path)` 内部是 `_app.injectAt('*/$path', route)`，
/// 而 relic 的 `PathTrie` **不允许在同一个挂载点上注入第二个 handler** ——
/// 第二次会抛 `Invalid argument(s): Conflicting values`。所以不能把 N 条
/// 路由逐条 `addRoute`，必须让**一个**挂载点内部再按「方法 + 子路径」
/// 注册多条。这正是 [Route.injectIn] 的默认写法。
class BaseRestRoute<T extends TableRow> extends Route {
  BaseRestRoute({
    RestCrudDelegate<T>? delegate,
    this.envelope = const PlainEnvelopeBuilder(),
    this.requireAuth = true,
    this.updateMethods = const {Method.put, Method.patch},
    this.enableBatchDelete = true,
    this.enablePostAliases = true,
  }) : _ctx = _RestContext<T>(delegate, envelope, requireAuth),
       super(path: '/') {
    // 子路由只依赖方法 + 路径 + 上下文，不触碰 delegate，
    // 所以这里可以安全地提前构建（delegate 是 lazy 的）。
    _subRoutes = <Route>[
      _ListRoute<T>(_ctx),
      _DetailRoute<T>(_ctx),
      _CreateRoute<T>(_ctx),
      _UpdateRoute<T>(_ctx, updateMethods),
      _DeleteRoute<T>(_ctx),
      if (enableBatchDelete) _BatchDeleteRoute<T>(_ctx),
      if (enablePostAliases) ...[
        _PostUpdateRoute<T>(_ctx),
        _PostDeleteRoute<T>(_ctx),
      ],
    ];
  }

  final _RestContext<T> _ctx;

  /// 信封构造器（业务项目用来输出自己的 `{code, message, data}`）。
  final RestEnvelopeBuilder envelope;

  /// 是否要求登录后才进入业务。默认 true；Webhook / 健康检查类资源可设 false。
  final bool requireAuth;

  /// `PUT|PATCH /:id` 接受的方法集合。
  final Set<Method> updateMethods;

  /// 是否注册 `DELETE /`（批量删除，body `{"ids":[…]}`）。
  final bool enableBatchDelete;

  /// 是否注册 `POST /update` 与 `POST /delete` 这两个兼容形式。
  ///
  /// 本项目「基本上只使用 GET、POST 接口」，所以标准动词之外补上 POST 形式，
  /// 让只用 GET/POST 的客户端也能完成全部操作。
  final bool enablePostAliases;

  late final List<Route> _subRoutes;

  /// 实际使用的 delegate。传 `null` 时**延迟到首次请求**才自动装配 ——
  /// 因为自动装配要访问 `Serverpod.instance.serializationManager`。
  RestCrudDelegate<T> get delegate => _ctx.delegate;

  /// 自动产生的子路由（只读，便于测试断言）。
  List<Route> get subRoutes => List.unmodifiable(_subRoutes);

  @override
  void injectIn(RelicRouter router) {
    final paths = <String>{};
    for (final route in _subRoutes) {
      router.anyOf(route.methods, route.path, route.asHandler);
      paths.add(route.path);
    }

    // 每个子路径都补一条 OPTIONS。
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
    throw UnimplementedError('BaseRestRoute 只负责挂载子路由，不处理请求');
  }
}

/// 子路由共享的上下文。
class _RestContext<T extends TableRow> {
  _RestContext(this._explicitDelegate, this.envelope, this.requireAuth);

  final RestCrudDelegate<T>? _explicitDelegate;
  final RestEnvelopeBuilder envelope;
  final bool requireAuth;

  /// 延迟自动装配：路由注册发生在 `pod.start()` 之前，
  /// 此时 `Serverpod.instance` 已就绪但数据库尚未连接 —— 推到首次请求最稳。
  late final RestCrudDelegate<T> delegate =
      _explicitDelegate ?? AutoCrudDelegate<T>();

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
      return _json(
        createdOnSuccess ? 201 : 200,
        await handle(session, request),
      );
    } on RestApiException catch (e) {
      return _json(e.httpStatus, ctx.envelope.failure(e.message, code: e.code));
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

  Response _json(int statusCode, Map<String, dynamic> json) => Response(
    statusCode,
    body: Body.fromString(jsonEncode(json), mimeType: MimeType.json),
  );
}

class _ListRoute<T extends TableRow> extends _RestSubRoute<T> {
  _ListRoute(super.ctx) : super(methods: {Method.get});

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    final payload = await ctx.delegate.list(session, request);

    // 分页载荷走分页信封；其它形状（如部门树）走普通成功信封。
    if (payload is RestPage) return ctx.envelope.page(payload.toPayload());
    return ctx.envelope.success(payload);
  }
}

class _DetailRoute<T extends TableRow> extends _RestSubRoute<T> {
  _DetailRoute(super.ctx) : super(methods: {Method.get}, path: '/:id');

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    return ctx.envelope.success(
      await ctx.delegate.detail(session, request.pathId()),
    );
  }
}

class _CreateRoute<T extends TableRow> extends _RestSubRoute<T> {
  _CreateRoute(super.ctx) : super(methods: {Method.post});

  @override
  bool get createdOnSuccess => true;

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    return ctx.envelope.success(
      await ctx.delegate.create(session, await request.jsonObjectBody()),
    );
  }
}

class _UpdateRoute<T extends TableRow> extends _RestSubRoute<T> {
  _UpdateRoute(super.ctx, Set<Method> methods)
    : super(methods: methods, path: '/:id');

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    return ctx.envelope.success(
      await ctx.delegate.update(
        session,
        request.pathId(),
        await request.jsonObjectBody(),
      ),
    );
  }
}

class _DeleteRoute<T extends TableRow> extends _RestSubRoute<T> {
  _DeleteRoute(super.ctx) : super(methods: {Method.delete}, path: '/:id');

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    await ctx.delegate.remove(session, request.pathId());
    return ctx.envelope.success(null, message: '删除成功');
  }
}

/// `DELETE /` —— 批量删除，body `{"ids":[1,2,3]}`。
class _BatchDeleteRoute<T extends TableRow> extends _RestSubRoute<T> {
  _BatchDeleteRoute(super.ctx) : super(methods: {Method.delete});

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    final ids = extractIds(await request.jsonObjectBody());
    final success = await ctx.delegate.removeBatch(session, ids);
    return ctx.envelope.success(
      {
        'total': ids.length,
        'successCount': success,
        'failedCount': ids.length - success,
      },
      message: '删除成功',
    );
  }
}

/// `POST /update` —— 更新（兼容只用 GET/POST 的客户端），body 里带 `id`。
class _PostUpdateRoute<T extends TableRow> extends _RestSubRoute<T> {
  _PostUpdateRoute(super.ctx) : super(methods: {Method.post}, path: '/update');

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    final id = asIntOrNull(body['id']);
    if (id == null || id <= 0) {
      throw const RestApiException.badRequest('请求体缺少合法的 id');
    }
    return ctx.envelope.success(await ctx.delegate.update(session, id, body));
  }
}

/// `POST /delete` —— 删除（兼容只用 GET/POST 的客户端）。
///
/// body 给 `{"id":n}` 删单条，给 `{"ids":[…]}` 删多条。
class _PostDeleteRoute<T extends TableRow> extends _RestSubRoute<T> {
  _PostDeleteRoute(super.ctx) : super(methods: {Method.post}, path: '/delete');

  @override
  Future<Map<String, dynamic>> handle(Session session, Request request) async {
    final ids = extractIds(await request.jsonObjectBody());
    if (ids.length == 1) {
      await ctx.delegate.remove(session, ids.first);
      return ctx.envelope.success(null, message: '删除成功');
    }
    final success = await ctx.delegate.removeBatch(session, ids);
    return ctx.envelope.success(
      {
        'total': ids.length,
        'successCount': success,
        'failedCount': ids.length - success,
      },
      message: '删除成功',
    );
  }
}

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
      throw RestApiException.badRequest('查询参数 $key 必须是整数，实际收到 "$raw"');
    }
    return parsed;
  }

  /// 读路径参数并断言是正整数（如 `/api/user/:id` 的 `:id`）。
  int pathId({Symbol key = #id}) {
    final raw = rawPathParameters[key];
    final parsed = raw == null ? null : int.tryParse(raw);
    if (parsed == null || parsed <= 0) {
      throw RestApiException.badRequest('路径参数必须是正整数，实际收到 "${raw ?? ''}"');
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
      throw RestApiException.badRequest('请求体不是合法 JSON：${e.message}');
    }
    if (decoded is! Map) {
      throw RestApiException.badRequest('请求体必须是 JSON 对象');
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

/// 从请求体里取出待删除的 id 列表，同时兼容 `{"id":n}` / `{"ids":[…]}` /
/// 裸数组三种写法。取不到或全为非法值抛 400。
List<int> extractIds(Map<String, dynamic> body) {
  final raw = body['ids'] ?? body['id'];
  final candidates = switch (raw) {
    final List<dynamic> list => list,
    final Object single => [single],
    _ => const <dynamic>[],
  };
  final ids = candidates
      .map(asIntOrNull)
      .whereType<int>()
      .where((id) => id > 0)
      .toSet()
      .toList();
  if (ids.isEmpty) {
    throw const RestApiException.badRequest('参数不合法：请提供 id 或非空的 ids');
  }
  return ids;
}

/// 非 CRUD 的「业务动作」REST 路由 —— 与 [BaseRestRoute] 同一套信封/鉴权/状态码。
///
/// ## 为什么需要它
///
/// [BaseRestRoute] 产出的是**固定的一套 CRUD 路由**（列表 / 详情 / 新增 /
/// 更新 / 删除 / 批量删），而「登录」「取公钥」「刷新 token」「重置密码」
/// 这类接口是**单点动作** —— 方法、路径、入参各不相同，套不进 CRUD 模板。
///
/// 本类只承担与 [BaseRestRoute] **完全相同**的那半边职责：
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
      return _json(e.httpStatus, envelope.failure(e.message, code: e.code));
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
    body: Body.fromString(jsonEncode(json), mimeType: MimeType.json),
  );
}

/// 一行注册 —— 用户要的 `registerCrud<User>('/api/user')` 形态。
extension ServerpodRestCrud on Serverpod {
  /// 注册一个 REST 资源。
  ///
  /// ```dart
  /// pod.registerCrud<SysUser>('/api/user');                  // 全自动
  /// pod.registerCrud<SysUser>('/api/user', delegate: Xxx());  // 自定义
  /// ```
  void registerCrud<T extends TableRow>(
    String path, {
    RestCrudDelegate<T>? delegate,
    RestEnvelopeBuilder envelope = const PlainEnvelopeBuilder(),
    bool requireAuth = true,
    Set<Method> updateMethods = const {Method.put, Method.patch},
    bool enableBatchDelete = true,
    bool enablePostAliases = true,
  }) {
    webServer.addRoute(
      BaseRestRoute<T>(
        delegate: delegate,
        envelope: envelope,
        requireAuth: requireAuth,
        updateMethods: updateMethods,
        enableBatchDelete: enableBatchDelete,
        enablePostAliases: enablePostAliases,
      ),
      path,
    );
  }
}
