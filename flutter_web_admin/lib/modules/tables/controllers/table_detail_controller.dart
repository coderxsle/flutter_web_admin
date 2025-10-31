import 'package:get/get.dart';
import 'package:flutter_web_client/client.dart';
import 'package:flutter_web_admin/api/client.dart';
import 'package:flutter_web_admin/components/feedback/gi_acro_message.dart';

/// 表格详情控制器
class TableDetailController extends GetxController {
  /// 表格 ID
  int tableId = 0;

  /// 表格详情
  Rx<AirTableDetail?> tableDetail = Rx<AirTableDetail?>(null);

  /// 行列表
  final rows = <AirTableRows>[].obs;

  /// 单元格数据 Map<rowId, Map<fieldId, Items>>
  final items = RxMap<int, Map<int, AirTableItems>>();

  /// 加载状态
  final loading = false.obs;

  /// 当前页码
  final currentPage = 1.obs;

  /// 每页数量
  final pageSize = 20.obs;

  /// 总行数
  final totalRows = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // 优先使用已设置的 tableId，否则尝试从路由参数获取
    if (tableId == 0) {
      tableId = int.tryParse(Get.parameters['id'] ?? '0') ?? 0;
    }
    if (tableId > 0) {
      loadTableDetail();
      loadRows();
    }
  }

  /// 加载表格详情
  Future<void> loadTableDetail() async {
    try {
      loading.value = true;
      final result = await client.tables.tableDetail(tableId);
      tableDetail.value = AirTableDetail.fromJson(result.data);
      logger.d('✅ 加载表格详情成功: ${tableDetail.value?.name}, fields: ${tableDetail.value?.fields?.length}');
    } catch (e) {
      logger.d('❌ 加载表格详情失败: $e');
      GiArcoMessage.error('加载表格详情失败: $e');
    } finally {
      loading.value = false;
    }
  }

  /// 加载行数据
  Future<void> loadRows() async {
    try {
      loading.value = true;
      final pagination = Pagination(page: currentPage.value, pageSize: pageSize.value);
      final response = await client.tableRows.getTableRows(tableId, pagination);
      
      // 清空当前页的items数据（避免残留旧数据）
      items.clear();
      
      // 解析行数据和单元格数据（后端已一次性返回）
      final rowsList = <AirTableRows>[];
      for (final rowData in response.data as List) {
        final rowId = rowData['id'] as int?;
        final rowIndex = rowData['index'] as int?;
        final rowTablesId = rowData['tablesId'] as int?;
        
        // 跳过不完整的行数据
        if (rowId == null || rowIndex == null || rowTablesId == null) {
          continue;
        }
        
        // 解析行基本信息
        final row = AirTableRows(
          id: rowId,
          index: rowIndex,
          tablesId: rowTablesId,
        );
        rowsList.add(row);
        
        // 解析该行的单元格数据
        if (rowData['items'] != null) {
          final itemsList = rowData['items'] as List;
          final rowItems = <int, AirTableItems>{};
          
          for (final itemData in itemsList) {
            final itemId = itemData['id'] as int?;
            final itemValue = itemData['value'] as String?;
            final itemFieldId = itemData['fieldId'] as int?;
            
            // 跳过不完整的单元格数据
            if (itemValue == null || itemFieldId == null) {
              continue;
            }
            
            final item = AirTableItems(
              id: itemId,
              value: itemValue,
              fieldId: itemFieldId,
              rowId: rowId,
            );
            
            // 按 fieldId 存储单元格
            rowItems[itemFieldId] = item;
          }
          
          // 存储到items Map: items[rowId][fieldId] = item
          items[rowId] = rowItems;
        }
      }
      
      rows.value = rowsList;
      totalRows.value = response.total;
      logger.d('✅ 加载完成: ${rows.length} 行, ${items.length} 行单元格数据, 总数: ${totalRows.value}');
    } catch (e) {
      logger.d('❌ 加载行数据失败: $e');
      GiArcoMessage.error('加载行数据失败: $e');
    } finally {
      loading.value = false;
    }
  }

  /// 翻页
  void onPageChange(int page) {
    currentPage.value = page;
    loadRows();
  }

  /// 每页数量变化
  void onPageSizeChange(int size) {
    pageSize.value = size;
    currentPage.value = 1;
    loadRows();
  }

  // ==================== 字段管理 ====================

  /// 添加字段
  Future<void> addField(String fieldName) async {
    if (fieldName.isEmpty) {
      GiArcoMessage.warning('请输入字段名称');
      return;
    }

    try {
      final field = await client.airTableFields.createField(
        tableId,
        fieldName,
      );
      if (field.isSuccess) {
        GiArcoMessage.success('添加字段成功');
        loadTableDetail();
      } else {
        GiArcoMessage.error('添加字段失败: ${field.message}');
      }
    } catch (e) {
      GiArcoMessage.error('添加字段失败: $e');
    }
  }

  /// 编辑字段
  Future<void> editField(String field, String newName) async {
    if (newName.isEmpty) {
      GiArcoMessage.warning('请输入字段名称');
      return;
    }

    try {
      final result = await client.airTableFields.updateField(field, newName);
      if (result.isSuccess) {
        GiArcoMessage.success('更新字段成功');
        loadTableDetail();
      } else {
        GiArcoMessage.error('更新字段失败: ${result.message}');
      }
    } catch (e) {
      GiArcoMessage.error('更新字段失败: $e');
    }
  }

  /// 删除字段
  Future<void> deleteField(String field) async {
    try {
      final result = await client.airTableFields.deleteField(field);
      if (result.isSuccess) {
        GiArcoMessage.success('删除字段成功');
        loadTableDetail();
        loadRows(); // 重新加载行数据
      }
    } catch (e) {
      GiArcoMessage.error('删除字段失败: $e');
    }
  }

  // ==================== 行管理 ====================

  /// 添加行
  Future<void> addRow() async {
    try {
      // 新行的索引 = 当前总行数
      final newIndex = totalRows.value;
      final row = await client.tableRows.createRow(
        tableId,
        index: newIndex,
      );
      if (row.isSuccess) {
        GiArcoMessage.success('添加行成功');
        loadRows();
      }
    } catch (e) {
      GiArcoMessage.error('添加行失败: $e');
    }
  }

  /// 删除行
  Future<void> deleteRow(int rowId) async {
    try {
      final result = await client.tableRows.deleteRow(rowId);
      if (result.isSuccess) {
        GiArcoMessage.success('删除行成功');
        loadRows();
      }
    } catch (e) {
      GiArcoMessage.error('删除行失败: $e');
    }
  }

  // ==================== 单元格管理 ====================

  /// 更新单元格值
  Future<void> updateCellValue(int rowId, int fieldId, String value) async {
    try {
      final reslut = await client.tableItems.upsertItem(fieldId, value, rowId);
      if (reslut.isSuccess) {
        // 更新本地缓存
        if (items[rowId] == null) {
          items[rowId] = {};
        }
        // 创建 AirTableItems 对象
        final item = AirTableItems(
          value: value,
          rowId: rowId,
          fieldId: fieldId,
        );
        items[rowId]![fieldId] = item;
        items.refresh();
        GiArcoMessage.success('更新单元格成功');
      }
    } catch (e) {
      GiArcoMessage.error('更新单元格失败: $e');
    }
  }

  /// 设置单元格关联
  Future<void> setCellRelation({
    required int rowId,
    required int fieldId,
    required String value,
    required int tiedItemId,
    required int tiedFieldId,
    required int tiedTableId,
  }) async {
    try {
      final item = await client.tableItems.upsertItem(
        fieldId,
        value,
        rowId,
      );
      if (item.isSuccess) {
        GiArcoMessage.success('设置关联成功');
        // 更新本地缓存
        if (items[rowId] == null) {
          items[rowId] = {};
        }
        items[rowId]![fieldId] = item.data as AirTableItems;
        items.refresh();
      }
    } catch (e) {
      GiArcoMessage.error('设置关联失败: $e');
    }
  }

  /// 移除单元格关联
  Future<void> removeCellRelation(int itemId) async {
    try {
      final item = await client.tableItems.upsertItem(itemId, '', 0);
      if (item.isSuccess) {
        GiArcoMessage.success('移除关联成功');
        loadRows();
      } else {
        GiArcoMessage.error('移除关联失败: ${item.message}');
      }
    } catch (e) {
      GiArcoMessage.error('移除关联失败: $e');
    } finally {
      loading.value = false;
    }
  }

  /// 刷新
  void refresh() {
    loadTableDetail();
    loadRows();
  }
}
