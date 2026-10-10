import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../zhouyi/algorithm/zhouyi_constants.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';

/// 标签黑 —— 安卓 style_text_black 的 @color/color_black
const Color _kHeadBlack = Color(0xFF000000);

/// 数值蓝 —— 安卓 style_text_blue 的 @color/color_blue
const Color _kHeadBlue = Color(0xFF0000FF);

/// 强调红 —— 安卓 style_text_red 的 @color/color_red
const Color _kHeadRed = Color(0xFFFF5252);

/// 表头字号 —— 安卓 style_text_black / blue / red 统一 14dip
const double _kHeadFontSize = 14;

/// 【五不遇时】字号 —— 安卓 style_text_red_wubuyushi 17dip + bold
const double _kWuBuYuShiFontSize = 17;

final RegExp _digitReg = RegExp(r'\d');
final RegExp _luoGongReg = RegExp(r'^(.*落)(\d+)(宫)$');

/// 奇门盘面头部信息。
///
/// 行序、文案、分段着色、字号与对齐均对齐安卓 HourQimenActivity 的表头
/// （activity_hour_qimen.xml 的 ll_headerview，填充逻辑在 loadNongliAndZhifuText /
/// loadGonyuanText / loadGanAndKongText）：
///
/// ```
///   公元：2025年05月05日13时20分30秒
///   小满：2025年05月21日10时12分00秒
///   农历：四月十四  小满上元  阴遁3局
///   干支：乙巳年 辛巳月 甲申日 庚午时
///   旬空：戌亥空 申酉空 午未空 子丑空
///   值符：天芮落2宫  值使：休門落1宫  旬首：甲子戊
/// ```
///
/// 安卓侧 6 个 TextView 均未设 textSize / textColor / gravity / margin，
/// 字号与颜色全部来自施加在其上的 TextAppearanceSpan。
class QiMenInfoPanel extends StatelessWidget {
  const QiMenInfoPanel({super.key, required this.model});

  final ZYHourQimenModel model;

  @override
  Widget build(BuildContext context) {
    final h = model.head;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _line(_gongYuan(h)),
        _line(_jieQi(h)),
        _line(_nongLi(h)),
        _line(_ganZhi(h)),
        _line(_xunKong(h)),
        _line(_zhiFu(h)),
      ],
    );
  }

  /// 安卓 6 行之间无 margin / divider，行高交给字体自身度量，与 getLineHeight() 同源。
  /// 不要设 height —— 会把行高锁成 fontSize × height，比字体度量小一截。
  static Widget _line(List<TextSpan> spans) => Text.rich(
        TextSpan(children: spans),
        style: TextStyle(
          fontSize: _kHeadFontSize.sp,
          color: _kHeadBlack,
        ),
      );

  static TextSpan _black(String text) => TextSpan(
        text: text,
        style: const TextStyle(
          color: _kHeadBlack,
          fontWeight: FontWeight.bold,
        ),
      );

  static TextSpan _blue(String text) =>
      TextSpan(text: text, style: const TextStyle(color: _kHeadBlue));

  static TextSpan _red(String text) =>
      TextSpan(text: text, style: const TextStyle(color: _kHeadRed));

  /// "2025年05月05日13时20分30秒" → 数字蓝 / 单位字黑粗。
  /// 对应安卓 changeTimeMoreColor 里 14 段交替的 TextAppearanceSpan。
  static List<TextSpan> _dateTimeValue(String text) {
    final spans = <TextSpan>[];
    final buf = StringBuffer();
    bool? digit;

    void flush() {
      if (buf.isEmpty) return;
      spans.add(digit! ? _blue(buf.toString()) : _black(buf.toString()));
      buf.clear();
    }

    for (final ch in text.characters) {
      final isDigit = _digitReg.hasMatch(ch);
      if (digit != null && digit != isDigit) flush();
      digit = isDigit;
      buf.write(ch);
    }
    flush();
    return spans;
  }

  /// 值符 / 值使的值形如「天芮落2宫」「休門落1宫」：
  /// 星门名与「落」蓝、宫位数红、「宫」黑粗（安卓 zhifuSpanText 的 3-6/6-7/7-8 段）。
  static List<TextSpan> _luoGong(String value) {
    final m = _luoGongReg.firstMatch(value);
    if (m == null) return [_blue(value)];
    return [_blue(m.group(1)!), _red(m.group(2)!), _black(m.group(3)!)];
  }

  /// 公元：2026年10月10日13时20分30秒 —— 标签黑粗，数字蓝，单位字黑粗
  List<TextSpan> _gongYuan(ZYHourQimenHeadModel h) {
    final d = h.dateTimes;
    if (d.length < 6) return [_black('公元：')];
    return [
      _black('公元：'),
      ..._dateTimeValue('${d[0]}年${d[1]}月${d[2]}日${d[3]}时${d[4]}分${d[5]}秒'),
    ];
  }

  /// 寒露：2026年10月08日14时29分27秒 —— 与公历行同一套分段规则
  List<TextSpan> _jieQi(ZYHourQimenHeadModel h) {
    if (h.jieQi.isEmpty) return [];
    return [
      _black('${h.jieQi}：'),
      ..._dateTimeValue(h.jieQiTime),
    ];
  }

  /// 农历：四月十四  小满上元  阴遁3局
  ///
  /// 月/日蓝，节气名蓝，三元（上/中/下）红，「元」蓝，阴阳遁与局数黑粗。
  List<TextSpan> _nongLi(ZYHourQimenHeadModel h) {
    final parts = h.nongli.split('月');
    final month = parts.isNotEmpty ? parts[0] : '';
    final day = parts.length > 1 ? parts[1] : '';
    final dun = h.dunType == YinYangType.yin ? '阴' : '阳';
    return [
      _black('农历：'),
      _blue(month),
      _black('月'),
      _blue(day),
      const TextSpan(text: '  '),
      _blue(h.jieQi),
      _red(h.sanYuan),
      _blue('元'),
      const TextSpan(text: '  '),
      _black('$dun遁${h.jushu}局'),
    ];
  }

  /// 干支：乙巳年 辛巳月 甲申日 庚午时【五不遇时】
  ///
  /// 干支值蓝，年/月/日/时黑粗；五不遇时为 17sp 粗红。
  List<TextSpan> _ganZhi(ZYHourQimenHeadModel h) {
    return [
      _black('干支：'),
      _blue(h.yearGanzhi),
      _black('年'),
      const TextSpan(text: ' '),
      _blue(h.monthGanzhi),
      _black('月'),
      const TextSpan(text: ' '),
      _blue(h.dayGanzhi),
      _black('日'),
      const TextSpan(text: ' '),
      _blue(h.hourGanzhi),
      _black('时'),
      if (h.isWuBuYuShi())
        const TextSpan(
          text: '【五不遇时】',
          style: TextStyle(
            color: _kHeadRed,
            fontSize: _kWuBuYuShiFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
    ];
  }

  /// 旬空：戌亥空 申酉空 午未空 子丑空 —— 旬空地支蓝，「空」黑粗
  List<TextSpan> _xunKong(ZYHourQimenHeadModel h) {
    final empties = [h.yearEmpty, h.monthEmpty, h.dayEmpty, h.hourEmpty];
    final spans = <TextSpan>[_black('旬空：')];
    for (var i = 0; i < empties.length; i++) {
      if (i > 0) spans.add(const TextSpan(text: ' '));
      spans.add(_blue(empties[i]));
      spans.add(_black('空'));
    }
    return spans;
  }

  /// 值符：天禽落5宫  值使：死門落2宫  旬首：甲辰壬
  List<TextSpan> _zhiFu(ZYHourQimenHeadModel h) {
    return [
      _black('值符：'),
      ..._luoGong(h.zhiFu),
      const TextSpan(text: '  '),
      _black('值使：'),
      ..._luoGong(h.zhiShi),
      const TextSpan(text: '  '),
      _black('旬首：'),
      _blue(h.hourXunShou),
    ];
  }
}
