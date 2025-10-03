import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/layout_admin_controller.dart';

class LayoutMenuFoldBtn extends StatelessWidget {
  const LayoutMenuFoldBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LayoutAdminController>();
    
    // 使用 MediaQuery 获取屏幕宽度
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 折叠按钮
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Obx(() => IconButton(
            iconSize: 18,
            padding: const EdgeInsets.all(8),
            onPressed: () => _handleFoldClick(controller, isDesktop),
            icon: Icon(
              size: 26,
              controller.isMenuExpanded.value ? Icons.menu_open : Icons.menu, 
            ),
            tooltip: controller.isMenuExpanded.value ? '折叠菜单' : '打开菜单',
          )),
        ),
      ],
    );
  }

  /// 处理折叠按钮点击
  void _handleFoldClick(LayoutAdminController controller, bool isDesktop) {
    if (isDesktop) {
      controller.toggleMenuExpansion();
    } else {
      // 移动端可以在这里处理抽屉逻辑
      controller.toggleMenuExpansion();
    }
  }
}

// IconButton(
//   onPressed: onToggleExpansion,
//   icon: Icon(isExpanded ? Icons.chevron_left : Icons.chevron_right, color: Colors.white),
//   tooltip: isExpanded ? '收起菜单' : '展开菜单',
// ),


// const Spacer(),
// IconButton(
//   onPressed: onToggleExpansion,
//   icon: Icon(
//     Icons.chevron_right,
//     color: Colors.white,
//   ),
//   tooltip: '展开菜单',
//   padding: EdgeInsets.zero,
//   constraints: const BoxConstraints(),
//   iconSize: 20,
// ),