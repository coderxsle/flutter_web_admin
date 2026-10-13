import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:yun_men_yi_pan/app/modules/ba_zi/controller/bazi_controller.dart';
import 'package:yun_men_yi_pan/app/modules/ba_zi/page/bazi_input_page.dart';
import 'package:yun_men_yi_pan/app/modules/launching/material.dart';

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
      getPages: [GetPage(name: '/', page: () => child)],
    ),
  );
}

/// TPopup 的面板只有 Container，而 TInput 内部的 TextField 必须要有 Material 祖先，
/// 少了它一开弹窗就 No Material widget found，这条用来守住那个包裹。
Future<void> _openLunarDialog(WidgetTester tester) async {
  Get.put(BaziInputController());
  addTearDown(Get.reset);

  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(_host(const BaziInputPage()));
  // Get 的路由要再推几帧才建出页面
  await tester.pump();
  for (var i = 0; i < 4; i++) {
    await tester.pump(const Duration(milliseconds: 300));
  }

  await tester.ensureVisible(find.text('阴历转阳历'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('阴历转阳历'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('阴历转阳历弹窗能打开且不抛异常', (tester) async {
    await _openLunarDialog(tester);

    expect(tester.takeException(), isNull);
    // 页面本身有一个输入框，弹窗里再加一个
    expect(find.byType(TInput), findsNWidgets(2));
    expect(find.text('确定'), findsOneWidget);
  });

  testWidgets('弹窗里输入日期后不抛异常', (tester) async {
    await _openLunarDialog(tester);

    // 有内容且聚焦时 TInput 会显示清除按钮（内部是 IconButton）
    await tester.enterText(find.byType(EditableText).last, '20240101');
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
