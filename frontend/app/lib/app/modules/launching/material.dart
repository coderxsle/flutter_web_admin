import 'package:auto_shop_server/app/routes/app_pages.dart';
import 'package:auto_shop_server/app/theme/app_colors.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../translations/app_translations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Widget setupMaterial(BuildContext context) {


  return GetMaterialApp(
    enableLog: true,
    title: AppName,//华为渠道审核要求任务栈中存在应用名称
    // 根据登录状态决定初始路由
    initialRoute: AppManager.userAccount == null ? '/LoginAccountPage' : Routes.INITIAL,
    getPages: AppPages.routes,
    navigatorKey: navigatorKey,
    // debugShowCheckedModeBanner: kDebugMode ? true :  false,
    debugShowCheckedModeBanner: false,
    locale: Get.deviceLocale,
    supportedLocales: AppTranslations.supportedLocales,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate, // 指定本地化的字符串和一些其他的值
      GlobalCupertinoLocalizations.delegate, // 对应的Cupertino风格
      GlobalWidgetsLocalizations.delegate // 指定默认的文本排列方向, 由左到右或由右到左
    ],
    navigatorObservers: [FlutterSmartDialog.observer],
    builder: FlutterSmartDialog.init(),
    theme: setupTheme(),
  );
}



setupTheme() {
  return ThemeData(
    // 设置全局主题
    canvasColor: Colors.transparent, // 为所有 Material 小部件设置默认颜色
    cardColor: Colors.white, //设置卡片颜色
    splashColor: Colors.black12, // 设置触摸水波纹效果的颜色
    highlightColor: Colors.greenAccent, // 设置触摸高亮效果的颜色
    scaffoldBackgroundColor: PageBackgroundColor, //页面背景色
    dialogBackgroundColor: Colors.white,
    shadowColor: Colors.transparent, // 阴影的颜色
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: Colors.white, // 设置对话框的背景颜色为白色
      surfaceTintColor: Colors.white,
      shadowColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      color: ThemeColor,
      // toolbarHeight: 44,
      toolbarHeight: 44.h,
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,//隐藏底部阴影分割线
      centerTitle: true,//标题是否居中 安卓上有效ios默认居中
      foregroundColor: Colors.white, /// 影响导航标题颜色,
      surfaceTintColor: Colors.white,
    ),
    // extensions: [TDThemeData.fromJson('test', testThemeConfig)!],
  );
}

