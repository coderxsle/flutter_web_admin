import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_web_admin_client/flutter_web_admin_client.dart';
import 'package:flutter_web_admin/router/app_router.dart';

import 'loacal_storage.dart';
import 'logger.dart';
import 'strings.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class AppManager {


  static bool isLaunching = false;
  static String uuid = "";
  static String brand = ""; // 手机品牌
  static String deviceModel = ""; // 设备型号, 例如: iPhone、iPad
  static String deviceName = ""; // 设备型号, 例如: iPhone 15 Pro
  static String deviceToken = ""; // 设备token
  static List<String> systemFeatures = []; // 表示设备支持的硬件或系统特性。例如，是否支持平板、NFC、蓝牙等功能。
  static String appName = ""; //
  static String version = ""; // app version
  static String buildNumber = ""; // app buildNumber
  static String osNumber = ""; // app buildNumber
  static int osSdkIntForAndroid = 0; // 使用的androidSDK版本：例如：31,33,34
  static String osReleaseVersionForAndroid = ""; // 手机端给用户展示的android系统的版本：例如：android10，android11，android13
  static bool isPhysicalDevice = false; // 是否是真机(物理设备)
  static bool _isFirstInstall = true; // 默认第一次安装
  //static String shopName = ""; // 当前的服务站名称
  //static String shopInfoId = ""; // 当前的服务站ID
  //static bool auth = false; // 生物认证状态，在 App 重启后会失效
  static String? userToken;
  static String? lastAccount; // 上次登录账号,退出登录后userData删除,但该值依旧存在
  static LoginResponse? _userInfo; // 当前登录账号
  // static ShopModel? currentShop; // 当前企业店铺
  // static ActiveAdvertModel? activeAdvert;
  // static ImageProvider? launchImage;
  // static PopupAdvertModel? popAdvert;
  // static WebViewEnvironment? webViewEnvironment;

  static bool isShowUpload = false; // 记录更新提示的弹出框，避免重复叠加弹框。

  // 首次安装返回true （同意隐私协议后，则返回false，默认为true）
  static bool get isFirstInstall {
    _isFirstInstall = localStorageRead(isInstalled) ?? true;
    return _isFirstInstall;
  }

  static set isFirstInstall(bool value) {
    _isFirstInstall = value;
    localStorageWrite(isInstalled, value);
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

  static Future<void> clearUserAccount() async {
    await localStorageRemove(kUserAccountUpdate);
  }

  static LoginResponse? get userInfo {
    final account = localStorageRead(kUserAccountUpdate);
    if (account is LoginResponse) _userInfo = account;
    if (account != null && account is String) {
      _userInfo = LoginResponse.fromJson(jsonDecode(account));
    }
    // logger.i("读取用户: $account");
    // 获取上次选中的店铺
    // ShopModel? shop = AppManager.getShopModel();
    // AppManager.currentShop = shop;
    return _userInfo;
  }

  static set userInfo(LoginResponse? userInfo) {
    try {
      _userInfo = userInfo;
      lastAccount = _userInfo?.username;
      if (userInfo != null) {
        localStorageWrite(kUserAccountUpdate, jsonEncode(userInfo));
        localStorageWrite('lastAccount', _userInfo?.username);
      } else {
        localStorageRemove(kUserAccountUpdate);
        localStorageRemove('lastAccount');
      }
    } catch (e) {
      log('添加用户错误: $e');
    }
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

  static Future<void> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      if (localStorageRead(kAndroidUUID) != null) {
        AppManager.uuid = localStorageRead(kAndroidUUID);
        //log.logMy("uuid从本地读取的->${localStorageRead(kAndroidUUID).toString()}");
      } else {
        final uuidPackage = const Uuid();
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
      AppManager.brand = 'Apple';
      AppManager.deviceModel = iosInfo.model.toString();
      // AppManager.deviceName = getIphoneModel(iosInfo.utsname.machine);
      AppManager.uuid = iosInfo.identifierForVendor!;
      AppManager.isPhysicalDevice = iosInfo.isPhysicalDevice;
    }
  }

  // 设置登录
  static void login(LoginResponse userInfo, {String? password}) {
    // 保存登录状态
    userInfo.token = AppManager.userToken!;
    AppManager.userInfo = userInfo;
    // 登录成功，需要切换数据库空间
    // DBManager.switchBaseSpace();
  }


  // 退出登录
  static void signOut() {
    AppManager.userInfo = null;
    // AppManager.currentShop = null;
    AppManager.clearShopModel();
    AppManager.clearUserAccount();
        
    // 导航到登录页面（基于路由名）
    AppRouter.router.goNamed(AppRoutes.login.name);
    logger.i('用户已登出');
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

  /// 删除缓存
  static Future clearApplicationCache() async {
    // showLoadingMessage("清除中...");

    // if (Platform.isIOS) {
    //   final tempDir = await getTemporaryDirectory();
    //   await AppManager.requestPermission(tempDir);
    // } else if (Platform.isAndroid) {
    //   String? downLoadDir = await FileUtilsMy.getDownLoadDirPath();
    //   String? completeDir = await FileUtilsMy.getCompleteDirPath();

    //   try {
    //     if (!ObjectUtil.isEmptyString(downLoadDir)) {
    //       List<FileSystemEntity> entitiesDownLoad = await FileUtilsMy.listFolder(downLoadDir);
    //       if (!ObjectUtil.isEmptyList(entitiesDownLoad)) {
    //         for (var o in entitiesDownLoad) {
    //           await o.delete();
    //         }
    //       }
    //     }
    //   } on Exception catch (e) {
    //     if (!ObjectUtil.isEmpty(e)) {
    //       logger.d(" catch Exception =>${e.toString()}");
    //     }
    //   }

    //   try {
    //     if (!ObjectUtil.isEmptyString(completeDir)) {
    //       List<FileSystemEntity> entitiesComplete = await FileUtilsMy.listFolder(completeDir);
    //       if (!ObjectUtil.isEmptyList(entitiesComplete)) {
    //         for (var e in entitiesComplete) {
    //           await e.delete();
    //         }
    //       }
    //     }
    //   } on Exception catch (e) {
    //     if (!ObjectUtil.isEmpty(e)) {
    //       logger.d(" catch Exception =>${e.toString()}");
    //     }
    //   }
    // }

    // dismissLoading();
    // showMessage("清除成功");
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

  // static setShopModel(ShopModel shop) {
  //   AppManager.currentShop = shop;
  //   final sid = AppManager.currentShop?.shopInfoId;
  //   Map<String, dynamic> baseParam = {"shopInfoId": sid, "shopId": sid};
  //   HttpManager.setBaseParam(baseParam);
  //   // log("HttpManager.baseParam = $baseParam");
  //   localStorageWrite(kStoreChange, jsonEncode(shop.toJson()));
  // }

  // static ShopModel? getShopModel() {
  //   var string = localStorageRead(kStoreChange);
  //   if (string != null) {
  //     final shopData = ShopModel.fromJson(jsonDecode(string!));
  //     // logger.i("读取当前店铺: $shopData");
  //     return shopData;
  //   }
  //   logger.w("读取当前店铺: null", stackTrace: null);
  //   return null;
  // }

  static clearShopModel() async {
    await localStorageRemove(kStoreChange);
    logger.w("已删除当前店铺", stackTrace: null);
  }
}