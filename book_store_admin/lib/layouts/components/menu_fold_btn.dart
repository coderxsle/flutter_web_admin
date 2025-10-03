///
/// @file MenuFoldBtn 组件
/// @description 菜单折叠按钮组件，支持响应式布局和抽屉模式
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/global.dart';
import 'app_logo.dart';
import 'app_menu.dart';

/// 菜单折叠按钮组件
/// 
/// 功能特性：
/// - 桌面端：切换菜单折叠状态
/// - 移动端：打开/关闭抽屉菜单
/// - 响应式设计
/// - 动画效果
class MenuFoldBtn extends StatefulWidget {
  const MenuFoldBtn({super.key});

  @override
  State<MenuFoldBtn> createState() => _MenuFoldBtnState();
}

class _MenuFoldBtnState extends State<MenuFoldBtn> {
  /// 应用状态控制器
  final _appController = Get.find<GlobalController>();
  
  /// 抽屉可见性状态
  bool _drawerVisible = false;

  /// 检查是否为桌面端
  bool get _isDesktop => MediaQuery.of(context).size.width >= 768;

  /// 处理折叠按钮点击
  void _handleFoldClick() {
    if (_isDesktop) {
      // 桌面端：切换菜单折叠状态
      _appController.setMenuCollapse(!_appController.menuCollapse);
    } else {
      // 移动端：打开抽屉菜单
      setState(() {
        _drawerVisible = !_drawerVisible;
      });
      _showDrawerMenu();
    }
  }

  /// 显示抽屉菜单
  void _showDrawerMenu() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Menu',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: Align(
            alignment: Alignment.centerLeft,
            child: _buildDrawerContent(),
          ),
        );
      },
    ).then((_) {
      setState(() {
        _drawerVisible = false;
      });
    });
  }

  /// 构建抽屉内容
  Widget _buildDrawerContent() {
    return GetBuilder<GlobalController>(
      builder: (controller) {
        return Container(
          width: 280,
          height: double.infinity,
          decoration: BoxDecoration(
            color: controller.menuDark 
                ? controller.darkThemeColor 
                : Theme.of(context).colorScheme.surface,
            border: Border(
              right: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(0.5),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(2, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              // Logo 组件
              const AppLogo(collapsed: false),
              
              // 分隔线
              Divider(
                height: 1,
                color: Theme.of(context).dividerColor,
              ),
              
              // 菜单列表
              Expanded(
                child: AppMenu(
                  menus: controller.menuRoutes,
                  onMenuItemClickAfter: _handleMenuItemClick,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 处理菜单项点击
  void _handleMenuItemClick() {
    // 关闭抽屉
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          child: IconButton(
            onPressed: _handleFoldClick,
            icon: Icon(
              controller.menuCollapse 
                  ? Icons.menu_open 
                  : Icons.menu,
              size: 18,
            ),
            iconSize: 18,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            tooltip: _isDesktop 
                ? (controller.menuCollapse ? '展开菜单' : '折叠菜单')
                : '打开菜单',
          ),
        );
      },
    );
  }
}
