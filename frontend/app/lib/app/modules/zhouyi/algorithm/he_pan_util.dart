import 'gan_zhi_relation.dart';
import 'wang_shuai_util.dart';
import 'wu_xing_util.dart';

/// 合盘里的一项判词。
class HePanItem {
  const HePanItem({
    required this.title,
    required this.detail,
    required this.point,
  });

  /// 项目名，如「夫妻宫（日支）」
  final String title;

  /// 判词，如「亥卯三合，情意相投」
  final String detail;

  /// 该项加减分，正为吉
  final int point;

  bool get good => point > 0;

  bool get bad => point < 0;
}

/// 两造合盘的结果。
class HePanResult {
  const HePanResult({
    required this.items,
    required this.score,
    required this.level,
    required this.summary,
  });

  final List<HePanItem> items;

  /// 0~100
  final int score;

  /// 上吉 / 中吉 / 平 / 欠佳 / 相冲
  final String level;

  /// 一句话总评
  final String summary;

  /// 单项加分与减分的合计，等于 [score] 减基准分
  int get totalPoint => items.fold(0, (sum, e) => sum + e.point);
}

/// 地支某个宫位的加减分表
class _ZhiWeight {
  const _ZhiWeight(this.points, this.same);

  /// 关系名 → 分值
  final Map<String, int> points;

  /// 同支时的分值
  final int same;
}

/// 合盘（合婚）。
///
/// 取传统合婚最常看的三处地支 —— 年支（生肖宫）、日支（夫妻宫）、月支（月令），
/// 加上日干生合、年命纳音与双方用神互补，六项加减后落成 0~100 的分。
///
/// 地支关系走 [GanZhiRelation.zhiPairKinds]，与盘内合冲刑害同源。
/// 同一对支可能同时命中多项（巳亥既冲又害），此时分值与判词一并叠加，不做取舍。
/// 这只是排盘的参考维度，不是婚配结论。
class HePanUtil {
  HePanUtil._();

  /// 基准分，六项全中性时取它
  static const int base = 60;

  static const _ZhiWeight _nianWeight = _ZhiWeight(
    {'六合': 15, '三合': 12, '相冲': -14, '六害': -7, '相刑': -9},
    3,
  );

  static const _ZhiWeight _yueWeight = _ZhiWeight(
    {'六合': 8, '三合': 6, '相冲': -8, '六害': -4, '相刑': -5},
    0,
  );

  static const _ZhiWeight _riWeight = _ZhiWeight(
    {'六合': 20, '三合': 16, '相冲': -20, '六害': -10, '相刑': -12},
    -2,
  );

  /// [aPillars] / [bPillars] 为两造四柱，[aNayin] / [bNayin] 为两造年柱纳音（如「海中金」）。
  static HePanResult compare({
    required List<String> aPillars,
    required WangShuaiResult aWang,
    required List<String> bPillars,
    required WangShuaiResult bWang,
    String aName = '甲',
    String bName = '乙',
    String aNayin = '',
    String bNayin = '',
  }) {
    final aZhi = GanZhiRelation.zhisOf(aPillars);
    final bZhi = GanZhiRelation.zhisOf(bPillars);
    final aGan = _ganAt(aPillars, 2);
    final bGan = _ganAt(bPillars, 2);

    final items = <HePanItem>[
      _item('日主（日干）', _ganJudge(aGan, bGan)),
      _item('夫妻宫（日支）', _zhiJudge(_zhiAt(aZhi, 2), _zhiAt(bZhi, 2), _riWeight)),
      _item('生肖宫（年支）', _zhiJudge(_zhiAt(aZhi, 0), _zhiAt(bZhi, 0), _nianWeight)),
      _item('月令（月支）', _zhiJudge(_zhiAt(aZhi, 1), _zhiAt(bZhi, 1), _yueWeight)),
      _item('年命纳音', _nayinJudge(aNayin, bNayin)),
      _item('用神互补', _yongShenJudge(aName, aWang, bName, bWang)),
    ];

    final score = (base + items.fold(0, (sum, e) => sum + e.point))
        .clamp(0, 100)
        .toInt();
    final level = levelOf(score);

    return HePanResult(
      items: items,
      score: score,
      level: level,
      summary: summaryOf(items, level),
    );
  }

  static HePanItem _item(String title, (int, String) judged) =>
      HePanItem(title: title, detail: judged.$2, point: judged.$1);

  static String _ganAt(List<String> pillars, int index) =>
      index < pillars.length && pillars[index].isNotEmpty
          ? pillars[index].substring(0, 1)
          : '';

  static String _zhiAt(List<String> zhis, int index) =>
      index < zhis.length ? zhis[index] : '';

  /// 日干之间：五合最吉，相冲最忌，其次论生、同、克
  static (int, String) _ganJudge(String a, String b) {
    if (a.isEmpty || b.isEmpty) return (0, '—');

    final kind = GanZhiRelation.ganPairKind(a, b);
    if (kind == '五合') {
      return (12, '$a$b合${GanZhiRelation.heQiOf(a, b)}，日主相合');
    }
    if (kind == '相冲') return (-7, '$a$b相冲，日主相冲');

    final ea = WuXingUtil.ganOf(a);
    final eb = WuXingUtil.ganOf(b);
    if (ea == eb) return (4, '同为$ea，性情相近');
    if (WuXingRelation.woSheng(ea) == eb) return (8, '$a（$ea）生$b（$eb）');
    if (WuXingRelation.woSheng(eb) == ea) return (8, '$b（$eb）生$a（$ea）');
    if (WuXingRelation.woKe(ea) == eb) return (-7, '$a（$ea）克$b（$eb）');
    if (WuXingRelation.woKe(eb) == ea) return (-7, '$b（$eb）克$a（$ea）');
    return (0, '$a$b无直接生克');
  }

  /// 某一处地支的合冲刑害，同支按同气论
  static (int, String) _zhiJudge(String a, String b, _ZhiWeight weight) {
    if (a.isEmpty || b.isEmpty) return (0, '—');
    if (a == b) return (weight.same, '$a$b同气');

    final hits = GanZhiRelation.zhiPairKinds(a, b);
    var point = 0;
    final texts = <String>[];
    for (final hit in hits) {
      final p = weight.points[hit];
      if (p == null) continue;
      point += p;
      texts.add(hit);
    }
    if (texts.isEmpty) return (0, '$a$b无合冲刑害');
    return (point, '$a$b${texts.join('、')}');
  }

  /// 年命纳音：取纳音名的末字为五行
  static (int, String) _nayinJudge(String a, String b) {
    if (a.isEmpty || b.isEmpty) return (0, '—');
    final ea = a.substring(a.length - 1);
    final eb = b.substring(b.length - 1);
    if (ea == eb) return (4, '$a$b同为$ea命');
    if (WuXingRelation.woSheng(ea) == eb) return (6, '$a$b相生');
    if (WuXingRelation.woSheng(eb) == ea) return (6, '$b$a相生');
    if (WuXingRelation.woKe(ea) == eb) return (-5, '$a$b相克');
    if (WuXingRelation.woKe(eb) == ea) return (-5, '$b$a相克');
    return (0, '$a$b无生克');
  }

  /// 双方的日主五行是否落在对方的喜用里
  static (int, String) _yongShenJudge(
    String aName,
    WangShuaiResult a,
    String bName,
    WangShuaiResult b,
  ) {
    var point = 0;
    final texts = <String>[];

    if (b.dayElement.isNotEmpty) {
      if (a.xiYong.contains(b.dayElement)) {
        point += 6;
        texts.add('$bName的日主${b.dayElement}是$aName的喜用');
      } else if (a.jiShen.contains(b.dayElement)) {
        point -= 5;
        texts.add('$bName的日主${b.dayElement}正是$aName的忌神');
      }
    }
    if (a.dayElement.isNotEmpty) {
      if (b.xiYong.contains(a.dayElement)) {
        point += 6;
        texts.add('$aName的日主${a.dayElement}是$bName的喜用');
      } else if (b.jiShen.contains(a.dayElement)) {
        point -= 5;
        texts.add('$aName的日主${a.dayElement}正是$bName的忌神');
      }
    }

    if (texts.isEmpty) return (0, '两造日主互不为喜忌');
    return (point, texts.join('；'));
  }

  static String levelOf(int score) {
    if (score >= 85) return '上吉';
    if (score >= 72) return '中吉';
    if (score >= 58) return '平';
    if (score >= 44) return '欠佳';
    return '相冲';
  }

  /// 总评：取分量最重的两条判词缀在档位后面
  static String summaryOf(List<HePanItem> items, String level) {
    final sorted = items.where((e) => e.point != 0).toList()
      ..sort((a, b) => b.point.abs().compareTo(a.point.abs()));
    if (sorted.isEmpty) return '$level：两造干支两不相犯，平顺无奇。';
    return '$level：${sorted.take(2).map((e) => e.detail).join('；')}。';
  }
}
