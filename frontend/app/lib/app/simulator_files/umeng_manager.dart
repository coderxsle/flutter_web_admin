import 'dart:async';
import 'dart:io';

import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:flutter/cupertino.dart';
// ================== 非模拟器 ===================
// import 'package:umeng_common_sdk/umeng_common_sdk.dart';
// import 'package:umeng_push_sdk/umeng_push_sdk.dart';
// import '../utils/common_widget/logger.dart';
// import '../utils/global.dart';
// import 'package:just_audio/just_audio.dart';

// ================== 非模拟器 ===================
//----------------------------------------------------------------------------------
//需要后台设置的代码：离线厂商通道设置channel_activity
//厂商消息下发时，Activity路径传入：com.umeng.message.UmengOfflineMessageActivity
//----------------------------------------------------------------------------------
const String kUMPushIOSAppKey = "64e2e3c5cbfabf4b74674a68";
const String kUMMasterSecret = "rwzis3kav4b5hdfngqar2lyln3h53aiy";
//友盟官网：应用信息内查找AppKey
const String kUMPushAndroidAppKey = "64cc9991a1a164591b62dbd3";
//友盟官网：应用信息内查找
const String kUMMessageSecretForAndroid = "3b1a0139d1ac796f35ec2df7d208885e";
final String channel = Platform.isIOS ? "AppStore" : Platform.isAndroid ? "Umeng" : "";

typedef Callback = void Function(String result);

class UmengPushManager {
  static final UmengPushManager _singleton = UmengPushManager._internal();
  static UmengPushManager get instance { return _singleton; }
  // 私有构造函数，只能在类内部被调用
  UmengPushManager._internal();
  static int badgeNumber = 0;

  // 初始化并注册
  static initRegister() {
    UmengPushManager.instance._init();
    UmengPushManager.instance._register();
  }

  /// 友盟日志
  static enableLog(bool? enable) {
    // UmengPushSdk.setLogEnable(enable??false);
  }

  /// 初始化友盟推送
  _init() async {

    // if (Platform.isIOS) UmengCommonSdk.initCommon(kUMPushAndroidAppKey, kUMPushIOSAppKey, channel, kUMMasterSecret);
    // if (Platform.isAndroid) UmengCommonSdk.initCommon(kUMPushAndroidAppKey, "", channel, kUMMessageSecretForAndroid);

  }

  /// 友盟推送注册
  _register() async {

    if (AppManager.isPhysicalDevice) {

    }
    // if (Platform.isIOS) UmengPushSdk.register(kUMPushIOSAppKey, channel);
    // if (Platform.isAndroid) UmengPushSdk.register(kUMPushAndroidAppKey, channel);

    UmengPushManager.setNotificationCallback((receive) async {
     //Logger.logMy("receive-->$receive");
      addBadge();

      // try {
      //   //本地MP3播放
      //   AudioPlayer audioPlayer = AudioPlayer();
      //   await audioPlayer.setAsset(AssetsRes.UMENG_PUSH_NOTIFICATION_DEFAULT_SOUND);
      //   await audioPlayer.play();
      // } catch (e) {
      //   LoggerTool.logMy("$logCatTag catch：${e.toString()}");
      // }
    }, (open) {
      //Logger.logMy("open-->$open");
      reduceBadge();
    });

  }

  /// 获取注册友盟推送的 deviceToken
  static Future<String?> getDeviceToken() async {
    // return await UmengPushSdk.getRegisteredId();
  }

  /// 设置推送是否可用，仅支持Android
  static openPushForAndroid(bool? enable) async{
    // UmengPushSdk.setPushEnable(enable??true);
  }

  /// 设置deviceToken回调，仅支持Android
  static void setTokenCallbackForAndroid(Callback? callback) {
    // UmengPushSdk.setTokenCallback(callback);
  }

  /// 设置透传消息回调 // 设置自定义消息回调
  static void setMessageCallback(Callback? callback) {
    // UmengPushSdk.setMessageCallback(callback);
  }

  /// 设置透传消息回调 // 设置通知消息回调
  static void setNotificationCallback(Callback? receive, Callback? open) {
    // UmengPushSdk.setNotificationCallback(receive, open);
  }

  /// 角标加 1，Android仅支持华为、荣耀、VIVO、OPPO（需申请）
  static addBadge() async {
    // bool? result = await UmengPushSdk.setBadge(badgeNumber++);
    // debugPrint("addBadge() $_singleton.badgeNumber result: $result");
  }

  /// 角标减 1
  static reduceBadge() async {
    if (badgeNumber-- < 0) {
      badgeNumber = 0;
    }
    // bool? result = await UmengPushSdk.setBadge(badgeNumber);
    // debugPrint("reduceBadge() $_singleton.badgeNumber result: $result");
  }

  /// 清除角标
  static clearBadge() async {
    badgeNumber = 0;
    // bool? result = await UmengPushSdk.setBadge(badgeNumber);
    // debugPrint("clearBadge() result: $result");
  }

}