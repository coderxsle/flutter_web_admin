import 'package:auto_shop_server/common/common_tools.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/result_code.dart';
import 'package:auto_shop_server/app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:http_manager/http_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../utils/app_version_update/app_version_info.dart';
import '../loacal_storage.dart';
import '../model/launch_advert_model.dart';

class LaunchRequest {

  //android通过获取systemConfig接口来获取版本信息
  static Future<AppVersionInfo?> androidAppUpdateInfo() async {

    AppVersionInfo appVersionInfo = AppVersionInfo(version: "", platform: "", buildNumber: "", releaseNotes: "", downloadUrl: "");
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String buildNumber = packageInfo.buildNumber;

    var url = '/pub/v1/config/getConfig';
    final param = {"": ""};
    var response = await httpManager.postAnalyzing(url, params: param);
    if (response.success) {
      //Logger.logMy("$logCatTag systemConfigEntity：${response.toString()}");
      if (response.data is List<dynamic>) {
        for (var index = 0; index < response.data.length; ++index) {
          var element = response.data[index];
          if (element['key'] == app_update_android_download_url) {
            String downUrl = element["value"];
            //Logger.logMy("$logCatTag downUrl：${downUrl.toString()}");
            localStorageWrite(app_update_android_download_url, downUrl);
            String versionCurr = CommonTools.getServiceVersionCode(downUrl);
            //Logger.logMy("$logCatTag versionCurr：${versionCurr.toString()}");
            appVersionInfo = AppVersionInfo(downloadUrl: downUrl, buildNumber: buildNumber, version: versionCurr, platform: appVersionInfoPlatform, releaseNotes: '');
            break;
          }
        }
      }
    }
    return appVersionInfo;
  }

  // 闪屏广告(App 启动后3～5秒倒计时的全屏广告)
  static Future<ResponseAnalyzed> requestActiveAdvert() async {
    String url = "";
    Map<String, dynamic> data = {};
    var result = await httpManager.getAnalyzing(url, params: data);
    if (result.success) {
      AppManager.activeAdvert = ActiveAdvertModel.fromJson(result.data);
      if (AppManager.activeAdvert?.picUrls?.first.picUrlAll?.isNotEmpty == true) {
        AppManager.launchImage = NetworkImage(AppManager.activeAdvert!.picUrls!.first.picUrlAll!);
      }
    }
    return result;
  }

  // 弹窗广告(App进入后台，或者其他操作后，在首页弹出的窗口广告)
  static Future<ResponseAnalyzed> requestPopupAdvert() async {
    var communityId = AppManager.userAccount!.communityId!;
    String url = "/$communityId";
    Map<String, dynamic> data = {};
    var result = await httpManager.getAnalyzing(url, params: data);
    if (result.success) {
      AppManager.popAdvert = PopupAdvertModel.fromJson(result.data);
    }
    return result;
  }

  // 获取用户隐私协议的签名状态
  static Future<ResponseAnalyzed> getSignState({String uuid = ""}) async {
    Map<String, dynamic> data = {"type": "autoSteward", "uid": uuid};
    String url = "/pub/v1/system/privacyPolicy/getSignState";
    return await httpManager.postAnalyzing(url, params: data);
  }

  // 上报用户隐私以阅读的签名名状态
  static Future<ResponseAnalyzed> setSignState({String uuid = ""}) async {
    Map<String, dynamic> data = {"type": "autoSteward", "uid": uuid};
    String url = "/pub/v1/system/privacyPolicy/setSignState";
    return await httpManager.postAnalyzing(url, params: data);
  }

  // 获取 UserToken
  static Future<ResponseAnalyzed> getUserToken({String uuid = ""}) async {
    String url = "/pub/v1/token/getToken/AutoSteward_$uuid";
    // String url = "/pub/v1/token/getToken/CloudSteward_$uuid";
    Map<String, dynamic> data = {};
    var result = await httpManager.getAnalyzing(url, params: data);
    if (result.success) {
      AppManager.userToken = result.data;
      httpManager.setHeaders({"UserToken": result.data});
      localStorageWrite('kUserDefaultsKeyToken', result.data);
    } else {
      debugPrint("getUserToken 获取失败 ${result.message}");
    }
    return result;
  }
}
