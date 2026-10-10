import 'dart:ui';

import 'package:auto_shop_server/common/index.dart';

// class DeviceUtils {
//   /// 判断是否为 Pad（支持 iOS 和 Android）
//   static bool isPad() {
//     // 获取屏幕的逻辑像素宽高
//     final size = window.physicalSize / window.devicePixelRatio;
//     final logicalWidth = size.width;
//
//     // iOS 判断：通过系统 API 确定是否为 iPad
//     if (Platform.isIOS) {
//       return _isIOSPad();
//     }
//
//     // Android 判断：逻辑宽度大于一定值判断为 Pad
//     if (Platform.isAndroid) {
//       return logicalWidth >= 600; // 可根据实际设备调整阈值
//     }
//
//     return false; // 非 iOS/Android 默认返回 false
//   }
//
//   /// 判断是否为 Phone
//   static bool isPhone() {
//     return !isPad();
//   }
//
//   /// 私有方法：专门判断 iOS 是否为 iPad
//   static bool _isIOSPad() {
//     return Platform.isIOS && (WidgetsBinding.instance.window.platformDispatcher.iosIsPad ?? false);
//   }
// }

// class DeviceUtils {
//   /// 判断当前设备是否为 Pad（支持 iOS 和 Android）
//   static bool isPad(BuildContext context) {
//     // 获取设备的物理尺寸
//     final size = MediaQuery.of(context).size;
//     // 获取设备像素密度
//     final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
//     // 计算逻辑屏幕尺寸
//     final logicalWidth = size.width * devicePixelRatio;
//
//     // iOS 判断：iPad 特定平台判断（Platform.isIOS && 条件）
//     if (Platform.isIOS) {
//       // iOS 下通过 `UIUserInterfaceIdiom` 确定设备类型
//       return _isIOSPad();
//     }
//
//     // Android 判断：以屏幕宽度、设备密度等逻辑判断
//     if (Platform.isAndroid) {
//       return logicalWidth >= 900; // 判断标准根据设备屏幕大小设置
//     }
//
//     return false; // 默认返回 false，非 iOS/Android 设备按 Phone 处理
//   }
//
//   /// 判断当前设备是否为 Phone
//   static bool isPhone(BuildContext context) {
//     return !isPad(context);
//   }
//
//   /// 私有方法：针对 iOS 判断是否为 iPad
//   static bool _isIOSPad() {
//     // 判断使用 'dart:io' + platform-specific APIs（iOS 限定）
//     return Platform.isIOS && (WidgetsBinding.instance.window.platformDispatcher.iosIsPad ?? false);
//   }
// }

class DeviceUtils {
  /// 判断是否为 Pad（支持 iOS 和 Android）
  static final bool isPad = _determineIfPad();

  /// 判断是否为 Phone
  static final bool isPhone = !isPad;

  /// 设备类型判定逻辑
  static bool _determineIfPad() {
    final view = PlatformDispatcher.instance.views.first;

    // iOS 平台判断
    if (Platform.isIOS) {
      return _isIOSDevicePad(view);
    }

    // Android 平台判断
    if (Platform.isAndroid) {
      return _isAndroidDevicePad(view);
    }

    return false;
  }

  /// iOS 平台：通过逻辑尺寸和设备类型判断
  static _isIOSDevicePad(FlutterView view) {

    return AppManager.deviceModel.contains("iPad");
    // 增加对 iPad 类型的判断
    // final size = view.physicalSize / view.devicePixelRatio;
    // return size.shortestSide >= 768 && WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio < 3;
    // return size.shortestSide >= 820 && WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio < 3;
  }

  /// Android 平台：通过逻辑宽度判断
  static _isAndroidDevicePad(FlutterView view) {
    final isTablet = AppManager.systemFeatures.contains("android.hardware.type.tablet");
    final size = view.physicalSize / view.devicePixelRatio;
    return isTablet && size.shortestSide >= 600;
  }
}