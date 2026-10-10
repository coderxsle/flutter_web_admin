// // class PermissionManager {
// //   static const String camera = "camera";
// //   static const String storage = "storage";
// //   static const String location = "location";
// //   static const String phone = "phone";
// //   static const String sms = "sms";
// //   static const String contacts = "contacts";
// //   static const String notification = "notification";
// //   static const String backgroundLocation = "backgroundLocation";
// //   static const String bluetooth = "bluetooth";
// //   static const String wifi = "wifi";
// //   static const String bodySensors = "bodySensors";
// //   static const String appTrackingTransparency = "appTrackingTransparency";
// //   static const String unknown = "unknown";
// //   static const String denied = "denied";
// //
// //   static const String granted = "granted";
// //   static const String restricted = "restricted";
// //
// //
// //   static Future<bool> requestPermission(String permission) async {
// //     return await PermissionManager.requestPermissions([permission]);
// //   }
// //
// //   static Future<bool> requestPermissions(List<String> permissions) async {
// //
// //   }
// //
// // }


// import 'package:flutter/material.dart';

// /// [PermissionManager] - 处理媒体库权限的工具类
// class PermissionManager {



//   /// 检查媒体库权限状态并提供相应的操作提示
//   static Future<void> checkAndHandlePhotosPermission(BuildContext context, {required Function onGranted}) async {
//     bool isGranted = await _checkPhotosPermission();

//     if (isGranted) {
//       // 权限已授权，执行相应操作
//       onGranted();
//     } else {
//       // 提示用户去设置中开启权限
//       _showPermissionDialog(context);
//     }
//   }



//   /// 检查媒体库权限是否被授予
//   /// [request] 表示是否在没有权限的情况下请求权限
//   static Future<bool> checkPhotosPermission({bool request = true}) async {
//     // 获取当前媒体库权限状态
//     final PermissionState ps = await PhotoManager.requestPermissionExtend();

//     if (ps.isAuth) {
//       // 已授权
//       return true;
//     } else if (request && ps != PermissionState.limited && ps != PermissionState.authorized) {
//       // 未授权时，请求用户授权
//       final PermissionState requestResult = await PhotoManager.requestPermissionExtend();

//       // 返回新的权限状态是否为已授权
//       return requestResult.isAuth;
//     } else {
//       // 其他状态（如受限、拒绝等）
//       return false;
//     }
//   }

//   /// 请求媒体库权限
//   static Future<bool> requestPhotosPermission() async {
//     final PermissionState result = await PhotoManager.requestPermissionExtend();
//     return result.isAuth;
//   }

//   /// 检查媒体库权限状态并提供相应的操作提示
//   static Future<void> checkAndHandlePhotosPermission(BuildContext context, {required Function onGranted}) async {
//     bool isGranted = await checkPhotosPermission();

//     if (isGranted) {
//       // 权限已授权，执行相应操作
//       onGranted();
//     } else {
//       // 提示用户去设置中开启权限
//       showPermissionDialog(context);
//     }
//   }

//   /// 显示一个提示对话框，引导用户去系统设置中开启权限
//   static void showPermissionDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('权限请求'),
//         content: const Text('请在设置中开启相册权限，以便访问您的照片。'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('取消'),
//           ),
//           TextButton(
//             onPressed: () {
//               PhotoManager.openSetting(); // 打开系统设置
//               Navigator.of(context).pop();
//             },
//             child: const Text('去设置'),
//           ),
//         ],
//       ),
//     );
//   }
// }