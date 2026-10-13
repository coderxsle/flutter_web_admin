import 'package:yun_men_yi_pan/app/modules/launching/material.dart';
import 'package:yun_men_yi_pan/app/modules/qi_men/controller/qimen_controller.dart';
import 'package:yun_men_yi_pan/app/modules/qi_men/page/qimen_input_page.dart';
import 'package:yun_men_yi_pan/app/modules/qi_men/page/qimen_result_page.dart';
import 'package:yun_men_yi_pan/app/modules/qi_men/widget/qimen_grid_panel.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/qimen_calculator.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/zy_datetime_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

/// 与 my_app.dart 的 ScreenUtilInit 配置保持一致
Widget _host(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    splitScreenMode: true,
    minTextAdapt: true,
    useInheritedMediaQuery: true,
    ensureScreenSize: true,
    enableScaleWH: () => true,
    enableScaleText: () => true,
    rebuildFactor: RebuildFactors.size,
    fontSizeResolver: FontSizeResolvers.height,
    builder: (context, _) => GetMaterialApp(
      theme: setupTheme(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Scaffold(body: child)),
        GetPage(name: '/result', page: () => const QiMenResultPage()),
      ],
    ),
  );
}

/// 年度扫描挂在 Future.delayed(Duration.zero) 上，必须推进假时钟才会触发，
/// 每推进一次排空一层，最后一次留下的空定时器就不会在 teardown 报错。
Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  for (var i = 0; i < 4; i++) {
    await tester.pump(const Duration(milliseconds: 300));
  }
}

void main() {
  for (final size in const [
    Size(320, 700),
    Size(390, 844),
    Size(430, 932),
    Size(800, 1280),
  ]) {
    testWidgets('输入页 ${size.width.toInt()}x${size.height.toInt()} 不溢出',
        (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      Get.put(QiMenInputController());
      addTearDown(Get.reset);

      await tester.pumpWidget(_host(const QiMenInputPage()));
      await _settle(tester);

      expect(tester.takeException(), isNull);
      expect(find.text('时间'), findsOneWidget);
      expect(find.text('局式'), findsOneWidget);
      expect(find.text('盘式'), findsOneWidget);
      expect(find.text('开始排盘'), findsOneWidget);
      expect(find.text('两法用局对比'), findsOneWidget);

      final start = tester.getSize(find.text('开始排盘').first);
      final methodRow = tester.getSize(find.text('局式'));
      // ignore: avoid_print
      print('输入页 ${size.width.toInt()}x${size.height.toInt()}: '
          '开始排盘 按钮文字 $start，局式标签 $methodRow');
    });

    testWidgets('结果页 ${size.width.toInt()}x${size.height.toInt()} 不溢出',
        (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      final model = QimenCalculator().calculate(
        ZYDatetimeModel.fromDateTime(DateTime(2026, 6, 20, 12)),
      );

      await tester.pumpWidget(_host(const SizedBox.shrink()));
      await _settle(tester);
      Get.toNamed(
        '/result',
        arguments: QiMenResultArgs(
          model: model,
          method: QimenMethod.chaibu,
          showAnGan: true,
          showDiBaShen: true,
        ),
      );
      await _settle(tester);

      expect(tester.takeException(), isNull);
      expect(find.text('起局信息'), findsOneWidget);
      expect(find.text('十干克应'), findsOneWidget);
      expect(find.text('占事'), findsOneWidget);

      // 九宫格一格的宽高比：越接近手机上的比例，大屏上越不会拉成长条
      final cell = find.byType(QiMenGridPanel);
      expect(cell, findsOneWidget);
      final grid = tester.getSize(cell);
      // ignore: avoid_print
      print('结果页 ${size.width.toInt()}x${size.height.toInt()}: '
          '九宫格 ${grid.width.toStringAsFixed(1)}x${grid.height.toStringAsFixed(1)}，'
          '单格宽 ${(grid.width / 3).toStringAsFixed(1)} 高 ${(grid.height / 3).toStringAsFixed(1)}');
    });
  }

  testWidgets('点「回到现在」把起局时间拨回此刻', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final controller = Get.put(QiMenInputController());
    addTearDown(Get.reset);
    controller.selectedTime.value = DateTime(2000, 1, 1, 8, 30);

    await tester.pumpWidget(_host(const QiMenInputPage()));
    await _settle(tester);

    expect(find.text('回到现在'), findsOneWidget);
    expect(find.textContaining('2000年01月01日'), findsOneWidget);

    await tester.tap(find.text('回到现在'));
    await _settle(tester);

    expect(controller.selectedTime.value.year, DateTime.now().year);
    expect(controller.selectedTime.value.month, DateTime.now().month);
    expect(find.textContaining('2000年01月01日'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
