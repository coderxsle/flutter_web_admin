# 如何添加新菜单

## 🎯 只需 3 步

### 步骤 1：打开配置文件

```bash
lib/config/menu_config.dart
```

### 步骤 2：添加菜单配置

在 `getStaticMenus()` 方法的数组中添加：

```dart
static List<MenuItem> getStaticMenus() {
  return [
    // 现有的菜单...
    
    // 👇 在这里添加你的新菜单
    _menu('/orders', '订单管理',
      iconData: Icons.shopping_bag,
      page: const OrderListPage(),
    ),
  ];
}
```

### 步骤 3：创建页面组件

创建对应的页面文件：

```dart
// lib/modules/orders/order_list_page.dart
import 'package:flutter/material.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('订单列表')),
      body: const Center(
        child: Text('订单列表页面'),
      ),
    );
  }
}
```

### 完成！🎉

运行项目，你会看到新菜单已经添加好了，包括：
- ✅ 菜单项显示
- ✅ 路由自动注册
- ✅ 页面导航
- ✅ 父菜单展开（如果是子菜单）

---

## 🎨 更多示例

### 添加带子菜单的菜单

```dart
_menu('/products', '商品管理',
  iconData: Icons.inventory,
  children: [
    _menu('/product_list', '商品列表',
      iconData: Icons.list,
      page: const ProductListPage(),
    ),
    _menu('/product_add', '添加商品',
      iconData: Icons.add_box,
      page: const ProductAddPage(),
    ),
  ],
),
```

### 添加多级嵌套菜单

```dart
_menu('/system', '系统管理',
  iconData: Icons.settings,
  children: [
    _menu('/users', '用户管理',
      iconData: Icons.people,
      children: [
        _menu('/user_list', '用户列表',
          iconData: Icons.list,
          page: const UserListPage(),
        ),
        _menu('/user_roles', '角色管理',
          iconData: Icons.admin_panel_settings,
          page: const UserRolesPage(),
        ),
      ],
    ),
    _menu('/logs', '系统日志',
      iconData: Icons.article,
      page: const SystemLogPage(),
    ),
  ],
),
```

### 使用 SVG 图标

```dart
_menu('/dashboard', '数据面板',
  svg: 'menu_chart.svg',  // SVG 文件放在 assets/images/ 目录下
  page: const DashboardPage(),
),
```

---

## ⚠️ 注意事项

1. **路由命名**：使用 `/` 开头，如 `/orders`
2. **叶子节点**：必须设置 `page` 参数
3. **父节点**：有 `children` 的节点不需要 `page`
4. **图标选择**：`iconData` 和 `svg` 二选一

---

## 🐛 常见问题

### Q: 添加后菜单不显示？
**A:** 检查是否正确添加到 `getStaticMenus()` 的返回数组中。

### Q: 点击菜单没反应？
**A:** 确保叶子节点设置了 `page` 参数。

### Q: 图标不显示？
**A:** 检查 `iconData` 是否正确，或 SVG 文件路径是否存在。

---

## 📖 需要更多帮助？

- 详细指南：`MENU_CONFIG_GUIDE.md`
- 代码示例：`menu_config_example.dart`
- 快速参考：`QUICK_REFERENCE.md`
- 完整说明：`README.md`

---

**就是这么简单！** 🚀



