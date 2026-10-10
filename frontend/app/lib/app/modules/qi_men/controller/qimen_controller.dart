import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/global.dart';
import '../../zhouyi/algorithm/qimen_calculator.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import '../../zhouyi/algorithm/zy_datetime_model.dart';

/// 结果页入参
class QiMenResultArgs {
  const QiMenResultArgs({
    required this.model,
    required this.method,
    required this.showAnGan,
    required this.showDiBaShen,
  });

  final ZYHourQimenModel model;
  final QimenMethod method;
  final bool showAnGan;
  final bool showDiBaShen;
}

/// 奇门遁甲输入页控制器（对应安卓 QiMenMainFragment）。
class QiMenInputController extends GetxController {
  final QimenCalculator _calculator = QimenCalculator();

  /// 起局时间
  final selectedTime = DateTime.now().obs;

  /// 局式：拆补 / 置闰
  final method = QimenMethod.chaibu.obs;

  /// 盘式选项：暗干飞支
  final showAnGan = false.obs;

  /// 盘式选项：地盘八神
  final showDiBaShen = false.obs;

  /// 排盘进行中
  final calculating = false.obs;

  /// 重置为当前时间
  void resetToNow() => selectedTime.value = DateTime.now();

  void setMethod(QimenMethod value) => method.value = value;

  void setShowAnGan(bool value) => showAnGan.value = value;

  void setShowDiBaShen(bool value) => showDiBaShen.value = value;

  /// 起局并跳转结果页
  Future<void> start() async {
    if (calculating.value) return;
    calculating.value = true;
    // 让 loading 状态先渲染一帧，置闰法需要向前回溯较久
    await Future<void>.delayed(Duration.zero);
    try {
      final model = _calculator.calculate(
        ZYDatetimeModel.fromDateTime(selectedTime.value),
        method: method.value,
      );
      Get.toNamed(
        Routes.QIMENRESULTPAGE,
        arguments: QiMenResultArgs(
          model: model,
          method: method.value,
          showAnGan: showAnGan.value,
          showDiBaShen: showDiBaShen.value,
        ),
      );
    } on QimenException catch (e) {
      showMessage(e.message);
    } finally {
      calculating.value = false;
    }
  }
}
