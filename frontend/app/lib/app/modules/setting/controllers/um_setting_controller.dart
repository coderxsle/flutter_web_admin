//消息推送的控制器
import 'package:auto_shop_server/common/param_key.dart';
import 'package:auto_shop_server/common/common_tools.dart';
import 'package:auto_shop_server/app/simulator/umeng_manager.dart';
import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/modules/launching/loacal_storage.dart';
import 'package:auto_shop_server/utils/error_log_utils.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:umeng_push_sdk/umeng_push_sdk.dart';

class UmSettingController extends GetxController {
  //是否开启权限通知，提醒需手动设置的
  var isOpenNotification = "".obs;
  //当前设备的版本
  var osVersion = '0.0'.obs;

  //横幅通知
  var valveNoticeSwitch = false;
  //声音设置
  var valveSoundSwitch = false;
  //震动设置
  var valveShockSwitch = false;
  //午休免打扰
  var valveMiddayRestSwitch = false;
  //个性化推荐开关
  var valvePersonAlizSwitch = false;

  @override
  void onInit() {
    super.onInit();

    //查看通知权限是否开启
    try {
      // do
      getOsNotice();

      if (box.hasData(ParamKey.kNoticeSwitch)) {
        valveNoticeSwitch = localStorageRead(ParamKey.kNoticeSwitch);
      }

      if (box.hasData(ParamKey.kSoundSwitch)) {
        valveSoundSwitch = localStorageRead(ParamKey.kSoundSwitch);
      }

      if (box.hasData(ParamKey.kShockSwitch)) {
        valveShockSwitch = localStorageRead(ParamKey.kShockSwitch);
      }

      if (box.hasData(ParamKey.kMiddayRestSwitch)) {
        valveMiddayRestSwitch = localStorageRead(ParamKey.kMiddayRestSwitch);
      }

      if (box.hasData(ParamKey.kPersonAlizSwitch)) {
        valvePersonAlizSwitch = localStorageRead(ParamKey.kPersonAlizSwitch);
      }
    } catch (e) {
      logger.i("$logCatTag catch：${e.toString()}");
      ErrorLogUtils.addLogSingle(fun: "UmSettingControllerOnInit", error: "友盟初始化任务失败$e");
    }
  }

  void updateShow() async {
    var status = await Permission.notification.status;
    if (status == PermissionStatus.granted) {
      isOpenNotification.value = "已开启";
      showMessageBottomLikeAndroid("通知权限已开启~", isLong: true);
    } else {
      isOpenNotification.value = "未开启";
      showMessageBottomLikeAndroid("通知权限未开启，请打开系统设置", isLong: true);
    }
    update();
  }

  void updateNotice(value) {
    valveNoticeSwitch = value;
    localStorageWrite(ParamKey.kNoticeSwitch, value);
    // Logger.logMy("updateNotice-更新之后->"+localStorageRead(ParamKey.kNoticeSwitch).toString());
    update();
  }

  void updateSound(value) {
    valveSoundSwitch = value;
    localStorageWrite(ParamKey.kSoundSwitch, value);
    // Logger.logMy("kSoundSwitch-更新之后->"+localStorageRead(ParamKey.kSoundSwitch).toString());
    update();
  }

  void updateShock(value) {
    valveShockSwitch = value;
    localStorageWrite(ParamKey.kShockSwitch, value);
    // Logger.logMy("kShockSwitch-更新之后->"+localStorageRead(ParamKey.kShockSwitch).toString());
    update();
  }

  void updateMiddayRest(value) {
    valveMiddayRestSwitch = value;
    localStorageWrite(ParamKey.kMiddayRestSwitch, value);
    // Logger.logMy("kMiddayRestSwitch-更新之后->"+localStorageRead(ParamKey.kMiddayRestSwitch).toString());
    update();
  }

  void updatePersonAliz(value) {
    valvePersonAlizSwitch = value;
    localStorageWrite(ParamKey.kPersonAlizSwitch, value);
    // Logger.logMy("kPersonAlizSwitch-更新之后->"+localStorageRead(ParamKey.kPersonAlizSwitch).toString());
    if (value) {
      UmengPushSdk.setPushEnable(true);
    } else {
      UmengPushSdk.setPushEnable(false);
    }
    update();
  }

  void clearBadge() {
    //Logger.logMy("clearBadge-更新之后->clearBadge");
    UmengPushManager.clearBadge();
    showMessageBottomLikeAndroid("首页角标清理完毕", isLong: false);
  }

  //推送开关 设置，统一设置？
  getOsNotice() async {
    await CommonTools.getOsVersion().then((version) {
      // Logger.logMy("版本信息=$version");
      osVersion.value = version;
    });

    var status = await Permission.notification.status;
    if (status.isGranted) {
      isOpenNotification.value = "已开启";
    } else {
      isOpenNotification.value = "未开启";
    }
  }
}
