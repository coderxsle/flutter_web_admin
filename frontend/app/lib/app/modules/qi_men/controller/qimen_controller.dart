import 'dart:async';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/global.dart';
import '../../zhouyi/algorithm/qimen_calculator.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import '../../zhouyi/algorithm/zy_datetime_model.dart';
import '../service/qimen_record_sync.dart';

/// 结果页入参
class QiMenResultArgs {
  const QiMenResultArgs({
    required this.model,
    required this.method,
    required this.showAnGan,
    required this.showDiBaShen,
    required this.clientKey,
    required this.chartTime,
    this.question = '',
    this.interpretation = '',
    this.feedback = '',
  });

  final ZYHourQimenModel model;
  final QimenMethod method;
  final bool showAnGan;
  final bool showDiBaShen;

  /// 本次排盘的记录键，结果页保存时沿用
  final String clientKey;

  /// 起局时间，与落库的 chart_time 一致
  final DateTime chartTime;

  /// 历史回看时带回的占事/卦解/反馈，现场起局时为空
  final String question;
  final String interpretation;
  final String feedback;
}

/// 奇门遁甲输入页控制器（对应安卓 QiMenMainFragment）。
class QiMenInputController extends GetxController {
  final QimenCalculator _calculator = QimenCalculator();

  /// 起局时间
  final selectedTime = DateTime.now().obs;

  /// 局式：拆补 / 置闰
  final method = QimenMethod.zhirun.obs;

  /// 盘式选项：暗干飞支，默认勾选
  final showAnGan = true.obs;

  /// 盘式选项：地盘八神，默认勾选
  final showDiBaShen = true.obs;

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
      final clientKey = QimenRecordSync.newClientKey();

      // 排盘即落一条记录；占事/卦解留到结果页保存时用同一 clientKey 补齐
      unawaited(
        QimenRecordSync.report(
          clientKey: clientKey,
          chartTime: selectedTime.value,
          method: method.value,
          showAnGan: showAnGan.value,
          showDiBaShen: showDiBaShen.value,
          model: model,
        ),
      );

      Get.toNamed(
        Routes.QIMENRESULTPAGE,
        arguments: QiMenResultArgs(
          model: model,
          method: method.value,
          showAnGan: showAnGan.value,
          showDiBaShen: showDiBaShen.value,
          clientKey: clientKey,
          chartTime: selectedTime.value,
        ),
      );
    } on QimenException catch (e) {
      showMessage(e.message);
    } finally {
      calculating.value = false;
    }
  }
}
