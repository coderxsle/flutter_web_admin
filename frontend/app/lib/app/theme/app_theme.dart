import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

/// 全项目唯一的颜色与主题来源。
///
/// 这里是唯一写死色值的地方：TDesign 主题 JSON 由下方常量拼出，因此
/// TDesign 组件（单选、多选、输入框、按钮等）与业务 widget 取到的是同一组颜色，
/// 不会再出现「按钮红、单选蓝」这种两套体系。
///
/// 业务代码取值方式：
/// - 有 BuildContext：`tdThemeOf(context).brandNormalColor`（跟随主题）
/// - 不能拿到 context 或需要 const：`TdColors.brand`
class TdColors {
  const TdColors._();

  /// 品牌色阶，与 TDesign 的 brandColor1..10 一一对应，由主色 #F54C4C 派生。
  /// 必须整段覆盖，否则禁用/按下态会回落成 TDesign 默认蓝。
  static const brandColor1 = Color(0xFFFFF0F1);
  static const brandColor2 = Color(0xFFFFE0E2);
  static const brandColor3 = Color(0xFFFBBFC1);
  static const brandColor4 = Color(0xFFF79A9D);
  static const brandColor5 = Color(0xFFF57274);
  static const brandColor6 = Color(0xFFF66567);
  static const brandColor7 = Color(0xFFF54C4C);
  static const brandColor8 = Color(0xFFD93B3B);
  static const brandColor9 = Color(0xFFB32E2E);
  static const brandColor10 = Color(0xFF8C2323);

  /// 主色，等于 TDesign brandNormalColor。
  static const brand = brandColor7;

  /// 浅色底（选中底色、浅色按钮底），等于 TDesign brandLightColor。
  static const brandLight = brandColor1;

  /// 禁用态，等于 TDesign brandDisabledColor。
  static const brandDisabled = brandColor3;

  /// 悬浮态，等于 TDesign brandHoverColor。
  static const brandHover = brandColor6;

  /// 按下态，等于 TDesign brandActiveColor。
  static const brandActive = brandColor8;

  /// 页面底色，等于 TDesign bgColorPage。
  static const pageBg = Color(0xFFF1F1F1);

  /// 容器底色，等于 TDesign bgColorContainer / textColorAnti。
  static const white = Color(0xFFFFFFFF);

  /// 正文主色，等于 TDesign textColorPrimary。
  static const textPrimary = Color(0xFF222222);

  /// 次要文字，等于 TDesign textColorSecondary。
  static const grey85 = Color(0xFF555555);

  /// 以下灰阶 TDesign 无对应 token，属项目扩展色。
  static const grey135 = Color(0xFF878787);
  static const grey153 = Color(0xFF999999);
  static const grey165 = Color(0xFFA5A5A5);
  static const grey195 = Color(0xFFC3C3C3);
  static const grey201 = Color(0xFFC9C9C9);
  static const grey225 = Color(0xFFE1E1E1);

  /// 语义与强调色，TDesign 无对应 token。
  static const red = Color(0xFFFF0000);
  static const redBg = Color(0xFFFDE8E8);
  static const orange = Color(0xFFFD8D43);
  static const orangeLight = Color(0xFFFFBC37);
  static const blue = Color(0xFF0521F5);
  static const blueBg = Color(0xFFDFF0FF);
}

/// 主题名，同时也是 [tdThemeJson] 的一级 key。
const String tdThemeName = 'red';

String _hex(Color c) => '#${(c.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

/// TDesign 主题 JSON，色值全部来自 [TdColors]，此处不写第二份字面量。
final String tdThemeJson = '''
{
  "$tdThemeName": {
    "color": {
      "brandColor1": "${_hex(TdColors.brandColor1)}",
      "brandColor2": "${_hex(TdColors.brandColor2)}",
      "brandColor3": "${_hex(TdColors.brandColor3)}",
      "brandColor4": "${_hex(TdColors.brandColor4)}",
      "brandColor5": "${_hex(TdColors.brandColor5)}",
      "brandColor6": "${_hex(TdColors.brandColor6)}",
      "brandColor7": "${_hex(TdColors.brandColor7)}",
      "brandColor8": "${_hex(TdColors.brandColor8)}",
      "brandColor9": "${_hex(TdColors.brandColor9)}",
      "brandColor10": "${_hex(TdColors.brandColor10)}",
      "bgColorPage": "${_hex(TdColors.pageBg)}",
      "bgColorContainer": "${_hex(TdColors.white)}",
      "textColorPrimary": "${_hex(TdColors.textPrimary)}",
      "textColorSecondary": "${_hex(TdColors.grey85)}",
      "textColorAnti": "${_hex(TdColors.white)}"
    }
  }
}
''';

/// 解析后的 TDesign 主题，全 App 一份。
final TThemeData themeData = TThemeData.fromJson(tdThemeName, tdThemeJson)!;

/// 取当前上下文的 TDesign 主题；取不到时回退到红色主题，避免回落成默认蓝。
TThemeData themeOf(BuildContext context) => Theme.of(context).extension<TThemeData>() ?? themeData;

/// 底部标签栏主题：选中项用品牌红淡底，新版把底色从 TTabBar 参数挪到了这里。
final TTabBarThemeData tabBarTheme = TTabBarThemeData(
  selectedBgColor: TdColors.brand.withValues(alpha: 0.12),
);
