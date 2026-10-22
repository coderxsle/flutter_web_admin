import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../utils/app_manager.dart';

/// 启动页：get 5 注册了 '/' 后 initialRoute 会被忽略，中间件也改不了落地页，
/// 所以由这里按登录态决定去首页还是登录页。
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.offAllNamed(AppManager.isLoggedIn ? Routes.BOTTOMTABVIEW : Routes.LOGINPAGE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SizedBox.shrink());
  }
}
