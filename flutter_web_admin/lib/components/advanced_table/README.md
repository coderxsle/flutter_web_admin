# AdvancedTable 高级表格组件

一个功能完善的企业级 Flutter Web 表格组件，专为复杂的后台管理系统设计。

## 🚀 核心特性

### ✅ 已实现功能

- **✨ 数据管理**
  - 筛选：支持列级筛选、全局搜索、多条件组合（AND/OR）
  - 排序：支持多种数据类型的排序
  - 分页：支持前端分页和服务端分页
  - 数据处理流程：筛选 → 排序 → 分页

- **🎯 交互功能**
  - 行选择：支持单选、多选、全选、反选
  - 行展开：支持自定义展开内容
  - 行操作：单击、双击事件
  - 批量操作：批量删除、批量修改等

- **🎨 UI/UX**
  - 工具栏：刷新、全屏、边框切换、斑马纹切换
  - 列设置：显示/隐藏列
  - 响应式设计：支持不同屏幕尺寸
  - 主题支持：与项目主题系统集成

- **⚡ 性能优化**
  - 虚拟滚动：支持大数据量（10000+ 行）
  - GetX 状态管理：高效的响应式更新
  - 数据缓存：避免重复计算

- **🔧 高级功能**
  - 列拖拽排序
  - 列宽调整
  - 固定列（左侧/右侧）
  - 单元格编辑（文本、选择、日期）
  - 导出功能（CSV/Excel）
  - 自定义渲染

## 📦 安装

组件已集成在项目中，无需额外安装。如需导出功能，可添加以下依赖：

```yaml
dependencies:
  excel: ^4.0.6           # Excel 导出（可选）
  csv: ^6.0.0             # CSV 导出（可选）
```

## 🎯 快速开始

### 基础用法

```dart
import 'package:flutter_web_admin/components/advanced_table/advanced_table.dart';

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
      sortable: true,
    ),
  ],
  data: userList,
)
```

### 使用控制器

```dart
// 1. 创建控制器
final controller = AdvancedTableController<User>(
  selectionConfig: TableSelectionConfig(
    type: SelectionType.multiple,
    getRowKey: (user) => user.id.toString(),
  ),
  paginationConfig: TablePaginationConfig(
    pageSize: 20,
  ),
);

// 2. 设置数据
controller.setData(userList);

// 3. 使用表格
AdvancedTable<User>(
  controller: controller,
  columns: columns,
)
```

## 📚 配置说明

### TableColumnConfig 列配置

```dart
TableColumnConfig<T>(
  title: '列标题',              // 必填
  dataIndex: 'fieldName',       // 数据字段名
  width: 150,                   // 列宽
  minWidth: 50,                 // 最小宽度
  maxWidth: 500,                // 最大宽度
  align: TableColumnAlign.left, // 对齐方式
  sortable: true,               // 是否可排序
  filterable: true,             // 是否可筛选
  filterType: FilterType.text,  // 筛选类型
  resizable: true,              // 是否可调整宽度
  draggable: true,              // 是否可拖拽
  fixed: TableColumnFixed.left, // 固定列（左/右）
  show: true,                   // 是否显示
  hideable: true,               // 是否可隐藏
  
  // 自定义渲染
  cellBuilder: (context, record, index) {
    return Text(record.name);
  },
  
  // 自定义表头
  headerBuilder: (context) {
    return Text('自定义表头');
  },
  
  // 格式化函数
  formatter: (record) => record.name.toUpperCase(),
)
```

### TableSelectionConfig 选择配置

```dart
TableSelectionConfig<T>(
  type: SelectionType.multiple,  // 选择类型：none/single/multiple
  showSelectAll: true,            // 是否显示全选
  getRowKey: (record) => record.id.toString(),  // 获取行键
  onSelectionChange: (keys, rows) {
    // 选择变化回调
  },
  rowSelectable: (record) => true,  // 行是否可选
  fixedSelection: true,             // 固定选择列
  selectionWidth: 50,               // 选择列宽度
)
```

### TablePaginationConfig 分页配置

```dart
TablePaginationConfig(
  enabled: true,                  // 是否启用分页
  pageSize: 10,                   // 每页大小
  pageSizeOptions: [10, 20, 50],  // 每页大小选项
  showPageSize: true,             // 显示每页大小选择器
  showTotal: true,                // 显示总数
  serverSide: false,              // 是否服务端分页
  onPageLoad: (page, pageSize) async {
    // 服务端分页加载回调
  },
)
```

### TableExportConfig 导出配置

```dart
TableExportConfig(
  enableExcel: true,              // 启用 Excel 导出
  enableCSV: true,                // 启用 CSV 导出
  fileName: 'export_data',        // 文件名
  exportAllColumns: false,        // 导出所有列
  exportAllPages: false,          // 导出所有页
  formatters: {                   // 数据格式化
    'date': (value) => formatDate(value),
  },
)
```

## 🔥 高级用法

### 1. 筛选和排序

```dart
// 设置筛选
controller.setGlobalSearch('关键词');

// 添加列筛选
controller.addFilterCondition(FilterCondition(
  columnKey: 'status',
  type: FilterType.select,
  operator: FilterOperator.equals,
  value: 'active',
));

// 排序
controller.toggleSort('age');  // 切换排序
```

### 2. 行选择和批量操作

```dart
// 选择行
controller.selectRow(rowKey);

// 全选
controller.selectAll();

// 清空选择
controller.clearSelection();

// 反选
controller.invertSelection();

// 获取选中的数据
final selectedRows = controller.selectedRows;

// 批量删除
controller.removeAllData(selectedRows);
```

### 3. 展开行

```dart
AdvancedTable<User>(
  controller: controller,
  columns: columns,
  expandedBuilder: (context, record, index) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text('展开的详细内容'),
    );
  },
)

// 切换展开
controller.toggleRowExpansion(rowKey);
```

### 4. 单元格编辑

```dart
TableColumnConfig<User>(
  title: '姓名',
  dataIndex: 'name',
  cellBuilder: (context, record, index) {
    return TextCellEditor(
      initialValue: record.name,
      onSave: (value) {
        // 保存编辑
        record.name = value;
        controller.refresh();
      },
    );
  },
)
```

### 5. 自定义操作列

```dart
TableColumnConfig<User>(
  title: '操作',
  width: 180,
  fixed: TableColumnFixed.right,
  cellBuilder: (context, record, index) {
    return Row(
      children: [
        TextButton(
          onPressed: () => editUser(record),
          child: Text('编辑'),
        ),
        TextButton(
          onPressed: () => deleteUser(record),
          child: Text('删除'),
        ),
      ],
    );
  },
)
```

### 6. 虚拟滚动（大数据量）

```dart
AdvancedTable<User>(
  controller: controller,
  columns: columns,
  enableVirtualScroll: true,  // 启用虚拟滚动
  rowHeight: 48,              // 固定行高（虚拟滚动需要）
)
```

### 7. 服务端分页

```dart
final controller = AdvancedTableController<User>(
  paginationConfig: TablePaginationConfig(
    serverSide: true,
    onPageLoad: (page, pageSize) async {
      // 从服务器加载数据
      final response = await api.getUsers(page, pageSize);
      controller.setData(response.data);
      controller.setTotal(response.total);
    },
  ),
);
```

### 8. 导出数据

```dart
import 'package:flutter_web_admin/components/advanced_table/features/export/csv_exporter.dart';

// 导出 CSV
final csvContent = CSVExporter.exportToCSV(
  data: controller.displayData,
  columns: controller.columns,
  config: exportConfig,
);

// 下载文件
TableUtils.downloadFile(
  csvContent,
  CSVExporter.getFileName(exportConfig),
  'text/csv',
);
```

## 🎨 样式定制

表格组件会自动适配项目主题，包括：

- 主题色
- 暗色模式
- 字体样式
- 边框颜色
- 背景色

## 📝 完整示例

查看 `lib/modules/demo/pages/advanced_table_demo_page.dart` 获取完整的使用示例。

## 🛠️ API 参考

### AdvancedTableController 方法

#### 数据操作
- `setData(List<T> data)` - 设置数据
- `addData(T record)` - 添加单条数据
- `updateData(int index, T record)` - 更新数据
- `removeData(T record)` - 删除数据
- `clearData()` - 清空数据
- `refresh()` - 刷新表格

#### 筛选操作
- `setFilter(FilterModel filter)` - 设置筛选
- `addFilterCondition(FilterCondition condition)` - 添加筛选条件
- `removeFilterCondition(String columnKey)` - 移除筛选条件
- `setGlobalSearch(String search)` - 全局搜索
- `clearFilter()` - 清空筛选

#### 排序操作
- `setSort(SortModel sort)` - 设置排序
- `toggleSort(String columnKey)` - 切换排序
- `clearSort()` - 清空排序

#### 分页操作
- `setPage(int page)` - 设置页码
- `setPageSize(int size)` - 设置每页大小
- `nextPage()` - 下一页
- `previousPage()` - 上一页

#### 选择操作
- `selectRow(String rowKey)` - 选择行
- `unselectRow(String rowKey)` - 取消选择
- `toggleRowSelection(String rowKey)` - 切换选择
- `selectAll()` - 全选
- `clearSelection()` - 清空选择
- `invertSelection()` - 反选

#### 展开操作
- `expandRow(String rowKey)` - 展开行
- `collapseRow(String rowKey)` - 折叠行
- `toggleRowExpansion(String rowKey)` - 切换展开
- `expandAll()` - 展开所有
- `collapseAll()` - 折叠所有

#### 列操作
- `setColumns(List<TableColumnConfig<T>> columns)` - 设置列
- `updateColumn(String columnKey, TableColumnConfig<T> column)` - 更新列
- `toggleColumnVisibility(String columnKey)` - 切换列显示
- `reorderColumns(int oldIndex, int newIndex)` - 重新排序列
- `updateColumnWidth(String columnKey, double width)` - 更新列宽

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

