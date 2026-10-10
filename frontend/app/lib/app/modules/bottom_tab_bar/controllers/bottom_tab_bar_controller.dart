import 'package:auto_shop_server/app/modules/ba_zi/page/bazi_input_page.dart';
import 'package:auto_shop_server/app/modules/mine/page/mine_page.dart';
import 'package:auto_shop_server/app/modules/qi_men/page/qimen_input_page.dart';
import 'package:auto_shop_server/app/modules/zhongyi/page/zhongyi_page.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../theme/app_theme.dart';
// import 'package:auto_shop_server/app/modules/home/views/home_view.dart';

class BottomTabBarController extends GetxController {
  /// 用于控制默认加载的tabs选项
  final currentIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  /// 底部 Tab 页面，新增 Tab 时同步补充 tabItems。
  /// 首页已下线，入口由各 Tab 直接承载；要恢复时打开下面那行注释。
  final List<Widget> pages = const [
    // HomeView(),
    QiMenInputPage(),
    BaziInputPage(),
    ZhongyiPage(),
    MinePage(),
  ];

  final List<TTabBarItemConfig> tabItems = [
    TTabBarItemConfig(
      unselectedIcon: const Icon(Icons.grid_view_outlined),
      selectedIcon: const Icon(Icons.grid_view_rounded, color: TdColors.brand),
      tabText: "奇门",
      selectTabTextStyle: const TextStyle(color: TdColors.brand),
      onTap: null,
    ),
    TTabBarItemConfig(
      tabText: "八字",
      unselectedIcon: const Icon(Icons.calendar_month_outlined),
      selectedIcon: const Icon(Icons.calendar_month, color: TdColors.brand),
      selectTabTextStyle: const TextStyle(color: TdColors.brand),
      onTap: null,
    ),
    TTabBarItemConfig(
      tabText: "中医",
      unselectedIcon: const Icon(Icons.medical_services_outlined),
      selectedIcon: const Icon(Icons.medical_services, color: TdColors.brand),
      selectTabTextStyle: const TextStyle(color: TdColors.brand),
      onTap: null,
    ),
    TTabBarItemConfig(
      tabText: "我的",
      unselectedIcon: const Icon(Icons.person_outline),
      selectedIcon: const Icon(Icons.person, color: TdColors.brand),
      selectTabTextStyle: const TextStyle(color: TdColors.brand),
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
    // 账号可能已被清空（退出登录/被踢下线），此时切 Tab 会把空账号带进页面
    if (AppManager.userAccount == null) {
      AppManager.signOut();
      return;
    }
    currentIndex.value = index;
    update();
  }
}
