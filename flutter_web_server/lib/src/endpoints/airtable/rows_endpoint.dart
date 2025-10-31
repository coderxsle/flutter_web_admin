import 'package:flutter_web_server/src/extensions/pagination_extension.dart';
import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/shared.dart';

class TableRowsEndpoint extends Endpoint {

  /// ✅ 获取表格的所有行（分页）
  Future<PageResponse> getTableRows(Session session, int tableId, Pagination pagination) async {
    try {
      // 验证表格是否存在
      final table = await AirTables.db.findById(session, tableId);
      if (table == null) {
        return PageResponse.failed('表格不存在');
      }

      // 查询总数
      final total = await AirTableRows.db.count(
        session,
        where: (t) => t.tables.id.equals(tableId),
      );

      // 查询数据（使用 include 一次性加载所有关联数据）
      final rows = await AirTableRows.db.find(
        session,
        where: (t) => t.tables.id.equals(tableId),
        limit: pagination.pageSize,
        offset: pagination.offset,
        orderBy: (t) => t.index,
        include: AirTableRows.include(
          items: AirTableItems.includeList(
            include: AirTableItems.include(
              field: AirTableFields.include(),  // 预加载 field 信息
            ),
          ),
        ),
      );

      // 构建返回数据（直接使用预加载的数据，无需额外查询）
      final rowsWithItems = <Map<String, dynamic>>[];
      for (final row in rows) {
        // 直接使用预加载的 items，不再查询数据库
        final items = row.items ?? [];
        
        final itemsData = items.map((item) => {
          'id': item.id, 'value': item.value, 'fieldId': item.field?.id,
        }).toList();

        rowsWithItems.add({'id': row.id, 'index': row.index, 'tablesId': row.tablesId, 'items': itemsData});
      }

      return PageResponse.success(rowsWithItems, pageNum: pagination.page, pageSize: pagination.pageSize, total: total);  
    } catch (e) {
      return PageResponse.failed('获取行列表失败: $e');
    }
  }


  /// ✅ 创建行
  Future<CommonResponse> createRow(Session session, int tableId, {int? index}) async {
    try {
      // 验证表格是否存在
      final table = await AirTables.db.findById(session, tableId);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      // 如果没有指定 index，则自动计算下一个索引
      int rowIndex = index ?? 1;
      if (index == null) {
        final maxIndexRow = await AirTableRows.db.findFirstRow(
          session,
          where: (t) => t.tables.id.equals(tableId),
          orderBy: (t) => t.index,
          orderDescending: true,
        );
        if (maxIndexRow != null) {
          rowIndex = maxIndexRow.index + 1;
        }
      }

      // 创建行
      final row = AirTableRows(index: rowIndex, tablesId: tableId);
      await AirTableRows.db.insertRow(session, row);

      return CommonResponse.success(true, '创建行成功');
    } catch (e) {
      return CommonResponse.failed('创建行失败: $e');
    }
  }

  /// 更新行索引（排序）
  /// PUT /airtable/rows/{id}
  Future<CommonResponse> updateRow(
    Session session,
    int id,
    int index,
  ) async {
    try {
      final row = await AirTableRows.db.findById(session, id);
      if (row == null) {
        return CommonResponse.failed('行不存在');
      }

      // 更新行索引
      row.index = index;
      final updatedRow = await AirTableRows.db.updateRow(session, row);

      // 获取统计信息
      final itemsCount = await AirTableItems.db.count(
        session,
        where: (t) => t.rowId.equals(id),
      );

      return CommonResponse.success({
        'id': updatedRow.id,
        'index': updatedRow.index,
        'tablesId': updatedRow.tablesId,
        'itemsCount': itemsCount,
      });
    } catch (e) {
      return CommonResponse.failed('更新行失败: $e');
    }
  }

  /// 删除行（级联删除所有相关的单元格数据）
  /// DELETE /airtable/rows/{id}
  Future<CommonResponse> deleteRow(Session session, int id) async {
    try {
      final row = await AirTableRows.db.findById(session, id);
      if (row == null) {
        return CommonResponse.failed('行不存在');
      }

      // 开始事务：删除行及所有相关的单元格数据
      await session.db.transaction((transaction) async {
        // 1. 删除所有相关的 Items
        await AirTableItems.db.deleteWhere(
          session,
          where: (t) => t.rowId.equals(id),
          transaction: transaction,
        );

        // 2. 删除行本身
        await AirTableRows.db.deleteRow(session, row, transaction: transaction);
      });

      return CommonResponse.success('删除成功');
    } catch (e) {
      return CommonResponse.failed('删除行失败: $e');
    }
  }

  /// 批量删除行
  /// POST /airtable/rows/batch-delete
  Future<CommonResponse> batchDeleteRows(
    Session session,
    List<int> ids,
  ) async {
    try {
      if (ids.isEmpty) {
        return CommonResponse.failed('请选择要删除的行');
      }

      int deletedCount = 0;

      // 开始事务：批量删除行及所有相关的单元格数据
      await session.db.transaction((transaction) async {
        for (final id in ids) {
          final row = await AirTableRows.db.findById(session, id);
          if (row != null) {
            // 1. 删除所有相关的 Items
            await AirTableItems.db.deleteWhere(
              session,
              where: (t) => t.rowId.equals(id),
              transaction: transaction,
            );

            // 2. 删除行本身
            await AirTableRows.db.deleteRow(session, row, transaction: transaction);
            deletedCount++;
          }
        }
      });

      return CommonResponse.success({
        'deletedCount': deletedCount,
      });
    } catch (e) {
      return CommonResponse.failed('批量删除行失败: $e');
    }
  }

} 