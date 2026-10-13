import 'package:yun_men_yi_pan/app/modules/qi_men/widget/qimen_method_compare_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// 与 my_app.dart 的 ScreenUtilInit 配置保持一致，量到的就是真机上的样子。
/// 注意 fontSizeResolver 取 height，字号按屏高比例缩放而非屏宽，手算容易估错。
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
    builder: (context, _) => MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 20.h),
          child: child,
        ),
      ),
    ),
  );
}

/// 换行后文字高度会超过宽度，据此判断是否被挤出了第二行
void _expectSingleLine(WidgetTester tester, String label) {
  final size = tester.getSize(find.text(label));
  expect(size.height, lessThan(size.width), reason: '$label 被挤换行了：$size');
}

void main() {
  const tabs = ['对照', '概览', '明细', '表格'];

  for (final width in [320.0, 360.0, 390.0]) {
    testWidgets('${width.toInt()}pt 屏下标题与四个页签同排且不换行', (tester) async {
      tester.view.physicalSize = Size(width, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        _host(QimenMethodCompareCard(time: DateTime(2026, 6, 20, 12))),
      );
      await tester.pump();
      // 全年扫描在首帧之后跑，这里让它算完
      await tester.pump(const Duration(milliseconds: 200));

      _expectSingleLine(tester, '两法用局对比');

      final report = <String>[];
      for (final label in tabs) {
        _expectSingleLine(tester, label);
        final box = find
            .ancestor(of: find.text(label), matching: find.byType(Container))
            .first;
        final boxWidth = tester.getSize(box).width;
        final textWidth = tester.getSize(find.text(label)).width;
        report.add('$label ${boxWidth.toStringAsFixed(1)}/'
            '${textWidth.toStringAsFixed(1)}');
        expect(boxWidth, greaterThan(textWidth), reason: '$label 页签无余量');
      }
      // ignore: avoid_print
      print('${width.toInt()}pt 页签 容器/文字：${report.join('，')}');
    });
  }

  testWidgets('页签顺序为 对照 / 概览 / 明细 / 表格，且与视图一一对应', (tester) async {
    tester.view.physicalSize = const Size(390, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      _host(QimenMethodCompareCard(time: DateTime(2026, 6, 20, 12))),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    final centers = [
      for (final label in tabs) tester.getCenter(find.text(label)).dx,
    ];
    for (var i = 1; i < centers.length; i++) {
      expect(centers[i - 1], lessThan(centers[i]),
          reason: '页签左右顺序不对：$centers');
    }

    // 明细在前、表格在后，页签与所切换的视图不能错位
    await _gotoTab(tester, '明细');
    expect(find.textContaining('拆补 '), findsWidgets, reason: '明细页没显示明细行');

    await _gotoTab(tester, '表格');
    expect(find.text('区间'), findsOneWidget, reason: '表格页没显示表头');
    expect(find.text('置闰'), findsOneWidget, reason: '表格页没显示表头');
  });

  testWidgets('区间日期不补前导零', (tester) async {
    tester.view.physicalSize = const Size(390, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      _host(QimenMethodCompareCard(time: DateTime(2026, 6, 20, 12))),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await _gotoTab(tester, '表格');

    expect(find.text('1-5 子时'), findsOneWidget, reason: '单日区间补了前导零');
    expect(find.text('1-20 子时'), findsOneWidget, reason: '单日区间补了前导零');

    // 跨日区间在列表下方，滚到可见再查
    await tester.scrollUntilVisible(
      find.text('6-19 ~ 6-21'),
      40,
      scrollable: find
          .descendant(of: find.byType(ListView), matching: find.byType(Scrollable))
          .first,
    );
    expect(find.text('6-19 ~ 6-21'), findsOneWidget, reason: '跨日区间格式不对');
  });
}

/// 点页签后要等翻页动画结束，再给新页一帧做布局，否则查不到新页的组件
Future<void> _gotoTab(WidgetTester tester, String label) async {
  await tester.tap(find.text(label));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
  await tester.pump();
}
