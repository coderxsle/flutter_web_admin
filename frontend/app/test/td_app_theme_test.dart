import 'package:yun_men_yi_pan/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

void main() {
  const tdesignDefaultBrand = Color(0xFF0052D9);

  test('主题 JSON 能解析出红色品牌色', () {
    expect(themeData.brandColor7, TdColors.brand);
    expect(themeData.brandColor, TdColors.brand);
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
    expect(themeData.textColorPlaceholder, TdColors.grey153);
    expect(themeData.textColorDisabled, TdColors.grey195);
    expect(themeData.componentStroke, TdColors.grey225);
    expect(themeData.componentBorder, TdColors.grey225);
    expect(themeData.borderLevel1Color, TdColors.grey225);
    expect(themeData.borderLevel2Color, TdColors.grey195);
  });

  test('中性色不残留 TDesign 默认灰', () {
    final tdesignGrays = {
      Color(0xFFF3F3F3),
      Color(0xFFEEEEEE),
      Color(0xFFE8E8E8),
      Color(0xFFDCDCDC),
      Color(0xFFC5C5C5),
      Color(0xFFA6A6A6),
    };
    final tokened = {
      themeData.bgColorPage,
      themeData.bgColorContainer,
      themeData.bgColorSecondaryContainer,
      themeData.componentStroke,
      themeData.componentBorder,
    };
    expect(tokened.intersection(tdesignGrays), isEmpty);
  });

  test('搜索框底色与页面底色可区分', () {
    expect(themeData.bgColorSecondaryContainer, isNot(themeData.bgColorPage));
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
    expect(captured?.brandColor, TdColors.brand);
    expect(captured?.brandColor, isNot(tdesignDefaultBrand));
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

  testWidgets('TDesign 单选框组在新主题下正常渲染', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: [themeData]),
        home: Scaffold(
          body: TRadioGroup<int>.options(
            value: 1,
            onChanged: (_) {},
            options: const [
              TRadioOption(value: 1, label: '选项一'),
              TRadioOption(value: 2, label: '选项二'),
            ],
          ),
        ),
      ),
    );
    expect(find.text('选项一'), findsOneWidget);
    expect(themeOf(tester.element(find.text('选项一'))).brandColor, TdColors.brand);
  });
}
