import 'package:serverpod/serverpod.dart';

import '../core/crud_types.dart';

/// 纯数据访问层 CRUD 服务。
///
/// 负责底层数据库操作与租户/软删约束，
/// 不处理审计、校验、业务钩子（这些在 BaseService 层）。
/// 通用 CRUD Service
///
/// 通过传入表结构与字段选择器，统一处理：
/// - 租户隔离（tenantId）
/// - 软删除（deleted）
/// - 基础 CRUD
class CrudService<T extends TableRow, TTable extends Table> {
  CrudService({
    required this.idColumn,
    required this.tenantIdColumn,
    required this.getId,
    required this.setTenantId,
    required this.resolveTenantId,
    required this.insertRow,
    required this.updateRow,
    required this.findFirstRow,
    required this.find,
    required this.deleteWhere,
    required this.count,
    this.deletedColumn,
    this.setDeleted,
  }) : enableSoftDelete = deletedColumn != null && setDeleted != null;

  final ColumnInt Function(TTable table) idColumn; // 主键列选择器
  final ColumnInt Function(TTable table) tenantIdColumn; // 租户ID列选择器
  final ColumnBool? Function(TTable table)? deletedColumn; // 软删除标志位列选择器（可选）

  final int? Function(T model) getId; // 从实体获取主键ID
  final void Function(T model, int tenantId) setTenantId; // 设置实体的租户ID
  final void Function(T model, bool deleted)? setDeleted; // 设置软删除状态（可空）
  final int Function(Session session) resolveTenantId; // 从会话解析租户ID
  final bool enableSoftDelete; // 是否启用软删除

  final InsertRow<T> insertRow; // 插入数据的方法
  final UpdateRow<T> updateRow; // 更新数据的方法
  final FindFirstRow<T, TTable> findFirstRow; // 查找首条数据的方法
  final FindRows<T, TTable> find; // 批量查找数据的方法
  final DeleteWhere<T, TTable> deleteWhere; // 条件删除数据的方法
  final CountRows<T, TTable> count; // 计数方法

  /// 创建（插入）实体数据。
  ///
  /// 功能说明：
  /// - 将指定的实体 [data] 写入数据库，为其设置正确的租户ID（支持多租户模型）。
  /// - 如果开启软删除，则确保创建时 [`deleted`] 字段为 false（即非删除状态）。
  /// - 最终调用底层 insertRow 执行实际的插入操作。
  ///
  /// 参数说明：
  /// - [session] 当前 Serverpod 会话对象（用于获取租户等上下文信息）
  /// - [data]    要插入的实体数据对象（会自动补全租户ID、软删除等字段）
  ///
  /// 返回值：
  /// - 返回数据库实际插入后的实体对象（含主键等数据库补齐字段）
  Future<T> create(Session session, T data) async {
    final tenantId = resolveTenantId(session);
    setTenantId(data, tenantId);
    if (enableSoftDelete) {
      setDeleted?.call(data, false);
    }
    return insertRow(session, data);
  }

  /// 更新（修改）实体数据。
  ///
  /// 功能说明：
  /// - 根据传入的数据对象 [data]，对数据库中已存在的数据进行更新操作。
  /// - 首先依据其主键及租户ID查找当前存储的实体，确保目标数据确实存在且未被软删除（如果启用软删除）。
  /// - 如找不到实体或实体已被删除，则抛出异常终止操作，防止误更新。
  /// - 会自动设置实体的租户ID（多租户支持）。
  /// - 如启用软删除，更新时自动确保 `deleted` 字段为 `false`（即更新必为非删除状态）。
  /// - 最终调用底层 `updateRow` 执行实际的数据库更新操作。
  ///
  /// 参数说明：
  /// - [session] 当前 Serverpod 会话对象（用于获取租户等上下文信息）
  /// - [data]    要更新的实体对象（需包含主键ID和完整内容）
  ///
  /// 返回值：
  /// - 返回数据库实际更新后的实体对象（如无异常则必为最新状态）
  ///
  /// 抛出异常：
  /// - 若未传主键或目标数据不存在/已被软删除，则抛出 [StateError]
  Future<T> update(Session session, T data) async {
    final tenantId = resolveTenantId(session);
    final id = getId(data);
    if (id == null) {
      throw StateError('更新失败：缺少主键');
    }

    final existing = await findFirstRow(
      session,
      where: (t) {
        var filter =
            idColumn(t).equals(id) & tenantIdColumn(t).equals(tenantId);
        if (enableSoftDelete) {
          filter = filter & deletedColumn!(t)!.equals(false);
        }
        return filter;
      },
    );

    if (existing == null) {
      throw StateError('更新失败：数据不存在或已被删除');
    }

    setTenantId(data, tenantId);
    if (enableSoftDelete) {
      setDeleted?.call(data, false);
    }

    return updateRow(session, data);
  }

  /// 根据主键ID删除指定数据记录。
  ///
  /// 支持物理删除和软删除两种模式，自动依据配置切换：
  /// - 物理删除：若未启用软删除功能，直接从数据库中物理移除目标实体；
  /// - 软删除：若启用软删除，仅将目标实体的 `deleted` 字段标记为 `true`，实际数据仍保留。
  ///
  /// 处理流程：
  /// - 首先按主键ID和当前租户ID查找目标实体（如无匹配，返回null，不做任何操作）。
  /// - 物理删除时，查找成功则直接移除数据，并返回被删除的实体内容。
  /// - 软删除时，需确认目标数据目前未被标记删除，再设置 `deleted` 字段为 `true` 后写回数据库，返回其新状态。
  ///
  /// 参数:
  /// - [session] 当前Serverpod会话对象（用于获取多租户上下文等信息）
  /// - [id]      要删除的数据主键ID
  ///
  /// 返回:
  /// - 被删除或软删的实体对象。如未找到有效数据则返回null。
  Future<T?> delete(Session session, int id) async {
    final tenantId = resolveTenantId(session);

    if (!enableSoftDelete) {
      final existing = await findFirstRow(
        session,
        where: (t) =>
            idColumn(t).equals(id) & tenantIdColumn(t).equals(tenantId),
      );
      if (existing == null) return null;
      await deleteWhere(
        session,
        where: (t) =>
            idColumn(t).equals(id) & tenantIdColumn(t).equals(tenantId),
      );
      return existing;
    }

    final existing = await findFirstRow(
      session,
      where: (t) =>
          idColumn(t).equals(id) &
          tenantIdColumn(t).equals(tenantId) &
          deletedColumn!(t)!.equals(false),
    );

    if (existing == null) {
      return null;
    }

    setDeleted?.call(existing, true);
    await updateRow(session, existing);
    return existing;
  }

  /// 批量删除数据记录的通用方法。
  ///
  /// 用途说明：
  /// - 支持通过一组主键ID，批量进行实体的删除操作。
  /// - 针对软删除和物理删除分别处理：如开启软删除，则实际为“批量标记删除”；否则直接真正删除。
  /// - 会自动剔除非法或重复的ID（仅保留大于0且唯一的主键）。
  /// - 返回值为本次操作成功删除/软删的实体主键ID集合（如没有可删除记录则返回空列表）。
  ///
  /// 具体流程：
  /// 1. 过滤非法/重复ID，仅保留>0的唯一主键。
  /// 2. 非软删模式下，按租户批量“物理删除”记录；返回所有真正删除的主键ID。
  /// 3. 软删模式下，先拿到所有有效未删除记录，对每条逐条设置deleted标记并更新。
  /// 4. 返回本次批量操作实际成功处理的实体ID（可能部分或全部未命中）。
  ///
  /// 参数:
  /// - [session]  当前Serverpod会话对象
  /// - [ids]      待删除的主键ID列表（允许包含非法/重复，会自动规整）
  ///
  /// 返回:
  ///   `List<int>`  实际成功删除（或标记为已删除）的主键ID列表
  Future<List<int>> deleteBatch(Session session, List<int> ids) async {
    // 1. 预处理ID集合，只保留大于0且唯一的ID
    final normalizedIds = ids.where((id) => id > 0).toSet();
    if (normalizedIds.isEmpty) return const [];

    // 2. 获取当前租户ID
    final tenantId = resolveTenantId(session);

    // 3. 物理删除流程（未开启软删除时直接删除）
    if (!enableSoftDelete) {
      final deletedRows = await deleteWhere(
        session,
        where: (t) =>
            idColumn(t).inSet(normalizedIds) &
            tenantIdColumn(t).equals(tenantId),
      );
      // 返回已删除实体的主键ID集合
      return deletedRows.map((row) => getId(row)).whereType<int>().toList();
    }

    // 4. 软删除流程：过滤出当前未标记删除&属于本租户的数据
    final rows = await find(
      session,
      where: (t) =>
          idColumn(t).inSet(normalizedIds) &
          tenantIdColumn(t).equals(tenantId) &
          deletedColumn!(t)!.equals(false),
    );
    if (rows.isEmpty) return const [];

    // 5. 对符合条件的所有实体逐条标记为已删除并写回数据库
    for (final row in rows) {
      setDeleted?.call(row, true);
      await updateRow(session, row);
    }
    // 返回本次批量软删除成功的主键ID集合
    return rows.map((row) => getId(row)).whereType<int>().toList();
  }

  /// 根据主键ID获取实体对象方法。
  ///
  /// 具体流程：
  /// 1. 根据传入的主键ID和当前会话的租户ID，构造查询条件；
  /// 2. 若启用软删除，自动排除已标记为“已删除”的记录；
  /// 3. 从数据库中检索符合条件的首条数据；
  /// 4. 若未找到对应记录，则返回 null。
  ///
  /// 参数：
  /// - [session] 当前 Serverpod 会话对象
  /// - [id]      需要查询的主键 ID
  ///
  /// 返回：
  ///   查询到的实体对象或 null（若未找到）
  Future<T?> get(Session session, int id) async {
    final tenantId = resolveTenantId(session);

    return findFirstRow(
      session,
      where: (t) {
        var filter =
            idColumn(t).equals(id) & tenantIdColumn(t).equals(tenantId);
        if (enableSoftDelete) {
          filter = filter & deletedColumn!(t)!.equals(false);
        }
        return filter;
      },
    );
  }
}
