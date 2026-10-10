import 'dart:convert';
import 'dart:developer';

import 'package:auto_shop_server/app/modules/home/models/shop_model.dart';
import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/utils/file_utils.dart';
import 'package:auto_shop_server/app/modules/launching/loacal_storage.dart';
import 'package:auto_shop_server/app/modules/launching/model/launch_advert_model.dart';
import 'package:auto_shop_server/app/modules/login/controller/login_account_controller.dart';
import 'package:auto_shop_server/app/modules/login/model/user_account.dart';
import 'package:auto_shop_server/app/modules/login/page/login_account_page.dart';
import 'package:broadcast_events/broadcast_events.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class AppManager {
  // 单例
  // AppManager._share();
  // static final AppManager _instance = AppManager._share();
  // static AppManager get instance { return _instance;}
  static String uuid = "";
  static String userToken = "";
  static String brand = ""; // 手机品牌
  static String deviceModel = ""; // 设备型号, 例如: iPhone、iPad
  static String deviceName = ""; // 设备型号, 例如: iPhone 15 Pro
  static String osNumber = ""; // app buildNumber
  static String deviceToken = ""; // 设备token
  static List<String> systemFeatures = []; // 表示设备支持的硬件或系统特性。例如，是否支持平板、NFC、蓝牙等功能。
  static String appName = ""; //
  static String version = ""; // app version
  static String buildNumber = ""; // app buildNumber
  static int osSdkIntForAndroid = 0; // 使用的androidSDK版本：例如：31,33,34
  static String osReleaseVersionForAndroid = ""; // 手机端给用户展示的android系统的版本：例如：android10，android11，android13
  static bool isPhysicalDevice = false; // 是否是真机(物理设备)
  static bool _isFirstInstall = true; // 默认第一次安装
  //static String shopName = ""; // 当前的服务站名称
  //static String shopInfoId = ""; // 当前的服务站ID
  //static bool auth = false; // 生物认证状态，在 App 重启后会失效
  static String? lastAccount; // 上次登录账号,退出登录后userData删除,但该值依旧存在
  static UserAccount? _userAccount; // 当前登录账号
  static ShopModel? currentShop; // 当前企业店铺
  static ActiveAdvertModel? activeAdvert;
  static ImageProvider? launchImage;
  static PopupAdvertModel? popAdvert;
  static WebViewEnvironment? webViewEnvironment;

  static bool isShowUpload = false; // 记录更新提示的弹出框，避免重复叠加弹框。

  // 首次安装返回true （同意隐私协议后，则返回false，默认为true）
  static bool get isFirstInstall {
    _isFirstInstall = localStorageRead("isFirstInstall") ?? true;
    return _isFirstInstall;
  }

  static set isFirstInstall(bool value) {
    _isFirstInstall = value;
    localStorageWrite("isFirstInstall", value);
  }

  // 获取上次登录的用户信息
  // static getUserData() {
  //   UserAccount? user = AppManager.getUserAccountModel();
  //   AppManager.userAccount = user;
  //
  //
  //   // 获取上次选中的店铺
  //   ShopModel? shop = AppManager.getShopModel();
  //   AppManager.currentShop = shop;
  //
  //   // 获取上次登录的账号
  //   AppManager.lastAccount = localStorageRead("lastAccount");
  //
  //   log(("getUserData() 执行完毕!");
  //   log(("上次登录的用户 = ${AppManager.lastAccount}");
  //   log(("AppManager.userAccount = ${AppManager.userAccount}");
  //   log(("AppManager.currentShop = ${AppManager.currentShop}");
  // }

  // static setUserAccountJson(Map<String, dynamic> user) {
  //   AppManager.userAccount = UserAccount.fromJson(user);
  //   AppManager.lastAccount = AppManager.userAccount!.loginName!;
  //   localStorageWrite(kUserAccountUpdate, jsonEncode(user));
  //   localStorageWrite("lastAccount", AppManager.userAccount?.loginName!);
  // }
  // static Future<Map<String, dynamic>> getUserAccountJson() async {
  //   var string = await localStorageRead(kUserAccountUpdate);
  //   return jsonDecode(string!);
  // }
  // static UserAccount? getUserAccountModel() {
  //   var string = localStorageRead(kUserAccountUpdate);
  //   if (string != null) {
  //     return UserAccount.fromJson(jsonDecode(string!));
  //   }
  //   return null;
  // }

  static clearUserAccount() async {
    await localStorageRemove(kUserAccountUpdate);
  }

  static UserAccount? get userAccount {
    final account = localStorageRead(kUserAccountUpdate);
    if (account is UserAccount) _userAccount = account;
    if (account != null && account is String) {
      _userAccount = UserAccount.fromJson(jsonDecode(account));
    }
    // logger.i("读取用户: $account");
    // 获取上次选中的店铺
    ShopModel? shop = AppManager.getShopModel();
    AppManager.currentShop = shop;
    return _userAccount;
  }

  static set userAccount(UserAccount? account) {
    try {
      _userAccount = account;
      lastAccount = _userAccount?.loginName;
      if (account != null) {
        localStorageWrite(kUserAccountUpdate, jsonEncode(account));
        localStorageWrite("lastAccount", _userAccount?.loginName);
      } else {
        localStorageRemove(kUserAccountUpdate);
        localStorageRemove("lastAccount");
      }
    } catch (e) {
      log("添加用户错误: $e");
    }
  }

  //2024-10-1获取该账号是否有动态按钮
  static bool? get hasButtonList {
    if (_userAccount != null) {
      if (!ObjectUtil.isEmptyList(_userAccount?.appFunctionList)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // 注册通知
  static registerBroadcast(String name, Function(dynamic value) result) {
    BroadcastEvents().subscribe(name, result);
  }

  // 删除通知
  static deleteBroadcast(String name) {
    BroadcastEvents().unsubscribe(name);
  }

  // 发送通知
  static sendBroadcast(String name, {dynamic value}) {
    BroadcastEvents().publish(name, arguments: value);
  }

  // // 获取上次登录的用户信息
  // static getUserData() {
  //   UserAccount? user = AppManager.getUserAccountModel();
  //   AppManager.userAccount = user;
  //
  //
  //   // 获取上次选中的店铺
  //   ShopModel? shop = AppManager.getShopModel();
  //   AppManager.currentShop = shop;
  //
  //   // 获取上次登录的账号
  //   AppManager.lastAccount = localStorageRead("lastAccount");
  //
  //   log(("getUserData() 执行完毕!");
  //   log(("上次登录的用户 = ${AppManager.lastAccount}");
  //   log(("AppManager.userAccount = ${AppManager.userAccount}");
  //   log(("AppManager.currentShop = ${AppManager.currentShop}");
  // }

  static getAuthState() {
    final auth = localStorageRead("native_auth") ?? false;
    // log("getAuthState() 执行完毕！ 认证状态：$auth");
    return auth;
  }

  static getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      if (box.hasData(kAndroidUUID)) {
        AppManager.uuid = localStorageRead(kAndroidUUID);
        //log.logMy("uuid从本地读取的->${localStorageRead(kAndroidUUID).toString()}");
      } else {
        var uuidPackage = const Uuid();
        AppManager.uuid = uuidPackage.v1();
        localStorageWrite(kAndroidUUID, uuidPackage.v1());
      }

      //log.logMy("uuidV1->${AppManager.uuid.toString()}");
      //log.logMy("localStorage-kAndroidUUID->${localStorageRead(kAndroidUUID).toString()}");

      final info = await deviceInfoPlugin.androidInfo;
      //AppManager.uuid = info.id;
      AppManager.brand = info.brand;
      AppManager.deviceModel = info.model;
      AppManager.systemFeatures = info.systemFeatures;
      AppManager.isPhysicalDevice = info.isPhysicalDevice;
      osSdkIntForAndroid = info.version.sdkInt;
      osReleaseVersionForAndroid = '$appVersionInfoPlatform${info.version.release}';
      //String fingerprint = info.fingerprint;
      //log.logMy("androidInfo->${fingerprint.toString()}");
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      AppManager.brand = "Apple";
      AppManager.deviceModel = iosInfo.model.toString();
      AppManager.deviceName = getIphoneModel(iosInfo.utsname.machine);
      AppManager.uuid = iosInfo.identifierForVendor!;
      AppManager.isPhysicalDevice = iosInfo.isPhysicalDevice;
    }
  }

  // 退出登录
  static signOut() {
    AppManager.userAccount = null;
    AppManager.currentShop = null;
    AppManager.clearUserAccount();
    AppManager.clearShopModel();
    Get.offAll(() => const LoginAccountPage(), bindings: [LoginAccountBinding()], transition: Transition.noTransition);
  }

  static Future<void> requestPermission(FileSystemEntity file) async {
    // PermissionStatus status = await Permission.storage.status;
    await delDir(file);
  }

  static Future<void> delDir(FileSystemEntity file) async {
    if (file is Directory && file.existsSync()) {
      log(file.path);
      final List<FileSystemEntity> children = file.listSync(recursive: true, followLinks: true);
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    try {
      if (file.existsSync()) {
        await file.delete(recursive: true);
      }
    } catch (err) {
      // log((err);
    }
  }

  //循环获取缓存大小
  static Future<double> getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    //  File
    if (file is File && file.existsSync()) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory && file.existsSync()) {
      List children = file.listSync();
      double total = 0;
      if (children.isNotEmpty)
        // ignore: curly_braces_in_flow_control_structures
        for (final FileSystemEntity child in children) {
          total += await getTotalSizeOfFilesInDir(child);
        }
      return total;
    }
    return 0;
  }

  /// 获取缓存
  static Future<String> findCacheSumSize() async {
    final tempDir = await getTemporaryDirectory();
    double cache = await AppManager.getTotalSizeOfFilesInDir(tempDir);
    return formatSize(cache);
  }

  /// 获取缓存包括android的下载路径和下载apk完成的路径
  static Future<String> findCacheSumSizeForAndroid() async {
    //下载中路径
    String? downLoadDir = await FileUtilsMy.getDownLoadDirPath();
    //下载完成路径
    String? downLoadComplete = await FileUtilsMy.getCompleteDirPath();
    //获取下载目录的文件大小
    double dirDownloadSize = 0.0;
    if (!ObjectUtil.isEmptyString(downLoadDir)) {
      Directory dirDownload = Directory(downLoadDir);
      dirDownloadSize = await getTotalSizeOfFilesInDir(dirDownload);
    }

    double dirDownloadCompleteSize = 0.0;
    if (!ObjectUtil.isEmptyString(downLoadComplete)) {
      Directory dirDownloadComplete = Directory(downLoadComplete);
      dirDownloadCompleteSize = await getTotalSizeOfFilesInDir(dirDownloadComplete);
    }

    double totalSize = dirDownloadSize + dirDownloadCompleteSize;
    return formatSize(totalSize);
  }

  /// 删除缓存
  static Future clearApplicationCache() async {
    showLoadingMessage("清除中...");

    if (Platform.isIOS) {
      final tempDir = await getTemporaryDirectory();
      await AppManager.requestPermission(tempDir);
    } else if (Platform.isAndroid) {
      String? downLoadDir = await FileUtilsMy.getDownLoadDirPath();
      String? completeDir = await FileUtilsMy.getCompleteDirPath();

      try {
        if (!ObjectUtil.isEmptyString(downLoadDir)) {
          List<FileSystemEntity> entitiesDownLoad = await FileUtilsMy.listFolder(downLoadDir);
          if (!ObjectUtil.isEmptyList(entitiesDownLoad)) {
            for (var o in entitiesDownLoad) {
              await o.delete();
            }
          }
        }
      } on Exception catch (e) {
        if (!ObjectUtil.isEmpty(e)) {
          logger.d(" catch Exception =>${e.toString()}");
        }
      }

      try {
        if (!ObjectUtil.isEmptyString(completeDir)) {
          List<FileSystemEntity> entitiesComplete = await FileUtilsMy.listFolder(completeDir);
          if (!ObjectUtil.isEmptyList(entitiesComplete)) {
            for (var e in entitiesComplete) {
              await e.delete();
            }
          }
        }
      } on Exception catch (e) {
        if (!ObjectUtil.isEmpty(e)) {
          logger.d(" catch Exception =>${e.toString()}");
        }
      }
    }

    dismissLoading();
    showMessage("清除成功");
  }

  /// 缓存大小格式转换
  static String formatSize(double value) {
    // ignore: unnecessary_null_comparison
    if (value == null) {
      return '0';
    }
    List<String> unitArr = ['B', 'K', 'M', 'G'];
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  static setShopModel(ShopModel shop) {
    AppManager.currentShop = shop;
    final sid = AppManager.currentShop?.shopInfoId;
    Map<String, dynamic> baseParam = {"shopInfoId": sid, "shopId": sid};
    httpManager.setBaseParam(baseParam);
    // log("httpManager.baseParam = $baseParam");
    localStorageWrite(kStoreChange, jsonEncode(shop.toJson()));
  }

  static ShopModel? getShopModel() {
    var string = localStorageRead(kStoreChange);
    if (string != null) {
      final shopData = ShopModel.fromJson(jsonDecode(string!));
      // logger.i("读取当前店铺: $shopData");
      return shopData;
    }
    if(!Platform.isAndroid) {
      logger.w("读取当前店铺: null", stackTrace: null);
    }
    return null;
  }

  static clearShopModel() async {
    await localStorageRemove(kStoreChange);
    if(!Platform.isAndroid) {
      logger.w("已删除当前店铺", stackTrace: null);
    }
  }
}

/// 获取iPhone设备型号
String getIphoneModel(String machine) {
  return _iOSModels[machine] ?? machine;
}

const _iOSModels = {
  "i386": "Simulator",
  "x86_64": "Simulator",
  "arm64": "Simulator",
  "iPhone1,1": "iPhone 2G",
  "iPhone1,2": "iPhone 3G",
  "iPhone2,1": "iPhone 3GS",
  "iPhone3,1": "iPhone 4",
  "iPhone3,2": "iPhone 4",
  "iPhone3,3": "iPhone 4",
  "iPhone4,1": "iPhone 4S",
  "iPhone5,1": "iPhone 5",
  "iPhone5,2": "iPhone 5",
  "iPhone5,3": "iPhone 5C",
  "iPhone5,4": "iPhone 5C",
  "iPhone6,1": "iPhone 5S",
  "iPhone6,2": "iPhone 5S",
  "iPhone7,2": "iPhone 6",
  "iPhone7,1": "iPhone 6 Plus",
  "iPhone8,1": "iPhone 6S",
  "iPhone8,2": "iPhone 6S Plus",
  "iPhone8,4": "iPhone SE (1st generation)",
  "iPhone9,1": "iPhone 7",
  "iPhone9,3": "iPhone 7",
  "iPhone9,2": "iPhone 7 Plus",
  "iPhone9,4": "iPhone 7 Plus",
  "iPhone10,1": "iPhone 8",
  "iPhone10,4": "iPhone 8",
  "iPhone10,2": "iPhone 8 Plus",
  "iPhone10,5": "iPhone 8 Plus",
  "iPhone10,3": "iPhone X",
  "iPhone10,6": "iPhone X",
  "iPhone11,8": "iPhone XR",
  "iPhone11,2": "iPhone XS",
  "iPhone11,6": "iPhone XS Max",
  "iPhone11,4": "iPhone XS Max",
  "iPhone12,1": "iPhone 11",
  "iPhone12,3": "iPhone 11 Pro",
  "iPhone12,5": "iPhone 11 Pro Max",
  "iPhone12,8": "iPhone SE (2nd generation)",
  "iPhone13,1": "iPhone 12 mini",
  "iPhone13,2": "iPhone 12",
  "iPhone13,3": "iPhone 12 Pro",
  "iPhone13,4": "iPhone 12 Pro Max",
  "iPhone14,4": "iPhone 13 mini",
  "iPhone14,5": "iPhone 13",
  "iPhone14,2": "iPhone 13 Pro",
  "iPhone14,3": "iPhone 13 Pro Max",
  "iPhone14,6": "iPhone SE (3rd generation)",
  "iPhone14,7": "iPhone 14",
  "iPhone14,8": "iPhone 14 Plus",
  "iPhone15,2": "iPhone 14 Pro",
  "iPhone15,3": "iPhone 14 Pro Max",
  "iPhone15,4": "iPhone 15",
  "iPhone15,5": "iPhone 15 Plus",
  "iPhone16,1": "iPhone 15 Pro",
  "iPhone16,2": "iPhone 15 Pro Max",
  "iPad1,1": "iPad 1",
  "iPad2,1": "iPad 2",
  "iPad2,2": "iPad 2",
  "iPad2,3": "iPad 2",
  "iPad2,4": "iPad 2",
  "iPad3,1": "iPad 3",
  "iPad3,2": "iPad 3",
  "iPad3,3": "iPad 3",
  "iPad3,4": "iPad 4",
  "iPad3,5": "iPad 4",
  "iPad3,6": "iPad 4",
  "iPad4,1": "iPad Air",
  "iPad4,2": "iPad Air",
  "iPad4,3": "iPad Air",
  "iPad5,3": "iPad Air 2",
  "iPad5,4": "iPad Air 2",
  "iPad6,7": "iPad Pro 12.9-inch",
  "iPad6,8": "iPad Pro 12.9-inch",
  "iPad6,3": "iPad Pro 9.7-inch",
  "iPad6,4": "iPad Pro 9.7-inch",
  "iPad6,11": "iPad 5th generation",
  "iPad6,12": "iPad 5th generation",
  "iPad7,1": "iPad Pro 12.9-inch 2nd generation",
  "iPad7,2": "iPad Pro 12.9-inch 2nd generation",
  "iPad7,3": "iPad Pro 10.5-inch",
  "iPad7,4": "iPad Pro 10.5-inch",
  "iPad7,5": "iPad 6th generation",
  "iPad7,6": "iPad 6th generation",
  "iPad7,11": "iPad 7th generation",
  "iPad7,12": "iPad 7th generation",
  "iPad8,1": "iPad Pro 11-inch",
  "iPad8,2": "iPad Pro 11-inch",
  "iPad8,3": "iPad Pro 11-inch",
  "iPad8,4": "iPad Pro 11-inch",
  "iPad8,5": "iPad Pro 12.9-inch 3rd generation",
  "iPad8,6": "iPad Pro 12.9-inch 3rd generation",
  "iPad8,7": "iPad Pro 12.9-inch 3rd generation",
  "iPad8,8": "iPad Pro 12.9-inch 3rd generation",
  "iPad11,1": "iPad mini 5th generation",
  "iPad11,2": "iPad mini 5th generation",
  "iPad11,3": "iPad Air 3rd generation",
  "iPad11,4": "iPad Air 3rd generation",
  "iPad11,6": "iPad 8th generation",
  "iPad11,7": "iPad 8th generation",
  "iPad12,1": "iPad 9th generation",
  "iPad12,2": "iPad 9th generation",
  "iPad13,1": "iPad Air 4th generation",
  "iPad13,2": "iPad Air 4th generation",
  "iPad13,4": "iPad Pro 11-inch 3rd generation",
  "iPad13,5": "iPad Pro 11-inch 3rd generation",
  "iPad13,6": "iPad Pro 11-inch 3rd generation",
  "iPad13,7": "iPad Pro 11-inch 3rd generation",
  "iPad13,8": "iPad Pro 12.9-inch 5th generation",
  "iPad13,9": "iPad Pro 12.9-inch 5th generation",
  "iPad13,10": "iPad Pro 12.9-inch 5th generation",
  "iPad13,11": "iPad Pro 12.9-inch 5th generation",
  "iPad14,1": "iPad mini 6th generation",
  "iPad14,2": "iPad mini 6th generation",
  "iPad14,3": "iPad Pro 11-inch 4th generation",
  "iPad14,4": "iPad Pro 11-inch 4th generation",
  "iPad14,5": "iPad Pro 12.9-inch 6th generation",
  "iPad14,6": "iPad Pro 12.9-inch 6th generation",
};
