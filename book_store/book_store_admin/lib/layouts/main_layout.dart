import 'package:book_store_admin/global/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/routes.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // 添加登录状态检查
    if (!Global.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(Routes.login);
      });
      return const SizedBox.shrink();
    }
    return Scaffold(
      body: Row(
        children: [
          // 左侧导航栏
          Container(
            width: 200,
            height: double.infinity,
            color: const Color(0xFF2C3E50),
            child: Column(
              children: [
                // Logo区域
                Container(
                  height: 64,
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '爱自然书店管理系统',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(color: Colors.white24, height: 1),
                // 导航菜单
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildMenuItem(icon: Icons.book, title: '图书管理', route: Routes.books),
                      _buildMenuItem(icon: Icons.category, title: '组合管理', route: Routes.packages),
                      _buildMenuItem(icon: Icons.folder, title: '分类管理', route: Routes.categories),
                      _buildMenuItem(icon: Icons.shopping_cart, title: '订单管理', route: Routes.orders),
                      _buildMenuItem(icon: Icons.people, title: '用户管理', route: Routes.users),
                      _buildMenuItem(icon: Icons.bar_chart, title: '统计分析', route: Routes.statistics),
                      _buildMenuItem(icon: Icons.settings, title: '系统管理', route: Routes.system),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 主内容区域
          Expanded(
            child: Column(
              children: [
                // 顶部导航栏
                Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        _generateBreadcrumb(),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      // 用户信息
                      PopupMenuButton(
                        offset: const Offset(0, 40),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.blue[100],
                              child: const Icon(Icons.person, size: 20),
                            ),
                            const SizedBox(width: 8),
                            const Text('管理员'),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'profile',
                            child: Text('个人信息'),
                          ),
                          const PopupMenuItem(
                            value: 'logout',
                            child: Text('退出登录'),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'logout') {
                            Global.logout();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                // 内容区域
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String route,
  }) {
    final isSelected = Get.currentRoute == route;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70, size: 20),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 14,
          ),
        ),
        dense: true,
        selected: isSelected,
        onTap: () => Get.toNamed(route),
      ),
    );
  }

  String _generateBreadcrumb() {
    final route = Get.currentRoute;
    final Map<String, String> routeNames = {
      Routes.system: '系统管理',
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