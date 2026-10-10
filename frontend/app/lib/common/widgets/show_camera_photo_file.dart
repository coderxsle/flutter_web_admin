import 'dart:io';

import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/constant_api.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:common_utils/common_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../../app/utils/common_widget/logger.dart';


class ShowCameraPhotoFile {
  // 仅支持拍照
  static camera(BuildContext context, {bool isCrop = false, required ValueChanged complete}) {
    final camera = _cameraAction(context, isCrop, complete);
    return _showActions(context, actions: [camera]);
  }

  // 仅支持相册选择
  static photo(BuildContext context, {num? max, bool isCrop = false, required ValueChanged complete}) {
    final picker = _pickerAction(context, max, complete);
    return _showActions(context, actions: [picker]);
  }

  // 仅支持选择文件 （iOS：文件管理器，选择 word、pdf 等）
  static file(BuildContext context, {required ValueChanged complete}) {
    final file = _fileAction(context, complete);
    return _showActions(context, actions: [file]);
  }

  // 支持拍照、或者相册
  static cameraPhoto(BuildContext context, {num? max, bool isCrop = false, required ValueChanged complete}) {
    final camera = _cameraAction(context, isCrop, complete);
    final picker = _pickerAction(context, max, complete);
    return _showActions(context, actions: [camera, picker]);
  }

  // 支持拍照、相册、文件选择
  static all(BuildContext context, {num? max, bool isCrop = false, required ValueChanged complete}) {
    final camera = _cameraAction(context, isCrop, complete);
    final picker = _pickerAction(context, max, complete);
    final file = _fileAction(context, complete);
    return _showActions(context, actions: [camera, picker, file]);
  }


  // 显示底部的选项菜单，可根据参数决定显示哪些按钮
  static _showActions(BuildContext context, {required List<Widget> actions}) {
    return showCupertinoModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        transitionBackgroundColor: Colors.white,
        barrierColor: Colors.black.withAlpha(150),
        shadow: const BoxShadow(color: Colors.transparent),
        builder: (context) => Container(
          color: Colors.transparent,
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


  static Widget _cameraAction(context, bool isCrop, ValueChanged complete) {
    return Container(
      color: Colors.white,
      child: CupertinoActionSheetAction(
          child: const Text("拍照"),
          onPressed: () {
            Navigator.of(context).pop();

            if (Platform.isIOS) _cameraPicker(context, isCrop, complete: complete);

            if (Platform.isAndroid) {
              _checkCameraPermission(ok: () {
                _cameraPicker(context, isCrop, complete: complete);
              });
            }
          }),
    );
  }

  static Widget _pickerAction(context, max, ValueChanged complete) {
    return Container(
      color: Colors.white,
      child: CupertinoActionSheetAction(
          child: const Text("相册选择"),
          onPressed: () {
            //2024-11-18 chenqi为了关闭【相机、相册、取消】弹窗。
            Navigator.of(context).pop();
            /*if (Platform.isIOS) _assetPicker(context, max ?? 9, complete: complete);
            if (Platform.isAndroid) {
              _checkAlbumOrFilePermission(ok: () {
                _assetPicker(context, max ?? 9, complete: complete);
              });
            }*/
            //抽取一个通用打开相册的方法
            defaultOpenToAlbum(context, max: max, complete: complete);
          }),
    );
  }

  //直接跳转到相册，2024-11-6
  static defaultOpenToAlbum(context,{num? max, required ValueChanged complete}) async {
    // 在打开相册前刷新媒体库
    // await refreshMediaStore();
    
    if (Platform.isIOS) _assetPicker(context, max ?? 9, complete: complete);
    if (Platform.isAndroid) {
      _checkAlbumOrFilePermission(ok: () {
        _assetPicker(context, max ?? 9, complete: complete);
      });
    }
  }

  static Widget _fileAction(context, ValueChanged complete) {
    return Container(
      color: Colors.white,
      child: CupertinoActionSheetAction(
          child: const Text("文件选择"),
          onPressed: () {
            Navigator.of(context).pop();

            if (Platform.isIOS) _assetFile(context, complete: complete);

            if (Platform.isAndroid) {
              _checkAlbumOrFilePermission(ok: () {
                _assetFile(context, complete: complete);
              });
            }
          }),
    );
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
    }
  }


  //做相册和文件的判断
  static _checkAlbumOrFilePermission({required Function ok}) async {
    List<Permission> permissions;

    if (AppManager.osSdkIntForAndroid < ANDROID_OS_SDK_33) {
      //logger.d("osSdkIntForAndroid < ANDROID_OS_SDK_33");
      permissions = [Permission.storage];
    } else {
      //logger.d("android系统大于33");
      permissions = [Permission.manageExternalStorage];
    }

    //@lastTime 2025/2/5因为春节华为审核未通过，出问题的代码，做改造。
    bool hasPermissionNotAllow = false;
    for (var value in permissions) {
      var status = await value.status;
      if (!status.isGranted) {
        //logger.d("有权限没打开");
        hasPermissionNotAllow = true;
        break;
      }
    }
    //logger.d("hasPermissionNotAllow-等于=$hasPermissionNotAllow");

    if (hasPermissionNotAllow) {
      //logger.d("hasPermissionNotAllow--是true，说明有权限没设置");
      _showDialogPermissionAndroidList(
          permissions: permissions,
          messageToUser: permission_content_album_storage, //相册存储权限提示
          doGranted: () {
            ok.call();
          });
    } else {
      ok.call();
    }
  }

  ////@updateTime 2025/2/5 检测多组权限:是否有权限没有被允许,单独抽取，不单独抽取也行，我先给注释掉
 /*static Future<bool> _checkPermissionAndroidList(List<Permission> permissionList) async {
    bool hasPermissionNotAllow = false;
    for (var value in permissionList) {
      var status = await value.status;
      if (!status.isGranted) {
        hasPermissionNotAllow = true;
        break;
      }
    }
    return hasPermissionNotAllow;
  }*/

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


  // 打开相机并捕获照片，且不保存到相册
  // static _cameraPicker2(context, {required ValueChanged complete}) async {
  //   // 跳转到相机预览页面，并传递相机控制器
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (_) => MyCameraPreview(callback: (filePath) => complete([filePath])),
  //   ));
  // }



  // 弃用该方法 （因为 wechat_camera_picker 不支持保存自定义路径，默认会保存到相册，删除照片时 iOS 会弹框提示，给用户体验不友好）
  // 打开相机并捕获照片，且不保留到相册
  // static _cameraPicker(context, {required ValueChanged complete}) async {
  //   const CameraPickerConfig config = CameraPickerConfig();
  //   List<String> imagePaths = [];
  //   CameraPicker.pickFromCamera(context, pickerConfig: config).then((asset) async {
  //     if (asset != null) {
  //       // 获取临时目录路径
  //       final tempDir = await getTemporaryDirectory();
  //       final tempPath = tempDir.path;
  //
  //       // 获取原始文件
  //       final file = await asset.file;
  //
  //       if (file != null) {
  //         // 使用 path 包获取文件名
  //         final fileName = path.basename(file.path);
  //
  //         // 将文件复制到临时目录，不保存到相册
  //         final newFile = await file.copy('$tempPath/$fileName');
  //
  //         // 3. 删除相册中的照片（使用 PhotoManager 删除）
  //         final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();
  //         for (final album in albums) {
  //           // 使用 assetCountAsync 获取相册中的资源数量
  //           final int assetCount = await album.assetCountAsync;
  //           if (assetCount > 0) {
  //             final List<AssetEntity> assets = await album.getAssetListRange(start: 0, end: assetCount);
  //             for (final asset in assets) {
  //               if (asset.id == asset.id) {
  //                 await PhotoManager.editor.deleteWithIds([asset.id]);
  //                 debugPrint('照片已成功从相册中删除: ${asset.id}');
  //               }
  //             }
  //           }
  //         }
  //         debugPrint('照片已保存到临时目录: ${newFile.path}');
  //       }
  //     }
  //   });
  // }


  // 打开系统相机并捕获照片，且不保存到相册
  static Future<void> _cameraPicker(BuildContext context, bool isCrop, {required ValueChanged complete}) async {
    final ImagePicker picker = ImagePicker();
    try {
      // 调用系统相机应用
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null && isCrop == false) {
        // 不裁剪，直接返回照片路径
        complete([photo.path]);
      }

      if (photo != null && isCrop == true) {
        // 裁剪和旋转照片
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: photo.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: '裁剪照片',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9,
              ],
            ),
            IOSUiSettings(
              title: '裁剪照片',
              minimumAspectRatio: 0,
            ),
          ],
        );

        if (croppedFile != null) {
          // 获取临时文件路径
          final Directory tempDir = await getTemporaryDirectory();
          final String tempFilePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
          // 将裁剪后的文件复制到临时路径
          await File(croppedFile.path).copy(tempFilePath);
          // 调用回调函数，并返回新生成的临时文件路径
          complete([tempFilePath]);
        }
      }
    } catch (e) {
      logger.i("Error during taking or editing picture: $e");
    }
  }

  // 从手机相册选择
  // static _assetPicker(context, max, {required Function(dynamic value) complete}) async {
  static _assetPicker(BuildContext context, max, {required Function(dynamic value) complete}) async {

    // 在选择前刷新媒体库
    await refreshMediaStore();
    List<String> imagePaths = [];
    final config = AssetPickerConfig(maxAssets: max, requestType: RequestType.image);
    // AssetPicker.pickAssets(context, pickerConfig: config).then((list) async {
    //   if (list != null) {
    //     // 使用 Future.wait 等待所有文件加载完成
    //     debugPrint("DateTime.now().toString()");
    //     debugPrint(DateTime.now().toString());
    //     List<Future<void>> futures = List.generate(list.length, (index) async {
    //       final entity = list[index];
    //       final File? file = await entity.file;
    //       if (file != null) {
    //         imagePaths.add(file.path);
    //       }
    //     });
    //     // 等待所有文件加载完成
    //     await Future.wait(futures);
    //     logger.i("照片图库选择了 = ${imagePaths.length} 张图片");
    //     logger.i(DateTime.now().toString());
    //     logger.i("照片数量： widget.images = ${imagePaths.length} 张图片");
    //     complete(imagePaths);
    //   }
    // });
    
    // 存储结果变量，避免在异步操作后使用 context
    final result = await AssetPicker.pickAssets(context, pickerConfig: config);
    
    if (result != null) {
      // 使用 Future.wait 等待所有文件加载完成
      debugPrint("DateTime.now().toString()");
      debugPrint(DateTime.now().toString());
      
      for (final entity in result) {
        final File? file = await entity.file;
        if (file != null) {
          imagePaths.add(file.path);
        }
      }
      
      logger.i("照片图库选择了 = ${imagePaths.length} 张图片");
      logger.i(DateTime.now().toString());
      logger.i("照片数量： widget.images = ${imagePaths.length} 张图片");
      complete(imagePaths);
    }
  }

  // 从手机文件选择
  static _assetFile(BuildContext context, {required Function(dynamic value) complete}) async {
    final List<PlatformFile> result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'word', 'excel', 'txt'],
    );
    if (result.isNotEmpty) {
      complete(result.map((file) => file.path!).toList());
    }
  }

    // 添加媒体库刷新方法
  static Future<void> refreshMediaStore() async {
    if (Platform.isAndroid) {
      try {
        // 刷新媒体库
        await PhotoManager.clearFileCache();
        await PhotoManager.releaseCache();
        // 重新请求权限，这会触发系统扫描
        await PhotoManager.requestPermissionExtend();
      } catch (e) {
        logger.e("刷新媒体库失败: $e");
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
