import 'package:book_store_shared/book_store_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/routes.dart';
import 'config/web_optimization.dart';
import 'global/global.dart';
import 'services/api_service.dart';

// 应用主题配置
final ThemeData appThemeData = ThemeData(
  fontFamily: "NotoSansSC",
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

// 全局变量，用于记录应用启动时间
int? _appStartTime;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化Web优化配置
  if (kIsWeb) {
    WebOptimization.initialize();
    
    // 预加载关键资源
    WebOptimization.preloadAssets([
      'assets/fonts/SourceHanSansSC-Regular-Common.woff2',
      'assets/fonts/SourceHanSansSC-Regular-Latin.woff2',
      // 添加其他关键资源
    ]);
    
    // 记录应用启动性能指标
    _appStartTime = DateTime.now().millisecondsSinceEpoch;
    WebOptimization.recordPerformanceMetric('应用初始化开始', 0);
  }
  
  await Global.init();
  LoggerTool.initLogger();
  ApiService().init();
  
  if (kIsWeb && _appStartTime != null) {
    final initTime = DateTime.now().millisecondsSinceEpoch - _appStartTime!;
    WebOptimization.recordPerformanceMetric('应用初始化完成', initTime.toDouble());
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 根据登录状态决定初始路由
    final initialRoute = Global.isLoggedIn ? Routes.books : Routes.login;
    
    return ScreenUtilInit(
      designSize: const Size(1920, 1080), // 设计稿尺寸
      builder: (_, child) => GetMaterialApp(
        title: '图书销售系统',
        theme: appThemeData,
        getPages: Routes.pages,
        initialRoute: initialRoute,
        builder: (context, child) {
          // 组合EasyLoading和性能优化
          child = EasyLoading.init()(context, child);
          
          if (kIsWeb && _appStartTime != null) {
            // 在Web平台上添加性能监控
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final renderTime = DateTime.now().millisecondsSinceEpoch - _appStartTime!;
              WebOptimization.recordPerformanceMetric('首屏渲染完成', renderTime.toDouble());
            });
          }
          
          return child;
        },
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
