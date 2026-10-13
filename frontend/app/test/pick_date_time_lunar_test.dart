import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' as mui;
import 'package:yun_men_yi_pan/app/modules/zhouyi/widget/pick_date_time.dart';

/// 与 launching/material.dart 一致：插件取的是 material_ui 那套 MaterialLocalizations，
/// 不额外注册它就会在 showDatePicker 里报 No MaterialLocalizations found。
Widget _host(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [mui.GlobalMaterialLocalizations.delegate],
    home: Scaffold(body: Center(child: child)),
  );
}

Future<void> _openPicker(WidgetTester tester, DateTime initial) async {
  await tester.pumpWidget(
    _host(
      Builder(
        builder: (context) => TextButton(
          onPressed: () => pickDateTime(context, initial: initial),
          child: const Text('open'),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

/// 日轮条目形如「20日」，itemExtent 36，向上拖一格加一天。
Finder _dayItem(int day) => find.text('$day日');

Finder _lunarLine(String text) => find.textContaining(text);

void main() {
  testWidgets('日期弹窗标题栏同时显示公历与农历', (tester) async {
    await _openPicker(tester, DateTime(2026, 6, 20, 12));

    expect(_lunarLine('2026 年 6 月 20 日 · 农历五月初六'), findsOneWidget);
    // 标题栏被整体接管，取消/确定不能丢
    expect(find.text('取消'), findsOneWidget);
    expect(find.text('确定'), findsOneWidget);
  });

  testWidgets('拖动日轮松手后农历跟着变', (tester) async {
    await _openPicker(tester, DateTime(2026, 6, 20, 12));

    await tester.drag(_dayItem(20), const Offset(0, -36));
    await tester.pumpAndSettle();

    expect(_lunarLine('2026 年 6 月 21 日 · 农历五月初七'), findsOneWidget);
  });

  testWidgets('拖住不放时农历已经跟着滚轮变', (tester) async {
    await _openPicker(tester, DateTime(2026, 6, 20, 12));

    final gesture = await tester.startGesture(tester.getCenter(_dayItem(20)));
    await gesture.moveBy(const Offset(0, -36));
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }

    // 手指还没抬起来，标题栏就该是新日期
    expect(_lunarLine('2026 年 6 月 21 日 · 农历五月初七'), findsOneWidget);

    await gesture.up();
    await tester.pumpAndSettle();
    expect(_lunarLine('2026 年 6 月 21 日 · 农历五月初七'), findsOneWidget);
  });

  testWidgets('拖月轮换月后农历月份跟着换', (tester) async {
    await _openPicker(tester, DateTime(2026, 6, 15, 12));
    expect(_lunarLine('2026 年 6 月 15 日 · 农历五月初一'), findsOneWidget);

    // 日轮只列当月的天，跨月要拖中间那列月轮
    await tester.drag(find.text('6月'), const Offset(0, -36));
    await tester.pumpAndSettle();

    expect(_lunarLine('2026 年 7 月 15 日 · 农历六月初二'), findsOneWidget);
  });
}
