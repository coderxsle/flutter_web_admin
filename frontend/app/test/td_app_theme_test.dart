import 'package:yun_men_yi_pan/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

void main() {
  const tdesignDefaultBrand = Color(0xFF0052D9);

  test('主题 JSON 能解析出红色品牌色', () {
    expect(themeData.brandColor7, TdColors.brand);
    expect(themeData.brandNormalColor, TdColors.brand);
    expect(themeData.textColorBrand, TdColors.brand);
  });

  test('品牌色阶整段覆盖，不残留 TDesign 默认蓝', () {
    final ramp = [
      themeData.brandColor1,
      themeData.brandColor2,
      themeData.brandColor3,
      themeData.brandColor4,
      themeData.brandColor5,
      themeData.brandColor6,
      themeData.brandColor7,
      themeData.brandColor8,
      themeData.brandColor9,
      themeData.brandColor10,
    ];
    for (final color in ramp) {
      expect(color, isNot(tdesignDefaultBrand));
    }
  });

  test('基础 token 与项目原值一致', () {
    expect(themeData.bgColorPage, TdColors.pageBg);
    expect(themeData.bgColorContainer, TdColors.white);
    expect(themeData.textColorPrimary, TdColors.textPrimary);
    expect(themeData.textColorSecondary, TdColors.grey85);
    expect(themeData.textColorAnti, TdColors.white);
  });

  testWidgets('注入后组件上下文读到的就是红色主题', (tester) async {
    TThemeData? captured;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: [themeData]),
        home: Builder(
          builder: (context) {
            captured = themeOf(context);
            return const SizedBox();
          },
        ),
      ),
    );
    expect(captured?.brandNormalColor, TdColors.brand);
    expect(captured?.brandNormalColor, isNot(tdesignDefaultBrand));
  });

  testWidgets('TDesign 复选框选中色跟随品牌红', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: [themeData]),
        home: Scaffold(
          body: TCheckbox(value: true, onChanged: (_) {}),
        ),
      ),
    );
    final icon = tester.widget<Icon>(find.byType(Icon).first);
    expect(icon.color, TdColors.brand);
    expect(icon.color, isNot(tdesignDefaultBrand));
  });

  testWidgets('TDesign 单选框选中色跟随品牌红', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: [themeData]),
        home: Scaffold(
          body: TRadio<int>(value: 1, groupValue: 1, onChanged: (_) {}),
        ),
      ),
    );
    final painter = tester
        .widgetList<CustomPaint>(find.byType(CustomPaint))
        .map((e) => e.painter)
        .firstWhere((p) => p.runtimeType.toString().contains('RadioIndicator'));
    final color = (painter as dynamic).color as Color;
    expect(color, TdColors.brand);
    expect(color, isNot(tdesignDefaultBrand));
  });
}
