// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'dart:io';

import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:auto_shop_server/common/common_tools.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../global.dart';
import 'gradient_button.dart';
import 'my_material_button.dart';

// 关闭当前的正在加载...
dismissLoading() async {
  await SmartDialog.dismiss(force: true, status: SmartStatus.loading);
}

/// 关闭弹出框
dismissAlertDialog() async {
  await SmartDialog.dismiss(force: true);
}

showLoadingMessage(String message) async {
  const time = Duration(seconds: 20);
  await SmartDialog.showLoading(msg: message, displayTime: time, usePenetrate: false);
  SmartDialog.dismiss(status: SmartStatus.loading);
}

// 提示
showMessage(String message) {
  double charDisplayTime = 0.10;
  int displayTime = (message.length * charDisplayTime).ceil();
  displayTime = displayTime.clamp(1, 5); // 限制展示时间最小1秒，最大为5秒钟
  SmartDialog.showToast(
    message,
    alignment: Alignment(0.0, 0.7),
    displayType: SmartToastType.onlyRefresh,
    displayTime: Duration(seconds: displayTime),
    animationType: SmartAnimationType.centerFade_otherSlide,
  );
}

ValueNotifier<double> progressNotifier = ValueNotifier(0.0);
void showProgress(String message) {
  SmartDialog.show(
    tag: 'progress',
    keepSingle: true,
    usePenetrate: false,
    clickMaskDismiss: false,
    builder: (_) => _buildProgressDialog(message),
  );
}

void updateProgress(int send, int total) {
  if (total <= 0) return;
  progressNotifier.value = send / total;
}

void dismissProgress() {
  SmartDialog.dismiss(tag: 'progress');
}

Widget _buildProgressDialog(String message) {
  return Container(
    width: 200,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(12),
    ),
    child: ValueListenableBuilder<double>(
      valueListenable: progressNotifier,
      builder: (context, value, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: value,
              minHeight: 2,
              backgroundColor: Colors.grey[100],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 10),
            Text("${(value * 100).toStringAsFixed(0)}%", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        );
      },
    ),
  );
}

//类似Android的底部弹窗
showMessageBottomLikeAndroid(String message, {required bool isLong}) {
  SmartDialog.showToast(message, //
      displayType: SmartToastType.onlyRefresh, //
      displayTime: Duration(seconds: isLong ? 2 : 1));
}

showDebugMessage(String message) {
  if (kDebugMode) showAlertMessage(message);
}

// 提示操作成功
showSuccessMessage(String message) {
  SmartDialog.showNotify(
    msg: message,
    notifyType: NotifyType.success,
    // alignment: const Alignment(0.0, -0.25),
    alignment: const Alignment(0.0, 0.5),
    displayTime: const Duration(milliseconds: 500),
    animationType: SmartAnimationType.centerFade_otherSlide,
  );
}

// 提示操作失败
showFailureMessage(String message) {
  double charDisplayTime = 0.1;
  int displayTime = (message.length * charDisplayTime).ceil();
  displayTime = displayTime.clamp(1, 5); // 限制展示时间最小1秒，最大为5秒钟
  SmartDialog.showNotify(
    msg: message,
    notifyType: NotifyType.failure,
    alignment: const Alignment(0.0, 0.5),
    displayTime: Duration(seconds: displayTime),
    animationType: SmartAnimationType.centerFade_otherSlide,
  );
}

// 提示警告！
showAlertMessage(String message) {
  double charDisplayTime = 0.1;
  int displayTime = (message.length * charDisplayTime).ceil();
  displayTime = displayTime.clamp(1, 5); // 限制展示时间最小1秒，最大为5秒钟
  SmartDialog.showNotify(
    msg: message,
    notifyType: NotifyType.alert,
    alignment: const Alignment(0.0, 0.5),
    displayTime: Duration(seconds: displayTime),
    animationType: SmartAnimationType.centerFade_otherSlide,
  );
}

////@timeUpdate 2025/6/14 13:07:07
// 提示警告！设置提示语在屏幕中心展示.
showAlertMessageAlignmentCenter(String message) {
  double charDisplayTime = 0.1;
  int displayTime = (message.length * charDisplayTime).ceil();
  displayTime = displayTime.clamp(1, 5); // 限制展示时间最小1秒，最大为5秒钟
  SmartDialog.showNotify(
    msg: message,
    notifyType: NotifyType.alert,
    //alignment: const Alignment(0.0, 0.5),
    alignment: Alignment.center,
    displayTime: Duration(seconds: displayTime),
    animationType: SmartAnimationType.centerFade_otherSlide,
  );
}

Widget bottomSheetAction(String title, {required VoidCallback onPressed}) {
  return Row(children: [
    Expanded(
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              title,
              style: const TextStyle(fontSize: 15, color: Font_Color_Black_34),
            ))),
  ]);
}

// 左右透明 单独取消按钮
show_iOS_bottom_sheet(String title, {List<String>? tags, Map<String, dynamic>? keyValues, required Function onTap}) {
  double height = 0;
  List<Widget> list = [];
  if (keyValues != null) {
    for (String key in keyValues.keys) {
      list.addAll([
        dividerLine(),
        bottomSheetAction(key, onPressed: () {
          onTap({key: keyValues[key]});
        }),
      ]);
    }
    height = (keyValues.length + 4) * 45;
  } else if (tags != null) {
    for (dynamic item in tags) {
      if (item is String) {
        list.addAll([
          dividerLine(),
          bottomSheetAction(item, onPressed: () {
            onTap(item);
          }),
        ]);
      }
    }
    height = (tags.length + 4) * 45;
  }
  Get.bottomSheet(
    barrierColor: Colors.black26,
    isScrollControlled: true,
    Container(
      height: height,
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(children: [
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(fontSize: 15, color: Font_Color_grey_153),
              ),
              const SizedBox(height: 15),
              Column(
                children: list,
              )
            ]),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 35),
              // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              // height: 400,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          "取消",
                          style: TextStyle(fontSize: 15, color: Font_Color_Black_34, fontWeight: FontWeight.bold),
                        ))),
              ])),
        ],
      ),
    ),
  );
}

typedef OnData<T> = void Function(T data);

show_bottom_one_selecte(String? title, {required Map<String, num> keyValues, required OnData callback}) {
  Get.bottomSheet(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
        height: 600,
        color: BGColor_grey_225,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: [
            Container(
              color: PageBackgroundColor,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title ?? "请选择", textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
            dividerLine(),
            Expanded(
                child: ListView(
              //padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              children: keyValues.keys.map((e) {
                return Container(
                  color: Colors.white,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.5),
                  child: ListTile(onTap: () => callback({e: keyValues[e]}), title: Text(e, textAlign: TextAlign.center, style: blackStyle())),
                );
              }).toList(),
            )),
          ],
        ),
      );
    }),
  );
}

class BottomOneSelectedModel {
  String icon, title, subTitle, value;
  int? index;
  dynamic model;

  BottomOneSelectedModel({this.icon = "", this.title = "", this.subTitle = "", this.value = "", this.index, this.model});
}

//弹窗因为选择修理厂，我给改造了一点（cq //timeUpdate 2025/3/3 加了一个标题的样式）
showBottomOneSelected(String title, List<BottomOneSelectedModel> models, {bool? isNeedDividerLine, TextStyle? titleDialogStyle, TextStyle? contentStyle, required Function(BottomOneSelectedModel) callback}) {
  Get.bottomSheet(StatefulBuilder(builder: (context, setState) {
    List<Widget> items = [];
    for (var index = 0; index < models.length; index++) {
      BottomOneSelectedModel model = models[index];
      items.add(GestureDetector(
        onTap: () => callback(model),
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.5),
          padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: (model.icon.isEmpty) ? MainAxisAlignment.center : MainAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (model.icon.startsWith(httpStartWithPrefix))
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      child: imageNetwork(
                        model.icon,
                        width: 44,
                        height: 44,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  if (model.icon.isNotEmpty && !(model.icon.startsWith(httpStartWithPrefix)))
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      child: imageAsset(
                        model.icon,
                        width: 44,
                        height: 44,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  Text(model.title, style: contentStyle ?? blackStyle()),

                  if (model.subTitle.isNotEmpty)
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text(model.subTitle, style: greyStyle(font: 14)),
                      ],
                    )
                  // const SizedBox(width: 10),
                  // Text(model.subTitle, style: greyStyle(font: 14)),
                ],
              ),
              // if (model.subTitle.isNotEmpty) Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(model.subTitle, style: greyStyle(font: 14)),
              //   ],
              // ),
            ],
          ),
        ),
      ));
    }
    return Container(
      height: 600,
      color: PageBackgroundColor,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title ?? "请选择", textAlign: TextAlign.center, style: titleDialogStyle ?? greyStyle(font: 18)),
              ],
            ),
          ),
          if (isNeedDividerLine ?? true) dividerLine(),
          Expanded(
              child: ListView(
            padding: const EdgeInsets.fromLTRB(0, 1, 0, 30),
            children: items,
          )),
        ],
      ),
    );
  }));
}

show_bottom_one_select2(String? selectTitle, String? imageKey, String? titleKey, String? subTitleKey, {required List keyValues, required Function(dynamic) callback}) {
  Get.bottomSheet(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      List<Widget> list = [];
      var img = "";
      var title = "";
      var subTitle = "";
      for (var index = 0; index < keyValues.length; index++) {
        if (keyValues[index].keys.contains(imageKey)) {
          img = keyValues[index][imageKey];
        }
        if (keyValues[index].keys.contains(titleKey)) {
          title = keyValues[index][titleKey];
        }
        if (keyValues[index].keys.contains(subTitleKey)) {
          subTitle = keyValues[index][subTitleKey];
        }
        list.add(
          GestureDetector(
            onTap: () => callback(index),
            child: Column(
              children: [
                Container(
                  height: 50,
                  color: Colors.white,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (img.isNotEmpty && img.startsWith("http"))
                            imageNetwork(
                              img,
                              width: 35,
                              height: 35,
                              fit: BoxFit.fitHeight,
                            ),
                          Text(title, style: blackStyle()),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Offstage(
                        offstage: !subTitle.isNotEmpty,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(subTitle, style: greyStyle(font: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (!(index == keyValues.length - 1)) //最后一条数据不添加横线
                  dividerLine(left: 15, right: 15),
              ],
            ),
          ),
        );
      }
      return Container(
        height: 600,
        color: PageBackgroundColor,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: [
            Container(
              color: PageBackgroundColor,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(selectTitle ?? "请选择", textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
            //Expanded(child: ListView(padding: const EdgeInsets.fromLTRB(0, 0, 0, 30), children: list)),
            Expanded(child: ListView(padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(Get.context!).padding.bottom), children: list)),
          ],
        ),
      );
    }),
  );
}

showAlertDialog(
    {String? title,
    TextStyle? titleStyleMy,
    String? message,
    TextStyle? messageTextStyle,
    Color? messageColor,
    String? titleImage,
    InlineSpan? messageTextSpan,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Widget? content,
    bool? buttonVertical = false,
    bool? hiddenButton = false,
    String? confirmText = "确定",
    String? cancelText = "取消",
    VoidCallback? confirm,
    VoidCallback? cancel}) async {
  SmartDialog.show(
      clickMaskDismiss: hiddenButton,
      alignment: Alignment.center,
      maskColor: Colors.black54,
      onMask: () => FocusManager.instance.primaryFocus?.unfocus(),
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            margin: margin ?? const EdgeInsets.only(left: 50, right: 50).w,
            padding: padding ?? const EdgeInsets.all(20).r,
            decoration: BoxDecoration(
              image: titleImage != null ? DecorationImage(image: AssetImage(titleImage), alignment: Alignment.topCenter, fit: BoxFit.scaleDown) : null,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 固定的标题部分
                if (title != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: titleImage != null ? 30 : 10).r,
                    child: Text(title, style: titleStyleMy ?? TextStyle(fontSize: 20.sp, color: titleImage != null ? Colors.white : Colors.black, fontWeight: FontWeight.w600)),
                  ),
                // 固定的消息部分
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10).r,
                    child: Text(message, style: messageTextStyle ?? TextStyle(fontSize: 14.sp, color: messageColor ?? Colors.black, height: 1.5)),
                  ),
                if (messageTextSpan != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10).r,
                    child: RichText(text: messageTextSpan, strutStyle: StrutStyle(fontSize: 14.sp)),
                  ),
                // 可滚动的内容部分
                if (content != null)
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10).r,
                        child: content,
                      ),
                    ),
                  ),
                // 固定的按钮部分
                if (hiddenButton == false && buttonVertical == true)
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 15, 10).r,
                    child: Column(
                      children: [
                        GradientButton(
                          gradient: const LinearGradient(
                            colors: [Colors.orange, Colors.red, Colors.orange],
                          ),
                          borderRadius: BorderRadius.circular(22),
                          onPressed: confirm ?? () => dismissAlertDialog(),
                          child: Text(confirmText!, style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                        ),
                        SizedBox(height: 10.r),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              onPressed: cancel ?? () => dismissAlertDialog(),
                              style: ButtonStyle(shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))), side: WidgetStateProperty.all(const BorderSide(width: 0.67, color: Colors.red)), backgroundColor: WidgetStateProperty.all(Colors.transparent)),
                              child: Text("$cancelText", style: TextStyle(fontSize: 15.sp, color: Colors.red))),
                        ),
                      ],
                    ),
                  ),
                if (hiddenButton == false && buttonVertical == false)
                  Container(
                    padding: const EdgeInsets.only(top: 5).r,
                    margin: const EdgeInsets.fromLTRB(20, 0, 15, 0).r,
                    child: Row(children: [
                      Expanded(
                        child: TextButton(
                            onPressed: cancel ?? () => dismissAlertDialog(),
                            style: ButtonStyle(
                                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                                padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
                                side: WidgetStateProperty.all(const BorderSide(width: 0.67, color: Colors.red)),
                                backgroundColor: WidgetStateProperty.all(Colors.transparent)),
                            child: Text("$cancelText", style: TextStyle(fontSize: 15.sp, color: Colors.red))),
                      ),
                      SizedBox(width: 10.r),
                      Expanded(
                        child: GradientButton(
                          gradient: const LinearGradient(
                            colors: [Colors.orange, Colors.red],
                          ),
                          borderRadius: BorderRadius.circular(22),
                          onPressed: confirm ?? () => dismissAlertDialog(),
                          child: Text(confirmText!, style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                        ),
                      ),
                    ]),
                  ),
              ],
            ),
          ),
        );
      });
}

//@timeUpdate 2025/8/9 这个弹窗仅仅只有 客户关怀 弹窗联系人列表用到
// 客户关怀->输入客户电话，弹出选择客户列表
showModalBottomSheet1(BuildContext context, List<BottomOneSelectedModel> models, {required Function(BottomOneSelectedModel) callback}) {
  return showModalBottomSheet(
      context: context,
      barrierColor: Colors.black54,
      backgroundColor: Colors.transparent,
      builder: (w) {
        return Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    ),
                    child: imageAsset(AssetsRes.SELECT_CLIENT_BG, fit: BoxFit.fitWidth),
                  ),
                ),
                Positioned(left: 80, top: 0, child: imageAsset(AssetsRes.SELECT_CLIENT_USER_ICON, width: 80, fit: BoxFit.cover)),
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: ListView.builder(
                    itemCount: models.length,
                    itemBuilder: (context, index) {
                      return MyMaterialButton(
                        delayed: 100,
                        onPressed: () => callback(models[index]),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                              child: Row(
                                children: [
                                  Text(models[index].title ?? "", style: blackStyle()),
                                  const SizedBox(width: 15),
                                  Text(models[index].subTitle ?? "", style: blackStyle()),
                                ],
                              ),
                            ),
                            dividerLine(),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        );
      });
}

void showModelSheet(BuildContext context, List<String> actions, {required Function(int) onClick}) {
  showCupertinoModalBottomSheet(
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
        actions: List.generate(actions.length, (index) {
          return Container(
            color: Colors.white,
            child: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                onClick(index);
              },
              child: Text(actions[index]),
            ),
          );
        }),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
      ),
    ),
  );
}

// cameraPicker(context, {required Function(dynamic value) complete}) async {
//   // 创建相机选择器配置 打开相机
//   const CameraPickerConfig config = CameraPickerConfig();
//   List<String> imagePaths = [];
//   AssetEntity? asset = await CameraPicker.pickFromCamera(context, pickerConfig: config);
//   if (asset != null) {
//     final File? file = await asset.file;
//     if (file != null) {
//       // 先保存到临时目录
//       final Directory tempDir = await getTemporaryDirectory();
//       String tempFilePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
//       await file.copy(tempFilePath);
//
//       // 删除保存到相册的照片
//       await file.delete();
//
//       // 返回临时文件路径
//       imagePaths.add(tempFilePath);
//       complete(imagePaths);
//     }
//   }
//   return null;
// }

// 相册选择
assetPicker(context, max, {required Function(dynamic value) complete}) {
  // 从手机相册选择
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
  return null;
}

//三个按钮的：目前只有android单独使用的弹窗。
showAlertDialogThreeButton(
    {String? title,
    String? message,
    Color? messageColor,
    InlineSpan? messageTextSpan,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Widget? content,
    bool? buttonVertical = false,
    bool? hiddenButton = false, //默认是false
    //是否需要隐藏取消按钮，如果隐藏的话，那么外部弹窗是不能关闭的
    bool? isHiddenCancelButton = false, //默认是false
    String? confirmText = "确定",
    String? middleText = "忽略",
    String? cancelText = "取消",
    VoidCallback? confirm,
    VoidCallback? middle, //
    VoidCallback? cancel}) async {
  SmartDialog.show(
      clickMaskDismiss: hiddenButton,
      alignment: Alignment.center,
      maskColor: Colors.black54,
      onMask: () => FocusManager.instance.primaryFocus?.unfocus(),
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              margin: margin ?? const EdgeInsets.only(left: 30, right: 30, bottom: 130),
              padding: padding ?? const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        title ?? "",
                        style: Platform.isIOS
                            ? const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
                            : const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                      ),
                    ),
                  if (message != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        message ?? "",
                        style: Platform.isIOS
                            ? TextStyle(fontSize: 16, color: messageColor ?? Colors.black, height: 1.5)
                            : TextStyle(
                                fontSize: 14,
                                color: messageColor ?? Colors.black,
                                height: 1.5,
                              ),
                      ),
                    ),
                  if (content != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: content,
                    ),
                  if (messageTextSpan != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: RichText(text: messageTextSpan),
                    ),
                  if (hiddenButton == false && buttonVertical == true)
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 15, 10),
                      child: Column(
                        children: [
                          GradientButton(
                            gradient: const LinearGradient(
                              colors: [Colors.orange, Colors.red, Colors.orange],
                            ),
                            borderRadius: BorderRadius.circular(22),
                            onPressed: confirm ?? () => dismissAlertDialog(),
                            child: Text(confirmText!, style: const TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                          const SizedBox(height: 10),
                          GradientButton(
                            gradient: const LinearGradient(
                              colors: [Colors.orange, Colors.red, Colors.orange],
                            ),
                            borderRadius: BorderRadius.circular(22),
                            onPressed: middle ?? () => dismissAlertDialog(),
                            child: Text(middleText!, style: const TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                          const SizedBox(height: 10),
                          //是否隐藏【取消按钮】
                          Visibility(
                            //如果是false就【说明不隐藏【取消】按钮】，那么就展开【取消按钮】
                            visible: (isHiddenCancelButton==false),
                            child: MyMaterialButton(
                              color: Colors.transparent,
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              borderRadius: BorderRadius.circular(22),
                              onPressed: cancel ?? () => dismissAlertDialog(),
                              child: Text("$cancelText", style: const TextStyle(fontSize: 16, color: Colors.blue)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  //是否按钮垂直等于false.就是水平摆放按钮。
                  if (hiddenButton == false && buttonVertical == false)
                    Container(
                      padding: Platform.isIOS ? const EdgeInsets.only(top: 5) : const EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Row(children: [
                        Expanded(
                          child: TextButton(
                              onPressed: cancel ?? () => dismissAlertDialog(),
                              style: ButtonStyle(
                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                                  // fixedSize: MaterialStateProperty.all(const Size(150, 40)),
                                  padding: WidgetStateProperty.all(const EdgeInsets.only(left: 20, right: 20)),
                                  side: WidgetStateProperty.all(const BorderSide(width: 0.67, color: Colors.red)),
                                  backgroundColor: WidgetStateProperty.all(Colors.transparent)),
                              child: Text("$cancelText", style: const TextStyle(fontSize: 16, color: Colors.red))),
                        ),
                        Platform.isIOS ? const SizedBox(width: 10) : const SizedBox(width: 10),
                        Expanded(
                          child: GradientButton(
                            gradient: const LinearGradient(
                              colors: [Colors.orange, Colors.red],
                            ),
                            borderRadius: BorderRadius.circular(22),
                            onPressed: confirm ?? () => dismissAlertDialog(),
                            child: Text(confirmText!, style: const TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ]),
                    ),
                ],
              ),
            ),
          );
        });
      });
}

//android端特用的APP更新弹窗小弹窗
/*showAlertDialogDownLodAPK(
    {String? title, //
    String? message, //
    Color? messageColor, //
    InlineSpan? messageTextSpan, //
    EdgeInsetsGeometry? margin, //
    EdgeInsetsGeometry? padding, //
    Widget? content, //下载组件？
    String? confirmText = "应用市场更新",
    String? middleText = "服务器下载",
    String? cancelText = "取消",
    VoidCallback? confirm, //
    VoidCallback? middle, //
    VoidCallback? cancel}) async {
  SmartDialog.show(
      alignment: Alignment.center,
      maskColor: Colors.black54,
      //clickMaskDismiss: false,
      onMask: () => FocusManager.instance.primaryFocus?.unfocus(),
      backType: SmartBackType.normal,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Container(
            margin: margin ?? const EdgeInsets.only(left: 30, right: 30, bottom: 130),
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(title ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(message ?? "", style: TextStyle(fontSize: 15, color: messageColor ?? Colors.black, height: 1.5)),
                  ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonTools.createButton(cancelText!, textColor: Colors.black, boxBackgroundColor: ThemeColor, onPressed: () {
                      cancel!();
                    }),
                    CommonTools.createButton(middleText!, textColor: Colors.black, boxBackgroundColor: ThemeColor, onPressed: () {
                      middle!();
                    }),
                    CommonTools.createButton(confirmText!, textColor: Colors.black, boxBackgroundColor: ThemeColor, onPressed: () {
                      confirm!();
                    }),
                  ],
                ),
              ],
            ),
          );
        });
      });
}*/

//一个单独的取消按钮
showAlertDialogSingleButton(
    {String? title = "提示", //
    String? message, //
    Color? messageColor, //
    InlineSpan? messageTextSpan, //
    EdgeInsetsGeometry? margin, //
    EdgeInsetsGeometry? padding, //
    String? cancelText = "关  闭",
    VoidCallback? cancel}) async {
  SmartDialog.show(
      alignment: Alignment.center,
      maskColor: Colors.black54,
      onMask: () => FocusManager.instance.primaryFocus?.unfocus(),
      backType: SmartBackType.normal,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Container(
            margin: margin ?? const EdgeInsets.only(left: 30, right: 30, bottom: 130),
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(title ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(message ?? "", style: TextStyle(fontSize: 15, color: messageColor ?? Colors.black, height: 1.5)),
                  ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonTools.createButtonMy(cancelText!, textColor: Colors.black, heightMy: 30.0, paddingLMy: 30.0, paddingRMy: 30.0, boxBorderColor: ThemeColor, boxBackgroundColor: Colors.white, onPressed: () {
                      cancel!();
                    }),
                  ],
                ),
              ],
            ),
          );
        });
      });
}

//一个白色弹窗没有消息没有按钮
showAlertDialogSingleNoMessageNoButton(
    {String? title = "提示", //
    String? message, //
    Color? messageColor, //
    InlineSpan? messageTextSpan, //
    EdgeInsetsGeometry? margin, //
    EdgeInsetsGeometry? padding, //
    VoidCallback? confirm, //
    VoidCallback? middle, //
    VoidCallback? cancel}) async {
  SmartDialog.show(
      alignment: Alignment.center,
      maskColor: Colors.black54,
      onMask: () => FocusManager.instance.primaryFocus?.unfocus(),
      backType: SmartBackType.normal,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Container(
            margin: margin ?? const EdgeInsets.only(left: 30, right: 30, bottom: 130),
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(title ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                if (message != null)
                  Padding(
                    //padding: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(message ?? "", style: TextStyle(fontSize: 15, color: messageColor ?? Colors.black, height: 1.5)),
                  ),
                const SizedBox(height: 10),
              ],
            ),
          );
        });
      });
}
