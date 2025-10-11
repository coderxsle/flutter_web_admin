import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../widgets/layout_sidebar.dart';
import '../controllers/layout_admin_controller.dart';
import 'package:flutter_web_admin/modules/layout/widgets/content_header.dart';

class LayoutAdminPage extends GetView<LayoutAdminController> {
  const LayoutAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 设置 context 到控制器
    controller.setContext(context);
    return Scaffold(
      body: Row(
        children: [
          // 侧边栏
          Obx(() => LayoutSidebar(
            // logo: 'assets/images/logo.png',
            isExpanded: controller.isMenuExpanded.value,
            onToggleExpansion: controller.toggleMenuExpansion,
            menuItems: controller.menuItems,
            currentRoute: controller.currentPage.value,
            onMenuTap: controller.navigateToPage,
            onToggleItem: controller.toggleMenuItemExpansion,
          )),
          // 主内容区域
          Expanded(
            child: Column(
              children: [
                // 头部区域
                LayoutContentHeader(),
                Expanded(
                  child: Obx(() => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.03, 0.0),  // 轻微向右偏移
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          )),
                          child: child,
                        ),
                      );
                    },
                    child: KeyedSubtree(
                      key: ValueKey(controller.currentPage.value),
                      child: controller.getCurrentPageContent(),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
