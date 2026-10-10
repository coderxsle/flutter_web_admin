import 'package:auto_shop_server/app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 购物车 Tab 占位页，业务内容待接入
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        // 作为底部 Tab 根页面时不显示返回
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
                onPressed: () => Get.back(),
              )
            : null,
        title: const NavigatorTitle("购物车"),
      ),
      body: const Center(
        child: Text("购物车页待接入", style: TextStyle(fontSize: 16, color: Colors.grey)),
      ),
    );
  }
}
