/// 时间差工具（对应安卓 util/TimeUtils 的 timeDifferenceFromTime / isLeapYear）
class TimeUtils {
  TimeUtils._();

  /// 注意：原实现直接修改这张表，此处保留同样的行为
  static final List<int> _dayNumberArray = [
    0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31,
  ];

  static bool isLeapYear(int year) =>
      year % 4 == 0 && year % 100 != 0 || year % 400 == 0;

  /// 计算两个「yyyy年MM月dd日HH时」字符串的时间差，返回「X年X月X天X小时」
  static String timeDifferenceFromTime(String fd, String td) {
    var startYear = int.parse(fd.substring(0, 4));
    var startMonth = int.parse(fd.substring(5, 7));
    var startDay = int.parse(fd.substring(8, 10));
    final startHour = int.parse(fd.substring(11, 13));

    var endYear = int.parse(td.substring(0, 4));
    var endMonth = int.parse(td.substring(5, 7));
    var endDay = int.parse(td.substring(8, 10));
    final endHour = int.parse(td.substring(11, 13));

    int hour;
    if (endHour < startHour) {
      endDay -= 1;
      hour = endHour + 24 - startHour;
    } else {
      hour = endHour - startHour;
    }

    int day;
    if (endDay < startDay) {
      endMonth -= 1;
      if (endMonth == 2) {
        _dayNumberArray[2] = isLeapYear(startYear) ? 28 : 29;
        day = endDay + _dayNumberArray[2] - startDay;
      } else {
        day = endDay + _dayNumberArray[endMonth] - startDay;
      }
    } else {
      day = endDay - startDay;
    }

    int month;
    if (endMonth < startMonth) {
      endYear -= 1;
      month = endMonth + 12 - startMonth;
    } else {
      month = endMonth - startMonth;
    }

    final year = endYear - startYear;
    return '$year年$month月$day天$hour小时';
  }
}
