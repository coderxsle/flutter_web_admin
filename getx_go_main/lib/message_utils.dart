import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// 根据消息长度计算显示时间
Duration _getDisplayDuration(String message) {
  // 假设每个字符需要 0.1 秒阅读时间，最少 2 秒，最多 8 秒
  final int characters = message.characters.length;
  final int seconds = (characters * 0.1).ceil();
  return Duration(seconds: seconds.clamp(2, 8));
}

// 显示顶部提示信息
void showSuccess(String message) {
  showTopSnackBar(
    Overlay.of(Get.context!),
    CustomSnackBar.success(message: message),
    displayDuration: _getDisplayDuration(message),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
} 

void showInfo(String message) {
  showTopSnackBar(
    Overlay.of(Get.context!),
    CustomSnackBar.info(message: message),
    displayDuration: _getDisplayDuration(message),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
}

void showError(String message) {
  showTopSnackBar(
    Overlay.of(Get.context!),
    CustomSnackBar.error(message: message),
    displayDuration: _getDisplayDuration(message),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
}


// // 显示顶部提示信息 - 使用GetX的Snackbar
// void showSuccess(String message) {
//   Get.snackbar(
//     '成功', // 标题
//     message, // 消息内容
//     backgroundColor: Colors.green,
//     colorText: Colors.white,
//     icon: const Icon(Icons.check_circle, color: Colors.white),
//     snackPosition: SnackPosition.top,
//     duration: _getDisplayDuration(message),
//     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   );
// } 

// void showInfo(String message) {
//   Get.snackbar(
//     '提示', // 标题
//     message, // 消息内容
//     backgroundColor: Colors.blue,
//     colorText: Colors.white,
//     icon: const Icon(Icons.info, color: Colors.white),
//     snackPosition: SnackPosition.top,
//     duration: _getDisplayDuration(message),
//     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   );
// }

// void showError(String message) {
//   Get.snackbar(
//     '错误', // 标题
//     message, // 消息内容
//     backgroundColor: Colors.red,
//     colorText: Colors.white,
//     icon: const Icon(Icons.error, color: Colors.white),
//     snackPosition: SnackPosition.top,
//     duration: _getDisplayDuration(message),
//     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   );
// }
