import 'package:flutter/material.dart';
import '../../../components/advanced_table/advanced_table.dart';
import '../../../components/advanced_table/controller/advanced_table_controller.dart';
import '../../../components/advanced_table/config/table_column_config.dart';
import '../../../components/advanced_table/config/table_selection_config.dart';
import '../../../components/advanced_table/config/table_pagination_config.dart';
import '../../../components/advanced_table/config/table_export_config.dart';

/// 高级表格演示页面
class AdvancedTableDemoPage extends StatefulWidget {
  final String title;
  
  const AdvancedTableDemoPage({
    super.key,
    required this.title,
  });

  @override
  State<AdvancedTableDemoPage> createState() => _AdvancedTableDemoPageState();
}

class _AdvancedTableDemoPageState extends State<AdvancedTableDemoPage> {
  late AdvancedTableController<Map<String, dynamic>> _controller;

  @override
  void initState() {
    super.initState();
    
    // 创建控制器
    _controller = AdvancedTableController<Map<String, dynamic>>(
      selectionConfig: TableSelectionConfig<Map<String, dynamic>>(
        type: SelectionType.multiple,
        showSelectAll: true,
        getRowKey: (record) => record['id'].toString(),
        onSelectionChange: (keys, rows) {
          debugPrint('选中的行: $keys');
          // Trigger a rebuild when selection changes
          if (mounted) {
            setState(() {});
          }
        },
      ),
      paginationConfig: const TablePaginationConfig(
        enabled: true,
        pageSize: 10,
        showPageSize: true,
        showTotal: true,
        serverSide: false,
      ),
    );

    // 设置模拟数据
    _controller.setData(_generateMockData(100));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 生成模拟数据
  List<Map<String, dynamic>> _generateMockData(int count) {
    return List.generate(count, (index) {
      final id = index + 1;
      return {
        'id': id,
        'name': '用户$id',
        'account': 'user$id',
        'email': 'user$id@example.com',
        'age': 20 + (id % 40),
        'status': id % 3 == 0 ? '禁用' : '启用',
        'phone': '138${id.toString().padLeft(8, '0')}',
        'gender': id % 2 == 0 ? '男' : '女',
        'hobby': ['阅读', '音乐', '运动', '旅行', '游戏'][id % 5],
        'createTime': '2024-${((id % 12) + 1).toString().padLeft(2, '0')}-${((id % 28) + 1).toString().padLeft(2, '0')} 10:00:00',
        'address': '北京市朝阳区某某街道${id}号',
        'score': 60 + (id % 40),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 24, 8, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 页面标题
          _buildPageHeader(context),
          const SizedBox(height: 20),
          
          // 页面内容 - 可滚动区域
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 功能说明
                  _buildFeatureInfo(context),
                  const SizedBox(height: 20),
                  
                  // 批量操作栏
                  _buildBatchActionBar(context),
                  
                  // 表格
                  SizedBox(
                    height: 700, // 设置固定高度，让表格有足够空间
                    child: AdvancedTable<Map<String, dynamic>>(
                      controller: _controller,
                      columns: _buildColumns(),
                      title: '用户列表',
                      showToolbar: true,
                      showRefresh: true,
                      showFullscreen: true,
                      showBorderToggle: true,
                      showStripeToggle: true,
                      showColumnSetting: true,
                      showExport: true,
                      exportConfig: const TableExportConfig(
                        enableExcel: true,
                        enableCSV: true,
                        fileName: 'users',
                      ),
                      selectionConfig: _controller.selectionConfig,
                      paginationConfig: _controller.paginationConfig!,
                      onRefresh: () {
                        debugPrint('刷新数据');
                        _controller.refresh();
                      },
                      onRowTap: (record, index) {
                        debugPrint('点击行: ${record['name']}');
                      },
                      onRowDoubleTap: (record, index) {
                        debugPrint('双击行: ${record['name']}');
                        _showDetailDialog(record);
                      },
                      expandedBuilder: (context, record, index) {
                        return _buildExpandedContent(record);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建页面标题
  Widget _buildPageHeader(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.table_chart,
          size: 26,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 12),
        Text(
          widget.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  /// 构建功能说明
  Widget _buildFeatureInfo(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
              const SizedBox(width: 8),
              Text(
                '高级表格组件演示',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '这是一个功能完善的企业级表格组件，支持筛选、排序、分页、选择、展开行等功能',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '功能特性：',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '• 多选/单选支持，支持批量操作\n'
            '• 列排序、筛选功能\n'
            '• 列显示/隐藏、列拖拽排序\n'
            '• 分页支持（前端/服务端）\n'
            '• 展开行、自定义渲染\n'
            '• 导出功能（Excel/CSV）\n'
            '• 响应式设计、暗色主题支持\n'
            '• 虚拟滚动（大数据量优化）',
            style: TextStyle(
              fontSize: 13,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建批量操作栏
  Widget _buildBatchActionBar(BuildContext context) {
    // Use a more defensive approach to avoid setState during build
    // Store the selected keys in a local variable to avoid repeated access
    final selectedKeys = _controller.selectedRowKeys;
    final hasSelection = selectedKeys.isNotEmpty;
    
    if (!hasSelection) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Text(
            '已选择 ${selectedKeys.length} 项',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          TextButton.icon(
            onPressed: () {
              _controller.clearSelection();
              // 触发重建以更新批量操作栏
              if (mounted) {
                setState(() {});
              }
            },
            icon: const Icon(Icons.clear, size: 16),
            label: const Text('清空选择'),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {
              _batchDelete();
            },
            icon: const Icon(Icons.delete, size: 16),
            label: const Text('批量删除'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {
              _batchEnable();
            },
            icon: const Icon(Icons.check_circle, size: 16),
            label: const Text('批量启用'),
          ),
        ],
      ),
    );
  }

  /// 构建列配置
  List<TableColumnConfig<Map<String, dynamic>>> _buildColumns() {
    return [
      TableColumnConfig<Map<String, dynamic>>(
        title: 'ID',
        dataIndex: 'id',
        width: 80,
        sortable: true,
        fixed: TableColumnFixed.left,
        align: TableColumnAlign.center,
      ),
      TableColumnConfig<Map<String, dynamic>>(
        title: '姓名',
        dataIndex: 'name',
        width: 120,
        sortable: true,
        filterable: true,
      ),
      TableColumnConfig<Map<String, dynamic>>(
        title: '账户',
        dataIndex: 'account',
        width: 120,
        sortable: true,
      ),
      TableColumnConfig<Map<String, dynamic>>(
        title: '邮箱',
        dataIndex: 'email',
        width: 200,
      ),
      TableColumnConfig<Map<String, dynamic>>(
        title: '年龄',
        dataIndex: 'age',
        width: 80,
        sortable: true,
        align: TableColumnAlign.center,
      ),
      TableColumnConfig<Map<String, dynamic>>(
        title: '状态',
        dataIndex: 'status',
        width: 100,
        align: TableColumnAlign.center,
        cellBuilder: (context, record, index) {
          final status = record['status'];
          final isActive = status == '启用';
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? Colors.green[100] : Colors.red[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.green[700] : Colors.red[700],
              ),
            ),
          );
        },
      ),
      TableColumnConfig<Map<String, dynamic>>(
        title: '手机号',
        dataIndex: 'phone',
        width: 130,
      ),
      TableColumnConfig<Map<String, dynamic>>(
        title: '性别',
        dataIndex: 'gender',
        width: 80,
        align: TableColumnAlign.center,
      ),
      TableColumnConfig<Map<String, dynamic>>(
        title: '爱好',
        dataIndex: 'hobby',
        width: 100,
      ),
      TableColumnConfig<Map<String, dynamic>>(
        title: '分数',
        dataIndex: 'score',
        width: 80,
        sortable: true,
        align: TableColumnAlign.center,
      ),
      TableColumnConfig<Map<String, dynamic>>(
        title: '创建时间',
        dataIndex: 'createTime',
        width: 180,
        sortable: true,
      ),
      TableColumnConfig<Map<String, dynamic>>(
        title: '地址',
        dataIndex: 'address',
        width: 250,
      ),
      TableColumnConfig<Map<String, dynamic>>(
        title: '操作',
        width: 180,
        fixed: TableColumnFixed.right,
        align: TableColumnAlign.center,
        hideable: false,
        cellBuilder: (context, record, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: TextButton(
                  onPressed: () => _editUser(record),
                  child: const Text('编辑'),
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: () => _deleteUser(record),
                  child: const Text('删除', style: TextStyle(color: Colors.red)),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.expand_more, size: 20),
                onPressed: () {
                  final rowKey = record['id'].toString();
                  _controller.toggleRowExpansion(rowKey);
                },
              ),
            ],
          );
        },
      ),
    ];
  }

  /// 构建展开内容
  Widget _buildExpandedContent(Map<String, dynamic> record) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '详细信息',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoItem('ID', record['id'].toString()),
              const SizedBox(width: 32),
              _buildInfoItem('姓名', record['name']),
              const SizedBox(width: 32),
              _buildInfoItem('账户', record['account']),
              const SizedBox(width: 32),
              _buildInfoItem('邮箱', record['email']),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoItem('年龄', record['age'].toString()),
              const SizedBox(width: 32),
              _buildInfoItem('性别', record['gender']),
              const SizedBox(width: 32),
              _buildInfoItem('手机号', record['phone']),
              const SizedBox(width: 32),
              _buildInfoItem('爱好', record['hobby']),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoItem('地址', record['address']),
        ],
      ),
    );
  }

  /// 构建信息项
  Widget _buildInfoItem(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  /// 编辑用户
  void _editUser(Map<String, dynamic> record) {
    debugPrint('编辑用户: ${record['name']}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('编辑用户: ${record['name']}')),
    );
  }

  /// 删除用户
  void _deleteUser(Map<String, dynamic> record) {
    debugPrint('删除用户: ${record['name']}');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除用户 ${record['name']} 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              _controller.removeData(record);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('已删除用户: ${record['name']}')),
              );
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 批量删除
  void _batchDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除选中的 ${_controller.selectedRowKeys.length} 个用户吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              _controller.removeAllData(_controller.selectedRows);
              _controller.clearSelection();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('已批量删除用户')),
              );
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 批量启用
  void _batchEnable() {
    debugPrint('批量启用: ${_controller.selectedRowKeys.length} 个用户');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('批量启用 ${_controller.selectedRowKeys.length} 个用户')),
    );
  }

  /// 显示详情对话框
  void _showDetailDialog(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('用户详情'),
        content: SizedBox(
          width: 600,
          child: _buildExpandedContent(record),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
}


