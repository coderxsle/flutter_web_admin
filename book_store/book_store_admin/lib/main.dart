import 'package:book_store_shared/book_store_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/routes.dart';
import 'global/global.dart';
import 'services/api_service.dart';

// 应用主题配置
final ThemeData appThemeData = ThemeData(
  primaryColor: const Color(0xFF0078D4),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF0078D4),
    primary: const Color(0xFF0078D4),
    secondary: const Color(0xFF268CDC),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0078D4),
    foregroundColor: Colors.white,
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  dividerTheme: const DividerThemeData(
    thickness: 1,
    color: Color(0xFFEEEEEE),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  LoggerTool.initLogger();
  ApiService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 根据登录状态决定初始路由
    final initialRoute = Global.isLoggedIn ? Routes.books : Routes.login;
    logger.i('Global.isLoggedIn: ${Global.isLoggedIn}');
    logger.i('initialRoute: $initialRoute');
    
    

    return ScreenUtilInit(
      designSize: const Size(1920, 1080), // 设计稿尺寸
      builder: (_, child) => GetCupertinoApp(
        title: '图书销售系统1',
        // theme: appThemeData,
        getPages: Routes.pages,
        initialRoute: initialRoute,
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        // 添加本地化支持
        locale: const Locale('zh', 'CN'),
        supportedLocales: const [
          Locale('zh', 'CN'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // 禁用GetX日志，减少输出
        logWriterCallback: (String text, {bool isError = false}) {
          // 可以在这里实现自定义的日志过滤或完全禁用
          // 完全禁用时保持此函数为空
        },
      ),
    );
  }
}
