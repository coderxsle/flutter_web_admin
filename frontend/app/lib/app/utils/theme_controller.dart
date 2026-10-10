import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';


class ThemeController extends GetxController {
  // 使用 RxBool 来监听夜间模式状态的变化
  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  set isDarkMode(bool value) => _isDarkMode.value = value;

  // 切换夜间模式的方法
  void toggleTheme() {
    isDarkMode = !isDarkMode;
    Get.changeTheme(isDarkMode ? darkTheme : lightTheme);
  }
}


final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  dialogTheme: const DialogThemeData(
    backgroundColor: Colors.white, // 设置对话框的背景颜色为白色
    surfaceTintColor: Colors.white,
    shadowColor: Colors.white,
  ),
  // appBarTheme: setupAppBarTheme(),
  // bottomAppBarTheme: setupBottomAppBarTheme(),
  // bottomNavigationBarTheme: setupBottomNavigationBarTheme(),

  // ThemeData(
  //   // 设置全局主题
  //   canvasColor: Colors.transparent, // 为所有 Material 小部件设置默认颜色
  //   cardColor: Colors.white, //设置卡片颜色
  //   // brightness: Brightness.dark,
  //   splashColor: Colors.black12, // 设置触摸水波纹效果的颜色
  //   highlightColor: Colors.greenAccent, // 设置触摸高亮效果的颜色
  //   // canvasColor: Colors.white, // 设置画布颜色
  //   // primaryColor: Colors.white, // 主要颜色
  //   // primarySwatch: , // 主要颜色样本
  //   scaffoldBackgroundColor: PageBackgroundColor, //页面背景色
  //   dialogBackgroundColor: Colors.white,
  //   shadowColor: Colors.transparent, // 阴影的颜色
  //   bottomSheetTheme: const BottomSheetThemeData(
  //     surfaceTintColor: Colors.transparent,
  //   ),
  //
  // ),
);



final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black, // 设置导航栏背景颜色为黑色
    iconTheme: IconThemeData(color: Colors.white), // 设置图标颜色
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // 设置标题文本颜色
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
);





setupButtonTheme() {
  return const ButtonThemeData(
  buttonColor: Colors.white,
  disabledColor: Colors.grey,
  focusColor: Colors.white,
  hoverColor: Colors.white,
  highlightColor: Colors.white,
  splashColor: Colors.white,
  );
}

setupElevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      // foregroundColor: ThemeColor,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      //disabledBackgroundColor: Colors.white,
      //disabledForegroundColor: Colors.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  );
}

BottomAppBarTheme setupBottomAppBarTheme() {
  return const BottomAppBarTheme(
    color: Colors.white,
    elevation: 0,
    shape: CircularNotchedRectangle(),  // Ensure shape is not null
  );
}

setupBottomNavigationBarTheme() {
  return const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    selectedIconTheme: IconThemeData(color: Colors.black),
    unselectedIconTheme: IconThemeData(),
    selectedLabelStyle: TextStyle(color: Colors.black),
    unselectedLabelStyle: TextStyle(color: Colors.grey),
  );
}

AppBarTheme setupAppBarTheme() {
  ThemeController theme = Get.find();
  return AppBarTheme(
    color: ThemeColor,
    backgroundColor: Colors.white, // 设置导航栏背景颜色为白色
    iconTheme: IconThemeData(color: theme.isDarkMode ? Colors.white : Colors.black), // 设置图标颜色
    elevation: 0,//隐藏底部阴影分割线
    centerTitle: true,//标题是否居中 安卓上有效ios默认居中
    toolbarHeight: 44,
    foregroundColor: Colors.white, /// 影响导航标题颜色,
    surfaceTintColor: Colors.white,
    titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20), // 设置标题文本颜色
  );
}


setupRefresh() {
  EasyRefresh.defaultHeaderBuilder = () => const ClassicHeader(
    dragText: "下拉刷新",
    armedText: "松开立即刷新",
    readyText: "刷新中...",
    processingText: "刷新中...",
    processedText: "刷新成功",
    noMoreText: "没有更多",
    failedText: "刷新失败",
    messageText: "最后更新于 %T",
    // dragText: 'Pull to refresh'.tr,
    // armedText: 'Release ready'.tr,
    // readyText: 'Refreshing...'.tr,
    // processingText: 'Refreshing...'.tr,
    // processedText: 'Succeeded'.tr,
    // noMoreText: 'No more'.tr,
    // failedText: 'Failed'.tr,
    // messageText: 'Last updated at %T'.tr,
  );
  EasyRefresh.defaultFooterBuilder = () => const ClassicFooter(
    dragText: "上拉刷新",
    armedText: "松开立即刷新",
    readyText: "刷新中...",
    processingText: "刷新中...",
    processedText: "刷新成功",
    noMoreText: "没有更多",
    failedText: "刷新失败",
    messageText: "最后更新于 %T",
    // dragText: 'Pull to load'.tr,
    // armedText: 'Release ready'.tr,
    // readyText: 'Loading...'.tr,
    // processingText: 'Loading...'.tr,
    // processedText: 'Succeeded'.tr,
    // noMoreText: 'No more'.tr,
    // failedText: 'Failed'.tr,
    // messageText: 'Last updated at %T'.tr,
  );
}
