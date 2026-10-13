import 'chn_chinese_calendar.dart';
import 'ming_gong_util.dart';
import 'zhouyi_constants.dart';

/// 流月：某流年十二个节气月的干支。
class LiuYueUtil {
  LiuYueUtil._();

  /// 正月起，月支顺序固定
  static const List<String> monthZhi = [
    '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥', '子', '丑',
  ];

  /// 与 [monthZhi] 一一对应的月名
  static const List<String> monthName = [
    '正月', '二月', '三月', '四月', '五月', '六月',
    '七月', '八月', '九月', '十月', '冬月', '腊月',
  ];

  /// 与 [monthZhi] 一一对应的交节
  static const List<String> monthJie = [
    '立春', '惊蛰', '清明', '立夏', '芒种', '小暑',
    '立秋', '白露', '寒露', '立冬', '大雪', '小寒',
  ];

  /// 十二个流月干支，自正月起；年干非法时返回空表
  static List<String> ofYear(String yearGan) {
    final start = MingGongUtil.ganOf(yearGan, '寅');
    if (start.isEmpty) return [];
    final si = ZhouyiConst.shiTianGan.indexOf(start);
    if (si < 0) return [];
    return [
      for (var i = 0; i < 12; i++)
        '${ZhouyiConst.shiTianGan[(si + i) % 10]}${monthZhi[i]}',
    ];
  }

  /// 按公历年取十二流月，年干取该年立春之后的干支年
  static List<String> ofYearNumber(int year) {
    final ganzhi = ChnChineseCalendar.instance
        .ganzhiJsonWithYear(year, 6, 1, 12)['yearGanzhi'];
    if (ganzhi == null || ganzhi.isEmpty) return [];
    return ofYear(ganzhi.substring(0, 1));
  }
}

/// 流日：某公历月内每一天的日柱干支。
///
/// 日柱按六十甲子连续排，所以只求该月 1 日的干支，其余顺推即可，
/// 不必逐日调用节气计算。
class LiuRiUtil {
  LiuRiUtil._();

  /// 某年某月每一天的日柱干支，下标 0 为 1 日；入参非法返回空表
  static List<String> ofMonth(int year, int month) {
    if (month < 1 || month > 12) return [];
    final days = DateTime(year, month + 1, 0).day;
    final first = ChnChineseCalendar.instance
        .ganzhiJsonWithYear(year, month, 1, 12)['dayGanzhi'];
    if (first == null || first.length < 2) return [];
    final gi = ZhouyiConst.shiTianGan.indexOf(first.substring(0, 1));
    final zi = ZhouyiConst.shiErDiZhi.indexOf(first.substring(1, 2));
    if (gi < 0 || zi < 0) return [];
    return [
      for (var i = 0; i < days; i++)
        '${ZhouyiConst.shiTianGan[(gi + i) % 10]}'
        '${ZhouyiConst.shiErDiZhi[(zi + i) % 12]}',
    ];
  }

  /// 某年某月的天数
  static int daysInMonth(int year, int month) =>
      (month < 1 || month > 12) ? 0 : DateTime(year, month + 1, 0).day;
}
