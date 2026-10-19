import 'package:flutter/material.dart';
// 前缀是必须的：material 也有一个同名的 DatePickerTheme
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
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
  static const pageBg = Color.fromARGB(255, 241, 241, 241);

  /// 容器底色，等于 TDesign bgColorContainer / textColorAnti。
  static const white = Color(0xFFFFFFFF);

  /// 正文主色，等于 TDesign textColorPrimary。
  static const textPrimary = Color(0xFF222222);

  /// 次要文字，等于 TDesign textColorSecondary。
  static const grey85 = Color(0xFF555555);

  /// 以下灰阶 TDesign 无对应 token，属项目扩展色。
  static const grey135 = Color.fromARGB(255, 113, 113, 113);
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
///
/// 中性色 token 必须全量覆盖：TDesign 的语义 token 会回落到它自己的默认灰，
/// 漏一个就会出现「页面 #F1F1F1、组件 #F3F3F3」这种同屏两个灰。
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
      "bgColorSecondaryContainer": "${_hex(TdColors.grey225)}",
      "bgColorSecondaryContainerActive": "${_hex(TdColors.grey201)}",
      "bgColorContainerActive": "${_hex(TdColors.grey225)}",
      "bgColorComponent": "${_hex(TdColors.grey225)}",
      "bgColorComponentActive": "${_hex(TdColors.grey201)}",
      "bgColorComponentDisabled": "${_hex(TdColors.pageBg)}",
      "bgColorSecondaryComponent": "${_hex(TdColors.grey201)}",
      "bgColorSecondaryComponentActive": "${_hex(TdColors.grey165)}",
      "textColorPrimary": "${_hex(TdColors.textPrimary)}",
      "textColorSecondary": "${_hex(TdColors.grey85)}",
      "textColorPlaceholder": "${_hex(TdColors.grey153)}",
      "textColorDisabled": "${_hex(TdColors.grey195)}",
      "textColorAnti": "${_hex(TdColors.white)}",
      "componentStroke": "${_hex(TdColors.grey225)}",
      "componentBorder": "${_hex(TdColors.grey225)}",
      "borderLevel1Color": "${_hex(TdColors.grey225)}",
      "borderLevel2Color": "${_hex(TdColors.grey195)}"
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

/// 分割线主题：TDivider 默认上下各留 10dp 外边距（占位 20.5dp），归零后只剩 0.5dp 的线。
/// 竖线（TDividerLayout.vertical）的左右 16dp 外边距也会一起没掉，真用到时单独包 Theme。
const TDividerThemeData dividerTheme = TDividerThemeData(margin: EdgeInsets.zero);

/// 输入框主题：TInput/TTextarea 独立使用时默认四周 16dp 内边距、自带白底，定高容器会被撑破、
/// 松开约束后又只剩中间一条白。留白和底色一律交给外层容器。
const TInputThemeData inputTheme =
    TInputThemeData(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10));

/// 日期时间弹窗主题：确定键用品牌红，不填会落回 TDesign 默认蓝。
final picker.DatePickerTheme datePickerTheme = picker.DatePickerTheme(
  cancelStyle: _pickerCancelStyle,
  doneStyle: _pickerDoneStyle,
  itemStyle: _pickerItemStyle,
);

/// 日期弹窗标题栏的两行高度：上面取消/确定，下面农历。
/// 合计就是 [datePickerLunarTheme] 的 titleHeight，插件按它算弹窗最大高度。
const double pickerTitleRowHeight = 44;
const double pickerLunarRowHeight = 28;

/// 日期弹窗主题：只比 [datePickerTheme] 多一行农历的高度，颜色样式一致。
final picker.DatePickerTheme datePickerLunarTheme = picker.DatePickerTheme(
  cancelStyle: _pickerCancelStyle,
  doneStyle: _pickerDoneStyle,
  itemStyle: _pickerItemStyle,
  titleHeight: pickerTitleRowHeight + pickerLunarRowHeight,
);

const _pickerCancelStyle = TextStyle(fontSize: 16, color: TdColors.grey85);
const _pickerDoneStyle = TextStyle(fontSize: 16, color: TdColors.brand);
const _pickerItemStyle = TextStyle(fontSize: 18, color: TdColors.textPrimary);
