import 'package:book_store_admin/global/global.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import '../config/routes.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  final PaneDisplayMode _displayMode = PaneDisplayMode.open;
  bool _showUserMenu = false;
  
  // 在build方法外定义导航项
  late final List<NavigationPaneItem> _items = _initNavigationItems();
  
  List<NavigationPaneItem> _initNavigationItems() {
    return [
      PaneItem(
        icon: const Icon(material.Icons.book),
        title: const Text('图书管理'),
        body: _NavigationBody(route: Routes.books, child: widget.child),
      ),
      PaneItem(
        icon: const Icon(material.Icons.category),
        title: const Text('组合管理'),
        body: _NavigationBody(route: Routes.packages, child: widget.child),
      ),
      PaneItem(
        icon: const Icon(material.Icons.folder),
        title: const Text('分类管理'),
        body: _NavigationBody(route: Routes.categories, child: widget.child),
      ),
      PaneItem(
        icon: const Icon(material.Icons.shopping_cart),
        title: const Text('订单管理'),
        body: _NavigationBody(route: Routes.orders, child: widget.child),
      ),
      PaneItem(
        icon: const Icon(material.Icons.people),
        title: const Text('用户管理'),
        body: _NavigationBody(route: Routes.users, child: widget.child),
      ),
      PaneItem(
        icon: const Icon(material.Icons.bar_chart),
        title: const Text('统计分析'),
        body: _NavigationBody(route: Routes.statistics, child: widget.child),
      ),
      PaneItemExpander(
        icon: const Icon(material.Icons.settings),
        title: const Text('系统管理'),
        body: _NavigationBody(route: Routes.system, child: widget.child),
        items: [
          PaneItem(
            icon: const Icon(material.Icons.people),
            title: const Text('用户管理'),
            body: _NavigationBody(route: Routes.systemUsers, child: widget.child),
          ),
          PaneItem(
            icon: const Icon(material.Icons.security),
            title: const Text('角色管理'),
            body: _NavigationBody(route: Routes.systemRoles, child: widget.child),
          ),
          PaneItem(
            icon: const Icon(material.Icons.menu),
            title: const Text('资源管理'),
            body: _NavigationBody(route: Routes.systemResources, child: widget.child),
          ),
          PaneItem(
            icon: const Icon(material.Icons.history),
            title: const Text('操作日志'),
            body: _NavigationBody(route: Routes.systemLogs, child: widget.child),
          ),
        ],
      ),
    ];
  }

  // 根据当前路由设置选中项
  void _updateSelectedIndex() {
    final route = Get.currentRoute;
    
    // 遍历顶级菜单项
    for (int i = 0; i < _items.length; i++) {
      var item = _items[i];
      
      if (item is PaneItem && 
          _getRouteFromBody(item.body) == route) {
        setState(() => _selectedIndex = i);
        return;
      } else if (item is PaneItemExpander) {
        // 检查子项
        for (int j = 0; j < item.items.length; j++) {
          var subItem = item.items[j];
          if (subItem is PaneItem && 
              _getRouteFromBody(subItem.body) == route) {
            setState(() => _selectedIndex = i);
            return;
          }
        }
      }
    }
  }
  
  // 从body中获取路由
  String? _getRouteFromBody(Widget body) {
    if (body is _NavigationBody) {
      return body.route;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSelectedIndex();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 添加登录状态检查
    if (!Global.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(Routes.login);
      });
      return const SizedBox.shrink();
    }
    
    // 添加本地化支持和FluentTheme
    return Localizations(
      delegates: const [
        FluentLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: const Locale('zh', 'CN'),
      child: FluentTheme(
        data: FluentThemeData(
          accentColor: Colors.blue,
          visualDensity: VisualDensity.standard,
          acrylicBackgroundColor: Colors.red,
          micaBackgroundColor: Colors.red,
          shadowColor: Colors.red,
          menuColor: Colors.red,
          cardColor: Colors.red,
          selectionColor: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          resources: const ResourceDictionary.light(),
          focusTheme: const FocusThemeData(
            glowFactor: 0.0,
          ),
          
        ),
        child: NavigationView(
          appBar: NavigationAppBar(
            title: const Text('爱自然书店管理系统'),
            automaticallyImplyLeading: false,
            actions: Container(
              width: 200,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: _buildUserMenu(),
            ),
          ),
          pane: NavigationPane(
            selected: _selectedIndex,
            onChanged: (index) {
              setState(() => _selectedIndex = index);
              
              // 根据选择的项目导航到对应路由
              var item = _items[index];
              String? route;
              
              if (item is PaneItem) {
                route = _getRouteFromBody(item.body);
              } else if (item is PaneItemExpander) {
                route = _getRouteFromBody(item.body);
              }
              
              if (route != null) {
                Get.toNamed(route);
              }
            },
            displayMode: _displayMode,
            items: _items,
            footerItems: [
              PaneItemAction(
                icon: const Icon(material.Icons.logout),
                title: const Text('退出登录'),
                onTap: () => Global.logout(),
              ),
            ],
          ),
          transitionBuilder: (child, animation) {
            return HorizontalSlidePageTransition(animation: animation, child: child);
          },
        ),
      ),
    );
  }
  
  Widget _buildUserMenu() {
    return material.PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'profile') {
          print("个人信息菜单项被点击");
          // 处理个人信息点击
        } else if (value == 'logout') {
          print("退出登录菜单项被点击");
          Global.logout();
        }
      },
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      itemBuilder: (context) => [
        const material.PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: [
              Icon(FluentIcons.contact_info, size: 16, color: Color(0xFF333333)),
              SizedBox(width: 12),
              Text(
                '个人信息',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
        const material.PopupMenuDivider(),
        const material.PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(FluentIcons.sign_out, size: 16, color: Color(0xFF333333)),
              SizedBox(width: 12),
              Text(
                '退出登录',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            material.CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFB3E5FC),
              child: Icon(material.Icons.person, size: 20, color: Color(0xFF0277BD)),
            ),
            SizedBox(width: 8),
            Text(
              '管理员',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              FluentIcons.chevron_down,
              size: 12,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

// 导航内容包装器
class _NavigationBody extends StatelessWidget {
  final Widget child;
  final String? route;
  
  const _NavigationBody({required this.child, this.route});
  
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text(_generateBreadcrumb()),
      ),
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
  
  String _generateBreadcrumb() {
    final Map<String, String> routeNames = {
      Routes.system: '系统管理',
      Routes.systemUsers: '系统管理 / 用户管理',
      Routes.systemRoles: '系统管理 / 角色管理',
      Routes.systemResources: '系统管理 / 资源管理',
      Routes.systemLogs: '系统管理 / 操作日志',
      Routes.books: '图书管理',
      Routes.categories: '分类管理',
      Routes.packages: '组合管理',
      Routes.orders: '订单管理',
      Routes.users: '用户管理',
      Routes.statistics: '统计分析',
    };

    return routeNames[route] ?? '首页';
  }
}