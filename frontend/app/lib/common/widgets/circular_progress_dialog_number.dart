import 'package:flutter/material.dart';
import 'package:get/get.dart';

///@description 带数字的进度圈
///@updateTime 2024/11/12 19:25
class NumberController extends GetxController {
  String message = "图片下载中";
  //圈圈的默认展示进度
  double circleNumber = 0;

  //更新进度圈圈下边的文字。
  void updateNumberProgress(String lastTimeValue, int number, int totalLength) {
    circleNumber = (number / totalLength);
    message = lastTimeValue;
    update(["numberControllerProgress"]);
  }

  @override
  void onClose() {
    //logger.d("onClose--onClose-onClose");
    message = "图片下载中";
    circleNumber = 0;
    super.onClose();
  }
}

///@description 下载图片的进度圈圈
///@updateTime 2024/11/12 19:24
class CircularProgressDialogNumber extends GetView<NumberController> {
  CircularProgressDialogNumber({super.key});
  final ValueNotifier<double> progressNotifier = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ValueListenableBuilder<double>(
        valueListenable: progressNotifier,
        builder: (context, value, child) {
          return GetBuilder<NumberController>(
            id: "numberControllerProgress",
            builder: (logic) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 6),
                  CircularProgressIndicator(
                    value: controller.circleNumber,
                    backgroundColor: Colors.grey[100],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  const SizedBox(height: 12),
                  //Text("${(value * 100).toStringAsFixed(0)}%", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(
                    controller.message,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
