/// 农历转公历（对应安卓 util/CalendarUtil，有效范围 1900-2049）
class LunarSolarUtil {
  LunarSolarUtil._();

  /// 计算农历 1900-2049 年的闰月与大小月信息
  static const List<int> _lunarInfo = [
    0x04bd8, 0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2,
    0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540, 0x0d6a0, 0x0ada2, 0x095b0, 0x14977,
    0x04970, 0x0a4b0, 0x0b4b5, 0x06a50, 0x06d40, 0x1ab54, 0x02b60, 0x09570, 0x052f2, 0x04970,
    0x06566, 0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60, 0x186e3, 0x092e0, 0x1c8d7, 0x0c950,
    0x0d4a0, 0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4, 0x025d0, 0x092d0, 0x0d2b2, 0x0a950, 0x0b557,
    0x06ca0, 0x0b550, 0x15355, 0x04da0, 0x0a5d0, 0x14573, 0x052d0, 0x0a9a8, 0x0e950, 0x06aa0,
    0x0aea6, 0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260, 0x0f263, 0x0d950, 0x05b57, 0x056a0,
    0x096d0, 0x04dd5, 0x04ad0, 0x0a4d0, 0x0d4d4, 0x0d250, 0x0d558, 0x0b540, 0x0b5a0, 0x195a6,
    0x095b0, 0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50, 0x06d40, 0x0af46, 0x0ab60, 0x09570,
    0x04af5, 0x04970, 0x064b0, 0x074a3, 0x0ea50, 0x06b58, 0x055c0, 0x0ab60, 0x096d5, 0x092e0,
    0x0c960, 0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0, 0x0abb7, 0x025d0, 0x092d0, 0x0cab5,
    0x0a950, 0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9, 0x04ba0, 0x0a5b0, 0x15176, 0x052b0, 0x0a930,
    0x07954, 0x06aa0, 0x0ad50, 0x05b52, 0x04b60, 0x0a6e6, 0x0a4e0, 0x0d260, 0x0ea65, 0x0d530,
    0x05aa0, 0x076a3, 0x096d0, 0x04bd7, 0x04ad0, 0x0a4d0, 0x1d0b6, 0x0d250, 0x0d520, 0x0dd45,
    0x0b5a0, 0x056d0, 0x055b2, 0x049b0, 0x0a577, 0x0a4b0, 0x0aa50, 0x1b255, 0x06d20, 0x0ada0,
  ];

  static const int minYear = 1900;
  static const int maxYear = 2049;

  /// 阳历起点（配合下方的 offset 计算基准）
  static final DateTime _startDate = DateTime(1900, 1, 30);

  /// 农历 year 年闰哪个月，1-12；无闰月返回 0
  static int getLeapMonth(int year) => _lunarInfo[year - minYear] & 0xf;

  /// 农历 year 年闰月的天数
  static int getLeapMonthDays(int year) {
    if (getLeapMonth(year) != 0) {
      return (_lunarInfo[year - minYear] & 0xf0000) == 0 ? 29 : 30;
    }
    return 0;
  }

  /// 农历 lunarYear 年 month 月的天数
  static int getMonthDays(int lunarYear, int month) {
    if (month > 31 || month < 0) {
      throw ArgumentError('月份有错！');
    }
    final bit = 1 << (16 - month);
    return ((_lunarInfo[lunarYear - minYear] & 0x0FFFF) & bit) == 0 ? 29 : 30;
  }

  /// 农历 year 年全年天数
  static int getYearDays(int year) {
    var sum = 29 * 12;
    for (var i = 0x8000; i >= 0x8; i >>= 1) {
      if ((_lunarInfo[year - minYear] & 0xfff0 & i) != 0) sum++;
    }
    return sum + getLeapMonthDays(year);
  }

  static void _checkLunarDate(
    int lunarYear,
    int lunarMonth,
    int lunarDay,
    bool leapMonthFlag,
  ) {
    if (lunarYear < minYear || lunarYear > maxYear) {
      throw ArgumentError('非法农历年份！');
    }
    if (lunarMonth < 1 || lunarMonth > 12) {
      throw ArgumentError('非法农历月份！');
    }
    if (lunarDay < 1 || lunarDay > 30) {
      throw ArgumentError('非法农历天数！');
    }
    final leap = getLeapMonth(lunarYear);
    if (leapMonthFlag && lunarMonth != leap) {
      throw ArgumentError('非法闰月！');
    }
  }

  /// 农历转公历。[lunarDate] 形如 `20240501`，返回 `YYYYMMDD`。
  static String lunarToSolar(String lunarDate, bool leapMonthFlag) {
    final lunarYear = int.parse(lunarDate.substring(0, 4));
    final lunarMonth = int.parse(lunarDate.substring(4, 6));
    final lunarDay = int.parse(lunarDate.substring(6, 8));

    _checkLunarDate(lunarYear, lunarMonth, lunarDay, leapMonthFlag);

    var offset = 0;
    for (var i = minYear; i < lunarYear; i++) {
      offset += getYearDays(i);
    }

    final leapMonth = getLeapMonth(lunarYear);
    if (leapMonthFlag && leapMonth != lunarMonth) {
      throw ArgumentError('您输入的闰月标志有误！');
    }

    if (leapMonth == 0 ||
        lunarMonth < leapMonth ||
        (lunarMonth == leapMonth && !leapMonthFlag)) {
      for (var i = 1; i < lunarMonth; i++) {
        offset += getMonthDays(lunarYear, i);
      }
      if (lunarDay > getMonthDays(lunarYear, lunarMonth)) {
        throw ArgumentError('不合法的农历日期！');
      }
      offset += lunarDay;
    } else {
      for (var i = 1; i < lunarMonth; i++) {
        offset += getMonthDays(lunarYear, i);
      }
      if (lunarMonth > leapMonth) {
        offset += getLeapMonthDays(lunarYear);
        if (lunarDay > getMonthDays(lunarYear, lunarMonth)) {
          throw ArgumentError('不合法的农历日期！');
        }
        offset += lunarDay;
      } else {
        offset += getMonthDays(lunarYear, lunarMonth);
        if (lunarDay > getLeapMonthDays(lunarYear)) {
          throw ArgumentError('不合法的农历日期！');
        }
        offset += lunarDay;
      }
    }

    final dt = _startDate.add(Duration(days: offset));
    return '${dt.year.toString().padLeft(4, '0')}'
        '${dt.month.toString().padLeft(2, '0')}'
        '${dt.day.toString().padLeft(2, '0')}';
  }
}
