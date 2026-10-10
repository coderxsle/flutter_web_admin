import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/utils/theme_controller.dart';
import 'app/modules/launching/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final ThemeController theme = Get.put(ThemeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setEasyRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),                         // 设计稿尺寸（宽390，高844）
      splitScreenMode: true,                                    // 启用分屏模式，适配折叠屏或分屏
      minTextAdapt: true,                                       // 文字最小适配，按屏幕最小边计算文字大小
      useInheritedMediaQuery: true,                             // 使用系统的 MediaQuery 适配屏幕信息
      ensureScreenSize: true,                                   // 确保初始化时屏幕尺寸已可用
      enableScaleWH: () => true,                                // 启用宽高比例缩放
      enableScaleText: () => true,                              // 禁用文字缩放（按具体需求）
      // rebuildFactor: RebuildFactors.orientation,                // 控制何时重建组件，当屏幕尺寸改变时重建，
      rebuildFactor: RebuildFactors.size,                       // 控制何时重建组件，当屏幕宽高变化时重建，
      fontSizeResolver: FontSizeResolvers.height,               // 按高度比例调整字体大小(目前适合该项目的情况)
      // responsiveWidgets: ['MyWidget'],                       // 仅对指定组件启用适配
      // excludeWidgets: ['ExcludedWidget'],                    // 排除某些组件的适配
      builder: (context, child) {
        // 强制禁用字体缩放
        // return MediaQuery(
        //   data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
        //   child: setupMaterial(context),
        // );
        return setupMaterial(context);
      }
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  setEasyRefresh() {
    EasyRefresh.defaultHeaderBuilder = () => const ClassicHeader(
      safeArea: false,
      dragText: "下拉刷新",
      armedText: "松开立即刷新",
      readyText: "刷新中...",
      processingText: "刷新中...",
      processedText: "刷新成功",
      noMoreText: "没有数据",
      failedText: "刷新失败",
      messageText: "最后更新于 %T",
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), // 修改头部字体大小
    );
    EasyRefresh.defaultFooterBuilder = () => const ClassicFooter(
      safeArea: false,
      dragText: "上拉刷新",
      armedText: "松开立即刷新",
      readyText: "刷新中...",
      processingText: "刷新中...",
      processedText: "刷新成功",
      noMoreText: "没有更多",
      failedText: "刷新失败",
      messageText: "最后更新于 %T",
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), // 修改头部字体大小
    );
  }
}

