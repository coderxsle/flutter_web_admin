import 'package:flutter/material.dart';
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
void showSuccess(BuildContext context, String message) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(message: message),
    displayDuration: _getDisplayDuration(message),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
} 

void showInfo(BuildContext context, String message) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.info(message: message),
    displayDuration: _getDisplayDuration(message),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
}

void showError(BuildContext context, String message) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(message: message),
    displayDuration: _getDisplayDuration(message),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
}
