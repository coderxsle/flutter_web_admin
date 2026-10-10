import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:auto_shop_server/app/utils/common_widget/my_dialog.dart';
import 'package:auto_shop_server/app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static final androidSDK = 33;

  // 检查相机权限
  static Future<bool> checkCamera() async {
    return Permission.camera.isGranted;
  }

  // 检查麦克风权限
  static Future<bool> checkMicrophone() async {
    return Permission.microphone.isGranted;
  }

  // 检查存储权限
  static Future<bool> checkStorage() async {
    return Permission.storage.isGranted;
  }

  // 请求相机权限
  static Future<void> requestCamera({String? message, required VoidCallback ok}) async {
    return _requestPermission(
      message: message ?? "需要访问您的相机权限，以便进行拍照等操作。",
      permissions: [Permission.camera],
      ok: ok,
    );
  }

  // 检查麦克风权限
  static Future<void> requestMicrophone({String? message, required VoidCallback ok}) async {
    return _requestPermission(
      message: message ?? "需要访问您的麦克风权限，以便进行语音通话等操作。",
      permissions: [Permission.microphone],
      ok: ok,
    );
  }

  // 检查存储权限
  static Future<void> requestStorage({String? message, required VoidCallback ok}) async {
    final storagePermission = AppManager.osSdkIntForAndroid < androidSDK
        ? Permission.storage
        : Permission.manageExternalStorage;
    
    return _requestPermission(
      message: message ?? "需要访问您的存储权限，以便保存文件。",
      permissions: [storagePermission],
      ok: ok,
    );
  }

  // 统一的权限检查方法
  static Future<void> _requestPermission({String? message, required List<Permission> permissions, required VoidCallback ok}) async {
    // 先检查是否已经有权限
    bool hasAllPermissions = true;
    for (var permission in permissions) {
      if (!await permission.isGranted) {
        hasAllPermissions = false;
        break;
      }
    }

    // 如果已经有所有权限，直接返回true
    if (hasAllPermissions) {
      ok();
      return;
    }

    // 请求权限
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    
    // 检查所有权限是否都已授予
    bool allGranted = true;
    for (var status in statuses.values) {
      if (!status.isGranted) {
        allGranted = false;
        break;
      }
    }

    // 如果有权限未授予，显示设置对话框
    if (!allGranted) {
      _showSettingsDialog(message ?? "", permissions, ok);
    } else {
      // 所有权限都已授予
      ok();
    }
  }

  // 显示设置对话框
  static void _showSettingsDialog(String message, List<Permission> permissions, VoidCallback onGranted) {
    showAlertDialog(
      title: "权限申请",
      message: message,
      margin: const EdgeInsets.only(left: 20, right: 20),
      confirmText: permission_setting,
      cancelText: permission_cancel,
      buttonVertical: false,
      confirm: () async {
        dismissAlertDialog();
        
        // 打开系统设置
        bool isOpened = await openAppSettings();
        if (!isOpened) {
          logger.d("无法打开系统设置页面");
          return;
        }

        // 用户从系统设置返回后，重新检查权限
        bool allGranted = true;
        for (var permission in permissions) {
          if (!await permission.isGranted) {
            allGranted = false;
            break;
          }
        }
        
        // 如果所有权限都已授予，执行回调
        if (allGranted) {
          onGranted();
        }
      },
    );
  }

}
