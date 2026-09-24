import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import 'db_audit_service.dart';

/// 业务 Service 复用 `serverpod_crud` 时的统一入口与适配工具。
///
/// ## 为什么需要这个文件
///
/// `BaseService<T, TTable>` 已经把 CRUD 骨架做完了：租户隔离、软删、审计、
/// 校验、分页（`QueryEngine`）、`before*/after*` 钩子。但本项目 9 个业务
/// Service 全是**手写**的，直接调 `SysXxx.db.find(...)`。
///
/// 「收敛」（决策 4）的做法是：**对外签名一个都不动**（typed Endpoint 还要
/// 活到 S5 退役阶段），只把 Service **内部**的 `SysXxx.db.*` 换成这里的
/// `engine`。这样：
///
/// * typed 侧行为可以用「逐字段一致」独立验证
///   （基线与回归结论见 `docs/rest-api-layer.md` §2.3 / §5.1）
/// * REST 侧的 `AutoCrudDelegate<T>` 之后可以复用同一个 engine
///
/// ## 为什么引擎是 lazy 的
///
/// [EntityDescriptor.fromServerpod] 内部会读
/// `Serverpod.instance.serializationManager` 反查表结构；类加载时
/// `Serverpod.instance` 可能还没就绪，所以每个引擎都延迟到**首次使用**才装配。
/// 这与 `BaseRestRoute` 的默认 delegate 是同一个原因。
///
/// ## ⚠️ 收敛会带来两处**行为变化**（务必知情，验证时必须盯住）
///
/// 1. **租户过滤从「按请求参数」变成「按 session」**
///    例：现有 `UserService.getUserList` 只在 `query.tenantId != null` 时才拼
///    `tenantId = ?`；而 `QueryEngine` 会**无条件**按 `session.tenantId` 过滤。
///    方向上更正确（这才是真多租户隔离），但若现网存在 tenantId 与登录态不一致
///    的数据，结果集就会变 —— 回归时重点比对 `total`。
/// 2. **写操作会多落一条审计**
///    现有手写删是直接改 `deleted = true`；`BaseService.delete` 之后会调用
///    `auditService.record` → 往 `sys_operate_log` 插一行（见下方引擎子类上的
///    「审计」一节）。这是**新增的写入**，不是回归；且 `OperateLogWriter.write`
///    内部整段 `try/catch`，写失败不影响业务。
/// `BaseEntityService` 虽然**没有任何抽象成员**，但被声明成了 `abstract`，
/// 所以每个资源需要一个具体子类才能实例化。
///
/// 6 个资源的引擎子类。
///
/// ⚠️ 这些子类的构造函数会执行 `EntityDescriptor.fromServerpod()`，它会读
/// `Serverpod.instance.serializationManager` —— **这正是引擎必须 lazy 的原因**。
/// 不要改写成 `static final`，否则类加载即崩。
///
/// ## 审计：每个引擎都注入了 [DbAuditService]
///
/// `BaseService` 的 `auditService` 默认是 `NoopAuditService`（**什么都不写**），
/// 所以不显式传的话，`create` / `update` / `delete` / `deleteBatch` 的审计
/// **一行都不会落库** —— 之前就是这样。
///
/// 现在按历史先例（`937d3e4` 的 `user_endpoint.dart` 用过
/// `super(auditService: DbAuditService(type:'user'))`）给 6 个引擎各传入一个
/// `DbAuditService`，`type` 取名与资源/表一致，写入 `sys_operate_log`。
///
/// ⚠️ 审计**不会**影响业务：`OperateLogWriter.write` 内部整段 `try/catch`，
/// 写日志失败只打一条 `audit-record-failed` 的 server 日志，不冒泡。
class _UserEngine extends BaseEntityService<SysUser, SysUserTable> {
  _UserEngine()
    : super(
        EntityDescriptor<SysUser, SysUserTable>.fromServerpod(),
        auditService: const DbAuditService<SysUser>(type: 'user'),
      );
}

class _DeptEngine extends BaseEntityService<SysDept, SysDeptTable> {
  _DeptEngine()
    : super(
        EntityDescriptor<SysDept, SysDeptTable>.fromServerpod(),
        auditService: const DbAuditService<SysDept>(type: 'dept'),
      );
}

class _RoleEngine extends BaseEntityService<SysRole, SysRoleTable> {
  _RoleEngine()
    : super(
        EntityDescriptor<SysRole, SysRoleTable>.fromServerpod(),
        auditService: const DbAuditService<SysRole>(type: 'role'),
      );
}

class _MenuEngine extends BaseEntityService<SysMenu, SysMenuTable> {
  _MenuEngine()
    : super(
        EntityDescriptor<SysMenu, SysMenuTable>.fromServerpod(),
        auditService: const DbAuditService<SysMenu>(type: 'menu'),
      );
}

class _DictCodeEngine extends BaseEntityService<SysDictCode, SysDictCodeTable> {
  _DictCodeEngine()
    : super(
        EntityDescriptor<SysDictCode, SysDictCodeTable>.fromServerpod(),
        auditService: const DbAuditService<SysDictCode>(type: 'dict_code'),
      );
}

class _DictDataEngine extends BaseEntityService<SysDictData, SysDictDataTable> {
  _DictDataEngine()
    : super(
        EntityDescriptor<SysDictData, SysDictDataTable>.fromServerpod(),
        auditService: const DbAuditService<SysDictData>(type: 'dict_data'),
      );
}

class SystemCrudEngines {
  SystemCrudEngines._();

  static BaseService<SysUser, SysUserTable>? _user;

  static BaseService<SysUser, SysUserTable> get user => _user ??= _UserEngine();

  static BaseService<SysDept, SysDeptTable>? _dept;

  static BaseService<SysDept, SysDeptTable> get dept => _dept ??= _DeptEngine();

  static BaseService<SysRole, SysRoleTable>? _role;

  static BaseService<SysRole, SysRoleTable> get role => _role ??= _RoleEngine();

  static BaseService<SysMenu, SysMenuTable>? _menu;

  static BaseService<SysMenu, SysMenuTable> get menu => _menu ??= _MenuEngine();

  static BaseService<SysDictCode, SysDictCodeTable>? _dictCode;

  static BaseService<SysDictCode, SysDictCodeTable> get dictCode =>
      _dictCode ??= _DictCodeEngine();

  static BaseService<SysDictData, SysDictDataTable>? _dictData;

  static BaseService<SysDictData, SysDictDataTable> get dictData =>
      _dictData ??= _DictDataEngine();
}

/// 分页参数的统一收敛规则。
///
/// ⚠️ **默认值与上限必须与被替换的旧代码逐字对齐**，否则回归必挂：
/// `UserService.getUserList` 是「`< 1` → 10，`> 100` → 100」，
/// 而 `QueryEngine` 内部是「`< 1` → 20，`> 200` → 200」。
/// 这里先按旧口径收敛，再交给 `QueryEngine`（此时不会再触发它自己的兜底）。
QueryDTO buildCrudQuery({
  int? page,
  int? pageSize,
  int defaultPageSize = 10,
  int maxPageSize = 100,
  List<QueryCondition>? filters,
  List<QuerySort>? sort,
  String? keyword,
}) {
  final rawPage = page ?? 1;
  final rawPageSize = pageSize ?? defaultPageSize;
  return QueryDTO(
    page: rawPage < 1 ? 1 : rawPage,
    pageSize: rawPageSize < 1
        ? defaultPageSize
        : (rawPageSize > maxPageSize ? maxPageSize : rawPageSize),
    filters: filters,
    sort: sort,
    keyword: keyword,
  );
}

/// 不分页的「全表」查询（带租户 + 软删过滤）。
///
/// 用于 role / dept / menu / dict 这类**历来返回全表**的列表接口
/// （前端自行切片 / 建树，服务端不分页）。
///
/// ⚠️ **为什么不复用 [BaseService.getList]**：那是**分页**语义 ——
/// `QueryEngine.pageQuery` 会拼 `limit` / `offset`，且 `pageSize` 有上限。
/// 这些资源的列表接口从来是全表返回，硬套会把它们**悄悄变成分页**（超限即截断）。
///
/// ⚠️ **但租户过滤同样会变严**：旧实现多写
/// `if (tenantId != null) filter &= t.tenantId.equals(tenantId)`，
/// 也就是**不传就不过滤**；这里一律按 `session.tenantId` 过滤，
/// 与 `BaseService` / `QueryEngine` 的口径统一。
Future<List<T>> findAllByEngine<T extends TableRow, TTable extends Table>(
  BaseService<T, TTable> engine,
  Session session, {
  /// [where] 交给调用方表达**额外的**过滤条件；**允许返回 `null`**
  /// （条件全为空时不必硬造一个恒真表达式）。
  Expression? Function(TTable table)? where,
  List<Column> Function(TTable table)? orderByList,
}) {
  final tenantId = engine.resolveTenantId(session);
  return engine.find(
    session,
    where: (t) {
      var filter = engine.tenantIdColumn(t).equals(tenantId);
      final deleted = engine.deletedColumn?.call(t);
      if (deleted != null) {
        filter = filter & deleted.equals(false);
      }
      final extra = where?.call(t);
      if (extra != null) {
        filter = filter & extra;
      }
      return filter;
    },
    orderByList: orderByList,
  );
}

/// `equal` 过滤条件。
QueryCondition condEq(String field, Object? value) =>
    QueryCondition(field: field, comparator: 'eq', value: value);

/// `like` 过滤条件。
///
/// ⚠️ 只传**裸值**：`QueryEngine` 内部会拼成 `LIKE '%value%'`（见
/// `query_engine.dart` 的 `_buildCondition`），自己再包一层 `%` 会变成
/// `%%value%%`，虽然结果通常相同，但别依赖这个巧合。
QueryCondition condLike(String field, String value) =>
    QueryCondition(field: field, comparator: 'like', value: value);

/// `in` 过滤条件（用于 `deptId` 的「本部门 + 所有子孙部门」这类集合过滤）。
QueryCondition condIn(String field, Iterable<Object?> values) =>
    QueryCondition(field: field, comparator: 'in', value: values.toList());

/// `between` 过滤条件。
QueryCondition condBetween(String field, Object start, Object end) =>
    QueryCondition(field: field, comparator: 'between', value: [start, end]);

/// 升序排序条件。
QuerySort sortAsc(String field) => QuerySort(field: field);

/// 降序排序条件。
QuerySort sortDesc(String field) => QuerySort(field: field, order: 'desc');

/// `CrudPage<T>` → RPC 侧的分页信封。
///
/// 契约：`data` 是**当前页数组**，`page` / `pageSize` / `totalPage` / `total`
/// 在**顶层**（前端 `useTable` 优先读顶层 `total`，不要塞进 data 里）。
///
/// [toJson] 由调用方决定用哪个序列化：
/// * `T.toJsonForProtocol()` —— **不含** `serverOnly` 字段（如 `SysUser.password`），
///   业务 Service 的既有用法都是这个；
/// * `T.toJson()` —— 含 `serverOnly`，只在服务端内部用，**不要直接返回给前端**。
PageResponse<Map<String, dynamic>> crudPageResponse<T extends TableRow>(
  CrudPage<T> page,
  Map<String, dynamic> Function(T item) toJson,
) {
  return PageResponse<Map<String, dynamic>>.success(
    page.data.map(toJson).toList(growable: false),
    page: page.page,
    pageSize: page.pageSize,
    total: page.total,
  );
}

/// 把引擎抛出的异常转回 RPC 的失败信封。
///
/// `BaseService` 的失败语义是**抛异常**（`StateError` / `QueryValidationException`），
/// 而现有 Service 一律**返回 `CommonResponse.failed`**。收敛时必须在调用点包住，
/// 否则 typed Endpoint 会把异常冒泡成 500，前端拿到的就不是 `{code, message}` 了。
///
/// 用法：
/// ```dart
/// try {
///   final updated = await SystemCrudEngines.user.update(session, user);
///   return CommonResponse.success(updated.copyWith(password: null));
/// } catch (e) {
///   return crudFailure('更新用户失败：', e);
/// }
/// ```
CommonResponse crudFailure(String prefix, Object error) =>
    CommonResponse.failed('$prefix$error');
