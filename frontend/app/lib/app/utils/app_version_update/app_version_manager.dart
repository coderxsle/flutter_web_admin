import 'dart:convert';
import 'dart:io';

import 'package:auto_shop_server/app/utils/result_code.dart';
import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/common/common_tools.dart';
import 'package:auto_shop_server/app/simulator/umeng_manager.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/app_version_update/app_version_info.dart';
import 'package:auto_shop_server/app/utils/app_version_update/min_required_version_model.dart';
import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/utils/sring_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modules/launching/request/launching_request.dart';

// const String Android = "1";
const String iOS = "2";

class AppVersionManager {
  /// 检查版本号
  static void checkVersionUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AppManager.version = packageInfo.version;
    AppManager.appName = packageInfo.appName;
    // 特别注意：android 特用 buildNumber 来升级 apk
    AppManager.buildNumber = packageInfo.buildNumber;
    AppVersionInfo? version;
    if (Platform.isIOS) version = await _iOSAppVersion();
    if (Platform.isAndroid) version = await _androidAppVersion();
    if (version != null) compareToUpdate(version);
    if (kDebugMode) _logAppRunningInfo();
  }

  /// 从 App Store 获取 iOS 的版本信息
  static Future<AppVersionInfo?> _iOSAppVersion() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final url = "$iOSVersionLookupURL?id=$AppStoreID&timestamp=$timestamp";
    // 用GET方法请求，GET请求会有缓存，导致获取版本不及时，换为POST
    // 拼接时间戳，防止服务器对请求进行对 get 请求做缓存处理，或者使用 post 请求。
    final result = await Dio().post(url);
    if (result.data is String) {
      if (json.decode(result.data) is Map<String, dynamic>) {
        return AppVersionInfo.fromIOSAppStore(json.decode(result.data));
      }
    } else if (result.data is Map<String, dynamic>) {
      return AppVersionInfo.fromIOSAppStore(result.data);
    }
    return null;
  }

  /// 获取 Android 的版本信息
  /// 优先使用品牌厂商内的应用商店更新
  /// 如果能针对设备品牌获取商店的版本号，跳转各自品牌厂商的应用商店更新App
  /// 如果商店没有上架，或者获取失败，则择使用 App 后台的服务器进行获取下载更新
  static Future<AppVersionInfo?> _androidAppVersion() async {
    //暂时只是从服务器获取uri链接取出最后数字做对比。
    // await LaunchRequest.androidAppUpdateInfo();
    return await _requestAppVersion();
    // switch (AppManager.brand) {
    //   case "Xiaomi":
    //   // 小米的逻辑处理
    //   // 目前，小米应用商店没有公开的官方 API，因此常见的方法是解析商店网页返回的 HTML 来获取版本信息。
    //     // xiaomiStoreVersion();
    //     break;
    //   case "Huawei":
    //   // 华为的逻辑处理
    //     break;
    // // 可以添加更多的 case 处理其他品牌
    //   default:
    //   // 默认处理逻辑，如果需要的话
    //     break;
    // }
    // return null;
  }

  /// 打开 小米 应用商店
  ///
  // static Future<void> openMiuiStore(String packageName) async {
  //   if (AppManager.brand == "Xiaomi") {
  //     const String miuiStoreScheme = "mimarket://details?id=";
  //     Uri uri = Uri(scheme: "$miuiStoreScheme$packageName");
  //     if (await canLaunchUrl(uri)) {
  //       await launchUrl(uri);
  //     } else {
  //       throw "打开商店失败";
  //     }
  //   }else {
  //     showMessage("非小米设备，无法打开");
  //   }
  // }

  /// 获取 App 版本信息
  static Future<AppVersionInfo?> _requestAppVersion() async {
    // request version info code...
    final appVersionInfo = await LaunchRequest.androidAppUpdateInfo();
    //勿删日志：调试、断点用到
    // if (appVersionInfo != null) {
    //     Logger.logMy("$logCatTag appVersionInfo：${appVersionInfo.toString()}");
    //     Logger.logMy("$logCatTag appVersionInfo.version：${appVersionInfo.version}");
    //     Logger.logMy("$logCatTag appVersionInfo.platform：${appVersionInfo.platform}");
    //     Logger.logMy("$logCatTag appVersionInfo.buildNumber：${appVersionInfo.buildNumber}");
    //   }
    return appVersionInfo;
  }

  //打开android的应用商店
  static openAndroidMarket() async {
    if (Platform.isAndroid) {
      const String url = marketAndroid;
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw '打开应用商店失败';
      }
    }
  }

  // 请求最小支持版本（iOS 已弃用，使用了 _requestMinRequiredVersion2 方法）
  static Future<String> _requestMinRequiredVersion(String platform) async {
    final result = await httpManager.getAnalyzing("/auth/v1/software/getLastSoftwareByPlatform/$platform");
    if (!ObjectUtil.isEmpty(result.data)) {
      if (result.data is Map<String, dynamic>) {
        // Android == 1
        if (platform == requestMinRequiredVersionAndroid) {
            //var resultData = result.data;
            //将map转为jsonStr返回回去。
            //String? jsonStr = JsonUtil.encodeObj(resultData);
            String? jsonStr = JsonUtil.encodeObj(result.data);
            if (jsonStr != null) {
              logger.d("jsonStr--格式化之后的json = $jsonStr");
              return jsonStr;
            }
            return "";
        }
        // iOS == 2 (ios 已弃用)
        if (platform == "2") return result.data["softwareVersion"];
      }
    }
    return "";
  }

  // 请求最小支持版本，直接返回 MinRequiredVersionModel 对象，更加规范
  static Future<MinRequiredVersionModel?> _requestMinRequiredVersion2(String platform) async {
    final result = await httpManager.getAnalyzing("/auth/v1/software/getLastSoftwareByPlatform/$platform");
    if (result.success) {
      final model = MinRequiredVersionModel.fromJson(result.data);
      return model;
    }
    return null;
  }

  /// 打开 iOS 版 App Store
  static openIOSAppStore() async {
    // const url = "https://itunes.apple.com/cn/app/$AppStoreID";
    // Uri uri = Uri(scheme: 'https', host: 'itunes.apple.com', path: '/cn/app/$AppStoreID');
    Uri uri = Uri.parse(iOSAppStoreURL);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "打开商店失败";
    }
  }

  /// 对比版本号判断是否弹出更新提示
  static Future<void> compareToUpdate(AppVersionInfo systemConfigVersion) async {
    if (Platform.isIOS) {
      String? localVersion = AppManager.version;
      if (localVersion.isEmpty) return;
      int state = _compareVersions(systemConfigVersion.version, localVersion);
      if (state > 0) {
        // 请求服务器，获取最小支持版本
        // 如果本地版本小于系统配置的最小支持版本，则弹出更新提示
        final model = await _requestMinRequiredVersion2(iOS);
        final lastForceUpdate = model?.lastForceUpdate;
        if (lastForceUpdate != null) {
          // 如果本地版本小于强制更新的版本，则 isRequired 为true，更新提示弹出强制更新，点击取消后，会重新触发弹框。
          final isRequired = _compareVersions(lastForceUpdate.softwareVersion!, localVersion) > 0;
          // 弹出更新提示 isRequired 为 false，则弹出更新，点击取消后，不会重新触发弹框。
          showUpdateDialog(systemConfigVersion, isRequired);
        }
      }
      //
    } else if (Platform.isAndroid) {
      //用户手机上目前正在安装的版本。
      String localBuildNumber = AppManager.buildNumber;
      if (StringUtils.notNullNorEmpty(localBuildNumber) && StringUtils.notNullNorEmpty(systemConfigVersion.version)) {
        //【后台配置版本】大于【安装版本】：
        if (int.parse(systemConfigVersion.version) > int.parse(localBuildNumber)) {
          //发现有版本更新，弹出更新提示，让用户下载。
          String minRequiredVersion = await _requestMinRequiredVersion(requestMinRequiredVersionAndroid);
          if (!ObjectUtil.isEmpty(minRequiredVersion)) {
            logger.d("获取最小支持版本-minRequiredVersion-是json格式-->$minRequiredVersion");
            //
            MinRequiredVersionModel? minRequiredVersionModel = JsonUtil.getObj(minRequiredVersion, (v) => MinRequiredVersionModel.fromJson(v as Map<String, dynamic>));
            if (!ObjectUtil.isEmpty(minRequiredVersionModel)) {
              //取出【lastForceUpdate】对象
              LastForceUpdate? lastForceUpdate = minRequiredVersionModel?.lastForceUpdate;
              if (!ObjectUtil.isEmpty(lastForceUpdate)) {
                //获取【强制更新的内部版本】：
                String? softwareVersion = lastForceUpdate?.softwareVersion;
                //获取【强制更新的内部版本的下载地址】
                String? downloadUrl = lastForceUpdate?.downloadUrl;
                //
                if (!ObjectUtil.isEmpty(softwareVersion)) {
                  //如果强制更新的内部版本小于当前安装版本，就是说：用户当前安装的版本，比强制更新的版本要大，那么用户自由更新。
                  if (int.parse(localBuildNumber) > int.parse(softwareVersion!)) {
                    //[用户安装的版本]大于[强制更新的版本]，则不弹出强制更新提示。
                    showUpdateDialogAndroidFree(systemConfigVersion);
                  }else{
                    //如果是[用户安装的版本，比强制更新的版本还要小]，那么必须强制更新：
                    showUpdateDialogAndroidLastForceUpdate(softwareVersion,downloadUrl!);
                  }
                }
              } else {
                //如果不是强制更新，弹出自由更新安装包的提示。
                showUpdateDialogAndroidFree(systemConfigVersion);
              }
            }
          } else {
            logger.d("获取最小支持版本-minRequiredVersion->空");
          }
        }
      }
    }
  }

  static _logAppRunningInfo() async {
    final deviceToken = await UmengPushManager.getDeviceToken();
    AppManager.deviceToken = deviceToken ?? "";
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    logger.i("应用名称：${packageInfo.appName}\n"
        "应用包名：${packageInfo.packageName}\n"
        "应用版本：${packageInfo.version}\n"
        "构建版本：${packageInfo.buildNumber}"
        "运行设备：${AppManager.isPhysicalDevice ? "物理机" : "模拟器"}\n"
        "设备品牌：${AppManager.brand}\n"
        "设备型号：${AppManager.deviceModel}\n"
        "设备名称：${AppManager.deviceName}\n"
        "设备UUID：${AppManager.uuid}\n"
        "deviceToken：${AppManager.deviceToken}\n"
        // "设备特性：\n${AppManager.systemFeatures.map((feature) => '- $feature').join(',\n')}"
        );
  }

  /// 比较两个版本号，例如 1.5.10 和 1.5.9
  /// 返回 1 表示 version1 > version2 即商店版本大于本地版本
  /// 返回 -1 表示 version1 < version2 即商店版本小于本地版本
  /// 返回 0 表示相等
  static int _compareVersions(String version1, String version2) {
    List<String> v1Parts = version1.split('.');
    List<String> v2Parts = version2.split('.');

    int maxLength = v1Parts.length > v2Parts.length ? v1Parts.length : v2Parts.length;

    for (int i = 0; i < maxLength; i++) {
      int v1 = i < v1Parts.length ? int.parse(v1Parts[i]) : 0;
      int v2 = i < v2Parts.length ? int.parse(v2Parts[i]) : 0;

      if (v1 > v2) return 1; // version1 > version2
      if (v1 < v2) return -1; // version1 < version2
    }
    return 0; // version1 == version2
  }

  /// 弹出更新的提示框
  static void showUpdateDialog(AppVersionInfo version, bool isRequired) {
    if (AppManager.isShowUpload != true) {
      AppManager.isShowUpload = true;
      showAlertDialog(
        title: "检测到新版本",
        message: "是否升级到${version.version}版本？",
        titleImage: null,
        margin: const EdgeInsets.only(left: 30, right: 30).w,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: version.releaseNotes,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black, height: 1.2.h),
                ),
              ]),
            ),
          ],
        ),
        confirmText: "立即更新",
        cancelText: "以后再说",
        // buttonVertical: true,
        confirm: () async {
          dismissAlertDialog();
          AppManager.isShowUpload = false;
          if (Platform.isIOS) openIOSAppStore();
        },
        cancel: () {
          dismissAlertDialog();
          AppManager.isShowUpload = false;
          if (isRequired) {
            // 如果需要强制更新，则弹出强制更新提示框
            showAlertDialog(
              title: "需要更新",
              message: "当前版本不再支持，请更新到最新版本以继续使用！",
              confirmText: "立即更新",
              cancelText: "取消",
              confirm: () async {
                dismissAlertDialog();
                AppManager.isShowUpload = false;
                if (Platform.isIOS) openIOSAppStore();
              },
              cancel: () {
                dismissAlertDialog();
                showUpdateDialog(version, isRequired);
              },
            );
          }
        },
      );
    }
  }

  // 弹出更新的提示框:自由更新，不是强制更新：自由更新的下载链接就是获取 systemConfig的
  static void showUpdateDialogAndroidFree(AppVersionInfo version) {
    if (AppManager.isShowUpload != true) {
      AppManager.isShowUpload = true;
      showAlertDialogThreeButton(
        title: "检测到新版本",
        message: "是否升级到${version.version}版本？",
        //不用隐藏【取消按钮】
        isHiddenCancelButton: false,
        margin: const EdgeInsets.only(left: 20, right: 20),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: version.releaseNotes,
                    style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
                  ),
                ]),
              ),
            ),
          ],
        ),
        confirmText: market_server_down,
        middleText: owner_server_down,
        cancelText: "以后再说",
        buttonVertical: true,
        confirm: () async {
          dismissAlertDialog();
          AppManager.isShowUpload = false;
          if (Platform.isAndroid) AppVersionManager.openAndroidMarket();
        },
        middle: () {
          dismissAlertDialog();
          AppManager.isShowUpload = false;
          logger.d("version.downloadUrl=>${version.downloadUrl}");
          CommonTools.methodDownLoadApkByDio(version.downloadUrl, Get.context!);
        },
        cancel: () {
          dismissAlertDialog();
          AppManager.isShowUpload = false;
        },
      );
    }
  }

  //弹出更新的提示框:自由更新，不是强制更新
  static void showUpdateDialogAndroidLastForceUpdate(String apkForceUpdateVersion,String apkForceUpdateUrl) {
    //
    if (AppManager.isShowUpload != true) {
      //
      AppManager.isShowUpload = true;
      //
      showAlertDialogThreeButton(
        title: "当前应用小于最低支持版本",
        //强制更新的最低版本
        message: "请升级到$apkForceUpdateVersion版本",
        //true（点击遮罩后，将关闭dialog），false（不关闭）
        //需要隐藏【取消】按钮
        isHiddenCancelButton: true,
        hiddenButton: false,
        margin: const EdgeInsets.only(left: 20, right: 20),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    //这里暂时是没有的
                    //text: version.releaseNotes,
                    text: "",
                    style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
                  ),
                ]),
              ),
            ),
          ],
        ),
        //应用市场更新
        confirmText: market_server_down,
        //服务器下载
        middleText: owner_server_down,
        //cancelText: "以后再说",
        //是垂直布局
        buttonVertical: true,
        confirm: () async {
          //打开应用市场去更新。
          dismissAlertDialog();
          AppManager.isShowUpload = false;
          if (Platform.isAndroid) AppVersionManager.openAndroidMarket();
        },
        middle: () {
          //从我们服务器去下载
          dismissAlertDialog();
          AppManager.isShowUpload = false;
          logger.d("强制更新：从我们服务器去升级下载新版本=>$apkForceUpdateUrl");
          //下载的就是当前的版本：
          CommonTools.methodDownLoadApkByDio(apkForceUpdateUrl, Get.context!);
          //
        },
        //没有取消按钮的逻辑。
        // cancel: () {
        //   dismissAlertDialog();
        //   AppManager.isShowUpload = false;
        // },
      );
    }
  }

}
