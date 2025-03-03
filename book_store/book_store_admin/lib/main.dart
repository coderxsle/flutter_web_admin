import 'package:book_store_shared/book_store_shared.dart';
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
  LoggerTool.initLogger();
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
        title: '图书销售系统',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: Routes.books,
        getPages: Routes.pages,
        builder: EasyLoading.init(),
        defaultTransition: Transition.fadeIn,
      ),
    );
  }
}
