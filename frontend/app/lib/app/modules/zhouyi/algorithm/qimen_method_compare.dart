import 'qimen_calculator.dart';
import 'zhirun_calculator.dart';
import 'zhouyi_constants.dart';
import 'zhouyi_models.dart';
import 'zy_datetime_model.dart';

/// 拆补、置闰两法用局不同的一段连续时辰
class QimenMethodDiffSegment {
  const QimenMethodDiffSegment({
    required this.startDay,
    required this.startShichen,
    required this.endDay,
    required this.endShichen,
    required this.shichenCount,
    required this.chaibuJu,
    required this.zhirunJu,
    required this.chaibuJuEnd,
    required this.zhirunJuEnd,
    required this.dunDiffers,
  });

  /// 起止日（时分秒为零）
  final DateTime startDay;
  final DateTime endDay;

  /// 起止时辰序号，0＝子时
  final int startShichen;
  final int endShichen;

  /// 该段内的时辰数
  final int shichenCount;

  /// 段首两法所行之局，形如「小满上元 阴遁3局」
  final String chaibuJu;
  final String zhirunJu;

  /// 段末两法所行之局；长段会跨三元，与段首不同
  final String chaibuJuEnd;
  final String zhirunJuEnd;

  /// 该段内是否出现阴阳遁不同
  final bool dunDiffers;
}

/// 某一年的两法用局差异统计
class QimenYearCompare {
  const QimenYearCompare({
    required this.year,
    required this.shichenDiff,
    required this.dayDiff,
    required this.segments,
    required this.leapCount,
    required this.leapText,
    required this.leapShichenDiff,
  });

  final int year;

  /// 全年用局不同的时辰数
  final int shichenDiff;

  /// 用局不同的天数
  final int dayDiff;

  final List<QimenMethodDiffSegment> segments;

  /// 该年闰奇次数，即置闰法重演芒种、大雪三元的次数
  final int leapCount;

  /// 首次闰奇的说明，形如「12-11 起大雪」；该年无闰奇为 null
  final String? leapText;

  /// 差异时辰中落在闰奇期内的数量，其余差异由超神接气造成
  final int leapShichenDiff;
}

/// 某一时刻两法所行之局的对照
class QimenMethodSnapshot {
  const QimenMethodSnapshot({
    required this.chaibuJu,
    required this.zhirunJu,
    required this.same,
    required this.dunDiffers,
  });

  final String chaibuJu;
  final String zhirunJu;
  final bool same;
  final bool dunDiffers;
}

/// 拆补法与置闰法的用局对比。
///
/// 两法的三元同出于甲己符头，故只比节气、阴阳遁、局数；差异恒发生在
/// 交节前后，源于拆补按交节时刻换节气、置闰按上元符头换节气。
class QimenMethodCompare {
  QimenMethodCompare._();

  /// 十二时辰的抽样时刻；子时取零时，与晚子时换日同一约定
  static const List<int> shichenHours = [
    0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22,
  ];

  static const String shichenNames = '子丑寅卯辰巳午未申酉戌亥';

  static final QimenCalculator _calculator = QimenCalculator();
  static final Map<int, QimenYearCompare> _yearCache = {};

  /// 全年差异，按年缓存
  static QimenYearCompare ofYear(int year) =>
      _yearCache.putIfAbsent(year, () => _scanYear(year));

  /// 某一时刻的两法对照
  static QimenMethodSnapshot at(ZYDatetimeModel dt) {
    final a = _calculator.calculate(dt, method: QimenMethod.chaibu).head;
    final b = _calculator.calculate(dt, method: QimenMethod.zhirun).head;
    return QimenMethodSnapshot(
      chaibuJu: juLabel(a),
      zhirunJu: juLabel(b),
      same: _sameJu(a, b),
      dunDiffers: a.dunType != b.dunType,
    );
  }

  /// 「小满上元 阴遁3局」
  static String juLabel(ZYHourQimenHeadModel h) {
    final dun = h.dunType == YinYangType.yang ? '阳' : '阴';
    return '${h.jieQi}${h.sanYuan}元 $dun遁${h.jushu}局';
  }

  /// 表格用的紧凑局名：「小满上元 阴遁3局」→「小满上元阴3局」；
  /// 段末与段首不同（跨三元）时用箭头相连，同节气则不复述
  static String juCompact(String start, [String? end]) {
    String one(String s) => s.replaceAll(' ', '').replaceAll('遁', '');
    final a = one(start);
    if (end == null || end == start) return a;
    final b = one(end);
    for (final jieQi in ZhouyiConst.jq0Arr) {
      if (a.startsWith(jieQi) && b.startsWith(jieQi)) {
        return '$a→${b.substring(jieQi.length)}';
      }
    }
    return '$a→$b';
  }

  static bool _sameJu(ZYHourQimenHeadModel a, ZYHourQimenHeadModel b) =>
      a.jieQi == b.jieQi &&
      a.sanYuan == b.sanYuan &&
      a.dunType == b.dunType &&
      a.jushu == b.jushu;

  static ZYHourQimenHeadModel _head(DateTime day, int hour, QimenMethod method) =>
      _calculator
          .calculate(
            ZYDatetimeModel(
              year: day.year,
              month: day.month,
              day: day.day,
              hour: hour,
              minute: 30,
            ),
            method: method,
          )
          .head;

  static QimenYearCompare _scanYear(int year) {
    final slots = <_Slot>[];
    var leapCount = 0;
    String? leapText;
    DateTime? lastLeapDay;

    for (var day = DateTime(year, 1, 1); day.year == year;) {
      final leapSlot =
          ZhirunCalculator.slotOf(day.year, day.month, day.day, 12, 0, 0);
      final leap = leapSlot.isLeap;
      // 闰奇期是连续的十五日，跨过间隔即进入新的一次闰奇
      if (leap) {
        if (lastLeapDay == null || day.difference(lastLeapDay).inDays > 1) {
          leapCount++;
          leapText ??= '${_monthDay(day)} 起'
              '${ZhouyiConst.jq0Arr[leapSlot.jieqiIndex]}';
        }
        lastLeapDay = day;
      }

      // 拆补法可能在交节时刻于日内换局，先探当日首尾，不换则整日同值
      final first = _head(day, shichenHours.first, QimenMethod.chaibu);
      final last = _head(day, shichenHours.last, QimenMethod.chaibu);
      if (_sameJu(first, last)) {
        final other = _head(day, 12, QimenMethod.zhirun);
        final differ = !_sameJu(first, other);
        final dun = differ && first.dunType != other.dunType;
        for (var i = 0; i < shichenHours.length; i++) {
          slots.add(_Slot(day, i, differ, dun, leap));
        }
      } else {
        for (var i = 0; i < shichenHours.length; i++) {
          final a = _head(day, shichenHours[i], QimenMethod.chaibu);
          final b = _head(day, shichenHours[i], QimenMethod.zhirun);
          final differ = !_sameJu(a, b);
          slots.add(
              _Slot(day, i, differ, differ && a.dunType != b.dunType, leap));
        }
      }
      day = day.add(const Duration(days: 1));
    }
    return _merge(year, slots, leapCount, leapText);
  }

  static String _monthDay(DateTime d) =>
      '${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static QimenYearCompare _merge(
    int year,
    List<_Slot> slots,
    int leapCount,
    String? leapText,
  ) {
    final segments = <QimenMethodDiffSegment>[];
    final days = <DateTime>{};
    var shichenDiff = 0;
    var leapShichenDiff = 0;
    var i = 0;
    while (i < slots.length) {
      if (!slots[i].differ) {
        i++;
        continue;
      }
      var j = i;
      var dun = false;
      while (true) {
        shichenDiff++;
        if (slots[j].leap) leapShichenDiff++;
        days.add(slots[j].day);
        dun = dun || slots[j].dunDiffers;
        if (j + 1 >= slots.length || !slots[j + 1].differ) break;
        j++;
      }
      final tail = slots[j];
      segments.add(
        QimenMethodDiffSegment(
          startDay: slots[i].day,
          startShichen: slots[i].shichen,
          endDay: tail.day,
          endShichen: tail.shichen,
          shichenCount: j - i + 1,
          chaibuJu: juLabel(_head(slots[i].day, shichenHours[slots[i].shichen],
              QimenMethod.chaibu)),
          zhirunJu: juLabel(_head(slots[i].day, shichenHours[slots[i].shichen],
              QimenMethod.zhirun)),
          chaibuJuEnd:
              juLabel(_head(tail.day, shichenHours[tail.shichen],
                  QimenMethod.chaibu)),
          zhirunJuEnd:
              juLabel(_head(tail.day, shichenHours[tail.shichen],
                  QimenMethod.zhirun)),
          dunDiffers: dun,
        ),
      );
      i = j + 1;
    }
    return QimenYearCompare(
      year: year,
      shichenDiff: shichenDiff,
      dayDiff: days.length,
      segments: segments,
      leapCount: leapCount,
      leapText: leapText,
      leapShichenDiff: leapShichenDiff,
    );
  }
}

/// 一个时辰的比对结论
class _Slot {
  const _Slot(this.day, this.shichen, this.differ, this.dunDiffers, this.leap);

  final DateTime day;
  final int shichen;
  final bool differ;
  final bool dunDiffers;

  /// 该时辰落在闰奇（重演芒种、大雪三元）的十五日内
  final bool leap;
}
