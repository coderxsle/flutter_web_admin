import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';
// `session.tenantId` / `session.targetTenantId` 是 serverpod_crud 提供的
// `SessionExtension`，不是 serverpod 核心的 API —— 少了这行会报
// `undefined_getter`。
import 'package:serverpod_crud/serverpod_crud.dart';

import 'pagination_extension.dart';

/// airtable 子系统的**业务实现**（C 档）。
///
/// ## 为什么要有这个类
///
/// S4 之前 `lib/src/services/airtable/` 是个**空目录**，21 个方法的业务逻辑
/// 全部写死在 `lib/src/endpoints/airtable/*_endpoint.dart` 里。这带来两个问题：
///
/// 1. REST 层要复用同一份逻辑，就得**反向依赖 Endpoint 层**（或复制一份），
///    而 REST 表现层的定位恰恰是「Route 不碰业务，和 typed Endpoint 共用
///    Service」——见 `docs/rest-api-layer.md` §1。
/// 2. S5 退役 typed Endpoint 时，逻辑会被一起删掉。
///
/// 所以先把逻辑收敛到这里，Endpoint 与 REST Route 都只做**参数搬运 + 信封**。
///
/// ## 租户与软删
///
/// 四张 `air_*` 表在 S4 补上了 `tenantId` / `deleted` 两列（迁移
/// `20260924070853559`），口径与 A 档 6 个资源对齐：
///
/// * **租户**：读一律按 [tenantIdOf] 过滤；写一律把 `tenantId` 打成本次会话的租户。
///   解析口径与 `serverpod_crud` 的 `BaseService._defaultResolveTenantId` **完全一致**
///   （平台超管的 `targetTenantId` 优先，否则取登录态 scope `tenantId:<id>`）。
/// * **软删**：读一律追加 `deleted = false`。
///
/// ⚠️ **本阶段的删除仍然是级联物理删除**（`deleteTable` 要连带清掉字段 / 行 /
/// 单元格），没有改成把 `deleted` 置 true。原因见 [deleteTable] 的注释 ——
/// 这是一处**已知取舍**，不是漏改。
///
/// ## 路径与命名
///
/// 方法名与 typed Endpoint 保持一一对应，便于对照回归；只有两处签名按
/// S4 的决策修正过（[updateField] / [deleteField] 改成按 **id**，不再是按
/// `fieldName`），另有一个重复方法被合并（原 `getTables2` 与 [getTables] 功能
/// 重叠，已删除）。
class AirtableService {
  AirtableService._();

  // ── 会话上下文 ──────────────────────────────────────────────────────

  /// 当前会话的租户 ID。
  ///
  /// 与 `serverpod_crud` 的 `BaseService._defaultResolveTenantId` 保持同一口径：
  ///
  /// 1. 平台超管动态切换租户时，`session.targetTenantId` 优先；
  /// 2. 否则取登录态 scope `tenantId:<id>`（`auth_service` 只在
  ///    `user.tenantId > 0` 时才签发这个 scope）；
  /// 3. 都取不到时是 0，也就是「系统租户 / 默认租户」。
  ///
  /// ⚠️ 因为第 3 条，**未登录或默认租户用户的 `tenantId` 是 0**，
  /// 而不是「不过滤」。这与 A 档 6 个资源的行为一致（收敛后的口径），
  /// 但比 airtable 改造前「完全不按租户过滤」要严格 —— 回归时重点比对
  /// 带 `tenantId` 的账号看到的数据量。
  static int tenantIdOf(Session session) {
    final target = session.targetTenantId;
    if (target != null && target > 0) return target;
    return session.tenantId;
  }

  // ── 表格（air_tables）──────────────────────────────────────────────

  /// 表格分页列表。
  ///
  /// 合并了原来的 `getTables` 与 `getTables2`：两者除了入参形式
  /// （`Pagination` 对象 vs 具名参数）外逻辑逐行相同，属于重复实现。
  static Future<PageResponse> getTables(
    Session session,
    Pagination pagination,
  ) async {
    try {
      final tenantId = tenantIdOf(session);
      final keyword = pagination.keyword;
      final hasKeyword = keyword != null && keyword.isNotEmpty;

      WhereExpressionBuilder<AirTablesTable> where = (t) =>
          t.tenantId.equals(tenantId) & t.deleted.equals(false);
      if (hasKeyword) {
        where = (t) =>
            t.tenantId.equals(tenantId) &
            t.deleted.equals(false) &
            t.name.like('%$keyword%');
      }

      final tables = await AirTables.db.find(
        session,
        where: where,
        limit: pagination.pageSize,
        offset: pagination.offset,
        orderBy: (t) => t.id.desc(),
      );
      final total = await AirTables.db.count(session, where: where);

      return PageResponse.success(
        tables,
        page: pagination.page,
        pageSize: pagination.pageSize,
        total: total,
      );
    } catch (e) {
      return PageResponse.failed('查询表格列表失败: $e');
    }
  }

  /// 表格详情：基础信息 + 简化字段列表 + 字段数 / 行数统计。
  static Future<CommonResponse> tableDetail(Session session, int id) async {
    try {
      final table = await _findTable(session, id);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      final fields = await AirTableFields.db.find(
        session,
        where: (t) =>
            t.tables.id.equals(id) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
        orderBy: (t) => t.id,
      );
      final rowsCount = await AirTableRows.db.count(
        session,
        where: (t) =>
            t.tables.id.equals(id) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
      );

      return CommonResponse.success(
        AirTableDetail(
          id: table.id!,
          name: table.name,
          fields: fields
              .map((f) => AirTableFieldsSummary(id: f.id!, field: f.field))
              .toList(),
          fieldsCount: fields.length,
          rowsCount: rowsCount,
        ),
      );
    } catch (e) {
      return CommonResponse.failed('获取表格详情失败: $e');
    }
  }

  /// 新建表格，返回**新表格的 id**。
  static Future<CommonResponse> createTable(
    Session session,
    String name,
  ) async {
    try {
      final trimmed = name.trim();
      if (trimmed.isEmpty) {
        return CommonResponse.failed('表格名称不能为空');
      }

      // 重名校验**必须限定在「本租户 + 未删除」范围内**：
      // `air_tables` 的唯一索引是 `(tenantId, name)`（S4 由 `(name)` 改来），
      // 不同租户允许同名。
      final existing = await AirTables.db.findFirstRow(
        session,
        where: (t) =>
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false) &
            t.name.equals(trimmed),
      );
      if (existing != null) {
        return CommonResponse.failed('表格名称已存在');
      }

      final created = await AirTables.db.insertRow(
        session,
        AirTables(name: trimmed, tenantId: tenantIdOf(session)),
      );

      return CommonResponse.success(created.id!);
    } catch (e) {
      return CommonResponse.failed('创建表格失败: $e');
    }
  }

  /// 重命名表格，返回**更新后的表格详情**（与 [tableDetail] 同结构）。
  static Future<CommonResponse> updateTable(
    Session session,
    int id,
    String name,
  ) async {
    try {
      final trimmed = name.trim();
      if (trimmed.isEmpty) {
        return CommonResponse.failed('表格名称不能为空');
      }

      final table = await _findTable(session, id);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      final existing = await AirTables.db.findFirstRow(
        session,
        where: (t) =>
            t.name.equals(trimmed) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false) &
            t.id.notEquals(id),
      );
      if (existing != null) {
        return CommonResponse.failed('表格名称已存在');
      }

      table.name = trimmed;
      final updated = await AirTables.db.updateRow(session, table);

      final fields = await AirTableFields.db.find(
        session,
        where: (t) =>
            t.tables.id.equals(id) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
        orderBy: (t) => t.id,
      );
      final rowsCount = await AirTableRows.db.count(
        session,
        where: (t) =>
            t.tables.id.equals(id) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
      );

      return CommonResponse.success(
        AirTableDetail(
          id: updated.id!,
          name: updated.name,
          fields: fields
              .map((f) => AirTableFieldsSummary(id: f.id!, field: f.field))
              .toList(),
          fieldsCount: fields.length,
          rowsCount: rowsCount,
        ),
      );
    } catch (e) {
      return CommonResponse.failed('更新表格失败: $e');
    }
  }

  /// 删除表格，**级联物理删除**其下所有行 / 字段 / 单元格。
  ///
  /// ## ⚠️ 为什么这里没有用 `deleted` 做软删
  ///
  /// S4 给四张 `air_*` 表补了 `deleted` 列，读路径也确实在按
  /// `deleted = false` 过滤，但**删除动作本身仍然是物理删 + 级联**，
  /// 这是本次刻意保留的取舍：
  ///
  /// * 级联链是「表 → 行 → 单元格」「表 → 字段 → 单元格」，
  ///   单元格同时挂在行和字段下面。改成软删要让四层标记在同一个事务里
  ///   保持一致，任何一处漏标都会让 `searchTableItems` 之类的
  ///   「按行集合再取单元格」的查询捞到脏数据；
  /// * 更要命的是 `air_tables` 上有唯一索引 `(tenantId, name)`。
  ///   改成软删之后，**被删掉的表会永久占住自己的名字**，用户删掉
  ///   表格后无法用同名重建（这类问题在 `sys_menu.permission` 上已经
  ///   出现过一次，见 `memory/MEMORY.md`）。
  ///
  /// 所以现状是：**列已加、读路径已按 `deleted = false` 过滤、
  /// 但恒为 false**。要不要整体切成软删是一个**独立决策**，切之前需要先定
  /// 唯一索引怎么处理（去掉 DB 约束改成应用层查重 / 索引里带上 `deleted`）。
  static Future<CommonResponse> deleteTable(Session session, int id) async {
    try {
      final table = await _findTable(session, id);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      await session.db.transaction((transaction) async {
        // 1. 该表所有行下的单元格
        final rows = await AirTableRows.db.find(
          session,
          where: (t) => t.tables.id.equals(id),
          transaction: transaction,
        );
        for (final row in rows) {
          await AirTableItems.db.deleteWhere(
            session,
            where: (t) => t.rowId.equals(row.id),
            transaction: transaction,
          );
        }

        // 2. 行、字段，最后才是表格本身
        await AirTableRows.db.deleteWhere(
          session,
          where: (t) => t.tables.id.equals(id),
          transaction: transaction,
        );
        await AirTableFields.db.deleteWhere(
          session,
          where: (t) => t.tables.id.equals(id),
          transaction: transaction,
        );
        await AirTables.db.deleteRow(session, table, transaction: transaction);
      });

      return CommonResponse.success('删除成功');
    } catch (e) {
      return CommonResponse.failed('删除表格失败: $e');
    }
  }

  // ── 字段（air_table_fields）────────────────────────────────────────

  /// 某张表格下的字段列表。
  static Future<CommonResponse> getAirTableFields(
    Session session,
    int tableId,
  ) async {
    try {
      final table = await _findTable(session, tableId);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      final fields = await AirTableFields.db.find(
        session,
        where: (t) =>
            t.tables.id.equals(tableId) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
        orderBy: (t) => t.id,
      );

      return CommonResponse.success(fields);
    } catch (e) {
      return CommonResponse.failed('获取字段列表失败: $e');
    }
  }

  /// 在表格下新建字段，返回新建的字段行。
  static Future<CommonResponse> createField(
    Session session,
    int tableId,
    String fieldName,
  ) async {
    try {
      final trimmed = fieldName.trim();
      if (trimmed.isEmpty) {
        return CommonResponse.failed('字段名称不能为空');
      }

      final table = await _findTable(session, tableId);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      final duplicated = await AirTableFields.db.findFirstRow(
        session,
        where: (t) =>
            t.tables.id.equals(tableId) &
            t.field.equals(trimmed) &
            t.deleted.equals(false),
      );
      if (duplicated != null) {
        return CommonResponse.failed('字段名称已存在');
      }

      final created = await AirTableFields.db.insertRow(
        session,
        AirTableFields(
          field: trimmed,
          tablesId: table.id!,
          tables: table,
          tenantId: tenantIdOf(session),
        ),
      );

      return CommonResponse.success(created);
    } catch (e) {
      return CommonResponse.failed('创建字段失败: $e');
    }
  }

  /// 重命名字段。
  ///
  /// ⚠️ **S4 修正**：签名从 `(fieldName, newName)` 改成了 `(id, newName)`。
  ///
  /// 改前的实现有两个问题：
  /// * REST 惯例是 `/fields/:id`，按名字定位既不符合惯例，也无法处理重名；
  /// * 更严重的是原实现里写的是 `field[0].field = fieldName.trim()` ——
  ///   **把原值写了回去**（应该用 `newName`），等于「改名」是个静默的空操作。
  static Future<CommonResponse> updateField(
    Session session,
    int id,
    String newName,
  ) async {
    try {
      final trimmed = newName.trim();
      if (trimmed.isEmpty) {
        return CommonResponse.failed('新字段名称不能为空');
      }

      final field = await AirTableFields.db.findFirstRow(
        session,
        where: (t) =>
            t.id.equals(id) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
      );
      if (field == null) {
        return CommonResponse.failed('字段不存在');
      }

      // 同一张表内不允许重名（排除自己）。
      // 原实现这里用的是 `t.field.equals(fieldName)`（旧名）而不是新名，
      // 所以「改成另一个已存在的名字」永远不会被拦住 —— 一并修掉。
      final duplicated = await AirTableFields.db.findFirstRow(
        session,
        where: (t) =>
            t.tables.id.equals(field.tablesId) &
            t.field.equals(trimmed) &
            t.deleted.equals(false) &
            t.id.notEquals(id),
      );
      if (duplicated != null) {
        return CommonResponse.failed('字段名称已存在');
      }

      field.field = trimmed;
      final updated = await AirTableFields.db.updateRow(session, field);

      return CommonResponse.success(updated);
    } catch (e) {
      return CommonResponse.failed('更新字段失败: $e');
    }
  }

  /// 删除字段（级联删掉该列下所有单元格）。
  ///
  /// ⚠️ **S4 修正**：签名从 `(fieldName)` 改成 `(id)`，理由同 [updateField]。
  static Future<CommonResponse> deleteField(Session session, int id) async {
    try {
      final field = await AirTableFields.db.findFirstRow(
        session,
        where: (t) =>
            t.id.equals(id) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
      );
      if (field == null) {
        return CommonResponse.failed('字段不存在');
      }

      await session.db.transaction((transaction) async {
        await AirTableItems.db.deleteWhere(
          session,
          where: (t) => t.field.id.equals(field.id),
          transaction: transaction,
        );
        await AirTableFields.db.deleteRow(
          session,
          field,
          transaction: transaction,
        );
      });

      return CommonResponse.success('删除成功');
    } catch (e) {
      return CommonResponse.failed('删除字段失败: $e');
    }
  }

  // ── 行（air_table_rows）────────────────────────────────────────────

  /// 某张表格下的行（分页），每行带上自己所有的单元格。
  ///
  /// ⚠️ 返回类型是 `PageResponse`（不是 `CommonResponse`），这是 typed 侧的历史
  /// 形状。`keyword` 参数**保留但未使用** —— 改造前就是这样，属于已知的无用参数。
  static Future<PageResponse> getTableRows(
    Session session,
    int tableId, {
    int page = 1,
    int pageSize = 20,
    String? keyword,
  }) async {
    try {
      final table = await _findTable(session, tableId);
      if (table == null) {
        return PageResponse.failed('表格不存在');
      }

      final total = await AirTableRows.db.count(
        session,
        where: (t) =>
            t.tables.id.equals(tableId) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
      );

      final rows = await AirTableRows.db.find(
        session,
        where: (t) =>
            t.tables.id.equals(tableId) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
        limit: pageSize,
        offset: (page - 1) * pageSize,
        orderBy: (t) => t.index,
        include: AirTableRows.include(
          items: AirTableItems.includeList(
            include: AirTableItems.include(field: AirTableFields.include()),
          ),
        ),
      );

      final data = <Map<String, dynamic>>[];
      for (final row in rows) {
        data.add({
          'id': row.id,
          'index': row.index,
          'tablesId': row.tablesId,
          'items': (row.items ?? const <AirTableItems>[]).map((item) => {
                'id': item.id,
                'value': item.value,
                'fieldId': item.field?.id,
              }).toList(),
        });
      }

      return PageResponse.success(
        data,
        page: page,
        pageSize: pageSize,
        total: total,
      );
    } catch (e) {
      return PageResponse.failed('获取行列表失败: $e');
    }
  }

  /// 新增一行；不传 [index] 时自动追加到末尾（最大 index + 1）。
  ///
  /// ⚠️ 返回值是 `true` 而不是新行 id（typed 侧历史形状），REST 侧保持一致。
  static Future<CommonResponse> createRow(
    Session session,
    int tableId, {
    int? index,
  }) async {
    try {
      final table = await _findTable(session, tableId);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      var rowIndex = index ?? 1;
      if (index == null) {
        final maxIndexRow = await AirTableRows.db.findFirstRow(
          session,
          where: (t) =>
              t.tables.id.equals(tableId) &
              t.tenantId.equals(tenantIdOf(session)) &
              t.deleted.equals(false),
          orderBy: (t) => t.index.desc(),
        );
        if (maxIndexRow != null) {
          rowIndex = maxIndexRow.index + 1;
        }
      }

      await AirTableRows.db.insertRow(
        session,
        AirTableRows(
          index: rowIndex,
          tablesId: tableId,
          tenantId: tenantIdOf(session),
        ),
      );

      return CommonResponse.success(true, '创建行成功');
    } catch (e) {
      return CommonResponse.failed('创建行失败: $e');
    }
  }

  /// 更新行的排序索引，返回该行的最新状态 + 单元格计数。
  static Future<CommonResponse> updateRow(
    Session session,
    int id,
    int index,
  ) async {
    try {
      final row = await AirTableRows.db.findFirstRow(
        session,
        where: (t) =>
            t.id.equals(id) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
      );
      if (row == null) {
        return CommonResponse.failed('行不存在');
      }

      row.index = index;
      final updated = await AirTableRows.db.updateRow(session, row);

      final itemsCount = await AirTableItems.db.count(
        session,
        where: (t) => t.rowId.equals(id),
      );

      return CommonResponse.success({
        'id': updated.id,
        'index': updated.index,
        'tablesId': updated.tablesId,
        'itemsCount': itemsCount,
      });
    } catch (e) {
      return CommonResponse.failed('更新行失败: $e');
    }
  }

  /// 删除一行（级联删掉该行所有单元格）。
  static Future<CommonResponse> deleteRow(Session session, int id) async {
    try {
      final row = await AirTableRows.db.findFirstRow(
        session,
        where: (t) =>
            t.id.equals(id) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
      );
      if (row == null) {
        return CommonResponse.failed('行不存在');
      }

      await session.db.transaction((transaction) async {
        await AirTableItems.db.deleteWhere(
          session,
          where: (t) => t.rowId.equals(id),
          transaction: transaction,
        );
        await AirTableRows.db.deleteRow(session, row, transaction: transaction);
      });

      return CommonResponse.success('删除成功');
    } catch (e) {
      return CommonResponse.failed('删除行失败: $e');
    }
  }

  /// 批量删除行。
  ///
  /// ⚠️ 返回的是 `{'deletedCount': n}`，n 是**实际命中的行数**。
  /// 一条都没命中时仍然返回成功（`deletedCount = 0`），REST 侧要靠这个计数
  /// 判断是不是 404，不能只看 `code`。
  static Future<CommonResponse> batchDeleteRows(
    Session session,
    List<int> ids,
  ) async {
    try {
      if (ids.isEmpty) {
        return CommonResponse.failed('请选择要删除的行');
      }

      var deletedCount = 0;
      final tenantId = tenantIdOf(session);

      await session.db.transaction((transaction) async {
        for (final id in ids) {
          final row = await AirTableRows.db.findFirstRow(
            session,
            where: (t) =>
                t.id.equals(id) &
                t.tenantId.equals(tenantId) &
                t.deleted.equals(false),
            transaction: transaction,
          );
          if (row == null) continue;

          await AirTableItems.db.deleteWhere(
            session,
            where: (t) => t.rowId.equals(id),
            transaction: transaction,
          );
          await AirTableRows.db.deleteRow(
            session,
            row,
            transaction: transaction,
          );
          deletedCount++;
        }
      });

      return CommonResponse.success({'deletedCount': deletedCount});
    } catch (e) {
      return CommonResponse.failed('批量删除行失败: $e');
    }
  }

  // ── 单元格（air_table_items）───────────────────────────────────────

  /// 写入单元格：同一「行 + 列」已有值则更新，否则新建。
  ///
  /// 返回写入的值本身（`value`），不是单元格行。
  static Future<CommonResponse> upsertItem(
    Session session,
    int fieldId,
    String value,
    int rowId,
  ) async {
    try {
      final row = await AirTableRows.db.findFirstRow(
        session,
        where: (t) =>
            t.id.equals(rowId) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
      );
      if (row == null) {
        return CommonResponse.failed('行不存在');
      }

      final field = await AirTableFields.db.findFirstRow(
        session,
        where: (t) =>
            t.id.equals(fieldId) & t.deleted.equals(false),
      );
      if (field == null) {
        return CommonResponse.failed('字段不存在$fieldId');
      }

      final existingItem = await AirTableItems.db.findFirstRow(
        session,
        where: (t) =>
            t.rowId.equals(rowId) &
            t.field.id.equals(field.id) &
            t.deleted.equals(false),
        include: AirTableItems.include(field: AirTableFields.include()),
      );

      if (existingItem != null) {
        existingItem.value = value;
        await AirTableItems.db.updateRow(session, existingItem);
        return CommonResponse.success(value, '更新单元格数据成功');
      }

      await AirTableItems.db.insertRow(
        session,
        AirTableItems(
          value: value,
          rowId: rowId,
          fieldId: fieldId,
          tenantId: tenantIdOf(session),
        ),
      );

      return CommonResponse.success(value, '创建单元格数据成功');
    } catch (e) {
      return CommonResponse.failed('创建单元格数据失败: $e');
    }
  }

  /// 删除单元格。
  static Future<CommonResponse> deleteItem(Session session, int id) async {
    try {
      final item = await AirTableItems.db.findFirstRow(
        session,
        where: (t) =>
            t.id.equals(id) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
      );
      if (item == null) {
        return CommonResponse.failed('单元格不存在');
      }

      await AirTableItems.db.deleteRow(session, item);

      return CommonResponse.success('删除成功');
    } catch (e) {
      return CommonResponse.failed('删除单元格数据失败: $e');
    }
  }

  // ── 关联（读视图 + 可关联项检索）───────────────────────────────────

  /// 单元格的关联信息：本单元格的值 + 它指向的表格 / 字段 / 单元格。
  ///
  /// ⚠️ **S4 修正**：「关联的单元格」原来取的是 `item.id`（也就是**它自己**），
  /// 所以 `tiedItem` 永远指向本行本身。真正要取的是外键 `item.itemId`。
  static Future<CommonResponse> getItemRelations(
    Session session,
    int id,
  ) async {
    try {
      final item = await AirTableItems.db.findFirstRow(
        session,
        where: (t) =>
            t.id.equals(id) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
      );
      if (item == null) {
        return CommonResponse.failed('单元格不存在');
      }

      Map<String, dynamic>? tiedTableInfo;
      Map<String, dynamic>? tiedFieldInfo;
      Map<String, dynamic>? tiedItemInfo;

      if (item.tables != null) {
        final tiedTable = await _findTable(session, item.tables!.id!);
        if (tiedTable != null) {
          tiedTableInfo = {'id': tiedTable.id, 'name': tiedTable.name};
        }
      }

      if (item.field != null) {
        final tiedField = await AirTableFields.db.findById(
          session,
          item.field!.id!,
        );
        if (tiedField != null) {
          tiedFieldInfo = {'id': tiedField.id, 'field': tiedField.field};
        }
      }

      final tiedItemId = item.itemId;
      if (tiedItemId != null) {
        final tiedItem = await AirTableItems.db.findById(session, tiedItemId);
        if (tiedItem != null) {
          tiedItemInfo = {'id': tiedItem.id, 'value': tiedItem.value};
        }
      }

      return CommonResponse.success({
        'itemId': item.id,
        'value': item.value,
        'tiedTable': tiedTableInfo,
        'tiedField': tiedFieldInfo,
        'tiedItem': tiedItemInfo,
      });
    } catch (e) {
      return CommonResponse.failed('获取关联信息失败: $e');
    }
  }

  /// 在某张表格里搜索可作为关联目标的单元格（分页）。
  ///
  /// ⚠️ **S4 修正**：原实现在 `AirTableRows` 上写
  /// `where: (t) => t.id.equals(tableId)` —— 是拿 **row.id** 去比 **tableId**，
  /// 于是 `rowIds` 几乎恒为空、接口恒返回空页。正确写法是 `t.tables.id`。
  static Future<PageResponse> searchTableItems(
    Session session,
    int tableId,
    Pagination pagination, {
    int? fieldId,
  }) async {
    try {
      final table = await _findTable(session, tableId);
      if (table == null) {
        return PageResponse.failed('表格不存在');
      }

      final rows = await AirTableRows.db.find(
        session,
        where: (t) => t.tables.id.equals(tableId),
      );
      final rowIds = rows.map((r) => r.id).whereType<int>().toSet();
      if (rowIds.isEmpty) {
        return PageResponse.success(
          const [],
          page: pagination.page,
          pageSize: pagination.pageSize,
          total: 0,
        );
      }

      final keyword = pagination.keyword;
      final hasKeyword = keyword != null && keyword.isNotEmpty;

      Expression buildWhere(AirTableItemsTable t) {
        var filter = t.rowId.inSet(rowIds);
        if (fieldId != null) {
          filter = filter & t.field.id.equals(fieldId);
        }
        if (hasKeyword) {
          filter = filter & t.value.like('%$keyword%');
        }
        return filter;
      }

      final total = await AirTableItems.db.count(
        session,
        where: buildWhere,
      );
      final items = await AirTableItems.db.find(
        session,
        where: buildWhere,
        limit: pagination.pageSize,
        offset: pagination.offset,
        orderBy: (t) => t.id,
      );

      final data = <Map<String, dynamic>>[];
      for (final item in items) {
        final field = item.field == null
            ? null
            : await AirTableFields.db.findById(session, item.field!.id!);
        final row = await AirTableRows.db.findById(session, item.rowId);
        data.add({
          'id': item.id,
          'value': item.value,
          'fieldId': item.field?.id,
          'fieldName': field?.field,
          'rowId': item.rowId,
          'rowIndex': row?.index,
        });
      }

      return PageResponse.success(
        data,
        page: pagination.page,
        pageSize: pagination.pageSize,
        total: total,
      );
    } catch (e) {
      return PageResponse.failed('搜索数据失败: $e');
    }
  }

  /// 所有可作为关联目标的表格（id + name）。
  static Future<CommonResponse> getAvailableTables(Session session) async {
    try {
      final tables = await AirTables.db.find(
        session,
        where: (t) =>
            t.tenantId.equals(tenantIdOf(session)) & t.deleted.equals(false),
        orderBy: (t) => t.id,
      );

      return CommonResponse.success(
        tables.map((t) => {'id': t.id, 'name': t.name}).toList(),
      );
    } catch (e) {
      return CommonResponse.failed('获取表格列表失败: $e');
    }
  }

  /// 指定表格的所有字段（用于选择关联字段）。
  static Future<CommonResponse> getTableFieldsForRelation(
    Session session,
    int tableId,
  ) async {
    try {
      final table = await _findTable(session, tableId);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      final fields = await AirTableFields.db.find(
        session,
        where: (t) =>
            t.tables.id.equals(tableId) &
            t.tenantId.equals(tenantIdOf(session)) &
            t.deleted.equals(false),
        orderBy: (t) => t.id,
      );

      return CommonResponse.success(
        fields.map((f) => {'id': f.id, 'field': f.field}).toList(),
      );
    } catch (e) {
      return CommonResponse.failed('获取字段列表失败: $e');
    }
  }

  // ── 内部工具 ───────────────────────────────────────────────────────

  /// 按 id 取**本租户、未删除**的表格；不属于本租户时等同不存在。
  ///
  /// `findById` 无法表达租户条件，所以这里统一用 `findFirstRow`。
  /// 所有对 `AirTables` 的「单条读写」都必须走它，否则会绕过租户隔离。
  static Future<AirTables?> _findTable(Session session, int id) {
    return AirTables.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(id) &
          t.tenantId.equals(tenantIdOf(session)) &
          t.deleted.equals(false),
    );
  }
}
