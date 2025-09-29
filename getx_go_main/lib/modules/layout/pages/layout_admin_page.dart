import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/layout_admin_controller.dart';
import '../widgets/layout_sidebar.dart';

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
            isExpanded: controller.isMenuExpanded.value,
            onToggleExpansion: controller.toggleMenuExpansion,
            menuItems: controller.menuItems,
            currentRoute: controller.currentPage.value,
            onMenuTap: controller.navigateToPage,
            onToggleItem: controller.toggleMenuItemExpansion,
          )),
          // 主内容区域
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: Obx(() => controller.getCurrentPageContent()),
            ),
          ),
        ],
      ),
    );
  }
}
