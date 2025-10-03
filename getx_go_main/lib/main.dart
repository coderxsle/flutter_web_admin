import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_launching.dart';
import 'router/app_router.dart';
import 'theme/theme_controller.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 添加全局异常处理
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    // 记录错误但不重复抛出
    print('Flutter Error: ${details.exception}');
  };
  
  await AppLaunching.launching();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (controller) {
        return MaterialApp.router(
          title: 'Flutter Admin',
          debugShowCheckedModeBanner: false,
          theme: controller.themeData,
          routerConfig: AppRouter.router,
          // 配置 SmartDialog
          builder: FlutterSmartDialog.init(),
        );
      },
    );
  }
}
