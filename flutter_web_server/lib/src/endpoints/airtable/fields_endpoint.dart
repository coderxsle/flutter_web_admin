import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/shared.dart';

class AirTableFieldsEndpoint extends Endpoint {

  /// 获取表格的所有字段
  Future<CommonResponse> getAirTableFields(Session session, int tableId) async {
    try {
      // 验证表格是否存在
      final table = await AirTables.db.findById(session, tableId);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      // 查询字段列表
      final fields = await AirTableFields.db.find(
        session,
        where: (t) => t.tables.id.equals(tableId),
        orderBy: (t) => t.id,
      );

      return CommonResponse.success(fields);
    } catch (e) {
      return CommonResponse.failed('获取字段列表失败: $e');
    }
  }

  /// 创建字段
  /// POST /airtable/AirTables/{tableId}/fields
  Future<CommonResponse> createField(Session session, int tableId, String fieldName) async {
    try {
      if (fieldName.trim().isEmpty) {
        return CommonResponse.failed('字段名称不能为空');
      }

      // 验证表格是否存在
      final table = await AirTables.db.findById(session, tableId);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      // 检查字段名是否重复
      final existingFields = await AirTableFields.db.find(
        session,
        where: (t) => t.tables.id.equals(tableId) & t.field.equals(fieldName.trim()),
      );

      if (existingFields.isNotEmpty) {
        return CommonResponse.failed('字段名称已存在');
      }

      // 创建字段
      final field = AirTableFields(
        field: fieldName.trim(),
        tablesId: table.id!,
        tables: table,
      );
      final newField = await AirTableFields.db.insertRow(session, field);

      return CommonResponse.success(newField);
    } catch (e) {
      return CommonResponse.failed('创建字段失败: $e');
    }
  }

  /// 更新字段
  /// PUT /airtable/fields/{id}
  Future<CommonResponse> updateField(Session session, String fieldName, String newName) async {
    try {
      if (fieldName.trim().isEmpty) {
        return CommonResponse.failed('字段名称不能为空');
      }

      if (newName.trim().isEmpty) {
        return CommonResponse.failed('新字段名称不能为空');
      }

      final field = await AirTableFields.db.find(session, where: (t) => t.field.equals(fieldName.trim()));
      if (field.isEmpty) {
        return CommonResponse.failed('字段不存在');
      }

      // 检查字段名是否重复（排除自己）
      final existingFields = await AirTableFields.db.find(
        session,
        where: (t) =>
            t.tables.id.equals(field[0].tables!.id!) &
            t.field.equals(fieldName.trim()) &
            t.id.notEquals(field[0].id),
      );

      if (existingFields.isNotEmpty) {
        return CommonResponse.failed('字段名称已存在');
      }

      // 更新字段
      field[0].field = fieldName.trim();
      final updatedField = await AirTableFields.db.updateRow(session, field[0]);
      
      return CommonResponse.success(updatedField);
    } catch (e) {
      return CommonResponse.failed('更新字段失败: $e');
    }
  }

  /// 删除字段（级联删除所有相关的单元格数据）
  /// DELETE /airtable/fields/{id}
  Future<CommonResponse> deleteField(Session session, String fieldName) async {
    try {
      final field = await AirTableFields.db.find(session, where: (t) => t.field.equals(fieldName.trim()));
      if (field.isEmpty) {
        return CommonResponse.failed('字段不存在$fieldName'); 
      }

      // 开始事务：删除字段及所有相关的单元格数据
      await session.db.transaction((transaction) async {
        // 1. 删除所有相关的 Items
        await AirTableItems.db.deleteWhere(
          session,
          where: (t) => t.field.id.equals(field[0].id),
          transaction: transaction,
        );

        // 2. 删除字段本身
        await AirTableFields.db.deleteRow(session, field[0], transaction: transaction);
      });

      return CommonResponse.success('删除成功');
    } catch (e) {
      return CommonResponse.failed('删除字段失败: $e');
    }
  }

} 