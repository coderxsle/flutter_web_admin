# GiTable - 基于 trina_grid 的增强表格组件

## 📋 概述

GiTable 是对 `trina_grid` (一个强大的 Flutter 表格组件) 的封装,完全复刻了 Vue 版 GiTable 对 Arco Design `<a-table>` 的封装方式。

### 核心特性

- ✅ **工具栏功能**: 斑马纹、刷新、全屏、边框、尺寸调整、列设置
- ✅ **数据自动适配**: 普通 Map 数据自动转换为 trina_grid 格式
- ✅ **列配置简化**: 提供用户友好的 API
- ✅ **内置功能**: 排序、筛选、分页、行选择、虚拟滚动
- ✅ **高性能**: 基于 trina_grid,支持大数据量
- ✅ **完全类型安全**: 泛型支持

## 🚀 快速开始

### 基础用法

```dart
import 'package:flutter_web_admin/components/table/gi_table/index.dart';

GiTable<Map<String, dynamic>>(
  title: '用户列表',
  columns: [
    GiTableColumn(
      title: '姓名',
      field: 'name',
      type: GiColumnType.text,
      width: 120,
    ),
    GiTableColumn(
      title: '年龄',
      field: 'age',
      type: GiColumnType.number,
      width: 80,
    ),
  ],
  data: [
    {'name': '张三', 'age': 20},
    {'name': '李四', 'age': 25},
  ],
  onRefresh: () => loadData(),
)
```

### 自定义单元格渲染

```dart
GiTableColumn<Map<String, dynamic>>(
  title: '状态',
  field: 'status',
  type: GiColumnType.number,
  cellRenderer: (context, cell, rowIndex) {
    return GiCellStatus(status: cell.value);
  },
)
```

### 启用行选择

```dart
GiTable(
  // ...其他配置
  enableRowSelection: true,
  multipleSelection: true,
  onRowSelectionChanged: (rows) {
    print('选中了 ${rows.length} 行');
  },
)
```

### 自定义工具栏按钮

```dart
GiTable(
  // ...其他配置
  customExtra: (context) => Row(
    children: [
      GiArcoButton(
        type: GiArcoButtonType.primary,
        text: '新增',
        icon: Icons.add,
        onPressed: () => onAdd(),
      ),
      GiArcoButton(
        text: '导出',
        icon: Icons.download,
        onPressed: () => onExport(),
      ),
    ],
  ),
)
```

### 冻结列

```dart
GiTableColumn(
  title: '操作',
  field: 'action',
  frozen: true,
  frozenPosition: TrinaColumnFrozen.end, // 冻结在右侧
  // ...
)
```

### 启用分页

GiTable 使用 GiPagination 组件作为自定义分页器，支持响应式设计和完整的分页功能。

#### 方式一：使用 GiTablePaginationController（推荐）

```dart
class _MyPageState extends State<MyPage> {
  late GiTablePaginationController _paginationController;
  List<Map<String, dynamic>> _tableData = [];
  final int _totalRecords = 500;
  
  @override
  void initState() {
    super.initState();
    _paginationController = GiTablePaginationController(pageSize: 20);
    _paginationController.setTotal(_totalRecords);
    _paginationController.addListener(_loadData);
    _loadData();
  }
  
  @override
  void dispose() {
    _paginationController.removeListener(_loadData);
    _paginationController.dispose();
    super.dispose();
  }
  
  Future<void> _loadData() async {
    // 根据 _paginationController.current 和 pageSize 加载数据
    final start = (_paginationController.current - 1) * _paginationController.pageSize;
    final end = start + _paginationController.pageSize;
    setState(() {
      _tableData = loadDataFromServer(start, end);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return GiTable(
      // ...其他配置
      data: _tableData,
      showPagination: true,
      currentPage: _paginationController.current,
      pageSize: _paginationController.pageSize,
      totalCount: _paginationController.total,
      onPageChange: _paginationController.onPageChange,
      onPageSizeChange: _paginationController.onPageSizeChange,
    );
  }
}
```

#### 方式二：手动管理分页状态

```dart
class _MyPageState extends State<MyPage> {
  int _currentPage = 1;
  int _pageSize = 20;
  int _total = 0;
  
  @override
  Widget build(BuildContext context) {
    return GiTable(
      // ...其他配置
      showPagination: true,
      currentPage: _currentPage,
      pageSize: _pageSize,
      totalCount: _total,
      onPageChange: (page) {
        setState(() {
          _currentPage = page;
        });
        _loadData();
      },
      onPageSizeChange: (pageSize) {
        setState(() {
          _pageSize = pageSize;
          _currentPage = 1;
        });
        _loadData();
      },
    );
  }
}
```

#### 分页特性

- ✅ 显示总数据量和当前页范围
- ✅ 支持每页条数选择器（10/20/50/100）
- ✅ 智能页码显示（超过7页使用省略号）
- ✅ 支持跳转到指定页码
- ✅ 响应式设计（移动端自动切换简单模式）
- ✅ Arco Design 风格样式

## 📖 API 文档

### GiTable Props

| 属性 | 类型 | 默认值 | 说明 |
|-----|------|-------|------|
| `title` | `String?` | - | 表格标题 |
| `columns` | `List<GiTableColumn>` | **必填** | 列配置 |
| `data` | `List<Map<String, dynamic>>` | **必填** | 数据源 |
| `showPagination` | `bool` | `false` | 是否显示分页 |
| `currentPage` | `int` | `1` | 当前页码（从1开始） |
| `pageSize` | `int` | `20` | 每页条数 |
| `totalCount` | `int` | `0` | 总条数 |
| `onPageChange` | `Function(int)?` | - | 页码变化回调 |
| `onPageSizeChange` | `Function(int)?` | - | 每页条数变化回调 |
| `enableRowSelection` | `bool` | `false` | 是否启用行选择 |
| `multipleSelection` | `bool` | `true` | 是否多选 |
| `onRefresh` | `VoidCallback?` | - | 刷新回调 |
| `customTitle` | `Widget Function(BuildContext)?` | - | 自定义标题区域 |
| `customExtra` | `Widget Function(BuildContext)?` | - | 自定义工具栏按钮 |
| `disabledColumnKeys` | `List<String>` | `[]` | 禁止列设置的列 |
| `loading` | `bool` | `false` | 加载状态 |
| `initialStriped` | `bool` | `false` | 初始斑马纹状态 |
| `initialBordered` | `bool` | `true` | 初始边框状态 |
| `initialSize` | `GiTableSize` | `medium` | 初始尺寸 |

### GiTableColumn Props

| 属性 | 类型 | 默认值 | 说明 |
|-----|------|-------|------|
| `title` | `String` | **必填** | 列标题 |
| `field` | `String` | **必填** | 字段名 |
| `type` | `GiColumnType` | `text` | 列类型 |
| `width` | `double?` | `100` | 列宽度 |
| `minWidth` | `double?` | `50` | 最小宽度 |
| `sortable` | `bool` | `true` | 是否可排序 |
| `filterable` | `bool` | `false` | 是否可筛选 |
| `frozen` | `bool` | `false` | 是否冻结 |
| `textAlign` | `TextAlign?` | - | 文本对齐 |
| `cellRenderer` | `Widget Function(...)？` | - | 自定义单元格渲染 |
| `formatter` | `String Function(dynamic)?` | - | 值格式化 |

### GiColumnType 枚举

- `text`: 文本类型
- `number`: 数字类型
- `date`: 日期类型
- `time`: 时间类型
- `datetime`: 日期时间类型
- `select`: 选择类型
- `currency`: 货币类型
- `percentage`: 百分比类型

### GiTableSize 枚举

- `mini`: 迷你 (行高 32px)
- `small`: 小型 (行高 40px)
- `medium`: 中等 (行高 48px)
- `large`: 大型 (行高 56px)

### GiTablePaginationController API

分页控制器，用于管理表格的分页状态。

#### 属性

| 属性 | 类型 | 说明 |
|-----|------|------|
| `current` | `int` | 当前页码（只读） |
| `pageSize` | `int` | 每页条数（只读） |
| `total` | `int` | 总数据量（只读） |
| `totalPages` | `int` | 总页数（只读） |

#### 方法

| 方法 | 参数 | 说明 |
|-----|------|------|
| `setTotal(int total)` | `total`: 总数据量 | 设置总数据量 |
| `onPageChange(int page)` | `page`: 页码 | 页码变化 |
| `onPageSizeChange(int pageSize)` | `pageSize`: 每页条数 | 每页条数变化（会重置到第一页） |
| `search()` | - | 搜索（重置到第一页） |
| `refresh()` | - | 刷新（保持当前页） |
| `reset()` | - | 重置所有状态 |

## 🎨 样式定制

### Arco Design 配色

组件使用 Arco Design 的默认配色:

- Primary Blue: `#165DFF`
- Border Color: `#E5E6EB`
- Striped BG: `#F7F8FA`

### 自定义主题

通过 Flutter 的 `ThemeData` 自动适配主题色。

## 🔧 高级用法

### 完整示例

查看 `lib/modules/demo/pages/gi_table_trina_demo_page.dart` 获取完整示例,包括:

- 自定义单元格渲染 (头像、状态、性别、标签)
- 操作列 (编辑、详情、删除)
- 行选择
- 工具栏按钮
- 分页
- 双击事件
- 冻结列

## 📊 与 trina_grid 对比

| 特性 | trina_grid | GiTable |
|------|-----------|---------|
| 数据格式 | TrinaRow/TrinaCell | 普通 Map (自动转换) |
| 工具栏 | 需自行实现 | ✅ 内置完整工具栏 |
| 列设置 | 需自行实现 | ✅ 拖拽排序 + 显隐 |
| 尺寸切换 | 需自行实现 | ✅ 4种尺寸一键切换 |
| 全屏 | 需自行实现 | ✅ 一键全屏 |
| API 复杂度 | 较高 | 简化友好 |

## 🎯 设计理念

### 数据适配层

GiTable 的核心是 `GiTableAdapter`,负责将用户友好的数据格式转换为 trina_grid 需要的格式:

```
用户数据 (List<Map>)
    ↓ 
GiTableAdapter
    ↓
TrinaGrid数据 (List<TrinaRow>)
```

这使得用户无需了解 trina_grid 的数据结构,直接使用普通的 Map 即可。

### 与 Vue 版本一致性

完全复刻 Vue 版 GiTable 的 API 设计:

| Vue | Flutter |
|-----|---------|
| `<GiTable :columns="..." :data="...">` | `GiTable(columns: ..., data: ...)` |
| `<template #custom-extra>` | `customExtra: (context) => ...` |
| `@refresh="onRefresh"` | `onRefresh: () => ...` |
| `:disabledColumnKeys="[...]"` | `disabledColumnKeys: [...]` |

## 🚀 性能优化

- ✅ 虚拟滚动 (trina_grid 内置)
- ✅ 懒加载支持
- ✅ 客户端/服务端分页
- ✅ 按需渲染单元格

## 📦 依赖

```yaml
dependencies:
  trina_grid: ^2.1.0
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request!

## 📝 License

MIT License

