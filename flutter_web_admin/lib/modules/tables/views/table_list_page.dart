import 'package:flutter/material.dart';
import 'package:flutter_web_admin/theme/theme.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../controllers/table_list_controller.dart';
import '../controllers/table_detail_controller.dart';
import '../widgets/create_table_dialog.dart';
import 'package:flutter_web_admin/components/button/gi_arco_button.dart';
import 'package:flutter_web_client/client.dart';
import 'package:intl/intl.dart';

/// 表格列表页面
class TableListPage extends GetView<TableListController> {
  const TableListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(init: TableListController(), builder: (controller) {
      return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题栏
            _buildHeader(context),
            const SizedBox(height: 24),
            
            // 表格卡片列表
            Expanded(
              child: Obx(() {
                if (controller.loading.value && controller.tables.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.tables.isEmpty) {
                  return _buildEmptyState(context);
                }

                return _buildTableGrid(context);
              }),
            ),
          ],
        ),
      ),  
    );
    });
  }

  /// 构建标题栏
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // 标题
        const Icon(Icons.table_chart, size: 32),
        const SizedBox(width: 12),
        const Text(
          'Airtable 管理',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        
        // 搜索框
        SizedBox(
          width: 300,
          child: TextField(
            decoration: const InputDecoration(
              hintText: '搜索表格...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            onChanged: (value) => controller.searchTables(value),
          ),
        ),
        const SizedBox(width: 16),
        
        // 新建表格按钮
        GiArcoButton(
          type: GiArcoButtonType.primary,
          icon: Icons.add,
          text: '新建表格',
          onPressed: () => _showCreateTableDialog(context),
        ),
      ],
    );
  }

  /// 构建表格卡片网格
  Widget _buildTableGrid(BuildContext context) {
    return Obx(() {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 320,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: controller.tables.length,
        itemBuilder: (context, index) {
          final table = controller.tables[index];
          return _buildTableCard(context, table);
        },
      );
    });
  }

  /// 构建单个表格卡片
  Widget _buildTableCard(BuildContext context, AirTables table) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    
    return Card(
      elevation: 2,
      child: InkWell(
        hoverColor: context.themeColors.primaryHover,
        onTap: () => _navigateToDetail(context, table.id!),
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 图标和名称
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.table_chart,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      table.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // 统计信息
              _buildStatRow(
                icon: Icons.view_column,
                label: '字段数量',
                value: '${table.fields?.length ?? 0} 个',
              ),
              const SizedBox(height: 8),
              _buildStatRow(
                icon: Icons.table_rows,
                label: '行数',
                value: '${table.rows?.length ?? 0} 行',
              ),
              const Spacer(),
              
              // 底部操作栏
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateFormat.format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => _navigateToDetail(context, table.id!),
                        child: const Text('查看'),
                      ),
                      TextButton(
                        onPressed: () => _confirmDelete(context, table),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('删除'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建统计行
  Widget _buildStatRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// 构建空状态
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.table_chart_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            '暂无表格',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '点击右上角"新建表格"开始创建',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          GiArcoButton(
            type: GiArcoButtonType.primary,
            icon: Icons.add,
            text: '新建表格',
            onPressed: () => _showCreateTableDialog(context),
          ),
        ],
      ),
    );
  }

  /// 显示创建表格对话框
  void _showCreateTableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateTableDialog(
        onConfirm: (name) {
          controller.createTable(name);
        },
      ),
    );
  }

  /// 确认删除
  void _confirmDelete(BuildContext context, AirTables table) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除表格"${table.name}"吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.deleteTable(table.id!);
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

  /// 导航到详情页
  void _navigateToDetail(BuildContext context, int tableId) {
    // 使用 GetX 传递参数到详情页
    Get.delete<TableDetailController>(); // 删除旧的控制器实例
    Get.lazyPut(() {
      final controller = TableDetailController();
      controller.tableId = tableId; // 直接设置 tableId
      return controller;
    });
    context.go('/table_detail');
  }
}

