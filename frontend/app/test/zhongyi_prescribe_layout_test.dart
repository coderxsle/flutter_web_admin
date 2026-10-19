import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/controller/zhongyi_prescribe_controller.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/page/zhongyi_prescribe_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/service/zhongyi_domain.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/widget/zhongyi_ui.dart';

/// 不拉患者列表：测试里不发真实请求，也就不会留下待跑的 Timer。
class _OfflineController extends ZhongyiPrescribeController {
  @override
  Future<void> loadPatients() async {}
}

List<String> _drain(WidgetTester tester) {
  final messages = <String>[];
  Object? error;
  while ((error = tester.takeException()) != null) {
    messages.add(error.toString());
  }
  return messages;
}

/// [width] 为逻辑宽度，[textScale] 模拟系统字体放大。
Future<void> _pumpPage(WidgetTester tester, {double width = 375, double textScale = 1.0}) async {
  tester.view.physicalSize = Size(width * 3, 812 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final controller = _OfflineController();
  controller.lines.add(ZhongyiPrescriptionLine(
    medicineId: 1,
    name: '滑石粉炒甘草',
    unit: 'g',
    purchasePrice: 0.5,
    salePrice: 1.2,
    stockQuantity: 500,
    dosageGrams: 12.5,
  ));
  Get.put<ZhongyiPrescribeController>(controller);
  addTearDown(Get.reset);
  await tester.pumpWidget(ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (context, child) => MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
        child: child!,
      ),
      home: const ZhongyiPrescribePage(),
    ),
  ));
  await tester.pump();
}

void main() {
  testWidgets('开方结算页的输入框不高出容器，也不横向溢出', (tester) async {
    for (final width in [375.0, 320.0]) {
      for (final scale in [1.0, 1.3]) {
        await _pumpPage(tester, width: width, textScale: scale);
        final reason = '$width 宽 / 字号 $scale';

        // 之前患者 / 电话 / 剂数用定高 38、单剂用量用定高 32 套 TInput，普遍溢出 18px。
        expect(_drain(tester), isEmpty, reason: '$reason：不应有任何溢出或异常');
        expect(find.byType(ZhongyiFormInput), findsNWidgets(4), reason: '$reason：患者 / 电话 / 剂数 / 单剂用量');

        final name = tester.getRect(find.byType(ZhongyiFormInput).first);
        expect(
          tester.getRect(find.text('输入患者姓名')).center.dy,
          closeTo(name.center.dy, 1),
          reason: '$reason：hint 应在输入框内垂直居中',
        );

        final dosage = tester.getRect(find.byType(ZhongyiFormInput).last);
        expect(dosage.height, greaterThanOrEqualTo(32), reason: '$reason：单剂用量高度 ${dosage.height}');
        expect(
          tester.getRect(find.text('单剂')).center.dy,
          closeTo(dosage.center.dy, 8),
          reason: '$reason：单剂文案与用量框应基本同高',
        );
      }
    }
  });
}
