import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/src/extensions/session_extension.dart';
import 'package:serverpod_crud/src/models/query/query_dto.dart';

import '../audit/audit_log.dart';
import '../audit/audit_service.dart';
import '../core/crud_models.dart';
import '../core/crud_types.dart';
import '../query/query_engine.dart';
import '../runtime/crud_runtime.dart';
import '../validation/validator.dart';
import 'crud_service.dart';

/// Serverpod ORM 适配器。
///
/// 将模型 `db` 静态方法统一包装为可注入函数，便于通用 CRUD 复用。
class ServerpodCrudAdapter<T extends TableRow, TTable extends Table> implements SerializableModel{
  const ServerpodCrudAdapter({
    required this.idColumn,
    required this.tenantIdColumn,
    required this.deletedColumn,
    required this.getId,
    required this.setTenantId,
    required this.setDeleted,
    required this.insertRow,
    required this.updateRow,
    required this.findFirstRow,
    required this.find,
    required this.deleteWhere,
    required this.count,
    required this.table,
  });

  factory ServerpodCrudAdapter.fromDb({
    required dynamic db,
    required TTable table,
    required ColumnInt Function(TTable table) idColumn,
    required ColumnInt Function(TTable table) tenantIdColumn,
    required ColumnBool? Function(TTable table)? deletedColumn,
    required int? Function(T model) getId,
    required void Function(T model, int tenantId) setTenantId,
    required void Function(T model, bool deleted)? setDeleted,
  }) {
    return ServerpodCrudAdapter<T, TTable>(
      idColumn: idColumn,
      tenantIdColumn: tenantIdColumn,
      deletedColumn: deletedColumn,
      getId: getId,
      setTenantId: setTenantId,
      setDeleted: setDeleted,
      insertRow: (session, row) => db.insertRow(session, row) as Future<T>,
      updateRow: (session, row) => db.updateRow(session, row) as Future<T>,
      findFirstRow: (session, {where}) => db.findFirstRow(session, where: where) as Future<T?>,
      find: (session, {where, limit, offset, orderBy, orderDescending = false, orderByList}) =>
          db.find(
            session,
            where: where,
            limit: limit,
            offset: offset,
            orderBy: orderBy,
            orderDescending: orderDescending,
            orderByList: orderByList,
          ) as Future<List<T>>,
      deleteWhere: (session, {required where}) => db.deleteWhere(session, where: where) as Future<List<T>>,
      count: (session, {where}) => db.count(session, where: where) as Future<int>,
      table: table,
    );
  }

  final ColumnInt Function(TTable table) idColumn;
  final ColumnInt Function(TTable table) tenantIdColumn;
  final ColumnBool? Function(TTable table)? deletedColumn;

  final int? Function(T model) getId;
  final void Function(T model, int tenantId) setTenantId;
  final void Function(T model, bool deleted)? setDeleted;

  final InsertRow<T> insertRow;
  final UpdateRow<T> updateRow;
  final FindFirstRow<T, TTable> findFirstRow;
  final FindRows<T, TTable> find;
  final DeleteWhere<T, TTable> deleteWhere;
  final CountRows<T, TTable> count;

  final TTable table;
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'idColumn': idColumn.toString(),
      'tenantIdColumn': tenantIdColumn.toString(),
      'deletedColumn': deletedColumn?.toString(),
      'getId': getId.toString(),
      'setTenantId': setTenantId.toString(),
      'setDeleted': setDeleted?.toString(),
      'table': table.toString(),
    };
  }
}

/// 实体描述对象。
///
/// 用于聚合：数据库适配器、字段映射、关键词字段、字段别名与租户解析策略。
class EntityDescriptor<T extends TableRow, TTable extends Table> implements SerializableModel{
  const EntityDescriptor({
    required this.adapter,
    required this.columnMap,
    this.keywordColumns,
    this.fieldAliases = const {},
    this.resolveTenantId,
  });

  factory EntityDescriptor.fromDb({
    required dynamic db,
    required TTable table,
    required ColumnInt Function(TTable table) idColumn,
    required ColumnInt Function(TTable table) tenantIdColumn,
    required ColumnBool? Function(TTable table)? deletedColumn,
    required int? Function(T model) getId,
    required void Function(T model, int tenantId) setTenantId,
    required void Function(T model, bool deleted)? setDeleted,
    required Map<String, Column Function(TTable table)> columnMap,
    KeywordColumns<TTable>? keywordColumns,
    Map<String, String> fieldAliases = const {},
    int Function(Session session)? resolveTenantId,
  }) {
    return EntityDescriptor<T, TTable>(
      adapter: ServerpodCrudAdapter<T, TTable>.fromDb(
        db: db,
        table: table,
        idColumn: idColumn,
        tenantIdColumn: tenantIdColumn,
        deletedColumn: deletedColumn,
        getId: getId,
        setTenantId: setTenantId,
        setDeleted: setDeleted,
      ),
      columnMap: columnMap,
      keywordColumns: keywordColumns,
      fieldAliases: fieldAliases,
      resolveTenantId: resolveTenantId,
    );
  }

  final ServerpodCrudAdapter<T, TTable> adapter;
  final Map<String, Column Function(TTable table)> columnMap;
  final KeywordColumns<TTable>? keywordColumns;
  final Map<String, String> fieldAliases;
  final int Function(Session session)? resolveTenantId;
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'adapter': adapter
          .toJson(), // Assumes ServerpodCrudAdapter also implements toJson().
      'columnMap': columnMap.map((key, value) => MapEntry(key, value.toString())),
      'keywordColumns': keywordColumns, // nullable, if null will stay null
      'fieldAliases': fieldAliases,
      // Cannot serialize resolveTenantId function, so just store its presence.
      'hasResolveTenantId': resolveTenantId != null,
    };
  }
}

/// 实体服务基类：基于 [EntityDescriptor] 自动装配 BaseService。
abstract class BaseEntityService<T extends TableRow, TTable extends Table> extends BaseService<T, TTable> {
  BaseEntityService(EntityDescriptor<T, TTable> descriptor, {super.runtime, super.auditService})
    : super.fromAdapter(
        adapter: descriptor.adapter,
        columnMap: descriptor.columnMap,
        keywordColumns: descriptor.keywordColumns,
        fieldAliases: descriptor.fieldAliases,
        resolveTenantId: descriptor.resolveTenantId,
      );
}

/// 审计字段策略：用于在创建/更新前自动填充审计字段。
abstract class AuditFieldStrategy<T extends TableRow> {
  const AuditFieldStrategy();

  void applyOnCreate(T model, Session session) {}
  void applyOnUpdate(T model, Session session) {}
}


/// CRUD 业务编排基类。
///
/// 封装 create/update/delete/get/list/query 等通用流程，
/// 并提供 before/after 钩子、校验器、审计服务、运行时插件扩展。
/// 
/// BaseService（base_service.dart）是干什么的？
// 它是业务层骨架，在 CrudService 之上加“流程控制”：
// 内部持有 _crud，实际数据库 CRUD 还是交给它
// 增加 before/after 钩子（beforeCreate、afterUpdate、beforeDelete 等）
// 增加 数据校验（validator）
// 增加 审计日志（auditService + AuditLog）
// 增加 审计字段填充策略（AuditFieldStrategy）
// 增加 动态查询能力（QueryEngine、QueryDTO/QueryCriteria）
// 提供 fromAdapter、EntityDescriptor、BaseEntityService 让实体接入更统一
// 一句话：把 CRUD 串成完整业务流程，可扩展、可审计、可校验。
class BaseService<T extends TableRow, TTable extends Table> {

  final ColumnInt Function(TTable table) idColumn;
  final ColumnInt Function(TTable table) tenantIdColumn;
  final ColumnBool? Function(TTable table)? deletedColumn;

  final int? Function(T model) getId;
  final void Function(T model, int tenantId) setTenantId;
  final void Function(T model, bool deleted)? setDeleted;

  final InsertRow<T> insertRow;
  final UpdateRow<T> updateRow;
  final FindFirstRow<T, TTable> findFirstRow;
  final FindRows<T, TTable> find;
  final DeleteWhere<T, TTable> deleteWhere;
  final CountRows<T, TTable> count;

  final TTable table;
  final Map<String, Column Function(TTable table)> columnMap;
  final KeywordColumns<TTable>? keywordColumns;
  final Map<String, String> fieldAliases;
  final AuditFieldStrategy<T>? auditFieldStrategy;
  final Validator<T>? validator;
  final AuditService<T> auditService;
  final CrudRuntime runtime;

  final int Function(Session session)? _resolveTenantId;
  final CrudService<T, TTable> _crud;
  
  BaseService({
    required this.idColumn,
    required this.tenantIdColumn,
    required this.deletedColumn,
    required this.getId,
    required this.setTenantId,
    required this.setDeleted,
    required this.insertRow,
    required this.updateRow,
    required this.findFirstRow,
    required this.find,
    required this.deleteWhere,
    required this.count,
    required this.table,
    required this.columnMap,
    this.keywordColumns,
    this.fieldAliases = const {},
    this.auditFieldStrategy,
    this.validator,
    AuditService<T>? auditService,
    int Function(Session session)? resolveTenantId,
    CrudRuntime? runtime,
  }) : auditService = auditService ?? NoopAuditService<T>(),
       _resolveTenantId = resolveTenantId,
       runtime = runtime ?? CrudRuntime(),
       _crud = CrudService<T, TTable>(
         idColumn: idColumn,
         tenantIdColumn: tenantIdColumn,
         deletedColumn: deletedColumn,
         getId: getId,
         setTenantId: setTenantId,
         setDeleted: setDeleted,
         resolveTenantId: resolveTenantId ?? _defaultResolveTenantId,
         insertRow: insertRow,
         updateRow: updateRow,
         findFirstRow: findFirstRow,
         find: find,
         deleteWhere: deleteWhere,
         count: count,
       );

  BaseService.fromAdapter({
    required ServerpodCrudAdapter<T, TTable> adapter,
    required this.columnMap,
    this.keywordColumns,
    this.fieldAliases = const {},
    this.auditFieldStrategy,
    this.validator,
    AuditService<T>? auditService,
    int Function(Session session)? resolveTenantId,
    CrudRuntime? runtime,
  }) : auditService = auditService ?? NoopAuditService<T>(),
       idColumn = adapter.idColumn,
       tenantIdColumn = adapter.tenantIdColumn,
       deletedColumn = adapter.deletedColumn,
       getId = adapter.getId,
       setTenantId = adapter.setTenantId,
       setDeleted = adapter.setDeleted,
       insertRow = adapter.insertRow,
       updateRow = adapter.updateRow,
       findFirstRow = adapter.findFirstRow,
       find = adapter.find,
       deleteWhere = adapter.deleteWhere,
       count = adapter.count,
       table = adapter.table,
       _resolveTenantId = resolveTenantId,
       runtime = runtime ?? CrudRuntime(),
       _crud = CrudService<T, TTable>(
         idColumn: adapter.idColumn,
         tenantIdColumn: adapter.tenantIdColumn,
         deletedColumn: adapter.deletedColumn,
         getId: adapter.getId,
         setTenantId: adapter.setTenantId,
         setDeleted: adapter.setDeleted,
         resolveTenantId: resolveTenantId ?? _defaultResolveTenantId,
         insertRow: adapter.insertRow,
         updateRow: adapter.updateRow,
         findFirstRow: adapter.findFirstRow,
         find: adapter.find,
         deleteWhere: adapter.deleteWhere,
         count: adapter.count,
       );



  /// 解析当前会话的租户ID（支持运行时动态调整）。
  ///
  /// 优先使用自定义解析函数（如有传入），否则采用默认解析逻辑：
  /// - 若 session.userObject 内有 targetTenantId（平台超管用动态切换租户），则优先返回；
  /// - 否则从登录态 scopes 中解析租户ID（scope: tenantId:<id>）；
  /// - 若都无法解析，则默认返回 0。
  int resolveTenantId(Session session) {
    return _resolveTenantId?.call(session) ?? _defaultResolveTenantId(session);
  }
      

  /// 默认租户ID解析逻辑（适用于无自定义多租户场景）。
  ///
  /// 实现详情：
  /// - 先检查 session.userObject 是否存在目标租户ID（如 targetTenantId 字段）；
  /// - 若未设置，则遍历认证信息（session.authenticated.scopes）查找形如 tenantId:<id> 的 scope 并解析为租户ID；
  /// - 若未能解析到有效租户ID，最终返回 0。
  static int _defaultResolveTenantId(Session session) {
    final auth = session.authenticated;
    if (auth == null) return 0;

    // 优先读取临时设置的目标租户（平台超管用）
    if (session.targetTenantId != null && session.targetTenantId! > 0) {
      return session.targetTenantId!;
    }

    // 否则读取登录态租户
    return session.tenantId;
  }

  ColumnResolver<TTable> get resolveColumn => (t, field) => columnMap[field]?.call(t);

  /// 创建前拦截点、可用于后续扩展数据权限策略。
  Future<void> beforeCreate(Session session, T data) async {}

  /// 创建后拦截点、可用于后续扩展数据权限策略。
  Future<void> afterCreate(Session session, T data, T created) async {}

  /// 更新前拦截点、可用于后续扩展数据权限策略。
  Future<void> beforeUpdate(Session session, T data) async {}
  
  /// 更新后拦截点、可用于后续扩展数据权限策略。
  Future<void> afterUpdate(Session session, T data, T updated) async {}
  
  /// 删除前拦截点、可用于后续扩展数据权限策略。
  Future<void> beforeDelete(Session session, int id) async {}
  
  /// 删除后拦截点、可用于后续扩展数据权限策略。
  Future<void> afterDelete(Session session, int id) async {}

  /// 查询前拦截点、可用于后续扩展数据权限策略。
  Future<void> beforeQuery(Session session, QueryDTO query) async {}


  
  /// 创建实体数据的通用流程：
  /// 1. 数据校验（如有配置 validator）。
  /// 2. 自动审计字段填充（如 auto 录入创建时间、创建人等）。
  /// 3. 触发 beforeCreate 钩子供业务扩展。
  /// 4. 真正持久化（CRUD层操作）。
  /// 5. 触发 afterCreate 钩子供业务扩展。
  /// 6. 记录审计日志（如有配置 auditService）。
  /// - 若校验失败，则抛出异常并直接返回。
  Future<T> create(Session session, T data) async {
    // 校验阶段：如配置了 validator 则做数据校验
    final validationResult = validator?.validate(data);
    if (validationResult != null && !validationResult.isValid) {
      // 校验失败时抛出首条错误信息，阻断创建流程
      throw StateError(validationResult.errors.first.message);
    }

    // 自动填充审计类字段（如创建人/创建时间等, 取决于实现）
    auditFieldStrategy?.applyOnCreate(data, session);

    // 创建前业务扩展钩子，可覆写实现业务自定义逻辑/副作用
    await beforeCreate(session, data);

    // 实际创建数据。转交给持有的 CrudService 负责底层 DB 写入
    final created = await _crud.create(session, data);

    // 创建后业务扩展钩子。可用于额外处理如发送通知等
    await afterCreate(session, data, created);

    final time = DateTime.now();
    // 构建审计日志对象，action 为 create，记录创建后的数据
    // 操作类型为创建、当前时间、获取主键。注意外部要实现 getId、变更后数据记录
    final audit = AuditLog(action: AuditAction.create, timestamp: time, entityId: getId(created), after: created);

    // 持久化审计日志（如 auditService 为 NoopAuditService 则为无操作）
    await auditService.record(session, audit);

    // 返回新创建的数据
    return created;
  }





  /// 更新实体数据的通用流程：
  /// 1. 数据校验（如有配置 validator）；
  /// 2. 自动审计字段填充（如更新人/更新时间等，可选）；
  /// 3. 触发 beforeUpdate 钩子，业务可扩展/自定义副作用；
  /// 4. 实际数据更新，委托 CrudService 完成 DB 写入；
  /// 5. 触发 afterUpdate 钩子，可用于额外二次处理；
  /// 6. 记录审计日志（如有配置 auditService）。
  /// - 若数据校验失败，则抛出首条错误，直接阻断更新流程。
  Future<T> update(Session session, T data) async {
    // 校验阶段：如 validator 存在，先进行数据校验
    final validationResult = validator?.validate(data);
    if (validationResult != null && !validationResult.isValid) {
      // 校验失败时抛出首条错误信息，阻断更新流程
      throw StateError(validationResult.errors.first.message);
    }
    // 自动填充更新相关审计字段（如更新时间、更新人等，具体依赖于实现）
    auditFieldStrategy?.applyOnUpdate(data, session);

    // 更新前业务扩展钩子，可覆写实现自定义逻辑/副作用
    await beforeUpdate(session, data);
    // 实际更新数据，通过 _crud.update 委托底层持久化（DB 操作）
    final updated = await _crud.update(session, data);

    // 更新后业务扩展钩子，可供业务层做二次处理
    await afterUpdate(session, data, updated);

    // 构建审计日志对象，action 为 create，记录创建后的数据
    // 操作类型为创建、操作时、主键标识。注意外部要实现 getId、变更后数据记录
    final time = DateTime.now();
    final audit = AuditLog(action: AuditAction.update, timestamp: time, entityId: getId(updated), after: updated);

    // 持久化审计日志（如 auditService 为 NoopAuditService 则为无操作）
    await auditService.record(session, audit);


    // 返回更新后的实体数据
    return updated;
  }





  /// 删除指定主键（id）对应实体的通用流程：
  /// 1. 调用 beforeDelete 钩子（可扩展实现删除前的业务逻辑，如权限校验、业务前置检查等）；
  /// 2. 委托底层 _crud.delete 方法执行实际的持久化删除操作（如软删、真删等）
  ///    - 返回被删除的实体对象（如记录不存在可为 null）；
  /// 3. 调用 afterDelete 钩子（可供业务扩展，如后续清理、异步任务等）；
  /// 4. 构建删除操作的审计日志 AuditLog，并通过 auditService 进行持久化记录
  ///    - 包含删除时间、动作类型、主键ID、删除前的实体快照等信息
  /// 5. 返回被删除的实体对象（可为 null）。
  ///
  /// - [session] 当前 Serverpod 会话对象
  /// - [id]      实体主键 ID
  /// - 返回值：删除前的实体对象（若未找到则为 null）
  Future<T?> delete(Session session, int id) async {
    // 1. 删除前扩展钩子（可自定义预处理/副作用）
    await beforeDelete(session, id);

    // 2. 执行实际删除，返回删除前的实体数据（如未找到则为 null）
    final deleted = await _crud.delete(session, id);

    // 3. 删除后扩展钩子（可自定义二次处理/联动逻辑）
    await afterDelete(session, id);

    // 4. 生成并记录审计日志，action为delete，记录时间、ID、删除前数据
    final time = DateTime.now();
    final audit = AuditLog(action: AuditAction.delete, timestamp: time, entityId: id, after: deleted);

    // 5. 持久化审计日志（如 auditService 为 NoopAuditService 则为无操作）
    await auditService.record(session, audit);

    // 6. 返回删除前的实体数据，如果未查到则为null
    return deleted;
  }


  /// 批量删除实体的通用流程
  /// 
  /// 功能说明：
  /// - 支持传入一组主键ID，自动过滤无效ID（<=0），对每个ID按顺序执行删除前、删除操作及扩展钩子，并记录审计日志。
  /// - 支持软删/真删，由底层 _crud.deleteBatch 实现。
  /// - 每次批量调用会记录批量处理的总数、成功删除数量、未找到（删除失败）数量等信息。
  ///
  /// 参数说明：
  /// - [session] 当前Serverpod会话对象
  /// - [ids]     要批量删除的主键列表（如存在重复会自动去重，只保留大于0的id）
  ///
  /// 主要处理步骤为：
  /// 1. 过滤、去重无效/重复ID（只保留>0的唯一主键）；
  /// 2. 按ID顺序依次调用 beforeDelete 钩子（允许业务预处理/扩展）；
  /// 3. 一次性批量查询所有实体数据（用于审计日志记录）；
  /// 4. 调用底层 _crud.deleteBatch 执行批量删除，并统计实际删除成功的数量；
  /// 5. 针对每个ID，依次调用 afterDelete 钩子及记录对应的审计日志（AuditLog），包含删除前的完整数据；
  /// 6. 最终返回 CrudBatchResult，含有效ID总数、成功数量、未找到数量等。
  ///
  /// 返回值：
  ///   [CrudBatchResult] - 记录增删影响数等统计
  Future<CrudBatchResult> deleteBatch(Session session, List<int> ids) async {
    // 步骤1：过滤非法id（≤0），并去重后生成最终待删除的主键列表
    final normalizedIds = ids.where((id) => id > 0).toSet().toList();
    // 若过滤后无有效ID，则直接返回空结果
    if (normalizedIds.isEmpty) {
      return const CrudBatchResult(total: 0, successCount: 0, notFoundCount: 0);
    }

    // 步骤2：所有ID都依次调用删除前钩子，如权限校验、级联校验等扩展流程
    for (final id in normalizedIds) {
      await beforeDelete(session, id);
    }

    // 步骤3：一次性批量查询所有实体的完整数据（用于审计日志记录），避免 N+1 查询问题
    final entitiesBeforeDelete = await _crud.find(session, where: (t) => _crud.idColumn(t).inSet(normalizedIds.toSet()));
    final entitiesMap = {for (var e in entitiesBeforeDelete) _crud.getId(e): e};

    // 步骤4：批量执行底层物理删除或软删除（取决于_crud配置）。
    // 若为物理删除，则直接从数据库移除；若为软删除，则仅更新删除标记（如 deleted 字段）。
    // 实际的删除逻辑由 _crud.deleteBatch 决定，两种情形均返回成功删除的ID列表。
    final successIds = await _crud.deleteBatch(session, normalizedIds);
    final successIdSet = successIds.toSet();
    final failedIds = normalizedIds.where((id) => !successIdSet.contains(id)).toList();

    // 步骤5：仅对成功删除条目执行删后钩子，并记录删除审计日志（包含删除前的完整数据）
    // 为整个批量删除操作生成唯一的 traceId，确保所有删除记录关联到同一链路
    final batchTraceId = 'audit-batch-${DateTime.now().microsecondsSinceEpoch}';
    for (final id in successIds) {
      // 扩展删除后逻辑，如同步清理、异步操作等
      await afterDelete(session, id);

      // 构造并持久化一条审计日志（AuditAction.delete），记录删除行为及删除前的完整实体数据
      final time = DateTime.now();
      final deletedEntity = entitiesMap[id];
      final audit = AuditLog<T>(action: AuditAction.delete, timestamp: time, traceId: batchTraceId, entityId: id, after: deletedEntity);

      // 持久化审计日志（如 auditService 为 NoopAuditService 则为无操作）
      await auditService.record(session, audit);
    }
    // 步骤6：统计结果，total为参与的有效id数量，successCount为实际删除成功的，notFoundCount为未找到的（或无效id数）
    return CrudBatchResult(total: normalizedIds.length, successCount: successIds.length, notFoundCount: failedIds.length, successIds: successIds, failedIds: failedIds);
  }



  /// 查询并返回指定主键的实体详情（按单表主键查找）
  ///
  /// - [session]: 当前的 Serverpod 会话对象
  /// - [id]: 实体主键 ID
  ///
  /// 实现说明：
  /// - 支持多租户模型，会自动按租户过滤，仅返回当前会话所属租户的数据。
  /// - 如果启用软删除（soft delete），则不会返回已标记为删除的记录。
  /// - 若未找到对应数据，则返回 null。
  ///
  /// 返回值：[T?] 查询到的实体对象或 null。
  Future<T?> get(Session session, int id) {
    return _crud.get(session, id);
  }

  
  
  /// 分页查询实体数据的核心方法
  ///
  /// 功能说明：
  /// - 支持标准分页、灵活过滤、排序、多租户、软删除等复杂场景。
  /// - 前端传入统一的分页查询DTO，方法内会自动传递各种表/字段/租户信息给底层引擎。
  /// - 返回包含数据及分页信息的 [CrudPage<T>] 结果集。
  ///
  /// 参数说明：
  /// - [session]: 当前会话（含用户/租户上下文等信息）
  /// - [query]: 分页/过滤/排序等全部查询条件（已由Mapper统一映射为QueryDTO）
  ///
  /// 执行流程：
  /// 1. 可选的查询前钩子 [beforeQuery]，供子类扩展预处理
  /// 2. 调用 [QueryEngine.pageQuery] 执行分页（Table/列配置及上下文全部托管完成）
  /// 3. 返回封装好的分页结果
  Future<CrudPage<T>> getList(Session session, QueryDTO query) async {
    // 步骤1：查询前钩子，允许子类注入前置逻辑（如追加条件、权限校验等）
    await beforeQuery(session, query);

    // 步骤2：调用底层查询引擎，自动处理分页、过滤、排序、多租户、软删除等
    return QueryEngine.pageQuery<T, TTable>(
      session: session,                    // Serverpod会话上下文
      query: query,                        // 分页+过滤+排序等整体查询描述
      table: table,                        // 当前实体关联的SQL表对象
      tenantIdColumn: tenantIdColumn,      // 多租户主键字段（如支持租户隔离）
      resolveTenantId: resolveTenantId,    // 动态租户ID解析函数（如有特殊需求）
      resolveColumn: resolveColumn,        // 字段名<->列名映射（如表/字段别名支持）
      fieldAliases: fieldAliases,          // 便捷的别名扩展（如对前端的友好字段映射）
      find: find,                          // 自定义单条查找函数（如需自定义查找逻辑）
      count: count,                        // 自定义计数函数（如做聚合优化）
      deletedColumn: deletedColumn,        // 软删除标记字段（如存在逻辑删除需求）
      keywordColumns: keywordColumns,      // 支持关键字检索的字段列表（如全文检索等）
      runtime: runtime,                    // 查询运行时上下文（如用于审计trace扩展等）
    );
  }
}

