import 'package:auto_shop_server/app/modules/home/models/home_page_model.dart';
import 'package:auto_shop_server/app/utils/common_widget/base_item.dart';
import 'package:auto_shop_server/app/utils/common_widget/my_material_button.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/modules/pay_manager/alipay_manager.dart';
import 'package:auto_shop_server/app/modules/pay_manager/wechat_manager.dart';
import 'package:auto_shop_server/common/widgets/web_view/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeMenuItemController extends BaseItemController {
  HomeMenuItemController({required this.code});
  final String? code;
  final badgeCount = "".obs;
  var showBadge = false.obs;

  // 首页九宫格菜单点击：目前仅支持外部链接跳转，业务页面待接入
  void itemOnTap(HomePageModelAppPurviewList? itemModel) {
    final name = itemModel?.purviewName ?? "";
    final url = itemModel?.url ?? "";
    if (url.isEmpty) {
      showMessage("该功能正在开发中...");
      return;
    }
    if (url.startsWith("http")) {
      Get.to(() => WebViewPage(url: url, title: name));
    } else if (url.startsWith("open.wechat://")) {
      WechatManager.openMiniProgram(url);
    } else if (url.startsWith("alipays://")) {
      AlipayManager.openMiniProgram(url);
    }
  }
}

class HomeMenuItem extends BaseItem {
  final HomePageModelAppPurviewList? model;
  final HomeMenuItemController controller;
  const HomeMenuItem(this.model, this.controller, {super.key, super.onTap});

  @override
  Widget build(BuildContext context) {
    return ShapeRadiusContainer(
      child: MyMaterialButton(
        onPressed: onTap!,
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                imageNetwork(model?.purviewUrl! ?? "", width: 50.h),
                Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model?.purviewName ?? "", style: blackStyle(font: 14.h)),
                      if (model?.totalValue != null && model!.totalValue!.isNotEmpty) Text("${model?.totalValue}", style: greyStyle(font: 12.h)),
                      if (model?.dailyValue != null && model!.dailyValue!.isNotEmpty) Text("${model?.dailyValue}", style: greyStyle(font: 12.h)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
