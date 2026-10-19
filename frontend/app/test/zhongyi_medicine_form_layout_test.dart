import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:yun_men_yi_pan/app/theme/app_theme.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/model/zhongyi_model.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/page/zhongyi_medicine_edit_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/widget/zhongyi_medicine_profile_form.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/service/zhongyi_domain.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/widget/zhongyi_sheet.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/widget/zhongyi_ui.dart';

const _medicine = ZhongyiMedicine(
  id: 1,
  medicineCode: 'M1',
  prefix: '滑石粉炒',
  name: '甘草',
  pinyin: 'gancao',
  category: 'herb',
);

/// 表单宿主；[width] 为逻辑宽度，用来模拟窄屏。
Future<void> _pumpForm(WidgetTester tester, {double width = 375, ZhongyiMedicine? medicine}) async {
  tester.view.physicalSize = Size(width * 3, 812 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (context, child) => MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(child: ZhongyiMedicineProfileForm(medicine: medicine)),
      ),
    ),
  ));
  await tester.pump();
}

/// 取走本次 pump 记录的全部异常文案。
List<String> _drainExceptions(WidgetTester tester) {
  final messages = <String>[];
  Object? error;
  while ((error = tester.takeException()) != null) {
    messages.add(error.toString());
  }
  return messages;
}

/// 取分类标签胶囊的底色。
Color _chipColor(WidgetTester tester, String label) {
  final finder = find.ancestor(of: find.text(label), matching: find.byType(Container)).first;
  return (tester.widget<Container>(finder).decoration as BoxDecoration).color!;
}

void main() {
  testWidgets('前缀标签在 Wrap 里按内容收缩，一行排多个', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 300,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  ZhongyiPrefixChip('酒', selected: true),
                  ZhongyiPrefixChip('醋'),
                  ZhongyiPrefixChip('滑石粉炒'),
                ],
              ),
            ),
          ),
        ),
      ),
    ));

    final wine = tester.getSize(find.widgetWithText(ZhongyiPrefixChip, '酒'));
    final vinegar = tester.getSize(find.widgetWithText(ZhongyiPrefixChip, '醋'));
    final long = tester.getSize(find.widgetWithText(ZhongyiPrefixChip, '滑石粉炒'));

    expect(wine.width, lessThan(60), reason: '单字标签宽度应随内容，实测 ${wine.width}');
    expect(vinegar.width, lessThan(60));
    expect(long.width, greaterThan(vinegar.width), reason: '宽度应随文案增长');

    final wineTop = tester.getTopLeft(find.widgetWithText(ZhongyiPrefixChip, '酒')).dy;
    final vinegarTop = tester.getTopLeft(find.widgetWithText(ZhongyiPrefixChip, '醋')).dy;
    expect(vinegarTop, wineTop, reason: '两个短标签必须在同一行');
  });

  testWidgets('前缀与基名同一行，长前缀不挤爆窄屏', (tester) async {
    for (final width in [375.0, 320.0]) {
      await _pumpForm(tester, width: width, medicine: _medicine);

      final picker = tester.getRect(find.byType(ZhongyiFormPicker));
      final name = tester.getRect(find.byType(ZhongyiFormInput));

      expect(name.top, picker.top, reason: '$width 宽：两个控件必须在同一行');
      expect(picker.right, lessThanOrEqualTo(name.left), reason: '$width 宽：前缀在左、基名在右');
      expect(name.width, greaterThan(120), reason: '$width 宽：基名输入框宽度实测 ${name.width}');
      expect(find.text('炮制前缀'), findsNothing, reason: '$width 宽：该行不再挂行标签');

      // TInput 自带白底（token.bgColorContainer），不清掉就会在外框里留一块错位的白块。
      final opaqueWhite = find.descendant(
        of: find.byType(ZhongyiFormInput),
        matching: find.byWidgetPredicate((widget) {
          final decoration = widget is DecoratedBox ? widget.decoration : null;
          return decoration is BoxDecoration && decoration.color == Colors.white;
        }),
      );
      expect(opaqueWhite, findsNothing, reason: '$width 宽：输入框内不应有白底');
      expect(
        tester.getRect(find.text('基名，如 甘草')).center.dy,
        closeTo(tester.getRect(find.byType(ZhongyiFormInput)).center.dy, 1),
        reason: '$width 宽：hint 应在输入框内垂直居中',
      );

      // 纵向 16px 之前由 TInput 默认 contentPadding=16 塞进 40 高行引起，现已清零。
      expect(_drainExceptions(tester), isEmpty, reason: '$width 宽：不应有任何溢出');
    }
  });

  testWidgets('单行与多行输入框都不溢出', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              ZhongyiFormRow(label: '单行', child: ZhongyiFormInput(controller: TextEditingController(), hint: '如 甘草')),
              ZhongyiFormRow(
                label: '多行',
                child: ZhongyiFormInput(controller: TextEditingController(), hint: '主治', maxLines: 3),
              ),
            ],
          ),
        ),
      ),
    ));
    await tester.pump();

    expect(_drainExceptions(tester), isEmpty, reason: '单行 / 多行输入框都不应溢出');
  });

  testWidgets('4 字前缀在表单 picker 里不被压缩', (tester) async {
    for (final width in [375.0, 320.0]) {
      await _pumpForm(tester, width: width, medicine: _medicine);

      final chip = tester.getSize(find.byType(ZhongyiPrefixChip));
      final textFinder = find.text('滑石粉炒');
      final textSize = tester.getSize(textFinder);
      final style = tester.widget<Text>(textFinder).style!;
      final natural = (TextPainter(
        text: TextSpan(text: '滑石粉炒', style: style),
        textDirection: TextDirection.ltr,
      )..layout())
          .width;

      expect(textSize.width, greaterThanOrEqualTo(natural - 0.5),
          reason: '$width 宽：文字被压到 ${textSize.width}，自然宽 $natural');
      expect(chip.width, greaterThanOrEqualTo(natural), reason: '$width 宽：标签比文字还窄');
      expect(_drainExceptions(tester), isEmpty);
    }
  });

  test('拼音只按基名生成，并修正词典错读', () {
    expect(zhongyiPinyinOf('大黄'), 'dahuang');
    expect(zhongyiPinyinOf('熟大黄'), 'shudahuang');
    expect(zhongyiPinyinOf('当归'), 'danggui');
    expect(zhongyiPinyinOf('白术'), 'baizhu');
    expect(zhongyiPinyinOf('红参'), 'hongshen');
    expect(zhongyiPinyinOf('玄参'), 'xuanshen');
    expect(zhongyiPinyinOf('大血藤'), 'daxueteng');
    // 没进修正表的词不能被误伤。
    expect(zhongyiPinyinOf('大枣'), 'dazao');
    expect(zhongyiPinyinOf('大戟'), 'daji');
    expect(zhongyiPinyinOf(''), '');
  });

  testWidgets('输入基名自动生成拼音', (tester) async {
    await _pumpForm(tester, width: 375);
    await tester.tap(find.textContaining('次要属性'));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(ZhongyiFormInput, '基名，如 甘草'), '大黄');
    await tester.pump();

    expect(find.text('dahuang'), findsOneWidget, reason: '大黄应拼成 dahuang');
    expect(find.text('daihuang'), findsNothing);

    // 旧数据里拼音可能是错的，手动改坏后「重算」应能按基名纠正。
    await tester.enterText(find.widgetWithText(ZhongyiFormInput, '改基名自动生成，可手动覆盖'), 'jiudaihuang');
    await tester.pump();
    await tester.tap(find.text('重算'));
    await tester.pump();
    expect(find.text('dahuang'), findsOneWidget, reason: '重算后应纠正为 dahuang');
  });

  testWidgets('分类默认选中植物药，标题与按钮之间不插分隔线', (tester) async {
    await _pumpForm(tester, width: 375);

    final label = tester.getRect(find.text('分类'));
    final chipFinder = find.ancestor(of: find.text('植物药'), matching: find.byType(Container)).first;
    final chip = tester.getRect(chipFinder);

    // 标题自带 4 底边距；之前卡片分隔线（约 20 高）把按钮整组压到了区块下半部。
    expect(chip.top - label.bottom, lessThan(12), reason: '标题与按钮间距 ${chip.top - label.bottom}');
    expect(
      (tester.widget<Container>(chipFinder).decoration as BoxDecoration).color,
      TdColors.brand,
      reason: '默认应选中植物药',
    );
  });

  testWidgets('分类点「其他」能选中', (tester) async {
    await _pumpForm(tester, width: 375);

    await tester.tap(find.text('其他'));
    await tester.pump();

    expect(_chipColor(tester, '其他'), TdColors.brand, reason: '点「其他」后应高亮');
    expect(_chipColor(tester, '植物药'), TdColors.brandLight, reason: '植物药应取消选中');
  });

  testWidgets('编辑态前缀回填到 picker', (tester) async {
    await _pumpForm(tester, width: 375, medicine: _medicine);

    final picker = find.byType(ZhongyiFormPicker);
    expect(
      find.descendant(of: picker, matching: find.text('滑石粉炒')),
      findsOneWidget,
      reason: '编辑进来应带着库里的前缀',
    );
    expect(find.text('选择前缀'), findsNothing, reason: '有前缀时不该显示占位文案');
  });

  testWidgets('详情晚到（先 null 后非 null）也能回填前缀', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    ZhongyiMedicine? medicine;
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () => setState(() => medicine = _medicine),
                    child: const Text('换数据'),
                  ),
                  ZhongyiMedicineProfileForm(medicine: medicine),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
    await tester.pump();
    expect(find.text('选择前缀'), findsOneWidget, reason: '数据没到时应是空表单');

    await tester.tap(find.text('换数据'));
    await tester.pump();

    expect(
      find.descendant(of: find.byType(ZhongyiFormPicker), matching: find.text('滑石粉炒')),
      findsOneWidget,
      reason: '数据到了要补填一次',
    );
    expect(find.text('甘草'), findsOneWidget, reason: '基名也应补填');
  });

  testWidgets('新增态不显示资料 / 库存 / 定价分段', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(375, 812),
      // 页面从 Get.arguments 取 id，没有 GetMaterialApp 会直接抛 GetRoot 异常。
      builder: (context, child) => const GetMaterialApp(home: ZhongyiMedicineEditPage()),
    ));
    // GetRoot 初始化会挂一个零延时定时器，pump 一次不推进时间会留下 pending timer。
    await tester.pumpAndSettle();

    for (final label in ['资料', '库存', '定价']) {
      expect(find.text(label), findsNothing, reason: '新增态不该出现「$label」分段按钮');
    }
    expect(find.text('创建药品'), findsOneWidget, reason: '应停在资料段，直接可创建');
  });

  testWidgets('炮制前缀弹窗里的自定义输入框不溢出', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              // 弹窗数据来自接口，UI 测试直接注入分组，避免依赖网络。
              onPressed: () => showZhongyiSheet<String>(
                context: context,
                title: '选择炮制前缀',
                heightFactor: 0.72,
                builder: (context) => const ZhongyiPrefixPicker(
                  prefix: '滑石粉炒',
                  groups: [
                    (title: '辅料', items: ['酒', '醋', '盐']),
                    (title: '复合炮制', items: ['滑石粉炒', '麸炒']),
                  ],
                ),
              ),
              child: const Text('打开'),
            ),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('打开'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pumpAndSettle();
    expect(find.text('添加前缀'), findsOneWidget, reason: '自定义输入框应已展开');

    final box = tester.getRect(
      find.ancestor(of: find.text('添加前缀'), matching: find.byType(Container)).first,
    );
    expect(
      tester.getRect(find.text('添加前缀')).center.dy,
      closeTo(box.center.dy, 1),
      reason: '自定义输入框的文字应垂直居中',
    );
    expect(_drainExceptions(tester), isEmpty, reason: '弹窗与自定义输入框都不应溢出');
  });
}
