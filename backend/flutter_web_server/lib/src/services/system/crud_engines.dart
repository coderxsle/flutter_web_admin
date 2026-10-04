import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import 'db_audit_service.dart';

/// 系统资源的 CRUD 引擎：6 个资源各一个 [BaseEntityService] 子类，外加 lazy 取用入口
/// [SystemCrudEngines]。
///
/// 业务 Service 一律通过 [SystemCrudEngines] 拿引擎，不再直接写 `SysXxx.db.*` ——
/// 租户隔离、软删、审计、校验、分页全部交给 `BaseService`。
///
/// ## 两条必须遵守的约定
///
/// 1. **引擎必须 lazy**，不能改写成 `static final`。构造函数会执行
///    [EntityDescriptor.fromServerpod]，它要读 `Serverpod.instance.serializationManager`
///    反查表结构；类加载时 `Serverpod.instance` 可能还没就绪，`static final` 会在
///    类加载时直接崩。
/// 2. **审计必须显式注入**。[BaseService] 的 `auditService` 默认是
///    `NoopAuditService`（不落库，只在首次丢弃时打一条 warning），不传就等于
///    `create` / `update` / `delete` / `deleteBatch` 全都没有审计。每个引擎传一个
///    [DbAuditService]，`type` 取名与资源/表一致，写入 `sys_operate_log`；`write`
///    内部整段 `try/catch`，写日志失败不影响业务。
class _UserEngine extends BaseEntityService<SysUser, SysUserTable> {
  _UserEngine()
    : super(
        // keywordFields：`?keyword=` 的 OR 命中字段（前端单搜索框用，filters 表达不了 OR）。
        // ⚠️ 必须是 ColumnString，否则 fromServerpod 抛 ArgumentError。
        EntityDescriptor<SysUser, SysUserTable>.fromServerpod(keywordFields: const ['username', 'nickname', 'phone']),
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

/// 6 个系统资源引擎的 lazy 取用入口。
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

  static BaseService<SysDictCode, SysDictCodeTable> get dictCode => _dictCode ??= _DictCodeEngine();

  static BaseService<SysDictData, SysDictDataTable>? _dictData;

  static BaseService<SysDictData, SysDictDataTable> get dictData => _dictData ??= _DictDataEngine();
}

/// 不分页的「全表」查询（带租户 + 软删过滤）。
///
/// 用于 role / dept / menu / dict 这类**历来返回全表**的列表接口
/// （前端自行切片 / 建树，服务端不分页）。
///
/// ⚠️ **不要换成 [BaseService.getList]**：那是**分页**语义 ——
/// `QueryEngine.pageQuery` 会拼 `limit` / `offset`，且 `pageSize` 有上限，
/// 硬套会把全表返回**悄悄变成分页**（超限即截断）。
///
/// 租户一律按 `session.tenantId` 过滤，与 `BaseService` / `QueryEngine` 口径一致 ——
/// 没有「不传就不过滤」这条旧口径。
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
