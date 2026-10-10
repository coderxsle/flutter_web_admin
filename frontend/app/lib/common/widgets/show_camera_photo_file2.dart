import 'dart:io';

import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/constant_api.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:common_utils/common_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../../app/utils/common_widget/logger.dart';

// enum ShowType {
// camera,
// photo,
// file
// }

class ShowCameraPhotoFile {
  // 仅支持拍照
  static Future camera(BuildContext context, {required ValueChanged complete}) {
    final camera = _cameraAction(context, complete);
    return _showActions(context, actions: [camera]);
  }

  // 仅支持相册选择
  static Future photo(BuildContext context, {num? max, required ValueChanged complete}) {
    final picker = _pickerAction(context, max, complete);
    return _showActions(context, actions: [picker]);
  }

  // 仅支持选择文件 （iOS：文件管理器，选择 word、pdf 等）
  static Future file(BuildContext context, {required ValueChanged complete}) {
    final file = _fileAction(context, complete);
    return _showActions(context, actions: [file]);
  }

  // 支持拍照、或者相册
  static Future cameraPhoto(BuildContext context, {num? max, required ValueChanged complete}) {
    final camera = _cameraAction(context, complete);
    final picker = _pickerAction(context, max, complete);
    return _showActions(context, actions: [camera, picker]);
  }

  // 支持拍照、相册、文件选择
  static Future all(BuildContext context, {num? max, required ValueChanged complete}) {
    final camera = _cameraAction(context, complete);
    final picker = _pickerAction(context, max, complete);
    final file = _fileAction(context, complete);
    return _showActions(context, actions: [camera, picker, file]);
  }


  // 显示底部的选项菜单，可根据参数决定显示哪些按钮
  static Future<void> _showActions(BuildContext context, {required List<Widget> actions}) async {
    return showCupertinoModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        transitionBackgroundColor: Colors.white,
        shadow: const BoxShadow(color: Colors.transparent),
        builder: (context) => Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: CupertinoActionSheet(
            // title: const Text('选择照片'),
            // message: const Text('选择照片来源'),
            messageScrollController: ScrollController(),
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
          ),
        )
    );
  }


  static Widget _cameraAction(context, ValueChanged complete) {
    return CupertinoActionSheetAction(
        child: const Text("拍照"),
        onPressed: () {
          Navigator.of(context).pop();
          _checkCameraPermission(ok: () {
            _cameraPicker(context, complete: complete);
          });
        });
  }

  static Widget _pickerAction(context, max, ValueChanged complete) {
    return CupertinoActionSheetAction(
        child: const Text("相册选择"),
        onPressed: () {
          Navigator.of(context).pop();
          _checkAlbumOrFilePermission(ok: () {
            _assetPicker(context, max ?? 9, complete: complete);
          });
        });
  }

  static Widget _fileAction(context, ValueChanged complete) {
    return CupertinoActionSheetAction(
        child: const Text("文件选择"),
        onPressed: () {
          Navigator.of(context).pop();
          _checkAlbumOrFilePermission(ok: () {
            _assetFile(context, complete: complete);
          });
        });
  }

  sdada() async {

    // 1. 请求相册删除权限
    // final permissionStatus = await PhotoManager.requestPermissionExtend();
    // if (!permissionStatus.isAuth) {
    //   print('需要相册权限才能删除照片。');
    //   return;
    // }

    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      // 已获取到权限
    } else if (ps.hasAccess) {
      // 已获取到权限（哪怕只是有限的访问权限）。
      // iOS Android 目前都已经有了部分权限的概念。
    } else {
      // 权限受限制（iOS）或者被拒绝，使用 `==` 能够更准确的判断是受限还是拒绝。
      // 你可以使用 `PhotoManager.openSetting()` 打开系统设置页面进行进一步的逻辑定制。


      // 含义：权限状态未决定。这意味着用户还没有明确地允许或拒绝该权限请求。
      // 用途：通常在应用第一次请求该权限时会出现这个状态。此时可以向用户请求权限。
      if (ps == PermissionState.notDetermined) {
        // 第一次请求权限或用户尚未明确选择
        // 可以在这里请求权限
      }

      // 含义：权限被限制。通常在 iOS 上出现，表示该权限受某些条件限制，比如家长控制或设备设置中的限制。
      // 用途：这种状态下应用无法请求权限。通常需要提示用户去系统设置中解除限制。
      if (ps == PermissionState.restricted) {
        // 权限被限制，可能需要家长控制或设备管理解除限制
        // 可以提示用户去系统设置中修改相关权限
      }

      // 含义：权限被用户拒绝。用户已经明确拒绝了该权限请求。
      // 用途：在这种状态下，如果用户再次请求权限，可能需要展示解释为什么需要该权限的提示；如果用户选择了“不再询问”，则必须引导用户手动去系统设置中开启权限。
      if (ps == PermissionState.denied) {
        // 用户拒绝了权限请求
        // 可以在这里向用户解释为什么需要权限，并再次请求
      }

      // 含义：权限已被用户授权。应用可以使用该权限访问相关设备资源。
      // 用途：可以继续执行需要该权限的操作，比如打开相机、获取位置信息等。
      if (ps == PermissionState.authorized) {
        // 权限已授权，可以执行需要该权限的操作
      }

      // 含义：权限受限。通常表示用户选择了有限的权限，如在 iOS 14+ 上的照片权限中，用户可以选择只允许访问选定的照片。
      // 用途：在这种状态下应用可以访问一些资源，但不具备完全的权限。可以提示用户授予完全权限，或者根据当前有限的权限继续操作。
      if (ps == PermissionState.limited) {
        // 权限受限（例如只能访问选定的照片）
        // 可以提示用户授予完整权限，或根据受限权限继续操作
      }
    }
  }


  //做相册和文件的判断
  static _checkAlbumOrFilePermission({required Function ok}) async {
    List<Permission> permissions;

    if (AppManager.osSdkIntForAndroid < ANDROID_OS_SDK_33) {
      permissions = [Permission.storage];
    } else {
      permissions = [Permission.manageExternalStorage];
    }

    bool hasPermissionNotAllow = false;

    for (var value in permissions) {
      var status = await value.status;
      if (!status.isGranted) {
        hasPermissionNotAllow = true;
        break;
      }
    }

    if (hasPermissionNotAllow) {
      _showDialogPermissionAndroidList(
          permissions: permissions,
          messageToUser: permission_content_album_storage, //相册存储权限提示
          doGranted: () {
            ok();
          });
    } else {
      ok();
    }
  }

  //可以弃用
  //执行方法之前-先检测-单个相机的:是否有权限没有被允许--
  static _checkCameraPermission({required Function ok}) async {
    List<Permission> permissions;

    if (AppManager.osSdkIntForAndroid < ANDROID_OS_SDK_33) {
      permissions = [Permission.camera, Permission.storage];
    } else {
      permissions = [Permission.camera, Permission.manageExternalStorage];
    }

    bool hasPermissionNotAllow = false;

    for (var value in permissions) {
      var status = await value.status;
      if (!status.isGranted) {
        hasPermissionNotAllow = true;
        break;
      }
    }

    if (hasPermissionNotAllow) {
      _showDialogPermissionAndroidList(
          permissions: permissions,
          messageToUser: permission_content_camera_storage, //相机和存储的权限提示
          doGranted: () {
            ok();
          });
    } else {
      ok();
    }
  }

  static _showDialogPermissionAndroidList({required List<Permission> permissions, required String messageToUser, required VoidCallback doGranted}) {
    showAlertDialog(
      title: permission_title_list,
      margin: const EdgeInsets.only(left: 20, right: 20),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: messageToUser,
                  style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
                ),
              ]),
            ),
          ),
        ],
      ),
      confirmText: permission_setting,
      cancelText: permission_cancel,
      buttonVertical: false,
      confirm: () {
        _requestPermissionAndroidList(permissions, messageToUser, doGranted);
        dismissAlertDialog();
      },
      cancel: () {
        dismissAlertDialog();
      },
    );
  }

  // 打开系统相机并捕获照片，且不保存到相册
  static Future<void> _cameraPicker(BuildContext context, {required ValueChanged complete}) async {
    final ImagePicker picker = ImagePicker();
    try {
      // 调用系统相机应用
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        // 获取临时文件路径
        final Directory tempDir = await getTemporaryDirectory();
        final String tempFilePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        // 将拍照保存的文件复制到临时路径
        await File(photo.path).copy(tempFilePath);
        // 调用回调函数，并返回新生成的临时文件路径
        complete([tempFilePath]);
      }
    } catch (e) {
      logger.i("Error during taking picture: $e");
    }
  }


  // 从手机相册选择
  static _assetPicker(context, max, {required Function(dynamic value) complete}) {
    final config = AssetPickerConfig(maxAssets: max, requestType: RequestType.image);
    List<String> imagePaths = [];
    AssetPicker.pickAssets(context, pickerConfig: config).then((list) async {
      if (list != null) {
        // 使用 Future.wait 等待所有文件加载完成
        debugPrint("DateTime.now().toString()");
        debugPrint(DateTime.now().toString());
        List<Future<void>> futures = List.generate(list.length, (index) async {
          final entity = list[index];
          final File? file = await entity.file;
          if (file != null) {
            imagePaths.add(file.path);
          }
        });
        // 等待所有文件加载完成
        await Future.wait(futures);
        logger.i("照片图库选择了 = ${imagePaths.length} 张图片");
        logger.i(DateTime.now().toString());
        logger.i("照片数量： widget.images = ${imagePaths.length} 张图片");
        complete(imagePaths);
      }
    });
  }

  // 从手机文件选择
  static _assetFile(BuildContext context, {required Function(dynamic value) complete}) async {
    final List<PlatformFile> result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result.isNotEmpty) {
      String? filePath = result.single.path;
      if (filePath != null) {
        complete(filePath);
      }
    }
  }

  ///检查权限
  static void _requestPermissionAndroidList(
      List<Permission> permissionList,
      String message, //
      VoidCallback callbackGranted, //所有的都同意
      {VoidCallback? callbackDenied}) async {
    bool flag = true;
    Permission? permissionCurrent;

    for (var permissionElement in permissionList) {
      var status = await permissionElement.status;
      if (!status.isGranted) {
        flag = false;
        permissionCurrent = permissionElement;
        break;
      }
    }

    if (!flag) {
      LoggerTool.logMy("$logCatTag 发现有权限未允许");

      PermissionStatus permissionStatusForCheck = await _requestPermissionList(permissionList);

      if (permissionStatusForCheck.isGranted) {
        LoggerTool.logMy("$logCatTag -多权限申请--isGranted--isGranted");
        (!ObjectUtil.isEmpty(callbackGranted)) ? callbackGranted.call() : () {}();
      } else if (permissionStatusForCheck.isDenied) {
        LoggerTool.logMy("$logCatTag -多权限申请--发现有权限未允许--isDenied");
        permissionCurrent?.onGrantedCallback(() {
          callbackGranted.call();
        }).onDeniedCallback(() {
          showMessageBottomLikeAndroid("${permissionCurrent.toString()}:$permission_open_setting", isLong: false);
          openAppSettings();
        }).request();
      } else if (permissionStatusForCheck.isPermanentlyDenied) {
        LoggerTool.logMy("$logCatTag 多权限申请，权限被永久拒绝，只能通过系统设置更改");

        //这一行是源码里的，我还不知道怎么用。
        //bool? isShown = await permissionCurrent?.shouldShowRequestRationale;

        if (permissionCurrent != null) {
          showMessageBottomLikeAndroid("${permissionCurrent.toString()}:$permission_open_setting", isLong: false);
          Future.delayed(const Duration(seconds: 2), () {
            openAppSettings();
          });
        }
      } else if (permissionStatusForCheck.isRestricted) {
        LoggerTool.logMy("$logCatTag permissionStatusForCheck.isRestricted");
        //IOS单独处理
        openAppSettings();
      } else if (permissionStatusForCheck.isLimited) {
        LoggerTool.logMy("$logCatTag 多权限申请，临时权限授予");
        //IOS单独处理
        openAppSettings();
      } else {
        //showDialogPermissionAndroidList(messageToUser, permissionList);
      }
    }
  }

  //申请权限：多组权限一并申请
  static Future<PermissionStatus> _requestPermissionList(List<Permission> permissionList) async {
    Map<Permission, PermissionStatus> statuses = await permissionList.request();
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;

    statuses.forEach((key, value) {
      if (!value.isGranted) {
        currentPermissionStatus = value;
        return;
      }
    });
    return currentPermissionStatus;
  }
}
