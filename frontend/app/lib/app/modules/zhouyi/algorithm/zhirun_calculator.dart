import 'chn_chinese_calendar.dart';
import 'zhouyi_constants.dart';

/// 置闰法计算结果
class ZhirunResult {
  /// 局数 1-9
  final int juNumber;

  /// 0=阴遁 1=阳遁
  final int dunType;

  /// 所行之节气名。超神时提前用未来节气，接气时沿用前一节气
  final String jieqi;

  /// 所行之节气索引，0=立春
  final int jieqiIndex;

  /// 所行节气的交节时刻
  final String jieqiTime;

  /// 是否落在闰奇（重演芒种、大雪三元）的十五日内
  final bool isLeap;

  ZhirunResult(
    this.juNumber,
    this.dunType,
    this.jieqi,
    this.jieqiIndex, {
    this.jieqiTime = '',
    this.isLeap = false,
  });
}

/// 置闰法「节气槽」排布信息，供自检与测试使用
class ZhirunSlotInfo {
  /// 槽首日（上元符头日）公历日期
  final String slotStartDate;

  /// 所行节气索引，0=立春
  final int jieqiIndex;

  /// 所行节气的交节时刻
  final String jieqiTime;

  /// 上元符头比节气交节日早几日；负数为符头后到（接气）
  final int chaoDays;

  /// 槽内三元：0=上元 1=中元 2=下元
  final int yuanIndex;

  /// 是否为闰奇槽
  final bool isLeap;

  ZhirunSlotInfo(
    this.slotStartDate,
    this.jieqiIndex,
    this.jieqiTime,
    this.chaoDays,
    this.yuanIndex,
    this.isLeap,
  );
}

/// 奇门遁甲置闰法（古法：符头定元 + 超神接气 + 置闰）
///
/// 依据《奇门遁甲统宗·置闰法》《造命宗镜集》：甲己日为符头，一符头管五日一元；
/// 上元符头甲子己卯甲午己酉，中元甲寅甲申己巳己亥，下元甲辰甲戌己丑己未；
/// 符头先到为超、节气先到为接，超神满九日（含首尾计日）则于芒种、大雪之后
/// 重演该节气的上中下三元十五日，是为闰奇。
class ZhirunCalculator {
  ZhirunCalculator._();

  /// 超神阈值：古籍「超不过九」按符头、节气含首尾计日，故实差取八日
  static const int _leapChaoDays = 8;

  /// 相位锚点：《统宗》康熙五十七年五月十六甲子置闰芒种、六月初二己卯为夏至上局
  static const int _anchorJieqi = 1718 * 24 + 9; // 1718 年夏至
  static const int _anchorShift = 7; // 夏至后七日，即己卯日

  static final List<_Node> _forward = [];
  static final List<_Node> _backwise = [];
  static final Map<int, List<double>> _jqCache = {};
  static List<_Node>? _ordered;

  /// 排盘：返回局数、阴阳遁、所行节气
  static ZhirunResult calculate(
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
  ) {
    final info = slotOf(year, month, day, hour, minute, second);
    final idx = info.jieqiIndex;
    final yang = idx < 9 || idx > 20;

    var ju = ZhouyiConst.juNumbers[idx];
    for (var i = 0; i < info.yuanIndex; i++) {
      ju += yang ? 6 : -6;
      while (ju > 9) {
        ju -= 9;
      }
      while (ju < 1) {
        ju += 9;
      }
    }

    return ZhirunResult(
      ju,
      yang ? YinYangType.yang : YinYangType.yin,
      ZhouyiConst.jq0Arr[idx],
      idx,
      jieqiTime: info.jieqiTime,
      isLeap: info.isLeap,
    );
  }

  /// 定位某时刻所在的节气槽（不查四柱，只按符头网格推节气与三元）
  static ZhirunSlotInfo slotOf(
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
  ) {
    final cal = ChnChineseCalendar.instance;
    var t = cal.dateToJuliandTimeWithYear(year, month, day, 0);
    t += cal.dateToJuliandTimeWithHour(hour, minute, second);

    final nodes = _ensure(year);
    // 晚子时换日，与四柱日干支同一约定
    final dayNum = _dayNumber(_dayStart(t + 1 / 24.0));

    var lo = 0, hi = nodes.length - 1;
    while (lo < hi) {
      final mid = (lo + hi + 1) >> 1;
      if (_dayNumber(nodes[mid].start) <= dayNum) {
        lo = mid;
      } else {
        hi = mid - 1;
      }
    }

    final node = nodes[lo];
    final startDay = _dayNumber(node.start);
    final span = ((nodes[lo + 1].start - node.start) / 15).round();
    final step = (dayNum - startDay) ~/ 15;
    final isLeap = span == 13 && step == 12;
    final k = node.k + (isLeap ? 11 : step);

    return ZhirunSlotInfo(
      _dateText(startDay + step * 15),
      _jieqiIndexOf(k),
      ChnChineseCalendar.instance.jtime(false, _jieqiJD(k)),
      _dayNumber(_jieqiJD(k)) - (startDay + step * 15),
      (dayNum - startDay - step * 15) ~/ 5,
      isLeap,
    );
  }

  // -------------------------------------------------------------------------
  // 二至槽链
  // -------------------------------------------------------------------------

  static List<_Node> _ensure(int year) {
    if (_forward.isEmpty) {
      final start =
          _dayStart(_jieqiJD(_anchorJieqi)) + _anchorShift;
      _forward.add(_Node(start, _anchorJieqi));
      _ordered = null;
    }
    while (_forward.last.k ~/ 24 < year + 2) {
      _stepForward();
    }
    while ((_backwise.isEmpty ? _forward.first.k : _backwise.last.k) ~/ 24 >
        year - 2) {
      _stepBackwise();
    }
    return _ordered ??= [
      ..._backwise.reversed,
      ..._forward,
    ];
  }

  /// 前进一个二至槽：候选起点比节气早满八日，则中间插入一个闰槽
  static void _stepForward() {
    final cur = _forward.last;
    final nextK = cur.k + 12;
    final cand = cur.start + 180;
    final chao = _dayNumber(_jieqiJD(nextK)) - _dayNumber(cand);
    _forward.add(_Node(chao >= _leapChaoDays ? cand + 15 : cand, nextK));
    _ordered = null;
  }

  /// 回退一个二至槽：该半年若曾置闰，则起点后移十五日
  static void _stepBackwise() {
    final cur = _backwise.isEmpty ? _forward.first : _backwise.last;
    final prevK = cur.k - 12;
    final cand = cur.start - 180;
    final chao = _dayNumber(_jieqiJD(prevK)) - _dayNumber(cand);
    _backwise.add(_Node(chao < _leapChaoDays - 15 ? cand - 15 : cand, prevK));
    _ordered = null;
  }

  // -------------------------------------------------------------------------
  // 历法小工具
  // -------------------------------------------------------------------------

  static int _jieqiIndexOf(int k) => ((k % 24) + 24) % 24;

  /// 儒略日 → 所在公历日序。交节时刻在午后时不可进位，故向下取整
  static int _dayNumber(double jd) => (jd + 0.5).floor();

  static List<double> _yearJq(int year) => _jqCache.putIfAbsent(year, () {
        final t = List<double>.filled(30, 0);
        ChnChineseCalendar.instance.getPureJQsinceSpring2(year, 0, 0, 0, t);
        return t;
      });

  static double _jieqiJD(int k) {
    final year = (k / 24).floor();
    return _yearJq(year)[k - year * 24];
  }

  static double _dayStart(double jd) {
    final d = _jdToDate(jd);
    return ChnChineseCalendar.instance
        .dateToJuliandTimeWithYear(d[0], d[1], d[2], 0);
  }

  static String _dateText(int dayNum) {
    final d = _jdToDate(dayNum - 0.5);
    return '${d[0]}-${d[1].toString().padLeft(2, '0')}'
        '-${d[2].toString().padLeft(2, '0')}';
  }

  static List<int> _jdToDate(double jd) {
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
}

/// 二至槽：夏至、冬至各一，半年一步，起点为当期上元符头日
class _Node {
  final double start;
  final int k;

  const _Node(this.start, this.k);
}
