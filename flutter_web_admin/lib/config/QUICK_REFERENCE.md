# 菜单系统快速参考

## 📌 添加新菜单（最常用）

### 在 `lib/config/menu_config.dart` 中：

```dart
static List<MenuItem> getStaticMenus() {
  return [
    // 👇 在这里添加你的菜单
    _menu('/your_route', '菜单标题',
      iconData: Icons.your_icon,
      page: const YourPage(),
    ),
  ];
}
```

**就这么简单！不需要修改其他任何地方！**

---

## 🎨 常用配置模板

### 1️⃣ 简单菜单（无子菜单）
```dart
_menu('/orders', '订单管理',
  iconData: Icons.shopping_bag,
  page: const OrderListPage(),
),
```

### 2️⃣ 带子菜单
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

### 3️⃣ 使用 SVG 图标
```dart
_menu('/dashboard', '仪表板',
  svg: 'menu_chart.svg',
  page: const DashboardPage(),
),
```

### 4️⃣ 多级嵌套菜单
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
      ],
    ),
  ],
),
```

---

## 🔧 控制器常用方法

```dart
final controller = Get.find<LayoutAdminController>();

// 导航到页面
controller.navigateToPage('/home');

// 刷新菜单
await controller.refreshMenus();

// 切换到服务器菜单
await controller.switchToServerMenus();

// 切换到本地菜单
controller.switchToLocalMenus();
```

---

## 🛠 工具类常用方法

```dart
// 查找菜单
final menu = MenuUtils.findMenuByRoute(menuItems, '/home');

// 搜索菜单
final results = MenuUtils.searchMenus(menuItems, '用户');

// 获取所有路由
final routes = MenuUtils.getAllRoutes(menuItems);

// 获取页面
final page = MenuUtils.getPageByRoute(menuItems, '/home');
```

---

## 🌐 服务器菜单

### JSON 格式
```json
[
  {
    "route": "/home",
    "title": "首页",
    "iconData": "home",
    "componentName": "HomePage"
  },
  {
    "route": "/products",
    "title": "商品管理",
    "iconData": "inventory",
    "children": [
      {
        "route": "/product_list",
        "title": "商品列表",
        "componentName": "ProductListPage"
      }
    ]
  }
]
```

### 实现 API（在 menu_service.dart）
```dart
Future<List<MenuItem>> _fetchMenusFromServer() async {
  final response = await http.get(
    Uri.parse('https://api.example.com/menus')
  );
  
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return MenuConfig.fromServerData(data);
  }
  
  return MenuConfig.getStaticMenus();
}
```

### 切换菜单源
```dart
// 使用服务器菜单
await controller.switchToServerMenus();

// 使用本地菜单
controller.switchToLocalMenus();
```

---

## 📋 检查清单

添加新菜单时确保：

- [ ] 在 `menu_config.dart` 中添加了菜单配置
- [ ] 设置了唯一的路由 `/route`
- [ ] 设置了菜单标题
- [ ] 设置了图标（`iconData` 或 `svg`）
- [ ] 叶子节点设置了 `page` 参数
- [ ] 创建了对应的页面组件
- [ ] 测试导航是否正常

---

## 🐛 常见问题快速解决

| 问题 | 解决方案 |
|------|---------|
| 菜单不显示 | 检查是否设置了 `page` 参数 |
| 页面不跳转 | 确认路由路径是否正确 |
| 父菜单不展开 | 系统会自动处理，无需手动配置 |
| 图标不显示 | 检查 `iconData` 或 `svg` 路径 |
| 服务器菜单失败 | 检查 API 地址，系统会自动降级 |

---

## 📂 文件位置

```
主要文件：
📌 lib/config/menu_config.dart        # 在这里配置菜单！

其他文件：
📄 lib/services/menu_service.dart     # 菜单服务
📄 lib/utils/menu_utils.dart          # 工具方法
📄 lib/models/menu_item.dart          # 菜单模型

文档：
📖 lib/config/README.md               # 详细说明
📖 lib/config/MENU_CONFIG_GUIDE.md   # 使用指南
📖 lib/config/menu_config_example.dart # 代码示例
```

---

## 🎯 记住这些关键点

1. **只配置一次**：只需在 `menu_config.dart` 中配置
2. **自动处理**：路由、层级关系自动处理
3. **支持动态**：支持服务器返回的动态菜单
4. **有缓存**：菜单数据自动缓存，性能优秀
5. **易维护**：减少 70% 的配置代码

---

## 💡 一句话总结

**在 `menu_config.dart` 中添加菜单，其他的交给系统自动处理！**

---

## 🔗 相关链接

- [完整文档](README.md)
- [详细指南](MENU_CONFIG_GUIDE.md)
- [代码示例](menu_config_example.dart)

---

**保存此文件，随时查阅！** 📚

