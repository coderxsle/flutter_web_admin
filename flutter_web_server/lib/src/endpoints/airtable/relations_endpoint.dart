import 'package:flutter_web_server/src/extensions/pagination_extension.dart';
import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/shared.dart';

class TableItemRelationsEndpoint extends Endpoint {

  /// 获取单元格的关联信息
  /// GET /airtable/items/{id}/relations
  Future<CommonResponse> getItemRelations(Session session, int id) async {
    try {
      final item = await AirTableItems.db.findById(session, id);
      if (item == null) {
        return CommonResponse.failed('单元格不存在');
      }

      Map<String, dynamic>? tiedTableInfo;
      Map<String, dynamic>? tiedFieldInfo;
      Map<String, dynamic>? tiedItemInfo;

      // 获取关联的表格信息
      if (item.tables != null) {
        final tiedTable = await AirTables.db.findById(session, item.tables!.id!);
        if (tiedTable != null) {
          tiedTableInfo = {
            'id': tiedTable.id,
            'name': tiedTable.name,
          };
        }
      }

      // 获取关联的字段信息
      if (item.field != null) {
        final tiedField = await AirTableFields.db.findById(session, item.field!.id!);
        if (tiedField != null) {
          tiedFieldInfo = {
            'id': tiedField.id,
            'field': tiedField.field,
          };
        }
      }

      // 获取关联的单元格信息
      if (item.id != null) {
        final tiedItem = await AirTableItems.db.findById(session, item.id!);
        if (tiedItem != null) {
          tiedItemInfo = {
            'id': tiedItem.id,
            'value': tiedItem.value,
          };
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

  /// 搜索可关联的数据
  /// GET /airtable/tables/{tableId}/searchable-items
  Future<PageResponse> searchTableItems(Session session, int tableId, Pagination pagination, { int? fieldId}) async {
    try {
      // 验证表格是否存在
      final table = await AirTables.db.findById(session, tableId);
      if (table == null) {
        return PageResponse.failed('表格不存在');
      }

      // 构建基础查询：获取属于该表格的所有行的 items
      final rows = await AirTableRows.db.find(
        session,
        where: (t) => t.id.equals(tableId),
      );
      final rowIds = rows.map((r) => r.id).whereType<int>().toSet();

      if (rowIds.isEmpty) {
        return PageResponse.success([], pageNum: pagination.page, pageSize: pagination.pageSize, total: 0);
      }

      // 查询总数和数据
      int total;
      List<AirTableItems> items;

      // 根据不同条件组合查询
      final keyword = pagination.keyword;
      
      if (fieldId != null && keyword != null && keyword.isNotEmpty) {
        // 有字段 ID 和关键词
        total = await AirTableItems.db.count(
          session,
          where: (t) => t.rowId.inSet(rowIds) & 
                        t.field.id.equals(fieldId) & 
                        t.value.like('%$keyword%'),
        );
        items = await AirTableItems.db.find(
          session,
          where: (t) => t.rowId.inSet(rowIds) & 
                        t.field.id.equals(fieldId) & 
                        t.value.like('%$keyword%'),
          limit: pagination.pageSize,
          offset: pagination.offset,
          orderBy: (t) => t.id,
        );
      } else if (fieldId != null) {
        // 只有字段 ID
        total = await AirTableItems.db.count(
          session,
          where: (t) => t.rowId.inSet(rowIds) & t.field.id.equals(fieldId),
        );
        items = await AirTableItems.db.find(
          session,
          where: (t) => t.rowId.inSet(rowIds) & t.field.id.equals(fieldId),
          limit: pagination.pageSize,
          offset: pagination.offset,
          orderBy: (t) => t.id,
        );
      } else if (keyword != null && keyword.isNotEmpty) {
        // 只有关键词
        total = await AirTableItems.db.count(
          session,
          where: (t) => t.rowId.inSet(rowIds) & t.value.like('%$keyword%'),
        );
        items = await AirTableItems.db.find(
          session,
          where: (t) => t.rowId.inSet(rowIds) & t.value.like('%$keyword%'),
          limit: pagination.pageSize,
          offset: pagination.offset,
          orderBy: (t) => t.id,
        );
      } else {
        // 没有任何过滤条件
        total = await AirTableItems.db.count(
          session,
          where: (t) => t.rowId.inSet(rowIds),
        );
        items = await AirTableItems.db.find(
          session,
          where: (t) => t.rowId.inSet(rowIds),
          limit: pagination.pageSize,
          offset: pagination.offset,
          orderBy: (t) => t.id,
        );
      }

      // 为每个单元格添加字段信息和行信息
      final itemsWithInfo = <Map<String, dynamic>>[];
      for (final item in items) {
        final field = await AirTableFields.db.findById(session, item.field!.id!);
        final row = await AirTableRows.db.findById(session, item.rowId);

        itemsWithInfo.add({
          'id': item.id,
          'value': item.value,
          'fieldId': item.field!.id!,
          'fieldName': field?.field,
          'rowId': item.rowId,
          'rowIndex': row?.index,
        });
      }

      return PageResponse.success(itemsWithInfo, pageNum: pagination.page, pageSize: pagination.pageSize, total: total);
    } catch (e) {
      return PageResponse.failed('搜索数据失败: $e');
    }
  }

  /// 获取所有可用于关联的表格列表
  /// GET /airtable/relations/tables
  Future<CommonResponse> getAvailableTables(Session session) async {
    try {
      final tables = await AirTables.db.find(
        session,
        orderBy: (t) => t.id,
      );

      final tablesData = tables.map((table) => {
        'id': table.id,
        'name': table.name,
      }).toList();

      return CommonResponse.success(tablesData);
    } catch (e) {
      return CommonResponse.failed('获取表格列表失败: $e');
    }
  }

  /// 获取指定表格的所有字段（用于选择关联字段）
  /// GET /airtable/relations/tables/{tableId}/fields
  Future<CommonResponse> getTableFieldsForRelation(
    Session session,
    int tableId,
  ) async {
    try {
      // 验证表格是否存在
      final table = await AirTables.db.findById(session, tableId);
      if (table == null) {
        return CommonResponse.failed('表格不存在');
      }

      final fields = await AirTableFields.db.find(
        session,
        where: (t) => t.tables.id.equals(tableId),
        orderBy: (t) => t.id,
      );

      final fieldsData = fields.map((field) => {
        'id': field.id,
        'field': field.field,
      }).toList();

      return CommonResponse.success(fieldsData);
    } catch (e) {
      return CommonResponse.failed('获取字段列表失败: $e');
    }
  }

}

