import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'config/routes.dart';
import 'global/global.dart';
import 'services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  ApiService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080), // 设计稿尺寸
      builder: (_, child) => GetMaterialApp(
        title: '书店后台管理系统',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        ),
        initialRoute: Routes.books,
        getPages: Routes.pages,
        builder: EasyLoading.init(),
        defaultTransition: Transition.fadeIn,
      ),
    );
  }
}
