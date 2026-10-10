import 'dart:io';

import 'package:auto_shop_server/app/routes/app_pages.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:auto_shop_server/common/widgets/web_view/web_view_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../utils/global.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});
  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  String _appName = "";
  String _packageName = "";
  String _version = "";
  String _buildNumber = "";

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo info) {
      _appName = info.appName;
      _packageName = info.packageName;
      _version = info.version;
      _buildNumber = info.buildNumber;
      // print(_appName);
      // print(_packageName);
      // print(_version);
      // print(_buildNumber);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const NavigatorTitle("关于我们"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: BGColor_white_255),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Platform.isIOS ? bodyIOS() : bodyAndroid(),
      // floatingActionButton: kDebugMode
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           Get.toNamed(Routes.CUSTOMERFLOWMAINPAGE, arguments: {
      //             arguments_jumpFromWhere: CustomerJumpFromWhere.jumpCustomerMine.typeUpLoad,
      //           });
      //         },
      //         child: const Icon(
      //           Icons.add,
      //         ))
      //     : const SizedBox.shrink()//
    );
  }

  Widget bodyIOS() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
          child: GestureDetector(
            child: ClipOval(child: Image.asset(AssetsRes.APP_ICON_1024, height: 100, width: 100)),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
          child: Text(
            "Version $_version ($_buildNumber)",
            style: const TextStyle(fontSize: 18, color: Font_Color_Black_34, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: const Text(
            "河北申联汽车园区运营管理有限公司",
            style: TextStyle(fontSize: 18, color: Font_Color_grey_153, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          // | 冀ICP备16021968号-1
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          // | 冀ICP备16021968号-1
          child: const Text(
            "版权所有 © 2024 河北申联汽车 保留所有版权",
            style: TextStyle(fontSize: 14, color: Font_Color_grey_153, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  bodyAndroid() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: GestureDetector(
            onTap: () {
              //测试入口
            },
            child: ClipOval(
                child: Image.asset(
              AssetsRes.APP_ICON_1024,
              height: 100,
              width: 100,
            )),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "构建版本：($_buildNumber)",
                style: const TextStyle(fontSize: 15, color: Font_Color_Black_34, fontWeight: FontWeight.w500),
              ),
              Text(
                "版本号：$_version",
                style: const TextStyle(fontSize: 14, color: Font_Color_Black_34, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            rowKeyValueTextWithLinkClick("", "服务协议", clickCallBack: () {
              Get.to(() => const WebViewPage(url: agreementUrl, title: "服务协议"));
            }),
            const Text(
              " | ",
              style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.w400),
            ),
            rowKeyValueTextWithLinkClick("", "隐私政策", clickCallBack: () {
              Get.to(() => const WebViewPage(url: privacyUrl, title: "隐私政策"));
            }),
          ],
        ),
        const SizedBox(height: 6),
        InkWell(
            onTap: () {
              Clipboard.setData(const ClipboardData(text: "4008686866"));
              showMessage("复制成功");
              callUpWithPhoneNumber("4008686866");
            },
            child: rowKeyValueTextMy("客服电话：", "400-8686-866", keyStyle: blackStyle(), valueStyle: blackStyle())),
        const SizedBox(height: 6),
        InkWell(
            onTap: () {
              Clipboard.setData(const ClipboardData(text: "冀ICP备2022016663号-4A"));
              showMessage("复制成功");
            },
            child: rowKeyValueTextMy("APP备案号：", "冀ICP备2022016663号-4A", keyStyle: blackStyle(), valueStyle: blackStyle())),
        const SizedBox(height: 6),
        rowKeyValueTextWithLinkClick("查询链接：", "https://beian.miit.gov.cn", keyStyle: blackStyle(), clickCallBack: () {
          Get.to(() => const WebViewPage(url: "https://beian.miit.gov.cn", title: "查询信息"));
        }),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: const Text(
            "河北云供销数字乡村科技有限公司",
            style: TextStyle(fontSize: 14, color: Font_Color_grey_153, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          // | 冀ICP备16021968号-1
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          // | 冀ICP备16021968号-1
          child: const Text(
            "版权所有 ©2016-2023 云供销数字乡村科技 保留所有版权",
            style: TextStyle(fontSize: 11, color: Font_Color_grey_153),
          ),
        ),
      ],
    );
  }
}
