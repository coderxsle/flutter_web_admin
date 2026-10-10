import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'gradient_button.dart';

class AlertDialogUtils {
  static void show({
    String? title,
    String? message,
    Color? messageColor,
    String? titleImage,
    InlineSpan? messageTextSpan,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Widget? content,
    bool buttonVertical = false,
    bool hiddenButton = false,
    String confirmText = "确定",
    String cancelText = "取消",
    VoidCallback? confirm,
    VoidCallback? cancel,
  }) {
    SmartDialog.show(
      clickMaskDismiss: hiddenButton,
      alignment: Alignment.center,
      maskColor: Colors.black54,
      onMask: () => FocusManager.instance.primaryFocus?.unfocus(),
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            margin: margin ?? const EdgeInsets.only(left: 30, right: 30, bottom: 130),
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: titleImage != null
                ? DecorationImage(image: AssetImage(titleImage), alignment: Alignment.topCenter, fit: BoxFit.fitWidth)
                : null,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (title != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: titleImage != null ? 30 : 10),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600,
                          color: titleImage != null ? Colors.white : Colors.black
                      ),
                    ),
                  ),
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(message, style: TextStyle(fontSize: 14, color: messageColor ?? Colors.black, height: 1.5)),
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
                if (hiddenButton == false && buttonVertical)
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 15, 10),
                    child: Column(
                      children: [
                        GradientButton(
                          onPressed: () {
                            dismiss();
                            if (confirm  != null) confirm();
                          },
                          borderRadius: BorderRadius.circular(22),
                          gradient: const LinearGradient(colors: [Colors.orange, Colors.red, Colors.orange]),
                          child: Text(confirmText, style: const TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: cancel ?? () => dismiss(),
                          child: Text(cancelText, style: const TextStyle(fontSize: 16, color: Colors.blue)),
                        ),
                      ],
                    ),
                  ),
                if (hiddenButton == false && !buttonVertical)
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                    child: Row(children: [
                      Expanded(
                        child: TextButton(
                          onPressed: cancel ?? () => dismiss(),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.transparent),
                            padding: WidgetStateProperty.all(const EdgeInsets.only(left: 20, right: 20)),
                            side: WidgetStateProperty.all(const BorderSide(width: 0.67, color: Colors.red)),
                            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                          ),
                          child: Text(cancelText, style: const TextStyle(fontSize: 16, color: Colors.red)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GradientButton(
                          onPressed: () {
                            dismiss();
                            if (confirm  != null) confirm();
                          },
                          borderRadius: BorderRadius.circular(22),
                          gradient: const LinearGradient(colors: [Colors.orange, Colors.red]),
                          child: Text(confirmText, style: const TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ]),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> dismiss() async {
    await SmartDialog.dismiss(force: true);
  }

}