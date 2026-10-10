import 'package:auto_shop_server/app/modules/cart/page/cart_page.dart';
import 'package:auto_shop_server/app/modules/group_buy/page/group_buy_page.dart';
import 'package:auto_shop_server/app/modules/mine/page/mine_page.dart';
import 'package:auto_shop_server/app/modules/service/page/service_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../theme/app_colors.dart';
import '../../home/views/home_view.dart';

class BottomTabBarController extends GetxController {
  /// 用于控制默认加载的tabs选项
  final currentIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  /// 底部 Tab 页面，新增 Tab 时同步补充 tabItems
  final List<Widget> pages = const [
    HomeView(),
    ServicePage(),
    GroupBuyPage(),
    CartPage(),
    MinePage(),
  ];

  final List<TTabBarItemConfig> tabItems = [
    TTabBarItemConfig(
      unselectedIcon: const Icon(Icons.home_outlined),
      selectedIcon: const Icon(Icons.home, color: ThemeColor),
      tabText: "首页",
      selectTabTextStyle: const TextStyle(color: ThemeColor),
      onTap: null,
    ),
    TTabBarItemConfig(
      unselectedIcon: const Icon(Icons.room_service_outlined),
      selectedIcon: const Icon(Icons.room_service, color: ThemeColor),
      tabText: "服务",
      selectTabTextStyle: const TextStyle(color: ThemeColor),
      onTap: null,
    ),
    TTabBarItemConfig(
      unselectedIcon: const Icon(Icons.group_outlined),
      selectedIcon: const Icon(Icons.group, color: ThemeColor),
      tabText: "团购",
      selectTabTextStyle: const TextStyle(color: ThemeColor),
      onTap: null,
    ),
    TTabBarItemConfig(
      unselectedIcon: const Icon(Icons.shopping_cart_outlined),
      selectedIcon: const Icon(Icons.shopping_cart, color: ThemeColor),
      tabText: "购物车",
      selectTabTextStyle: const TextStyle(color: ThemeColor),
      onTap: null,
    ),
    TTabBarItemConfig(
      unselectedIcon: const Icon(Icons.person_outline),
      selectedIcon: const Icon(Icons.person, color: ThemeColor),
      tabText: "我的",
      selectTabTextStyle: const TextStyle(color: ThemeColor),
      onTap: null,
    ),
  ];

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments.containsKey("initialPage")) {
      currentIndex.value = Get.arguments["initialPage"];
      pageController = PageController(initialPage: currentIndex.value);
      update();
    }
    super.onInit();
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
