import 'chn_chinese_calendar.dart';
import 'zhouyi_constants.dart';

/// 置闰法计算结果
class ZhirunResult {
  /// 局数 1-9
  final int juNumber;

  /// 0=阴遁 1=阳遁
  final int dunType;

  /// 使用的节气名
  final String jieqi;

  /// 使用的节气索引
  final int jieqiIndex;

  ZhirunResult(this.juNumber, this.dunType, this.jieqi, this.jieqiIndex);
}

/// 奇门遁甲置闰法本地计算（超神接气规则）
///
/// 对应安卓 com.bubble.zhouyi.qimendunjia.Hour.tools.ZhirunCalculator。
class ZhirunCalculator {
  ZhirunCalculator._();

  /// 24 节气名称（索引 0 = 立春）
  static const List<String> _jieqiNames = [
    '立春', '雨水', '惊蛰',
    '春分', '清明', '谷雨',
    '立夏', '小满', '芒种',
    '夏至', '小暑', '大暑',
    '立秋', '处暑', '白露',
    '秋分', '寒露', '霜降',
    '立冬', '小雪', '大雪',
    '冬至', '小寒', '大寒',
  ];

  /// 接近节气末期时切换到下一节气
  static const double _jieqiSwitchRatio = 0.93;

  static ZhirunResult calculate(
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
  ) {
    final cal = ChnChineseCalendar.instance;

    var currentJD = cal.dateToJuliandTimeWithYear(year, month, day, 0);
    currentJD += cal.dateToJuliandTimeWithHour(hour, minute, second);

    final jieqi = cal.getJieqiWithYear(year, month, day, hour, minute, second);
    final currentJieqiIndex = jieqi.currentJieqiIndex;
    final allJieqiTime = jieqi.allJieqiTime;
    final currentJieqi = jieqi.currentJieqi;

    // 超神接气判定
    var useJieqiIndex = currentJieqiIndex;
    var useJieqi = currentJieqi;

    final currentJieqiStartJD = allJieqiTime[currentJieqiIndex];
    final nextJieqiStartJD = allJieqiTime[(currentJieqiIndex + 1) % 24];
    final jieqiDuration = nextJieqiStartJD - currentJieqiStartJD;
    final timeFromJieqiStart = currentJD - currentJieqiStartJD;
    final positionRatio = timeFromJieqiStart / jieqiDuration;

    if (positionRatio >= _jieqiSwitchRatio) {
      useJieqiIndex = (currentJieqiIndex + 1) % 24;
      useJieqi = _jieqiNames[useJieqiIndex];
    }

    // 阴阳遁
    final dunType = _calculateDunType(allJieqiTime, currentJD);

    // 三元
    final sizhu = cal.ganzhiJsonWithYear(year, month, day, hour);
    final dayGanzhi = sizhu['dayGanzhi'] ?? '';

    final useJieqiStartJD = allJieqiTime[useJieqiIndex];
    var shangYuanFirstDayJD = _findShangYuanFirstDayFromDate(useJieqiStartJD);
    var daysFromShangYuan = currentJD - shangYuanFirstDayJD;

    if (daysFromShangYuan >= 15.0) {
      shangYuanFirstDayJD = _findShangYuanFirstDayFromDate(currentJD);
      daysFromShangYuan = currentJD - shangYuanFirstDayJD;
    }

    final sanYuan = _calculateSanYuanByJieqiDays(daysFromShangYuan);
    // 日干支参与判断三元，保留以对齐原实现的数据流
    assert(dayGanzhi.isNotEmpty);

    // 局数
    final baseJuNumber = ZhouyiConst.juNumbersZhirun[useJieqiIndex];
    final finalJuNumber =
        _adjustJuNumberBySanYuan(baseJuNumber, dunType, sanYuan, useJieqiIndex);

    return ZhirunResult(finalJuNumber, dunType, useJieqi, useJieqiIndex);
  }

  /// 夏至到冬至之间为阴遁，其余为阳遁
  static int _calculateDunType(List<double> allJieqiTime, double currentJD) {
    final xiaZhiJD = allJieqiTime[9]; // 夏至
    final dongZhiJD = allJieqiTime[21]; // 冬至
    if (currentJD >= xiaZhiJD && currentJD < dongZhiJD) {
      return YinYangType.yin;
    }
    return YinYangType.yang;
  }

  /// 从指定日期向前查找最近的旬首日（甲子/甲戌/甲申/甲午/甲辰/甲寅）
  static double _findShangYuanFirstDayFromDate(double startJD) {
    const xunshou = ['甲子', '甲戌', '甲申', '甲午', '甲辰', '甲寅'];
    for (var i = 0; i <= 15; i++) {
      final checkJD = startJD - i;
      final date = _julianDayToDate(checkJD);
      final sizhu = ChnChineseCalendar.instance
          .ganzhiJsonWithYear(date[0], date[1], date[2], 0);
      if (xunshou.contains(sizhu['dayGanzhi'])) {
        return checkJD;
      }
    }
    return startJD;
  }

  /// 儒略日转公历 [年, 月, 日]
  static List<int> _julianDayToDate(double jd) {
    final z = (jd + 0.5).floor();
    final alpha = ((z - 1867216.25) / 36524.25).floor();
    final a = z + 1 + alpha - (alpha ~/ 4);
    final b = a + 1524;
    final c = ((b - 122.1) / 365.25).floor();
    final d = (365.25 * c).floor();
    final e = ((b - d) / 30.6001).floor();

    final day = b - d - (30.6001 * e).floor();
    final month = e < 14 ? e - 1 : e - 13;
    final year = month > 2 ? c - 4716 : c - 4715;
    return [year, month, day];
  }

  /// 置闰法按距上元起点的天数划分三元：上元 0-4 天，中元 5-9 天，下元 10-14 天
  static String _calculateSanYuanByJieqiDays(double daysFromJieqi) {
    final dayNumber = daysFromJieqi.floor();
    if (dayNumber < 5) return '上';
    if (dayNumber < 10) return '中';
    return '下';
  }

  /// 按三元调整局数
  ///
  /// 立冬小雪大雪组（索引 18-20）：阴遁加 3、阳遁减 3；其余组方向相反。
  static int _adjustJuNumberBySanYuan(
    int baseJuNumber,
    int dunType,
    String sanYuan,
    int jieqiIndex,
  ) {
    var juNumber = baseJuNumber;
    final idx2 = '上中下'.indexOf(sanYuan);
    final isLidongGroup = (jieqiIndex >= 18 && jieqiIndex <= 20);

    if (dunType == YinYangType.yin) {
      if (isLidongGroup) {
        for (var i = 0; i < idx2; i++) {
          juNumber += 3;
          while (juNumber > 9) {
            juNumber -= 9;
          }
        }
      } else {
        for (var i = 0; i < idx2; i++) {
          juNumber -= 3;
          while (juNumber < 1) {
            juNumber += 9;
          }
        }
      }
    } else if (dunType == YinYangType.yang) {
      if (isLidongGroup) {
        for (var i = 0; i < idx2; i++) {
          juNumber -= 3;
          while (juNumber < 1) {
            juNumber += 9;
          }
        }
      } else {
        for (var i = 0; i < idx2; i++) {
          juNumber += 3;
          while (juNumber > 9) {
            juNumber -= 9;
          }
        }
      }
    }
    return juNumber;
  }
}
