import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// 显示顶部提示信息
void showSuccess(BuildContext context, String message) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(message: message),
    displayDuration: const Duration(seconds: 2),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
} 

void showInfo(BuildContext context, String message) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.info(message: message),
    displayDuration: const Duration(seconds: 2),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
}


void showError(BuildContext context, String message) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(message: message),
    displayDuration: const Duration(seconds: 2),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );
}
