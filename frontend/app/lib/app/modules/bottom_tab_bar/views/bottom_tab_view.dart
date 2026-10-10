import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../controllers/bottom_tab_bar_controller.dart';

class BottomTabView extends GetView<BottomTabBarController> {
  const BottomTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: setupPageView(),
      bottomNavigationBar: setupBottomBar(),
    );
  }

  Widget setupPageView() {
    return PageView(
      controller: controller.pageController,
      physics: const NeverScrollableScrollPhysics(), // 禁止左右滑动
      children: controller.pages,
      onPageChanged: (index) {
        controller.setCurrentIndex(index);
      },
    );
  }

  Widget setupBottomBar() {
    return Obx(() => TTabBar(
          type: TTabBarType.iconText,
          needInkWell: true,
          value: controller.currentIndex.value,
          onChanged: (index) {
            controller.setCurrentIndex(index);
            controller.pageController.jumpToPage(index);
          },
          navigationTabs: controller.tabItems,
        ));
  }
}
