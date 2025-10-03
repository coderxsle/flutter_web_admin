///
/// @file LayoutTop 组件
/// @description 顶部布局组件，采用纯顶部导航的布局方式
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../global/global.dart';
import 'components/app_logo.dart';
import 'components/app_menu.dart';
import 'components/app_main.dart';
import 'components/app_tabs.dart';
import 'components/header_right_bar.dart';

/// 顶部布局组件
/// 
/// 采用纯顶部导航的布局方式：
/// - 顶部：Logo + 水平菜单 + 右侧工具栏
/// - 中间：标签页（可选）
/// - 底部：主内容区域
class LayoutTop extends StatefulWidget {
  /// 子组件内容
  final Widget child;

  const LayoutTop({
    super.key,
    required this.child,
  });

  @override
  State<LayoutTop> createState() => _LayoutTopState();
}

class _LayoutTopState extends State<LayoutTop> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<GlobalController>(
        builder: (controller) {
          return Column(
            children: [
              // 顶部导航栏
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // Logo 组件
                    const AppLogo(collapsed: false),
                    
                    // 水平菜单
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AppMenu(
                          menus: controller.menuRoutes,
                          mode: MenuMode.horizontal,
                          menuStyle: const {
                            'flex': 1,
                            'overflow': 'hidden',
                          },
                        ),
                      ),
                    ),
                    
                    // 右侧工具栏
                    Container(
                      padding: const EdgeInsets.only(right: 16),
                      child: const HeaderRightBar(),
                    ),
                  ],
                ),
              ),
              
              // 标签页（根据配置显示）
              if (controller.tabVisible) const AppTabs(),
              
              // 主内容区域
              Expanded(
                child: AppMain(child: widget.child),
              ),
            ],
          );
        },
      ),
    );
  }
}
