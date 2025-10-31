import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'theme/theme_controller.dart';
import 'app_manager.dart';
import 'loacal_storage.dart';
import 'my_dialog.dart';
import 'config/app_config.dart';
import 'api/api_result_code.dart';
import 'package:flutter/foundation.dart';
import 'package:http_manager/http_manager.dart';
import 'package:flutter_web_shared/shared.dart';


class AppLaunching {

  static Future<void> launching() async {
    // 确保基础组件总是被初始化
    await _baseComponents();
    
    logger.i('启动完成！');
    
    // 延迟执行非关键初始化，让首帧尽快渲染
    Future.delayed(Duration.zero, () {
      _postLaunchInitialization();
    });
  }
  
  // 首帧渲染后的初始化
  static Future<void> _postLaunchInitialization() async {
    // 这里可以放一些非关键的初始化任务
    logger.i('后台初始化完成');
  }

  // 初始化基础组件
  static Future<void> _baseComponents() async {
    // 确保 GetStorage 初始化
    await GetStorage.init();

    // 设置网络
    await _setupNetwork();

    // 初始化主题系统 注册主题控制器
    Get.put<ThemeController>(ThemeController(), permanent: true);
    
    // 如果App是第一次安装，则启动需要授权的组件
    // 如果不进行授权，就获取设备信息，App在审核时会被拒绝
    if (AppManager.isFirstInstall) {
      await _authorizedComponents();
    }else {
      // 获取设备信息
      await AppManager.getDeviceInfo();
    }
  }

  // 正常启动的组件
  static Future<void> _authorizedComponents() async {
    // 暂时使用
    // if (kReleaseMode) localStorageRemove("isDebugBaseUrl");
    
  }

  static changeNetworkBaseURL({String? host}) {
    if (host != null) {
      if (host.startsWith('http') != true) host = 'http://$host';
      httpManager.baseUrl = host;
      localStorageWrite('isDebugBaseUrl', host == baseURLTest ? true : false);
      showMessage('已连接主机 $host');
    } else {
      if (localStorageRead('isDebugBaseUrl') == true) {
        httpManager.baseUrl = baseURL;
        localStorageWrite('isDebugBaseUrl', false);
        showMessage('已切换正式环境');
        debugPrint('=====已切换正式环境=====');
      } else {
        httpManager.baseUrl = baseURLTest;
        localStorageWrite('isDebugBaseUrl', true);
        showMessage('已切换测试环境');
        debugPrint('=====已切换测试环境=====');
      }
    }
    // AppLaunching.requestUserToken();
  }

  // 根据设备UDID获取token
  // static Future<ResponseAnalyzed> requestUserToken() async {
  //   return await LaunchRequest.getUserToken(uuid: AppManager.uuid);
  // }

  // 配置网络
  static Future<void> _setupNetwork() async {

    logger.i('🕙 开始配置网络...');

    // 显示日志
    httpManager.showLog = true;

    // 获取是否是测试环境
    final debug = localStorageRead('isDebugBaseUrl') ?? false;

    // 设置网络基础地址
    httpManager.baseUrl = debug == true ? baseURLTest : baseURL;

    // 获取用户token
    final userToken = AppManager.userInfo?.token ?? '';

    AppManager.userToken = userToken;
    logger.i('🕙 用户token: $userToken');

    logger.i('🕙 用户信息: ${AppManager.userInfo?.toJson()}');
    
    // 设置请求头
    logger.i('🕙 开始设置请求头...');
    final headers = {
      // "UserToken": userToken,
      // "DeviceCode": AppManager.uuid,
      'Authorization': 'Bearer $userToken',
      // "DeviceModel": AppManager.deviceModel,
      'User-Agent': 'AutoSteward/${AppManager.version}${kIsWeb ? '(Web)' : (Platform.isIOS ? '(iOS)' : '(Android)')}',
    };
    httpManager.setHeaders(headers);
    logger.i('✅ 请求头设置完成！');

    // final sid = AppManager.currentShop?.shopInfoId;
    // Map<String, dynamic> baseParam = {"shopInfoId": sid, "shopId": sid};
    // HttpManager.setBaseParam(baseParam);

    // 设置 Http 请求的响应解析
    ResponseAnalyzed.setResponseKey('code', 'message', 'data');

    // 设置响应解析
    ResponseAnalyzed.setResultCheck((result) => ResponseAnalyzedExtention.checkeAnalyzing(result));

    logger.i('✅ 网络配置完成！');
    logger.i('HttpManager.baseUrl：${httpManager.baseUrl}');

  }

}
