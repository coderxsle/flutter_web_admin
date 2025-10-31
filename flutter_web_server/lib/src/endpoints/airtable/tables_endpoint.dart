import 'package:flutter_web_server/src/extensions/pagination_extension.dart';
import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/shared.dart';

class TablesEndpoint extends Endpoint {

  /// 查询所有表格（分页）
  Future<CommonResponse> getTables(Session session, Pagination pagination) async {
    try {

      // 构建查询条件
      WhereExpressionBuilder<AirTablesTable>? where;
      if (pagination.keyword != null && pagination.keyword!.isNotEmpty) {
        where = (t) => t.name.like('%${pagination.keyword}%');
      }

      // 查询数据
      final tables = await AirTables.db.find(
        session,
        where: where,
        limit: pagination.pageSize,
        offset: pagination.offset,
        orderBy: (t) => t.id,
        orderDescending: true,
      );

      // 查询总数和数据
      final total = pagination.keyword != null && pagination.keyword!.isNotEmpty
          ? await AirTables.db.count(session, where: where)
          : await AirTables.db.count(session);

      return PageResponse.success(tables, pageNum: pagination.page, pageSize: pagination.pageSize, total: total);
    } catch (e) {
      return CommonResponse.failed('查询表格列表失败: $e');
    }
  }

  /// 获取表格详情（包含字段列表）
  Future<CommonResponse> tableDetail(Session session, int id) async {
    try {
      final table = await AirTables.db.findById(session, id);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      // 获取字段列表，并构建简化版字段列表（TableFieldsSummary）
      final fields = await AirTableFields.db.find(session, where: (t) => t.tables.id.equals(id), orderBy: (t) => t.id);
      final fieldsSummary = fields.map((f) => AirTableFieldsSummary(id: f.id!, field: f.field)).toList();

      // 获取行总数
      final rowsCount = await AirTableRows.db.count(session, where: (t) => t.tables.id.equals(id));

      // 构建表格详情响应
      final tableDetail = AirTableDetail(
        id: table.id!,
        name: table.name,
        fields: fieldsSummary,
        fieldsCount: fields.length,
        rowsCount: rowsCount,
      );

      return CommonResponse.success(tableDetail);
    } catch (e) {
      return CommonResponse.failed('获取表格详情失败: $e');
    }
  }


  /// 创建表格
  Future<CommonResponse> createTable(Session session, String name) async {
    try {
      if (name.trim().isEmpty) {
        return CommonResponse.failed('表格名称不能为空');
      }

      // 检查表格名称是否已存在
      final existingTable = await AirTables.db.findFirstRow(session, where: (t) => t.name.equals(name.trim()));
      
      if (existingTable != null) {
        return CommonResponse.failed('表格名称已存在');
      }
      // 创建表格
      final table = AirTables(name: name.trim());
      final newTable = await AirTables.db.insertRow(session, table);

      return CommonResponse.success(newTable.id!);
    } catch (e) {
      return CommonResponse.failed('创建表格失败: $e');
    }
  }

  /// 更新表格
  /// PUT /airtable/tables/{id}
  Future<CommonResponse> updateTable(Session session, int id, String name) async {
    try {
      if (name.trim().isEmpty) {
        return CommonResponse.failed('表格名称不能为空');
      }

      final table = await AirTables.db.findById(session, id);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      // 检查新名称是否与其他表格冲突（排除当前表格）
      final existingTable = await AirTables.db.findFirstRow(
        session,
        where: (t) => t.name.equals(name.trim()) & t.id.notEquals(id),
      );
      
      if (existingTable != null) {
        return CommonResponse.failed('表格名称已存在');
      }

      table.name = name.trim();
      final updatedTable = await AirTables.db.updateRow(session, table);

      // 获取字段列表和统计信息
      final fields = await AirTableFields.db.find(
        session,
        where: (t) => t.tables.id.equals(id),
        orderBy: (t) => t.id,
      );
      final fieldsCount = fields.length;
      final rowsCount = await AirTableRows.db.count(
        session,
        where: (t) => t.tables.id.equals(id),
      );

      // 构建表格详情响应
      final tableDetail = AirTableDetail(
        id: updatedTable.id!,
        name: updatedTable.name,
        fields: fields.map((f) => AirTableFieldsSummary(id: f.id!, field: f.field)).toList(),
        fieldsCount: fieldsCount,
        rowsCount: rowsCount,
      );

      return CommonResponse.success(tableDetail);
    } catch (e) {
      return CommonResponse.failed('更新表格失败: $e');
    }
  }

  /// 删除表格（级联删除所有相关数据）
  /// DELETE /airtable/tables/{id}
  Future<CommonResponse> deleteTable(Session session, int id) async {
    try {
      final table = await AirTables.db.findById(session, id);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      // 开始事务：删除表格及所有相关数据
      await session.db.transaction((transaction) async {
        // 1. 删除所有相关的 Items
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

        // 2. 删除所有相关的 Rows
        await AirTableRows.db.deleteWhere(
          session,
          where: (t) => t.tables.id.equals(id),
          transaction: transaction,
        );

        // 3. 删除所有相关的 Fields
        await AirTableFields.db.deleteWhere(
          session,
          where: (t) => t.tables.id.equals(id),
          transaction: transaction,
        );

        // 4. 删除表格本身
        await AirTables.db.deleteRow(session, table, transaction: transaction);
      });

      return CommonResponse.success('删除成功');
    } catch (e) {
      return CommonResponse.failed('删除表格失败: $e');
    }
  }

} 