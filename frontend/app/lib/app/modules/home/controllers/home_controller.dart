import 'dart:async';

import 'package:auto_shop_server/app/modules/home/views/home_menu_item.dart';
import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/utils/app_version_update/app_version_manager.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/utils/result_code.dart';
import 'package:auto_shop_server/app/modules/launching/loacal_storage.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../models/home_page_model.dart';
import '../request/home_request.dart';

class HomeController extends BaseController with GetSingleTickerProviderStateMixin {
  final model = HomePageModel.fromJson({}).obs;
  final List<HomeMenuItemController> itemControllers = [];

  @override
  Future<FutureOr> onRefresh() async {
    await getHomeData();
    super.onRefresh();
  }

  @override
  Future<FutureOr> onLoad() async {
    await getHomeData();
    super.onLoad();
  }

  @override
  void onClose() {
    super.onClose();
    AppManager.deleteBroadcast(kHomeRefresh);
  }

  @override
  void onReady() {
    super.onReady();
    if (localStorageRead("isDebugBaseUrl") == true) {
      afterDelay(1000, callBack: () {
        showMessage("请注意！当前为测试环境！");
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    getHomeData();

    afterDelay(3000, callBack: () async {
      // 2 秒后检测是否有新的版本
      // if (Platform.isAndroid) {
      //   AppLaunching.checkAppAndroidVersionUpdate(); // 临时使用
      // }
      AppVersionManager.checkVersionUpdate();

      //@updateTime 2025/1/5新增一个通知权限是否打开的弹窗提示
      if (Platform.isAndroid) {
        checkNotification();
      }
    });

    AppManager.registerBroadcast(kHomeRefresh, (value) {
      getHomeData();
    });
  }

  // 获取首页数据
  getHomeData() async {
    final result = await HomeRequest.getHomeData();
    dismissLoading();
    if (result.success) {
      modelAnalyzing(result, model, HomePageModel.fromJson);
    } else {
      AppManager.signOut();
    }
  }

  //android设备检测通知权限是否开启，-为了接收消息推送
  checkNotification() async {
    //获取当前的通知权限
    PermissionStatus status = await Permission.notification.status;
    if (!ObjectUtil.isEmpty(status)) {
      if (status.isGranted) {
        // logger.i("通知权限-Permission.notification.status[已打开]");
      } else if (status.isDenied || status.isPermanentlyDenied) {
        //如果用户拒绝了权限或者没有被询问过，那么我们可以请求权限
        logger.w("通知权限-Permission.notification.status[未开启]");
        showAlertDialog(
            title: titleTips,
            confirmText: "打开",
            message: permission_content_post_notifications,
            confirm: () async {
              SmartDialog.dismiss(force: true);
              // 请求通知权限
              final result = await Permission.notification.request();
              //// 再次检查权限状态以确认用户是否授予了权限
              if (result == PermissionStatus.granted) {
                showMessage("通知权限已开启");
              } else {
                logger.w("通知权限未开启");
                // 如果权限被永久拒绝，则引导用户去设置页面手动开启权限
                openAppSettings();
              }
            },
            cancel: () {
              dismissAlertDialog();
            });
      }
    }
  }
}
