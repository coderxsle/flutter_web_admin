# Airtable 模块实现文档

## 📋 概述

基于实施计划文档实现的 Airtable 动态表格管理系统,提供完整的表格、字段、行和单元格管理功能。

## 🏗️ 项目结构

```
lib/modules/tables/
├── controllers/           # 控制器
│   ├── table_list_controller.dart      # 表格列表控制器
│   └── table_detail_controller.dart    # 表格详情控制器
├── services/             # 服务层
│   └── airtable_service.dart           # API 服务封装
├── views/                # 视图页面
│   ├── table_list_page.dart            # 表格列表页面
│   └── table_detail_page.dart          # 表格详情页面(类似Excel)
├── widgets/              # 组件
│   ├── create_table_dialog.dart        # 创建表格对话框
│   ├── create_field_dialog.dart        # 创建字段对话框
│   └── edit_cell_dialog.dart           # 编辑单元格对话框
├── router/               # 路由配置
│   └── tables_router.dart              # 模块路由
└── README.md            # 本文档
```

## ⚙️ 安装步骤

### 1. 生成 Serverpod 客户端代码

在服务端项目根目录运行:

```bash
cd flutter_web_server
serverpod generate
```

这将生成客户端所需的 endpoint 代码,包括 `airtable` endpoint。

### 2. 更新路由配置

在 `lib/router/app_router.dart` 中添加 airtable 路由:

```dart
// 导入
import 'package:flutter_web_admin/modules/tables/router/tables_router.dart';

// 在 GoRouter 的 routes 中添加:
GoRoute(
  path: '/airtable/tables',
  name: 'airtable_tables',
  builder: (context, state) {
    Get.put(TableListController());
    return const TableListPage();
  },
),
GoRoute(
  path: '/airtable/tables/:id',
  name: 'airtable_table_detail',
  builder: (context, state) {
    Get.put(TableDetailController());
    return const TableDetailPage();
  },
),
```

### 3. 添加到侧边栏菜单

在 `lib/modules/layout/static/static.dart` 的菜单配置中添加:

```dart
Menu(
  id: 'airtable',
  parentId: null,
  name: 'Airtable',
  icon: Icons.table_chart,
  path: '/airtable/tables',
  children: [],
),
```

## 🎨 功能特性

### 1. 表格列表页面

**路由:** `/airtable/tables`

**功能:**
- ✅ 卡片式展示所有表格
- ✅ 显示字段数、行数统计
- ✅ 搜索表格
- ✅ 创建新表格
- ✅ 删除表格
- ✅ 点击进入详情

### 2. 表格详情页面

**路由:** `/airtable/tables/:id`

**功能:**
- ✅ Excel 风格的数据表格显示
- ✅ 动态列(字段)管理
  - 添加字段
  - 编辑字段
  - 删除字段
- ✅ 行管理
  - 添加行
  - 删除行
- ✅ 单元格编辑
  - 双击编辑
  - 文本输入
  - 数据关联设置
  - 移除关联

### 3. 关联功能

- ✅ 跨表格数据关联
- ✅ 搜索可关联数据
- ✅ 显示关联状态
- ✅ 移除关联关系

## 🔌 API 服务

`AirtableService` 提供了完整的 API 封装:

### 表格管理
- `getTables()` - 获取表格列表(分页)
- `getTableDetail()` - 获取表格详情
- `createTable()` - 创建表格
- `updateTable()` - 更新表格
- `deleteTable()` - 删除表格

### 字段管理
- `getFields()` - 获取字段列表
- `createField()` - 创建字段
- `updateField()` - 更新字段
- `deleteField()` - 删除字段

### 行管理
- `getRows()` - 获取行列表(分页)
- `createRow()` - 创建行
- `updateRow()` - 更新行
- `deleteRow()` - 删除行

### 单元格管理
- `getItems()` - 获取单元格数据
- `upsertItem()` - 创建/更新单元格
- `deleteItem()` - 删除单元格
- `removeRelation()` - 移除关联

### 关联管理
- `searchRelationItems()` - 搜索可关联数据

## 🎯 使用示例

### 创建表格

```dart
await AirtableService.createTable('客户管理');
```

### 添加字段

```dart
await AirtableService.createField(
  tableId: 1,
  fieldName: '客户姓名',
);
```

### 更新单元格

```dart
await AirtableService.upsertItem(
  rowId: 1,
  fieldId: 1,
  value: '张三',
);
```

### 设置单元格关联

```dart
await AirtableService.upsertItem(
  rowId: 1,
  fieldId: 1,
  value: '张三',
  tiedTableId: 2,    // 关联到表格2
  tiedFieldId: 3,    // 关联到字段3
  tiedItemId: 5,     // 关联到具体数据5
);
```

## 🧩 组件复用

本模块完全基于现有组件实现:

- **GiArcoButton** - 所有操作按钮
- **GiInput** - 搜索输入框
- **GiArcoMessage** - 消息提示
- **DataTable** - 原生 Flutter 表格组件
- **Dialog** - 原生对话框组件

## 🔧 待优化项

1. **虚拟滚动** - 大数据量时的性能优化
2. **批量操作** - 批量删除行/字段
3. **拖拽排序** - 行的拖拽重新排序
4. **数据导入导出** - Excel/CSV 导入导出
5. **字段类型** - 不同类型字段的验证和渲染
6. **权限控制** - 表格的访问权限管理

## 📝 注意事项

1. **数据一致性**: 删除表格/字段时会级联删除相关数据
2. **分页加载**: 大数据量表格使用分页加载
3. **错误处理**: 所有操作都有错误提示
4. **关联验证**: 设置关联前需验证目标数据存在

## 🚀 启动访问

完成上述配置后,访问:

```
http://localhost:port/airtable/tables
```

即可开始使用 Airtable 功能。

## 📚 相关文档

- [后端 API 文档](../../../flutter_web_server/lib/src/endpoints/airtable/README.md)
- [实施计划](../../../flutter_web_server/lib/src/models/airtable/IMPLEMENTATION_PLAN.md)
- [快速开始](../../../flutter_web_server/lib/src/endpoints/airtable/QUICK_START.md)




