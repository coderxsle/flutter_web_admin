import 'dart:io';

import 'package:auto_shop_server/app/modules/home/models/home_page_model.dart';
import 'package:auto_shop_server/common/common_tools.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/common_widget/base_controller.dart';
import 'package:auto_shop_server/app/utils/constant_api.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/utils/result_code.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:auto_shop_server/common/widgets/remark_view.dart';
import 'package:auto_shop_server/common/widgets/web_view/web_view_page.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http_manager/http_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../routes/app_pages.dart';

int clickCount = 0;

class HomeHeaderView extends GetView {
  final HomePageModel? model;
  const HomeHeaderView(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    screenWidth(context);
    return GestureDetector(
      onTap: ()=> _configProxyPage(),
      child: SizedBox(
        child: Stack(
          children: [
            // 背景
            Positioned(
              left: 0, top: 0, right: 0,
              child: imageAsset(AssetsRes.HOME_NAVIGATION, fit: BoxFit.fitWidth),
            ),
            FlexibleSpaceBar(
                titlePadding: const EdgeInsets.fromLTRB(25, 0, 0, 50).r,
                background: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 0, 0).r,
                  child: Row(
                    children: [
                      GestureDetector(
                        // onTap: ()=> Get.toNamed("/MinePage", arguments: model?.appPurviewList!),
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                          // if (kReleaseMode) Get.toNamed("/MinePage", arguments: model?.appPurviewList!);
                        },
                        child: ClipOval(
                            child: imageNetwork(model?.photoUrl??"", width: 68, height: 68, fit: BoxFit.cover, failed: AssetsRes.FACEID_IMAGE)
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: ()=> Get.toNamed("/MinePage", arguments: model?.appPurviewList!),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(model?.managerName ?? "无姓名", style: whiteStyle(font: 16.sp)),
                            Text(model?.actorName ?? "无职位", maxLines: 2, style: whiteStyle(font: 13.sp)),
                            Text(model?.shopName ?? "无企业或店铺", style: whiteStyle()),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
            GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 6).r,
              expandedTitleScale: 1.0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Container(
                  //   padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
                  //   child: Text(model?.shopName ?? "无企业或店铺", style: whiteStyle()),
                  // ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: ()=> Get.toNamed("/MessagePage"),
                    child: const Image(image: AssetImage(AssetsRes.HOME_HEADER_MESSAGE), width: 36),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              background: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  scanner(),
                  const SizedBox(width: 5),
                ],
              )
            )
          ),
            Positioned(
              left: 10, bottom: 6,
              child: buildPaddingForAndroid(),
            )
        ],
      )
      ),
    );
  }

  //华为审核用到
  Widget buildPaddingForAndroid() {
    if (Platform.isAndroid) {
      return const Padding(padding: EdgeInsets.only(left: 12.0, top: 6.0,bottom: 4.0), child: Text("为你推荐", style: TextStyle(fontSize: 11, color: Colors.white)));
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget scanner() {
    return IconButton(
        icon: const Image(image: AssetImage(AssetsRes.HOME_SCAN), width: 32),
        onPressed: (){Platform.isIOS ?openScanPage():openScanPageForAndroid();}
    );
  }

  //用于华为审核用到
  openScanPageForAndroid() async {
    //Logger.logMy("openScanPageForAndroid--openScanPageForAndroid");
    List<Permission> permissions;
    if(AppManager.osSdkIntForAndroid<ANDROID_OS_SDK_33) {
      permissions = [Permission.camera, Permission.storage];
    }else {
      permissions = [Permission.camera,Permission.manageExternalStorage];
    }

    BaseController baseController = BaseController();
    bool hasPermissionNotAllow = await baseController.checkPermissionAndroidList(permissions);
    if(hasPermissionNotAllow){
      CommonTools.showDialogPermissionAndroidList(permissions: permissions, messageToUser: permission_content_camera_storage, doGranted: (){
        openScanPage();
      });
    }else{
      openScanPage();
    }
  }

  openScanPage(){
    Get.toNamed("/ScanPage")?.then((code) async {

      if(ObjectUtil.isEmpty(code)){
        return;
      }

      if (GetUtils.isURL(code)) {
        /// "扫码识别到是 http 开头的 url，去打开网页"
        if (code.contains("ygxpt.com")) {
          final originalUri = Uri.parse(code);
          final param = Map<String, String>.from(originalUri.queryParameters);
          final newParam = {...param, "userToken": AppManager.userToken};
          final uri = originalUri.replace(queryParameters: newParam);
          Get.to(()=> WebViewPage(url: uri.toString()));
        }else {
          showAlertDialog(
              title: "温馨提示",
              message: "$code\n该网页不受我们控制，请在使用时注意安全。",
              margin: const EdgeInsets.only(left: 30, right: 20),
              confirmText: "打开",
              confirm: () async {
                dismissAlertDialog();
                await launchUrl(Uri.parse(code), mode: LaunchMode.externalApplication);
              }
          );
        }
      } else {
        showMessage("暂不支持该二维码类型");
      }
    });
  }

  void _configProxyPage() {
    clickCount ++;
    if(clickCount == 20) {
      clickCount = 0;
      final hostVC = TextEditingController(text: "192.168.");
      final portVC = TextEditingController(text: "8888");
      showAlertDialog(
          title: "请输入代理",
          content: Column(
            children: [
              // const SizedBox(height: 10,),
              RemarkView(title: "", controller: hostVC, height: 32, hintText: "请输入代理地址", bgColor: Colors.grey[100]),
              const SizedBox(height: 10,),
              RemarkView(title: "", controller: portVC, height: 32, hintText: "请输入端口号", bgColor: Colors.grey[100]),
            ],
          ),
          confirm: () async {
            httpManager.setProxy(host: hostVC.text, port: portVC.text);
            showMessage("代理设置成功");
            dismissAlertDialog();
          },
          cancelText: "关闭代理",
          cancel: () {
            httpManager.setProxy();
            dismissAlertDialog();
          }
      );
    }
  }

}
