import 'dart:io';

import 'package:auto_shop_server/app/simulator/umeng_manager.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/utils/result_code.dart';
import 'package:auto_shop_server/app/modules/pay_manager/wechat_manager.dart';
import 'package:auto_shop_server/database/db_manager.dart';
import 'package:auto_shop_server/common/widgets/web_view/web_view_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:http_manager/http_manager.dart';

import 'request/launching_request.dart';
import '../../../main_api.dart';
import 'loacal_storage.dart';

class AppLaunching {

  static Future<void> launching() async {
    if(Platform.isAndroid){
      //@timeUpdate 2025/8/25 因为vivo审核，如果是android平台暂时不初始化日志
    }else{
      LoggerTool.initLogger();
    }
    // 确保基础组件总是被初始化
    await _launchingBaseComponents();
    if (!AppManager.isFirstInstall) {
      await _launchingNormalComponents();
    }
  }

  // 初始化基础组件
  static Future<void> _launchingBaseComponents() async {
    await _setupNetwork();
  }

  // 正常启动的组件
  static Future<void> _launchingNormalComponents() async {
    // 暂时使用
    if (kReleaseMode) localStorageRemove("isDebugBaseUrl");
    if(Platform.isAndroid){
      LoggerTool.initLogger();
    }
    await AppManager.getDeviceInfo();
    await AppManager.getAuthState();
    // await AppLaunching.requestPopAdvert();
    // await AppLaunching.requestActiveAdvert();
    WechatManager.instance.register();
    //2025年12月25日，因为vivo审核说友盟有:同意隐私声明后-后台，监听应用安装、更新、卸载的行为
    try {
      // do
      UmengPushManager.initRegister();
    } catch (e) {
      LoggerTool.logMy("$logCatTag catch：${e.toString()}");
    }

    if (!FlutterDownloader.initialized) {
      FlutterDownloader.initialize(debug: true, ignoreSsl: true);
    }
    await _initDb();
    await _createWebViewEnvironment();
    await AppLaunching.requestUserToken();
    // logger.i("appLaunching()执行完毕");
  }

  //初始化数据库相关
  static _initDb() async {

    try {
      // 业务数据库待接入
    } catch (e) {
      LoggerTool.logMy("$logCatTag catch：${e.toString()}");
    }
    // 初始化数据库
    await DBManager.init();
  }

  // 展示用户协议
  static void readUserInfoTap() {
    if (AppManager.isFirstInstall == false) {
      return;
    }
    debugPrint("第一次安装App");
    debugPrint("开始展示隐私协议");
    showAlertDialog(
        title: "隐私政策",
        messageTextSpan: _textSpan1(),
        confirmText: "同意",
        confirm: () async {
          dismissAlertDialog();
          debugPrint("用户同意个人隐私协议");
          AppManager.isFirstInstall = false;
          AppLaunching._launchingNormalComponents();
          AppLaunching._setSignStateHttp();
        },
        cancel: () {
          dismissAlertDialog();
          showAlertDialog(
              title: "温馨提示",
              messageTextSpan: _textSpan2(),
              confirmText: "同意",
              confirm: () async {
                dismissAlertDialog();
                debugPrint("用户同意个人隐私协议");
                AppManager.isFirstInstall = false;
                AppLaunching._launchingNormalComponents();
                AppLaunching._setSignStateHttp();
              },
              cancelText: "不同意",
              cancel: () {
                debugPrint("用户不同意协议，App已退出");
                exit(0);
              });
        });
  }

  static changeNetworkBaseURL({String? host}) {
    if (host != null) {
      if (host.startsWith("http") != true) host = "http://$host";
      httpManager.baseUrl = host;
      localStorageWrite("isDebugBaseUrl", host == baseURLTest ? true : false);
      showMessage("已连接主机 $host");
    } else {
      if (localStorageRead("isDebugBaseUrl") == true) {
        httpManager.baseUrl = baseURL;
        localStorageWrite("isDebugBaseUrl", false);
        showMessage("已切换正式环境");
        debugPrint('=====已切换正式环境=====');
      } else {
        httpManager.baseUrl = baseURLTest;
        localStorageWrite("isDebugBaseUrl", true);
        showMessage("已切换测试环境");
        debugPrint('=====已切换测试环境=====');
      }
    }
    AppLaunching.requestUserToken();
  }

  // 根据设备UDID获取token
  static Future<ResponseAnalyzed> requestUserToken() async {
    return await LaunchRequest.getUserToken(uuid: AppManager.uuid);
  }

  static Future<void> _createWebViewEnvironment() async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
      final availableVersion = await WebViewEnvironment.getAvailableVersion();
      assert(availableVersion != null, 'Failed to find an installed WebView2 Runtime or non-stable Microsoft Edge installation.');
      final environment = await WebViewEnvironment.create(settings: WebViewEnvironmentSettings());
      AppManager.webViewEnvironment = environment;
    }
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
    }
  }

  // 配置网络
  static _setupNetwork() async {
    httpManager.showLog = true;
    final debug = localStorageRead("isDebugBaseUrl")??false;
    httpManager.baseUrl = debug == true ? baseURLTest : baseURL;
    var token = AppManager.userAccount == null ? "" : AppManager.userAccount!.userToken!;
    final headers = {
      "DeviceCode": AppManager.uuid,
      // "User-Agent": "AutoSteward/(iOS)",
      "User-Agent": "AutoSteward/${AppManager.version}${Platform.isIOS?"(iOS)":"(Android)"}",
      "DeviceModel": AppManager.deviceModel,
      "UserToken": token,
    };
    httpManager.setHeaders(headers);
    final sid = AppManager.currentShop?.shopInfoId;
    Map<String, dynamic> baseParam = {"shopInfoId": sid, "shopId": sid};
    httpManager.setBaseParam(baseParam);

    ResponseAnalyzed.setResponseKey("code", "message", "data");
    ResponseAnalyzed.setResultCheck((result) => ResponseAnalyzedExtention.checkeAnalyzing(result));
    // logger.i("httpManager.baseUrl：${httpManager.baseUrl}");
    // logger.i("httpManager.baseParam：$baseParam");
    // logger.i("setupNetwork() 执行完毕！");

  }

  // 设置用户隐私协议的签名状态
  static Future _setSignStateHttp() async {
    if (AppManager.uuid.isNotEmpty) {
      var result = await LaunchRequest.setSignState(uuid: AppManager.uuid);
      if (result.success) {
        logger.i("用户同意个人隐私协议，已上传服务器！");
      }
    } else {
      logger.i("上报用户隐私以阅读的签名名状态：uuid为空!");
    }
  }

  static InlineSpan? _textSpan1() {

    String contentTopAndroid = "您点击【同意】,即表示您已阅读并同意以上条款。请您充分了解在使用本软件过程中我们可能收集、使用您的个人信息情形，"
        "希望您着重关注：\n"
        "1：为了消息推送，我们采用友盟SDK，采集您的设备（IMEI/MAC/Android ID/IDFA/OAID/OpenUDID/GUID/SIM卡IMSI/ICCID位置信息、网络信息等。\n"//
        "2: 在使用各模块的过程中，第三方SDK会处理设备MAC地址、软件安装列表、位置、联系人、通话记录、日历、短息本机电话号码、等信息。\n"//
        "APP内【设置-关于我们】有【隐私政策】的常驻入口，我们将全力保障您的合法权益与信息安全,并将持续为您提供更优质的服务。\n";//

    String contentTopIOS = '依据最新的监管要求更新了用户隐私保护协议，并且禁止软件获取不相关的权限和数据，以此来最大限度的保护用户的利益。为此我们明确了用户的查询、更正和删除其个人信息的方式。\n请仔细阅读';

    return TextSpan(children: [
      TextSpan(
        text: Platform.isIOS?contentTopIOS:contentTopAndroid,
        style: Platform.isIOS?const TextStyle(fontSize: 16, color: Colors.black, height: 1.5):const TextStyle(fontSize: 12.5, color: Colors.black, height: 1.3),
      ),
      TextSpan(
          text: '《服务协议》',
          style: Platform.isIOS?const TextStyle(fontSize: 16, color: Colors.blue, decorationColor: Colors.blue, height: 1.5):const TextStyle(fontSize: 12.5, color: Colors.blue, decorationColor: Colors.blue, height: 1.3),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Get.to(()=> const WebViewPage(url: agreementUrl, title: "服务协议"));
            }),
      TextSpan(
        text: '和',
        style: Platform.isIOS?const TextStyle(fontSize: 16, color: Colors.black, height: 1.5):const TextStyle(fontSize: 12.5, color: Colors.black, height: 1.3),
      ),
      TextSpan(
          text: '《隐私政策》',
          style: Platform.isIOS?const TextStyle(fontSize: 16, color: Colors.blue, decorationColor: Colors.blue, height: 1.5):const TextStyle(fontSize: 12.5, color: Colors.blue, decorationColor: Colors.blue, height: 1.3),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Get.to(()=> const WebViewPage(url: privacyUrl, title: "用户隐私政策"));
            }),
      TextSpan(
          text: '尤其是加粗和划横线的内容，并了解我们对您个人信息的处理规则。',
          style: Platform.isIOS?const TextStyle(fontSize: 16, color: Colors.black, height: 1.5):const TextStyle(fontSize: 12.5, color: Colors.black, height: 1.3)
      ),
    ]);
  }

  static InlineSpan? _textSpan2() {
    return TextSpan(children: [
      const TextSpan(
        text: '为了在提供服务的同时，更好的保障您的合法权益，请仔细阅读我们的',
        style: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
      ),
      TextSpan(
          text: '《服务协议》',
          style: const TextStyle(fontSize: 16, color: Colors.blue, decorationColor: Colors.blue, height: 1.5),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Get.to(()=> const WebViewPage(url: "https://echelianhtml.ygxpt.com/agreement/index.html", title: "服务协议"));
            }),
      const TextSpan(
        text: '和',
        style: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
      ),
      TextSpan(
          text: '《隐私政策》',
          style: const TextStyle(fontSize: 16, color: Colors.blue, decorationColor: Colors.blue, height: 1.5),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Get.to(()=> const WebViewPage(url: "https://echelianhtml.ygxpt.com/privacy/index.html", title: "用户隐私政策"));
            }),
      const TextSpan(
        text: '我们尊重您的选择，如果您不同意，我们无法为您提供相应的服务，App也将会退出。',
        style: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
      ),
    ]);
  }
}
