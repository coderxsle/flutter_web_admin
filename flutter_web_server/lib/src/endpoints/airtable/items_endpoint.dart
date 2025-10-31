import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/shared.dart';

class TableItemsEndpoint extends Endpoint {

  /// ✅ 创建/更新单元格数据（Upsert）
  Future<CommonResponse> upsertItem(Session session, int fieldId, String value, int rowId) async {
    try {
      // 验证行是否存在
      final row = await AirTableRows.db.findById(session, rowId);
      if (row == null) {
        return CommonResponse.failed('行不存在');
      }

      // 验证字段是否存在
      final result = await AirTableFields.db.find(session, where: (t) => t.id.equals(fieldId));
      if (result.isEmpty) {
        return CommonResponse.failed('字段不存在$fieldId');
      }

      // 检查是否已存在该单元格（包含关联数据以确保缓存一致性）
      final existingItem = await AirTableItems.db.findFirstRow(
        session,
        where: (t) => t.rowId.equals(rowId) & t.field.id.equals(result[0].id),
        include: AirTableItems.include(
          field: AirTableFields.include(),
        ),
      );

      if (existingItem != null) {
        // 更新已存在的单元格
        existingItem.value = value;
        await AirTableItems.db.updateRow(session, existingItem);
        
        return CommonResponse.success(value, '更新单元格数据成功');
      }

      // 创建新单元格
      final item = AirTableItems(value: value, rowId: rowId, fieldId: fieldId);

      // 插入单元格数据
      await AirTableItems.db.insertRow(session, item);

      return CommonResponse.success(value, '创建单元格数据成功');
    } catch (e) {
      return CommonResponse.failed('创建单元格数据失败: $e');
    }
  }

  /// 删除单元格数据
  /// DELETE /airtable/items/{id}
  Future<CommonResponse> deleteItem(Session session, int id) async {
    try {
      final item = await AirTableItems.db.findById(session, id);
      if (item == null) {
        return CommonResponse.failed('单元格不存在');
      }

      await AirTableItems.db.deleteRow(session, item);

      return CommonResponse.success('删除成功');
    } catch (e) {
      return CommonResponse.failed('删除单元格数据失败: $e');
    }
  }

} 