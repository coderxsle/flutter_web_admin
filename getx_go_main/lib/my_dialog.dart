import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'gradient_button.dart';

// 关闭当前的正在加载...
Future<void> dismissLoading() async {
  await SmartDialog.dismiss(force: true, status: SmartStatus.loading);
}

/// 关闭弹出框
Future<void> dismissAlertDialog() async {
  await SmartDialog.dismiss(force: true);
}

Future<void> showLoadingMessage(String message) async {
  const time = Duration(seconds: 20);
  await SmartDialog.showLoading(msg: message, displayTime: time, usePenetrate: false);
  SmartDialog.dismiss(status: SmartStatus.loading);
}

// 提示
Future<void> showMessage(String message) async {
  final charDisplayTime = 0.10;
  var displayTime = (message.length * charDisplayTime).ceil();
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
Future<void> showMessageBottomLikeAndroid(String message, {required bool isLong}) async {
  SmartDialog.showToast(message, //
      displayType: SmartToastType.onlyRefresh, //
      displayTime: Duration(seconds: isLong ? 2 : 1));
}

Future<void> showDebugMessage(String message) async {
  if (kDebugMode) showAlertMessage(message);
}

// 提示操作成功
Future<void> showSuccessMessage(String message) async {
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
Future<void> showFailureMessage(String message) async {
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
Future<void> showAlertMessage(String message) async {
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


// 弹窗
Future<void> showAlertDialog(
    {String? title,
    TextStyle? titleStyleMy,
    String? message,
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
            margin: margin ?? const EdgeInsets.only(left: 50, right: 50),
            padding: padding ?? const EdgeInsets.all(20),
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
                    padding: EdgeInsets.only(bottom: titleImage != null ? 30 : 10),
                    child: Text(title, style: titleStyleMy??TextStyle(fontSize: 20, color: titleImage != null ? Colors.white : Colors.black, fontWeight: FontWeight.w600)),
                  ),
                // 固定的消息部分
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(message, style: TextStyle(fontSize: 14, color: messageColor ?? Colors.black, height: 1.5)),
                  ),
                if (messageTextSpan != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: RichText(text: messageTextSpan, strutStyle: StrutStyle(fontSize: 14)),
                  ),
                // 可滚动的内容部分
                if (content != null)
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: content,
                      ),
                    ),
                  ),
                // 固定的按钮部分
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
                          child: Text(confirmText!, style: TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                        if (cancelText != null) SizedBox(height: 10),
                        if (cancelText != null) SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              onPressed: cancel ?? () => dismissAlertDialog(),
                              style: ButtonStyle(
                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                                  side: WidgetStateProperty.all(const BorderSide(width: 0.67, color: Colors.red)),
                                  backgroundColor: WidgetStateProperty.all(Colors.transparent)),
                              child: Text(cancelText, style: TextStyle(fontSize: 15, color: Colors.red))),
                        ),
                      ],
                    ),
                  ),
                if (hiddenButton == false && buttonVertical == false)
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                    child: Row(children: [
                      if (cancelText != null) Expanded(
                        child: TextButton(
                            onPressed: cancel ?? () => dismissAlertDialog(),
                            style: ButtonStyle(
                                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                                padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
                                side: WidgetStateProperty.all(const BorderSide(width: 0.67, color: Colors.red)),
                                backgroundColor: WidgetStateProperty.all(Colors.transparent)),
                            child: Text(cancelText, style: TextStyle(fontSize: 15, color: Colors.red))),
                      ),
                      if (cancelText != null) SizedBox(width: 10),
                      Expanded(
                        child: GradientButton(
                          gradient: const LinearGradient(
                            colors: [Colors.orange, Colors.red],
                          ),
                          borderRadius: BorderRadius.circular(22),
                          onPressed: confirm ?? () => dismissAlertDialog(),
                          child: Text(confirmText!, style: TextStyle(fontSize: 15, color: Colors.white)),
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
