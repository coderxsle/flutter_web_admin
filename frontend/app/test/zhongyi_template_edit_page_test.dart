import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/model/zhongyi_model.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/page/zhongyi_template_edit_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/widget/zhongyi_ui.dart';

/// 新增态不依赖网络：`Get.arguments` 为空即 id=0，页面不发起加载。
Future<void> _pumpNewPage(WidgetTester tester, {double width = 375}) async {
  tester.view.physicalSize = Size(width * 3, 812 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (context, child) => const GetMaterialApp(home: ZhongyiTemplateEditPage()),
  ));
  await tester.pumpAndSettle();
}

List<String> _drainExceptions(WidgetTester tester) {
  final messages = <String>[];
  Object? error;
  while ((error = tester.takeException()) != null) {
    messages.add(error.toString());
  }
  return messages;
}

void main() {
  test('can_edit 由后端下发，缺失时按不可编辑处理', () {
    final editable = ZhongyiTemplate.fromJson({'id': 3, 'name': '四逆汤', 'scope': 'public', 'can_edit': true});
    final readonly = ZhongyiTemplate.fromJson({'id': 4, 'name': '四君子汤', 'scope': 'public'});

    expect(editable.canEdit, isTrue, reason: '公共模板的创建者本人应可改');
    expect(readonly.canEdit, isFalse, reason: '后端没给权限位时不能放行编辑');
  });

  testWidgets('新增模板页在窄屏下不溢出', (tester) async {
    for (final width in [375.0, 320.0]) {
      await _pumpNewPage(tester, width: width);
      expect(_drainExceptions(tester), isEmpty, reason: '$width 宽：不应有任何溢出');
      expect(find.text('模板名称'), findsOneWidget);
    }
  });

  testWidgets('启用开关在模板名称行内，标签与输入框贴紧', (tester) async {
    await _pumpNewPage(tester);

    final label = tester.getRect(find.text('模板名称'));
    final input = tester.getRect(find.byType(ZhongyiFormInput).first);
    final toggle = tester.getRect(find.byType(TSwitch));
    final caption = tester.getRect(find.text('是否启用'));

    expect(input.left - label.right, lessThanOrEqualTo(12), reason: '标签与输入框间距应收到 10 左右');
    expect((toggle.center.dy - input.center.dy).abs(), lessThan(2), reason: '开关应与名称输入框同一行');
    expect(caption.right, lessThan(toggle.left), reason: '「是否启用」应在开关左侧');
    expect(caption.left, greaterThan(input.right), reason: '文字在输入框右侧');
    expect(find.text('启用'), findsNothing, reason: '不再单独占一行');
  });

  testWidgets('模板类型与标签同一行，非管理员只看到个人模板', (tester) async {
    await _pumpNewPage(tester);

    final label = tester.getRect(find.text('模板类型'));
    final chip = tester.getRect(find.text('个人模板'));

    expect((chip.center.dy - label.center.dy).abs(), lessThan(2), reason: '标签与选项应垂直居中在同一行');
    expect(chip.left, greaterThan(label.right), reason: '标签在左、选项在右');
    expect(find.text('公共模板'), findsNothing, reason: '非管理员不能选共享类型');
    expect(find.textContaining('只能由管理员调整'), findsNothing, reason: '不再单独占一行提示');
  });
}
