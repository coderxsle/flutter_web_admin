# AdvancedTable 使用示例

## 目录

1. [基础表格](#基础表格)
2. [带选择的表格](#带选择的表格)
3. [带筛选和排序的表格](#带筛选和排序的表格)
4. [带分页的表格](#带分页的表格)
5. [带展开行的表格](#带展开行的表格)
6. [带单元格编辑的表格](#带单元格编辑的表格)
7. [带批量操作的表格](#带批量操作的表格)
8. [服务端分页表格](#服务端分页表格)
9. [虚拟滚动表格](#虚拟滚动表格)
10. [完整功能表格](#完整功能表格)

---

## 基础表格

最简单的表格，只显示数据。

```dart
AdvancedTable<User>(
  columns: [
    TableColumnConfig<User>(
      title: 'ID',
      dataIndex: 'id',
      width: 80,
    ),
    TableColumnConfig<User>(
      title: '姓名',
      dataIndex: 'name',
      width: 120,
    ),
    TableColumnConfig<User>(
      title: '邮箱',
      dataIndex: 'email',
      width: 200,
    ),
  ],
  data: users,
)
```

## 带选择的表格

支持单选或多选。

```dart
final controller = AdvancedTableController<User>(
  selectionConfig: TableSelectionConfig(
    type: SelectionType.multiple,
    showSelectAll: true,
    getRowKey: (user) => user.id.toString(),
    onSelectionChange: (keys, rows) {
      print('选中了 ${keys.length} 行');
    },
  ),
);

AdvancedTable<User>(
  controller: controller,
  columns: columns,
  selectionConfig: controller.selectionConfig,
)
```

## 带筛选和排序的表格

列支持筛选和排序功能。

```dart
AdvancedTable<User>(
  controller: controller,
  columns: [
    TableColumnConfig<User>(
      title: '姓名',
      dataIndex: 'name',
      sortable: true,
      filterable: true,
      filterType: FilterType.text,
    ),
    TableColumnConfig<User>(
      title: '年龄',
      dataIndex: 'age',
      sortable: true,
      filterable: true,
      filterType: FilterType.number,
      sorter: (a, b) => a.age.compareTo(b.age),
    ),
    TableColumnConfig<User>(
      title: '状态',
      dataIndex: 'status',
      filterable: true,
      filterType: FilterType.select,
      filterOptions: [
        FilterOption(label: '启用', value: 'active'),
        FilterOption(label: '禁用', value: 'inactive'),
      ],
    ),
  ],
)
```

## 带分页的表格

前端分页功能。

```dart
AdvancedTable<User>(
  controller: controller,
  columns: columns,
  paginationConfig: TablePaginationConfig(
    enabled: true,
    pageSize: 20,
    pageSizeOptions: [10, 20, 50, 100],
    showPageSize: true,
    showTotal: true,
  ),
)
```

## 带展开行的表格

点击展开查看详细信息。

```dart
AdvancedTable<User>(
  controller: controller,
  columns: [
    ...columns,
    TableColumnConfig<User>(
      title: '操作',
      width: 80,
      cellBuilder: (context, user, index) {
        final rowKey = user.id.toString();
        return IconButton(
          icon: Icon(
            controller.isRowExpanded(rowKey)
                ? Icons.expand_less
                : Icons.expand_more,
          ),
          onPressed: () {
            controller.toggleRowExpansion(rowKey);
          },
        );
      },
    ),
  ],
  expandedBuilder: (context, user, index) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('详细信息'),
          SizedBox(height: 8),
          Text('ID: ${user.id}'),
          Text('姓名: ${user.name}'),
          Text('邮箱: ${user.email}'),
          Text('地址: ${user.address}'),
        ],
      ),
    );
  },
)
```

## 带单元格编辑的表格

支持行内编辑。

```dart
import 'package:flutter_web_admin/components/advanced_table/features/cell_editor/text_editor.dart';

TableColumnConfig<User>(
  title: '姓名',
  dataIndex: 'name',
  cellBuilder: (context, user, index) {
    return TextCellEditor(
      initialValue: user.name,
      onSave: (value) {
        user.name = value;
        controller.updateData(index, user);
      },
    );
  },
)
```

## 带批量操作的表格

选中多行后进行批量操作。

```dart
Column(
  children: [
    // 批量操作栏
    Obx(() {
      if (!controller.hasSelection) {
        return SizedBox.shrink();
      }
      
      return BatchActionBar(
        selectedCount: controller.selectedRowKeys.length,
        onClearSelection: controller.clearSelection,
        onSelectAll: controller.selectAll,
        onInvertSelection: controller.invertSelection,
        actions: [
          BatchActionButton(
            icon: Icons.delete,
            label: '批量删除',
            isDangerous: true,
            onTap: () {
              controller.removeAllData(controller.selectedRows);
              controller.clearSelection();
            },
          ),
          BatchActionButton(
            icon: Icons.check_circle,
            label: '批量启用',
            onTap: () {
              // 批量启用逻辑
            },
          ),
        ],
      );
    }),
    
    // 表格
    Expanded(
      child: AdvancedTable<User>(
        controller: controller,
        columns: columns,
        selectionConfig: controller.selectionConfig,
      ),
    ),
  ],
)
```

## 服务端分页表格

从服务器加载数据。

```dart
final controller = AdvancedTableController<User>(
  paginationConfig: TablePaginationConfig(
    serverSide: true,
    pageSize: 20,
    onPageLoad: (page, pageSize) async {
      controller.setLoading(true);
      try {
        final response = await api.getUsers(
          page: page,
          pageSize: pageSize,
        );
        controller.setData(response.data);
        controller.setTotal(response.total);
      } finally {
        controller.setLoading(false);
      }
    },
  ),
);

// 首次加载
controller.paginationConfig!.onPageLoad!(1, 20);

AdvancedTable<User>(
  controller: controller,
  columns: columns,
  paginationConfig: controller.paginationConfig!,
)
```

## 虚拟滚动表格

支持大数据量（10000+ 行）。

```dart
AdvancedTable<User>(
  controller: controller,
  columns: columns,
  enableVirtualScroll: true,  // 启用虚拟滚动
  rowHeight: 48,              // 固定行高
  height: 600,                // 固定表格高度
  paginationConfig: TablePaginationConfig(
    enabled: false,           // 禁用分页
  ),
)
```

## 完整功能表格

综合所有功能的完整示例。

```dart
class MyTablePage extends StatefulWidget {
  @override
  _MyTablePageState createState() => _MyTablePageState();
}

class _MyTablePageState extends State<MyTablePage> {
  late AdvancedTableController<User> controller;

  @override
  void initState() {
    super.initState();
    
    controller = AdvancedTableController<User>(
      selectionConfig: TableSelectionConfig(
        type: SelectionType.multiple,
        showSelectAll: true,
        getRowKey: (user) => user.id.toString(),
      ),
      paginationConfig: TablePaginationConfig(
        pageSize: 20,
        pageSizeOptions: [10, 20, 50, 100],
      ),
    );
    
    loadData();
  }

  Future<void> loadData() async {
    controller.setLoading(true);
    try {
      final users = await api.getUsers();
      controller.setData(users);
    } finally {
      controller.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 批量操作栏
          Obx(() => _buildBatchActionBar()),
          
          // 表格
          Expanded(
            child: AdvancedTable<User>(
              controller: controller,
              title: '用户列表',
              showToolbar: true,
              showRefresh: true,
              showFullscreen: true,
              showColumnSetting: true,
              showExport: true,
              columns: _buildColumns(),
              selectionConfig: controller.selectionConfig,
              paginationConfig: controller.paginationConfig!,
              exportConfig: TableExportConfig(
                enableExcel: true,
                enableCSV: true,
                fileName: 'users',
              ),
              onRefresh: loadData,
              onRowTap: (user, index) {
                print('点击: ${user.name}');
              },
              expandedBuilder: (context, user, index) {
                return _buildExpandedContent(user);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBatchActionBar() {
    if (!controller.hasSelection) {
      return SizedBox.shrink();
    }
    
    return BatchActionBar(
      selectedCount: controller.selectedRowKeys.length,
      onClearSelection: controller.clearSelection,
      onSelectAll: controller.selectAll,
      actions: [
        BatchActionButton(
          icon: Icons.delete,
          label: '删除',
          isDangerous: true,
          onTap: _batchDelete,
        ),
        BatchActionButton(
          icon: Icons.edit,
          label: '编辑',
          onTap: _batchEdit,
        ),
      ],
    );
  }

  List<TableColumnConfig<User>> _buildColumns() {
    return [
      TableColumnConfig<User>(
        title: 'ID',
        dataIndex: 'id',
        width: 80,
        fixed: TableColumnFixed.left,
        sortable: true,
      ),
      TableColumnConfig<User>(
        title: '姓名',
        dataIndex: 'name',
        width: 120,
        sortable: true,
        filterable: true,
        filterType: FilterType.text,
      ),
      TableColumnConfig<User>(
        title: '邮箱',
        dataIndex: 'email',
        width: 200,
      ),
      TableColumnConfig<User>(
        title: '年龄',
        dataIndex: 'age',
        width: 80,
        sortable: true,
        align: TableColumnAlign.center,
      ),
      TableColumnConfig<User>(
        title: '状态',
        dataIndex: 'status',
        width: 100,
        filterable: true,
        filterType: FilterType.select,
        filterOptions: [
          FilterOption(label: '启用', value: 'active'),
          FilterOption(label: '禁用', value: 'inactive'),
        ],
        cellBuilder: (context, user, index) {
          final isActive = user.status == 'active';
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? Colors.green[100] : Colors.red[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isActive ? '启用' : '禁用',
              style: TextStyle(
                color: isActive ? Colors.green[700] : Colors.red[700],
              ),
            ),
          );
        },
      ),
      TableColumnConfig<User>(
        title: '操作',
        width: 150,
        fixed: TableColumnFixed.right,
        cellBuilder: (context, user, index) {
          return Row(
            children: [
              TextButton(
                onPressed: () => _editUser(user),
                child: Text('编辑'),
              ),
              TextButton(
                onPressed: () => _deleteUser(user),
                child: Text('删除'),
              ),
            ],
          );
        },
      ),
    ];
  }

  Widget _buildExpandedContent(User user) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('详细信息', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('地址: ${user.address}'),
          Text('电话: ${user.phone}'),
          Text('备注: ${user.remark}'),
        ],
      ),
    );
  }

  void _editUser(User user) {
    // 编辑用户逻辑
  }

  void _deleteUser(User user) {
    // 删除用户逻辑
  }

  void _batchDelete() {
    controller.removeAllData(controller.selectedRows);
    controller.clearSelection();
  }

  void _batchEdit() {
    // 批量编辑逻辑
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
```

## 实际项目示例

查看完整的实现示例：
- `lib/modules/demo/pages/advanced_table_demo_page.dart`

## 技巧和最佳实践

1. **使用控制器管理状态**
   - 推荐使用控制器来管理表格状态
   - 控制器提供了丰富的 API 来操作数据

2. **合理使用固定列**
   - 左侧固定选择列、ID 列等
   - 右侧固定操作列

3. **优化性能**
   - 大数据量时启用虚拟滚动
   - 使用服务端分页减少前端压力

4. **自定义渲染**
   - 使用 `cellBuilder` 自定义单元格
   - 使用 `headerBuilder` 自定义表头

5. **响应式设计**
   - 表格会自动适配屏幕大小
   - 移动端会简化显示

6. **主题集成**
   - 表格自动使用项目主题
   - 支持亮色/暗色模式

