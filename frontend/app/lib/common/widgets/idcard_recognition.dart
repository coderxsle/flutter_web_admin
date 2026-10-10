// import 'dart:io';

// import 'package:auto_shop_server/Base/common_request.dart';
// import 'package:auto_shop_server/app/utils/app_manager.dart';
// import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
// import 'package:auto_shop_server/app/utils/constant_api.dart';
// import 'package:auto_shop_server/app/utils/global.dart';
// import 'package:auto_shop_server/widgets/permission_manager.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';
// import 'package:wechat_camera_picker/wechat_camera_picker.dart';

// import 'show_camera_photo_file.dart';

// const double holeWidth = 200;
// const double holeHeight = 100;


// class IdcardRecognition {

//     // 仅支持拍照
//   static showCamera(BuildContext context, {required ValueChanged complete}) {
//     final camera = _cameraAction(context, complete);

//     return _showActions(context, actions: [camera]);
//   }

//   static showCameraAlbum(BuildContext context, {required ValueChanged complete}) {
//     final camera = _cameraAction(context, complete);
//     final album = _albumAction(context, complete);
//     return _showActions(context, actions: [camera, album]);
//   }

//   // 仅支持相册选择
//   // static photo(BuildContext context, {num? max, bool isCrop = false, required ValueChanged complete}) {
//   //   final picker = _pickerAction(context, max, complete);
//   //   return _showActions(context, actions: [picker]);
//   // }


//   // 拍照的按钮
//   static Widget _cameraAction(context, ValueChanged complete) {
//     return CupertinoActionSheetAction(
//         child: const Text("拍照"),
//         onPressed: () {
//           Navigator.of(context).pop();
//           PermissionManager.checkAndHandlePhotosPermission(context,
//             onGranted: () => _openCamera(context, complete: complete),
//           );
//         });
//   }

//   // 相册选择的按钮
//   static Widget _albumAction(context, ValueChanged complete) {
//     return CupertinoActionSheetAction(
//         child: const Text("相册选择"),
//         onPressed: () {
//           Navigator.of(context).pop();
//           PermissionManager.checkAndHandlePhotosPermission(context,
//             onGranted: () => _openAlbum(context, complete: complete),
//           );
//         });
//   }

//   // 打开相机的操作
//   static _openCamera(BuildContext context, {required ValueChanged complete}) async {
//     await CameraPicker.pickFromCamera(
//       Get.context!,
//       pickerConfig: CameraPickerConfig(foregroundBuilder: foregroundBuilder, onXFileCaptured: (XFile file, CameraPickerViewType type) {
//         Get.back();
//         _cropImage(file, complete: complete);
//         return true;
//       }),
//     );
//   }

//   // 打开相册的操作
//   static _openAlbum(BuildContext context, {required ValueChanged complete}) async {
//     final config = AssetPickerConfig(maxAssets: 1, requestType: RequestType.image);
//     List<String> imagePaths = [];
//     AssetPicker.pickAssets(context, pickerConfig: config).then((list) async {
//       if (list != null) {
//         // 使用 Future.wait 等待所有文件加载完成
//         debugPrint("DateTime.now().toString()");
//         debugPrint(DateTime.now().toString());
//         List<Future<void>> futures = List.generate(list.length, (index) async {
//           final entity = list[index];
//           final File? file = await entity.file;
//           if (file != null) {
//             imagePaths.add(file.path);
//           }
//         });
//         // 等待所有文件加载完成
//         await Future.wait(futures);
//         logger.i("照片图库选择了 = ${imagePaths.length} 张图片");
//         logger.i(DateTime.now().toString());
//         logger.i("照片数量： widget.images = ${imagePaths.length} 张图片");
//         complete(imagePaths);
//         if (imagePaths.isNotEmpty) {
//           _cropImage(XFile(imagePaths.first), complete: complete);
//         }
//       }
//     });

//   }


//   // 裁剪图片的操作
//   static _cropImage(XFile file, {required ValueChanged complete}) async {
//     final croppedFile = await ImageCropper().cropImage(
//       sourcePath: file.path,
//       aspectRatio: const CropAspectRatio(
//         ratioX: 1,
//         ratioY: 1.15,
//       ),
//       // cropStyle: CropStyle.rectangle,
//       compressFormat: ImageCompressFormat.jpg,
//       compressQuality: 90,
//       uiSettings: [
//         AndroidUiSettings(
//           toolbarColor: Colors.deepOrange,
//           toolbarWidgetColor: Colors.white,
//           initAspectRatio: CropAspectRatioPreset.original,
//           lockAspectRatio: false,
//         ),
//         IOSUiSettings(
//           rectWidth: holeWidth.toDouble(),
//           rectHeight: holeHeight.toDouble(),
//         ),
//       ],
//     );

//     if (croppedFile != null) {
//       // 在这里保存裁剪后的图片或执行其他操作
//       showLoadingMessage("正在识别");
//       Get.defaultDialog(title: "证件识别", content: Image.file(File(croppedFile.path)));
//       final response = await CommonRequest.uploadImage(croppedFile.path);
//       Get.close(1);
//       dismissLoading();
//       complete(response);
//     }
//     complete(null);
//   }


//   static Widget foregroundBuilder(BuildContext context, CameraController? controller) {
//       // 计算挖孔矩形的位置，使其居中显示

//     final holeWidth = MediaQuery.of(context).size.width;
//     final holeHeight = MediaQuery.of(context).size.height;
//     double screenWidth = holeWidth;
//     double screenHeight = holeHeight;

//       return Center(
//         child: CustomPaint(
//           size: Size(screenWidth, screenHeight), // 设置挖孔形状的大小
//           painter: CutoutPainter(
//             holeWidth: holeWidth,
//             holeHeight: holeHeight,
//             holeX: (screenWidth - holeWidth) / 2,
//             holeY: (screenHeight - holeHeight) / 2.65,
//           ),
//         ),
//       );
//   }

//   // 显示底部的选项菜单，可根据参数决定显示哪些按钮
//   static _showActions(BuildContext context, {required List<Widget> actions}) {
//     return showCupertinoModalBottomSheet(
//         context: context,
//         backgroundColor: Colors.transparent,
//         transitionBackgroundColor: Colors.white,
//         barrierColor: Colors.black.withAlpha(150),
//         shadow: const BoxShadow(color: Colors.transparent),
//         builder: (context) => Container(
//           color: Colors.transparent,
//           margin: const EdgeInsets.only(left: 10, right: 10),
//           child: CupertinoActionSheet(
//             // title: const Text('选择照片'),
//             // message: const Text('选择照片来源'),
//             messageScrollController: ScrollController(),
//             actions: actions,
//             cancelButton: CupertinoActionSheetAction(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('取消'),
//             ),
//           ),
//         )
//     );
//   }








//     //可以弃用
//   //执行方法之前-先检测-单个相机的:是否有权限没有被允许--
//   static _checkCameraPermission({required Function ok}) async {
//     List<Permission> permissions;

//     if (AppManager.osSdkIntForAndroid < ANDROID_OS_SDK_33) {
//       permissions = [Permission.camera, Permission.storage];
//     } else {
//       permissions = [Permission.camera, Permission.manageExternalStorage];
//     }

//     bool hasPermissionNotAllow = false;

//     for (var value in permissions) {
//       var status = await value.status;
//       if (!status.isGranted) {
//         hasPermissionNotAllow = true;
//         break;
//       }
//     }

//     if (hasPermissionNotAllow) {
//       _showDialogPermissionAndroidList(
//           permissions: permissions,
//           messageToUser: permission_content_camera_storage, //相机和存储的权限提示
//           doGranted: () {
//             ok();
//           });
//     } else {
//       ok();
//     }
//   }

//   static _showDialogPermissionAndroidList({required List<Permission> permissions, required String messageToUser, required VoidCallback doGranted}) {
//     showAlertDialog(
//       title: permission_title_list,
//       margin: const EdgeInsets.only(left: 20, right: 20),
//       content: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SingleChildScrollView(
//             child: RichText(
//               text: TextSpan(children: [
//                 TextSpan(
//                   text: messageToUser,
//                   style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
//                 ),
//               ]),
//             ),
//           ),
//         ],
//       ),
//       confirmText: permission_setting,
//       cancelText: permission_cancel,
//       buttonVertical: false,
//       confirm: () {
//         dismissAlertDialog();
//             showAlertDialog(
//       title: permission_title_list,
//       margin: const EdgeInsets.only(left: 20, right: 20),
//       content: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SingleChildScrollView(
//             child: RichText(
//               text: TextSpan(children: [
//                 TextSpan(
//                   text: messageToUser,
//                   style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
//                 ),
//               ]),
//             ),
//           ),
//         ],
//       ),
//       confirmText: permission_setting,
//       cancelText: permission_cancel,
//       buttonVertical: false,
//       confirm: () {
//         dismissAlertDialog();
        
//       },
//       cancel: () {
//         dismissAlertDialog();
//       },
//     );
//       },
//       cancel: () {
//         dismissAlertDialog();
//       },
//     );
//   }


// }







// class CutoutPainter extends CustomPainter {
//   final double holeWidth;
//   final double holeHeight;
//   final double holeX;
//   final double holeY;

//   CutoutPainter({
//     required this.holeWidth,
//     required this.holeHeight,
//     required this.holeX,
//     required this.holeY,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = const Color.fromRGBO(0, 0, 0, 0.5); // 定义形状的颜色

//     // 创建一个路径来描述形状
//     Path path = Path()
//       ..moveTo(0, 0) // 移动到路径的起始点
//       ..lineTo(size.width, 0) // 从起始点开始画线到右上角
//       ..lineTo(size.width, size.height) // 画线到右下角
//       ..lineTo(0, size.height) // 画线到左下角
//       ..close(); // 关闭路径形成一个封闭的形状

//     // 创建一个内部挖孔的路径（矩形）
//     Path holePath = Path()
//       ..addRect(Rect.fromLTWH(holeX, holeY, holeWidth, holeHeight)); // 创建一个长方形挖孔

//     path = Path.combine(PathOperation.difference, path, holePath); // 将挖孔路径与形状路径进行组合

//     canvas.drawPath(path, paint); // 将路径填充到画布上
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }








// }
