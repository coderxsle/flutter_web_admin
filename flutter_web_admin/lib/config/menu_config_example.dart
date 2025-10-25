/// 菜单配置示例文件
/// 这个文件展示了如何快速添加新菜单
/// 
/// 使用步骤：
/// 1. 打开 menu_config.dart
/// 2. 在 getStaticMenus() 方法中添加新菜单
/// 3. 完成！不需要修改其他任何地方

/// ============================================
/// 示例 1: 添加一个简单的菜单项
/// ============================================
/// 
/// 在 menu_config.dart 的 getStaticMenus() 中添加：
/// 
/// ```dart
/// _menu('/orders', '订单管理',
///   iconData: Icons.shopping_bag,
///   page: const OrderListPage(),
/// ),
/// ```
/// 
/// 就这么简单！路由、图标、页面都配置好了。

/// ============================================
/// 示例 2: 添加带子菜单的菜单项
/// ============================================
/// 
/// ```dart
/// _menu('/products', '商品管理',
///   iconData: Icons.inventory,
///   children: [
///     _menu('/product_list', '商品列表',
///       iconData: Icons.list,
///       page: const ProductListPage(),
///     ),
///     _menu('/product_add', '添加商品',
///       iconData: Icons.add_box,
///       page: const ProductAddPage(),
///     ),
///   ],
/// ),
/// ```
/// 
/// 父子关系会自动处理，无需手动维护！

/// ============================================
/// 示例 3: 添加多级嵌套菜单
/// ============================================
/// 
/// ```dart
/// _menu('/system', '系统管理',
///   iconData: Icons.settings,
///   children: [
///     _menu('/system_user', '用户管理',
///       iconData: Icons.people,
///       children: [
///         _menu('/user_list', '用户列表',
///           iconData: Icons.list,
///           page: const UserListPage(),
///         ),
///         _menu('/user_roles', '角色管理',
///           iconData: Icons.admin_panel_settings,
///           page: const UserRolesPage(),
///         ),
///       ],
///     ),
///     _menu('/system_log', '系统日志',
///       iconData: Icons.article,
///       page: const SystemLogPage(),
///     ),
///   ],
/// ),
/// ```
/// 
/// 支持任意深度的菜单嵌套！

/// ============================================
/// 示例 4: 使用 SVG 图标
/// ============================================
/// 
/// ```dart
/// _menu('/dashboard', '数据面板',
///   svg: 'menu_chart.svg',  // 使用 SVG 图标
///   page: const DashboardPage(),
/// ),
/// ```
/// 
/// SVG 文件放在 assets/images/ 目录下

/// ============================================
/// 示例 5: 完整的业务模块示例
/// ============================================
/// 
/// ```dart
/// _menu('/content', '内容管理',
///   iconData: Icons.article,
///   children: [
///     _menu('/articles', '文章管理',
///       iconData: Icons.description,
///       children: [
///         _menu('/article_list', '文章列表',
///           iconData: Icons.list,
///           page: const ArticleListPage(),
///         ),
///         _menu('/article_create', '创建文章',
///           iconData: Icons.create,
///           page: const ArticleCreatePage(),
///         ),
///         _menu('/article_categories', '文章分类',
///           iconData: Icons.category,
///           page: const ArticleCategoriesPage(),
///         ),
///       ],
///     ),
///     _menu('/media', '媒体库',
///       iconData: Icons.perm_media,
///       page: const MediaLibraryPage(),
///     ),
///     _menu('/comments', '评论管理',
///       iconData: Icons.comment,
///       page: const CommentsPage(),
///     ),
///   ],
/// ),
/// ```

/// ============================================
/// 对比：旧方式 vs 新方式
/// ============================================

// ❌ 旧方式 - 需要在多个地方修改
class OldWay {
  // 1. 在控制器中添加菜单配置
  void configureMenu() {
    // menuItems.value = [
    //   item('/my_page', '我的页面', page: MyPage()),
    // ];
  }
  
  // 2. 在路由中注册
  void registerRoute() {
    // 需要手动添加路由
  }
  
  // 3. 手动维护父子关系
  void maintainHierarchy() {
    // final menuHierarchy = {
    //   'my_page': ['/parent'],
    // };
  }
  
  // 总共需要修改 3 个地方！😫
}

// ✅ 新方式 - 只需一处配置
class NewWay {
  // 只需在 menu_config.dart 中添加：
  // _menu('/my_page', '我的页面',
  //   iconData: Icons.page_view,
  //   page: const MyPage(),
  // ),
  
  // 完成！只需 1 个地方！😊
  // 路由、层级关系全部自动处理！
}

/// ============================================
/// 服务器动态菜单示例
/// ============================================

class ServerMenuExample {
  /// 服务器返回的 JSON 格式示例
  static const String jsonExample = '''
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
          "iconData": "list",
          "componentName": "ProductListPage"
        },
        {
          "route": "/product_add",
          "title": "添加商品",
          "iconData": "add_box",
          "componentName": "ProductAddPage"
        }
      ]
    }
  ]
  ''';
  
  /// 在 menu_service.dart 中实现 API 调用
  /// 
  /// ```dart
  /// Future<List<MenuItem>> _fetchMenusFromServer() async {
  ///   final response = await http.get(
  ///     Uri.parse('https://api.example.com/menus')
  ///   );
  ///   
  ///   if (response.statusCode == 200) {
  ///     final List<dynamic> data = json.decode(response.body);
  ///     return MenuConfig.fromServerData(
  ///       data.map((e) => e as Map<String, dynamic>).toList()
  ///     );
  ///   }
  ///   
  ///   return MenuConfig.getStaticMenus();
  /// }
  /// ```
}

/// ============================================
/// 常见问题解答
/// ============================================

class FAQ {
  /// Q1: 如何添加新菜单？
  /// A1: 只需在 menu_config.dart 的 getStaticMenus() 中添加 _menu() 配置即可
  
  /// Q2: 需要注册路由吗？
  /// A2: 不需要！路由会根据菜单配置自动处理
  
  /// Q3: 父子关系怎么维护？
  /// A3: 不需要维护！系统会自动从菜单结构中构建层级关系
  
  /// Q4: 支持动态菜单吗？
  /// A4: 支持！可以从服务器获取菜单配置
  
  /// Q5: 如何切换服务器菜单和本地菜单？
  /// A5: 使用 controller.switchToServerMenus() 或 controller.switchToLocalMenus()
  
  /// Q6: 菜单数据会缓存吗？
  /// A6: 会！MenuService 会自动缓存，减少不必要的请求
  
  /// Q7: 支持权限控制吗？
  /// A7: 支持！可以在 menu_service.dart 中实现 filterMenusByPermissions()
  
  /// Q8: 如何搜索菜单？
  /// A8: 使用 MenuUtils.searchMenus(menuItems, '关键字')
}

/// ============================================
/// 快速开始模板
/// ============================================

/// 复制以下代码到 menu_config.dart 中快速开始：
/// 
/// ```dart
/// _menu('/your_route', '你的菜单名称',
///   iconData: Icons.your_icon,  // 或使用 svg: 'your_icon.svg'
///   page: const YourPage(),      // 如果有子菜单则不需要 page
///   children: [                  // 可选，子菜单列表
///     _menu('/child_route', '子菜单',
///       iconData: Icons.child_icon,
///       page: const ChildPage(),
///     ),
///   ],
/// ),
/// ```

/// ============================================
/// 下一步
/// ============================================
/// 
/// 1. 打开 lib/config/menu_config.dart
/// 2. 找到 getStaticMenus() 方法
/// 3. 添加你的菜单配置
/// 4. 创建对应的页面组件
/// 5. 运行项目，享受自动化！
/// 
/// 就是这么简单！🎉

