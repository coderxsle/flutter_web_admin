import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../widgets/layout_sidebar.dart';
import '../controllers/layout_admin_controller.dart';
import 'package:getx_go_main/modules/layout/widgets/content_header.dart';

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
                  child: Obx(() => controller.getCurrentPageContent()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
