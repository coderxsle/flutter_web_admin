
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 首页占位页，业务内容待接入。
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PageBackgroundColor,
      appBar: AppBar(
        // 作为底部 Tab 根页面时不显示返回
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: BGColor_white_255),
                onPressed: () => Get.back(),
              )
            : null,
        title: const NavigatorTitle("首页"),
      ),
      body: const Center(
        child: Text("首页待接入", style: TextStyle(fontSize: 16, color: Colors.grey)),
      ),
    );
  }
}
