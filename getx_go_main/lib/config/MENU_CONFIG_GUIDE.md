# 菜单配置指南

## 📖 概述

新的菜单系统让你只需在**一个地方**配置菜单，系统会自动处理：
- ✅ 路由注册
- ✅ 父子关系展开
- ✅ 菜单层级管理
- ✅ 服务器动态菜单支持

## 🚀 快速开始

### 1. 添加新菜单（本地静态菜单）

只需在 `lib/config/menu_config.dart` 的 `getStaticMenus()` 方法中添加：

```dart
// 在 menu_config.dart 中
static List<MenuItem> getStaticMenus() {
  return [
    // 添加新菜单就这么简单！
    _menu('/my_new_page', '我的新页面',
      iconData: Icons.new_releases,
      page: const MyNewPage(),
    ),
    
    // 或者添加带子菜单的
    _menu('/settings', '系统设置',
      iconData: Icons.settings,
      children: [
        _menu('/basic_settings', '基础设置',
          iconData: Icons.settings_applications,
          page: const BasicSettingsPage(),
        ),
      ],
    ),
  ];
}
```

**就这样！** 不需要在其他地方做任何修改！

### 2. 菜单参数说明

```dart
_menu(
  '/route',           // 路由路径（必填）
  '菜单标题',          // 显示的标题（必填）
  iconData: Icons.xxx, // Flutter 图标（可选）
  svg: 'icon.svg',    // SVG 图标（可选，与 iconData 二选一）
  page: const XXPage(), // 页面组件（叶子节点必填）
  children: [],       // 子菜单列表（可选）
)
```

## 🌐 服务器动态菜单

### 1. 服务器返回的菜单格式

```json
[
  {
    "route": "/home",
    "title": "首页",
    "iconData": "home",
    "componentName": "HomePage"
  },
  {
    "route": "/users",
    "title": "用户管理",
    "iconData": "people",
    "children": [
      {
        "route": "/user_list",
        "title": "用户列表",
        "iconData": "people",
        "componentName": "UserListPage"
      }
    ]
  }
]
```

### 2. 实现服务器菜单接口

在 `lib/services/menu_service.dart` 中修改 `_fetchMenusFromServer` 方法：

```dart
Future<List<MenuItem>> _fetchMenusFromServer() async {
  try {
    // 调用你的 API
    final response = await http.get(
      Uri.parse('https://your-api.com/api/menus')
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return MenuConfig.fromServerData(
        data.map((e) => e as Map<String, dynamic>).toList()
      );
    }
    
    // 失败时使用本地菜单
    return MenuConfig.getStaticMenus();
  } catch (e) {
    print('获取服务器菜单失败: $e');
    return MenuConfig.getStaticMenus();
  }
}
```

### 3. 切换菜单模式

在控制器中：

```dart
// 切换到服务器菜单
await controller.switchToServerMenus();

// 切换回本地菜单
controller.switchToLocalMenus();

// 刷新菜单
await controller.refreshMenus();
```

## 🎯 高级功能

### 1. 图标映射配置

如果服务器返回图标名称字符串，在 `menu_config.dart` 中配置映射：

```dart
static IconData? _parseIconData(String iconName) {
  final iconMap = {
    'home': Icons.home,
    'dashboard': Icons.dashboard,
    'people': Icons.people,
    'settings': Icons.settings,
    // 添加更多图标映射
  };
  return iconMap[iconName];
}
```

### 2. 页面工厂配置

如果服务器返回组件名称，配置页面工厂：

```dart
static Widget? _getPageByName(String componentName) {
  final pageMap = {
    'HomePage': const HomePage(),
    'DashboardPage': const DashboardPage(),
    'UserListPage': UserListPage(),
    // 添加更多页面映射
  };
  return pageMap[componentName];
}
```

### 3. 权限过滤

在 `menu_service.dart` 中实现权限过滤：

```dart
List<MenuItem> filterMenusByPermissions(
  List<MenuItem> menus, 
  List<String> userPermissions
) {
  return menus.where((menu) {
    // 实现你的权限逻辑
    return hasPermission(menu, userPermissions);
  }).map((menu) {
    if (menu.hasChildren) {
      final filteredChildren = filterMenusByPermissions(
        menu.children!, 
        userPermissions
      );
      return menu.copyWith(children: filteredChildren);
    }
    return menu;
  }).toList();
}
```

## 📝 迁移指南

### 旧的方式（需要修改多处）：

```dart
// ❌ 需要在控制器中配置菜单
menuItems.value = [
  item('/home', '首页', ...),
];

// ❌ 需要手动维护父子关系
final menuHierarchy = {
  'user_list': ['/users'],
  'user_roles': ['/users'],
};
```

### 新的方式（只需一处配置）：

```dart
// ✅ 只在 menu_config.dart 中配置
static List<MenuItem> getStaticMenus() {
  return [
    _menu('/home', '首页', ...),
  ];
}
// 父子关系自动处理！
```

## 🔧 工具类使用

### MenuUtils 提供的功能：

```dart
// 查找菜单
MenuUtils.findMenuByRoute(menuItems, '/home');

// 获取页面
MenuUtils.getPageByRoute(menuItems, '/home');

// 自动构建层级关系
MenuUtils.buildMenuHierarchy(menuItems);

// 展开父菜单
MenuUtils.ensureParentMenusExpanded(menuItems, route, hierarchy, refresh);

// 搜索菜单
MenuUtils.searchMenus(menuItems, '用户');

// 获取所有路由
MenuUtils.getAllRoutes(menuItems);
```

## 💡 最佳实践

1. **菜单配置集中管理**：所有菜单只在 `menu_config.dart` 中配置
2. **使用 SVG 图标**：对于自定义图标，使用 SVG 文件
3. **权限控制**：在服务器端返回用户有权限的菜单
4. **缓存策略**：MenuService 自动缓存菜单，减少请求
5. **降级处理**：服务器菜单获取失败时自动使用本地菜单

## 🎨 示例

### 完整的菜单配置示例：

```dart
_menu('/products', '商品管理',
  iconData: Icons.shopping_cart,
  children: [
    _menu('/product_list', '商品列表',
      iconData: Icons.list,
      page: const ProductListPage(),
    ),
    _menu('/categories', '分类管理',
      iconData: Icons.category,
      children: [
        _menu('/category_list', '分类列表',
          iconData: Icons.list,
          page: const CategoryListPage(),
        ),
        _menu('/category_tree', '分类树',
          iconData: Icons.account_tree,
          page: const CategoryTreePage(),
        ),
      ],
    ),
  ],
),
```

## 🐛 故障排除

### 问题：添加新菜单后页面不显示

**解决**：检查菜单配置中是否设置了 `page` 参数

### 问题：父菜单不自动展开

**解决**：确保调用了 `MenuUtils.buildMenuHierarchy()` 构建层级关系

### 问题：服务器菜单加载失败

**解决**：
1. 检查 API 地址是否正确
2. 检查返回的 JSON 格式是否符合要求
3. 查看控制台错误日志
4. 系统会自动降级使用本地菜单

## 📚 相关文件

- `lib/config/menu_config.dart` - 菜单配置（主要配置文件）
- `lib/services/menu_service.dart` - 菜单服务
- `lib/utils/menu_utils.dart` - 菜单工具类
- `lib/models/menu_item.dart` - 菜单模型
- `lib/modules/layout/controllers/layout_admin_controller.dart` - 布局控制器

## 🎉 总结

使用新的菜单系统，你只需要：

1. 在 `menu_config.dart` 中添加菜单配置
2. 创建对应的页面组件
3. 完成！系统自动处理其他所有事情

不需要再维护复杂的路由关系和层级结构！

