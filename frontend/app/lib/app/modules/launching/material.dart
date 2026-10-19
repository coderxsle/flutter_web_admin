import 'package:yun_men_yi_pan/app/routes/app_pages.dart';
import 'package:yun_men_yi_pan/app/theme/app_theme.dart';
import 'package:yun_men_yi_pan/app/utils/app_manager.dart';
import 'package:yun_men_yi_pan/app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
// 取 TDesign token 要直接 import：TColors 是 extension，transitive import 不生效
import 'package:tdesign_flutter/tdesign_flutter.dart';
// 前缀不能省：material_ui 是另一套 Material，与 flutter/material.dart 重名
import 'package:material_ui/material_ui.dart' as mui;

import '../../translations/app_translations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Widget setupMaterial(BuildContext context) {


  return GetMaterialApp(
    enableLog: true,
    title: AppName,//华为渠道审核要求任务栈中存在应用名称
    // 根据登录状态决定初始路由
    initialRoute: AppManager.isLoggedIn ? Routes.INITIAL : '/LoginAccountPage',
    getPages: AppPages.routes,
    navigatorKey: navigatorKey,
    // debugShowCheckedModeBanner: kDebugMode ? true :  false,
    debugShowCheckedModeBanner: false,
    locale: Get.deviceLocale,
    supportedLocales: AppTranslations.supportedLocales,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate, // 指定本地化的字符串和一些其他的值
      GlobalCupertinoLocalizations.delegate, // 对应的Cupertino风格
      GlobalWidgetsLocalizations.delegate, // 指定默认的文本排列方向, 由左到右或由右到左
      // flutter_datetime_picker_plus 取的是 material_ui 那套 MaterialLocalizations，
      // 不额外注册它就会报 No MaterialLocalizations found
      mui.GlobalMaterialLocalizations.delegate,
    ],
    navigatorObservers: [FlutterSmartDialog.observer],
    builder: FlutterSmartDialog.init(),
    theme: setupTheme(),
  );
}



ThemeData setupTheme() {
  return ThemeData(
    // TDesign 主题：所有 tdesign 组件从这里取色，主色为品牌红
    extensions: [themeData, tabBarTheme, dividerTheme, inputTheme],
    // 原生字段也取 TDesign token，全局只有一份色值来源
    canvasColor: Colors.transparent, // 为所有 Material 小部件设置默认颜色
    cardColor: themeData.bgColorContainer, //设置卡片颜色
    splashColor: Colors.black12, // 设置触摸水波纹效果的颜色
    highlightColor: Colors.greenAccent, // 设置触摸高亮效果的颜色
    scaffoldBackgroundColor: themeData.bgColorPage, //页面背景色
    shadowColor: Colors.transparent, // 阴影的颜色
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: themeData.bgColorContainer,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: themeData.bgColorContainer, // 设置对话框的背景颜色为白色
      surfaceTintColor: themeData.bgColorContainer,
      shadowColor: themeData.bgColorContainer,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: themeData.brandColor,
      // toolbarHeight: 44,
      toolbarHeight: 44.h,
      iconTheme: IconThemeData(color: themeData.textColorAnti),
      elevation: 0,//隐藏底部阴影分割线
      centerTitle: true,//标题是否居中 安卓上有效ios默认居中
      foregroundColor: themeData.textColorAnti, /// 影响导航标题颜色,
      surfaceTintColor: themeData.bgColorContainer,
    ),
  );
}

