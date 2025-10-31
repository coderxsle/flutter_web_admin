import 'package:flutter/material.dart';
import 'package:flutter_web_shared/shared.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../controllers/table_detail_controller.dart';
import '../widgets/create_field_dialog.dart';
import 'package:flutter_web_admin/components/button/gi_arco_button.dart';
import 'package:flutter_web_client/client.dart';
import 'package:flutter_web_admin/components/table/gi_table.dart';
import 'package:flutter_web_admin/components/table/gi_table_column.dart';
import 'package:trina_grid/trina_grid.dart';

/// 表格详情页面（类似 Excel）
class TableDetailPage extends GetView<TableDetailController> {
  const TableDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(init: TableDetailController(), builder: (controller) {
      return Scaffold(
      body: Column(
        children: [
          // 顶部工具栏
          _buildToolbar(context),
          const Divider(height: 1),
          
          // 表格内容
          Expanded(
            child: Obx(() {
              if (controller.loading.value && controller.rows.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return _buildTableView(context);
            }),
          ),
        ],
      ),
     );
    });
  }

  /// 构建工具栏
  Widget _buildToolbar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // 返回按钮
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/tables'),
          ),
          const SizedBox(width: 8),
          
          // 表格图标和名称
          const Icon(Icons.table_chart, size: 24),
          const SizedBox(width: 12),
          Obx(() => Text(
            controller.tableDetail.value?.name ?? '加载中...',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
          const Spacer(),
          
          // 搜索框
          SizedBox(
            width: 200,
            child: TextField(
              decoration: const InputDecoration(
                hintText: '搜索...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // 添加字段按钮
          GiArcoButton(
            icon: Icons.add,
            text: '添加字段',
            onPressed: () => _showAddFieldDialog(context),
          ),
          const SizedBox(width: 12),
          
          // 添加行按钮
          GiArcoButton(
            type: GiArcoButtonType.primary,
            icon: Icons.add,
            text: '添加行',
            onPressed: () => controller.addRow(),
          ),
        ],
      ),
    );
  }

  /// 构建表格视图
  Widget _buildTableView(BuildContext context) {
    return Obx(() {
      final fields = controller.tableDetail.value?.fields ?? [];
      final rows = controller.rows;

      print('🔍 UI 渲染检查: fields=${fields.length}, rows=${rows.length}');

      if (fields.isEmpty) {
        return _buildEmptyState(context);
      }

      // 使用 GiTable 组件
      return _buildGiTable(context, fields, rows);
    });
  }

  /// 构建 GiTable 表格
  Widget _buildGiTable(BuildContext context, List<AirTableFieldsSummary> fields, List<AirTableRows> rows) {
    // 1. 构建列配置
    final columns = <GiTableColumn>[
      // 行号列（冻结在左侧）
      GiTableColumn(
        title: 'id',
        field: '_rowNumber',
        width: 60,
        frozen: true,
        frozenPosition: TrinaColumnFrozen.start,
        readOnly: true,
        textAlign: TextAlign.center,
      ),
      
      // 动态字段列
      ...fields.map((field) => GiTableColumn(
        title: field.field,
        field: 'field_${field.id}',
        width: 150,
        titleRenderer: (context) => _buildFieldHeader(context, field),
        cellRenderer: (context, cell, rowIndex) => _buildFieldCell(
          context,
          cell,
          rowIndex,
          field,
          rows[rowIndex],
        ),
      )),
      
      // 操作列（冻结在右侧）
      GiTableColumn(
        title: '操作',
        field: '_actions',
        width: 80,
        frozen: true,
        frozenPosition: TrinaColumnFrozen.end,
        readOnly: true,
        cellRenderer: (context, cell, rowIndex) => _buildActionsCell(
          context,
          rows[rowIndex],
        ),
      ),
    ];
    
    // 2. 转换数据为 GiTable 需要的格式
    final tableData = rows.asMap().entries.map((entry) {
      final index = entry.key;
      final row = entry.value;
      final rowData = <String, dynamic>{
        'id': index, // 添加行索引，用于 onCellChanged 回调
        '_rowNumber': '${row.index + 1}',
        '_actions': '', // 占位，实际由 cellRenderer 渲染
      };
      
      // 添加每个字段的数据
      for (final field in fields) {
        final cellValue = controller.items[row.id!]?[field.id]?.value ?? '';
        rowData['field_${field.id}'] = cellValue;
      }
      
      return rowData;
    }).toList();
    
    // 3. 返回 GiTable
    return GiTable(
      columns: columns,
      data: tableData,
      initialBordered: true,
      initialStriped: true,
      initialSize: GiTableSize.medium,
      loading: controller.loading.value,
      noRowsWidget: _buildEmptyDataState(context),
      onCellChanged: (event) {
        logger.d('🔍 单元格值变化: ${event.column.title}, ${event.value}');
        
        // 查找对应的字段（使用 orElse 避免抛出异常）
        final field = fields.firstWhere(
          (field) => field.field == event.column.title,
          orElse: () {
            logger.w('⚠️ 未找到字段: ${event.column.title}，跳过编辑');
            return AirTableFieldsSummary(id: -1, field: ''); // 返回无效字段
          },
        );
        
        // 如果是无效字段（如行号列、操作列），直接返回
        if (field.id == -1) {
          return;
        }
        
        // 获取行数据（从 Map 中获取 id）
        logger.d('🔍 调试: event.row.data 类型: ${event.row.data.runtimeType}');
        logger.d('🔍 调试: event.row.data 内容: ${event.row.data}');
        
        final data = event.row.data as Map<String, dynamic>?;
        logger.d('🔍 调试: 转换后的 data: $data');
        
        final rowId = data?['id'] as int?;
        logger.d('🔍 调试: 获取到的 rowId: $rowId');
        
        if (rowId == null || rowId >= rows.length) {
          logger.w('⚠️ 无效的行索引: $rowId');
          return;
        }
        
        final row = rows[rowId];
        final currentValue = controller.items[row.id!]?[field.id]?.value ?? '';
        final currentItem = controller.items[row.id!]?[field.id];
        
        // 显示确认对话框
        _showConfirmDialog(
          context,
          row: row,
          field: field,
          currentValue: currentValue,
          newValue: event.value ?? '',
          currentItem: currentItem,
        );
      },
    );
  }
  
  /// 构建字段表头（带编辑/删除菜单）
  Widget _buildFieldHeader(BuildContext context, AirTableFieldsSummary field) {
    return Row(
      children: [
        Expanded(
          child: Text(
            field.field,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 4),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, size: 18),
          padding: EdgeInsets.zero,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 18),
                  SizedBox(width: 8),
                  Text('编辑'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 18, color: Colors.red),
                  SizedBox(width: 8),
                  Text('删除', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'edit') {
              _showEditFieldDialog(context, field.field);
            } else if (value == 'delete') {
              _confirmDeleteField(context, field.field);
            }
          },
        ),
      ],
    );
  }
  
  /// 构建字段单元格（可点击编辑）
  Widget _buildFieldCell(
    BuildContext context,
    TrinaCell cell,
    int rowIndex,
    AirTableFieldsSummary field,
    AirTableRows row,
  ) {
    final cellValue = controller.items[row.id!]?[field.id]?.value ?? '';
    final cellItem = controller.items[row.id!]?[field.id];
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: Text(
              cellValue.isEmpty ? '(空)' : cellValue,
              style: TextStyle(
                color: cellValue.isEmpty
                    ? Colors.grey[400]
                    : Colors.black87,
              ),
            ),
          ),
          // 如果有关联，显示关联图标
          if (cellItem?.item?.id != null)
            const Icon(
              Icons.link,
              size: 16,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }
  
  /// 构建操作列单元格
  Widget _buildActionsCell(BuildContext context, AirTableRows row) {
    return Center(
      child: IconButton(
        icon: const Icon(Icons.delete, size: 18),
        color: Colors.red,
        onPressed: () => _confirmDeleteRow(context, row),
        tooltip: '删除行',
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
  
  /// 构建空数据状态（在表格内部显示）
  Widget _buildEmptyDataState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 60,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            '暂无数据',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建空状态
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.grid_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            '表格还没有数据',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '添加字段和行来开始使用',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GiArcoButton(
                icon: Icons.add,
                text: '添加字段',
                onPressed: () => _showAddFieldDialog(context),
              ),
              const SizedBox(width: 12),
              GiArcoButton(
                type: GiArcoButtonType.primary,
                icon: Icons.add,
                text: '添加行',
                onPressed: () => controller.addRow(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 显示添加字段对话框
  void _showAddFieldDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateFieldDialog(
        onConfirm: (name) => controller.addField(name),
      ),
    );
  }

  /// 显示编辑字段对话框
  void _showEditFieldDialog(BuildContext context, String field) {
    showDialog(
      context: context,
      builder: (context) => CreateFieldDialog(
        initialName: field,
        title: '编辑字段',
        onConfirm: (name) => controller.editField(field, name),
      ),
    );
  }

  /// 确认删除字段
  void _confirmDeleteField(BuildContext context, String field) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除字段"$field"吗？此操作将删除该字段下的所有数据。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.deleteField(field);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  /// 确认删除行
  void _confirmDeleteRow(BuildContext context, AirTableRows row) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除第 ${row.index + 1} 行吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.deleteRow(row.id!);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  /// 显示确认修改对话框
  void _showConfirmDialog(
    BuildContext context, {
    required AirTableRows row,
    required AirTableFieldsSummary field,
    required String currentValue,
    required String newValue,
    AirTableItems? currentItem,
  }) {
    final tableName = controller.tableDetail.value?.name ?? '未知表';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
            SizedBox(width: 12),
            Text('确认修改'),
          ],
        ),
        content: SizedBox(
          width: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '您确定要进行以下修改吗？',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              
              // 修改信息卡片
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 表名
                    Row(
                      children: [
                        Icon(Icons.table_chart, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text(
                          '表名：',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            tableName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // 字段名
                    Row(
                      children: [
                        Icon(Icons.label, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text(
                          '字段：',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            field.field,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    const Divider(),
                    const SizedBox(height: 12),
                    
                    // 当前值
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '当前值：',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            currentValue.isEmpty ? '空值' : currentValue,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // 箭头
                    Icon(Icons.arrow_downward),
                    const SizedBox(height: 8),
                    
                    // 新值
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '新值：',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            newValue,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // 提示信息
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.orange[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '此操作将立即生效，请确认后再提交',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              // 先执行保存编辑后的值
              await controller.updateCellValue(row.id!, field.id, newValue);
              // 等待保存完成后，再刷新表格数据
              await controller.loadRows();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
  
}
