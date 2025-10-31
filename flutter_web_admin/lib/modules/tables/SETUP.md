# Airtable 模块集成步骤

## ⚠️ 重要提示

在使用本模块之前,必须先完成以下步骤:

## 第一步:生成 Serverpod 客户端代码

在服务端项目根目录运行:

```bash
cd /Users/coderxslee/workspace/flutter_web_admin/flutter_web_server
serverpod generate
```

这将生成:
- 客户端 endpoint 代码
- 协议类的更新
- 包括 `airtable` endpoint

## 第二步:在路由中添加 Airtable 页面

找到 `lib/router/app_router.dart`,并手动添加以下路由:

### 方式一:直接添加到 GoRouter.routes

```dart
import 'package:flutter_web_admin/modules/tables/views/table_list_page.dart';
import 'package:flutter_web_admin/modules/tables/views/table_detail_page.dart';
import 'package:flutter_web_admin/modules/tables/controllers/table_list_controller.dart';
import 'package:flutter_web_admin/modules/tables/controllers/table_detail_controller.dart';

// 在 routes 数组中添加:
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

### 方式二:使用 LayoutAdminRouter (如果支持)

如果你的项目使用 `LayoutAdminRouter`,可能需要在对应的配置中添加页面注册。

## 第三步:添加到侧边栏菜单 (可选)

找到 `lib/modules/layout/static/static.dart` 或菜单配置文件,添加菜单项:

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

## 第四步:测试访问

完成以上步骤后,重新运行项目并访问:

```
http://localhost:port/airtable/tables
```

## 常见问题

### Q1: `The getter 'airtable' isn't defined for the type 'Client'`

**解决方案:** 你还没有运行 `serverpod generate`。请完成第一步。

### Q2: 页面无法访问 404

**解决方案:** 检查路由配置是否正确添加。

### Q3: 运行时报错 `Client` 相关错误

**解决方案:** 
1. 确保运行了 `serverpod generate`
2. 确保服务端的 `airtable_endpoint.dart` 已正确创建
3. 重启 Flutter 应用

## 验证安装

运行以下命令检查是否生成了 airtable endpoint:

```bash
# 检查客户端代码
grep -r "airtable" flutter_web_client/lib/src/protocol/client.dart

# 应该看到类似:
# late final EndpointAirtable airtable;
```

如果看到了,说明生成成功! 🎉




