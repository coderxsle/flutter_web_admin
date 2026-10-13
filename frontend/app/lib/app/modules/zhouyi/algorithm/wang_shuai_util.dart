import 'shi_shen_util.dart';
import 'wu_xing_util.dart';

/// 五行生克查找。
class WuXingRelation {
  WuXingRelation._();

  static const Map<String, String> _shengWo = {
    '木': '水', '火': '木', '土': '火', '金': '土', '水': '金',
  };
  static const Map<String, String> _woSheng = {
    '木': '火', '火': '土', '土': '金', '金': '水', '水': '木',
  };
  static const Map<String, String> _woKe = {
    '木': '土', '土': '水', '水': '火', '火': '金', '金': '木',
  };
  static const Map<String, String> _keWo = {
    '木': '金', '火': '水', '土': '木', '金': '火', '水': '土',
  };

  /// 生我者（印）
  static String shengWo(String element) => _shengWo[element] ?? '';

  /// 我生者（食伤）
  static String woSheng(String element) => _woSheng[element] ?? '';

  /// 我克者（财）
  static String woKe(String element) => _woKe[element] ?? '';

  /// 克我者（官杀）
  static String keWo(String element) => _keWo[element] ?? '';
}

/// 日主旺衰与喜忌（扶抑法）。
class WangShuaiResult {
  const WangShuaiResult({
    required this.dayElement,
    required this.party,
    required this.level,
    required this.strong,
    required this.deLing,
    required this.deDi,
    required this.deShi,
    required this.xiYong,
    required this.jiShen,
  });

  /// 日主五行
  final String dayElement;

  /// 五组计数：比劫 / 印 / 食伤 / 财 / 官杀
  final Map<String, int> party;

  /// 强弱档位：极弱 / 偏弱 / 中和 / 偏强 / 极强
  final String level;

  /// 是否偏强，喜忌方向由它决定
  final bool strong;

  /// 得令：月支本气属同党
  final bool deLing;

  /// 得地：日支本气属同党
  final bool deDi;

  /// 得势：除日干外的三个天干里有同党
  final bool deShi;

  /// 喜用五行
  final List<String> xiYong;

  /// 忌神五行
  final List<String> jiShen;

  /// 同党（比劫 + 印）
  int get sameCount => (party['比劫'] ?? 0) + (party['印'] ?? 0);

  /// 异党（食伤 + 财 + 官杀）
  int get otherCount =>
      (party['食伤'] ?? 0) + (party['财'] ?? 0) + (party['官杀'] ?? 0);

  /// 同党占比 0~1
  double get sameRatio {
    final total = sameCount + otherCount;
    return total == 0 ? 0 : sameCount / total;
  }

  /// 同党占比百分数，保留一位小数
  String get samePercent => '${(sameRatio * 100).toStringAsFixed(1)}%';

  /// 「得令 · 得势」这样的三项摘要
  String get supportLabel {
    final parts = <String>[
      if (deLing) '得令',
      if (deDi) '得地',
      if (deShi) '得势',
    ];
    return parts.isEmpty ? '失令失地失势' : parts.join(' · ');
  }
}

/// 旺衰判断。
///
/// 统计口径与五行个数一致：四柱天干各计 1、地支本气各计 1，合计 8 个字。
/// 比劫与印归同党，食伤、财、官杀归异党；同党占过半即作偏强论。
/// 得令看月支本气、得地看日支本气、得势看除日干外的三个天干，均以同党五行记。
class WangShuaiUtil {
  WangShuaiUtil._();

  /// 强弱分档阈值（按同党占比）
  static const double jiQiang = 0.7;
  static const double pianQiang = 0.55;
  static const double pianRuo = 0.45;
  static const double jiRuo = 0.3;

  static WangShuaiResult judge(String dayGan, List<String> pillars) {
    final me = WuXingUtil.ganOf(dayGan);
    final count = WuXingUtil.count(pillars);
    final sheng = WuXingRelation.shengWo(me);
    final woSheng = WuXingRelation.woSheng(me);
    final woKe = WuXingRelation.woKe(me);
    final keWo = WuXingRelation.keWo(me);

    final party = <String, int>{
      '比劫': count[me] ?? 0,
      '印': count[sheng] ?? 0,
      '食伤': count[woSheng] ?? 0,
      '财': count[woKe] ?? 0,
      '官杀': count[keWo] ?? 0,
    };

    final same = party['比劫']! + party['印']!;
    final other = party['食伤']! + party['财']! + party['官杀']!;
    final ratio = (same + other) == 0 ? 0.0 : same / (same + other);
    final strong = ratio > 0.5;

    final tongDang = {me, sheng};
    final deLing = _zhiIn(pillars, 1, tongDang);
    final deDi = _zhiIn(pillars, 2, tongDang);
    final deShi = _ganIn(pillars, tongDang);

    final xiYong = _ordered(strong ? [keWo, woKe, woSheng] : [sheng, me]);
    final jiShen = _ordered(strong ? [sheng, me] : [keWo, woKe, woSheng]);

    String level;
    if (ratio >= jiQiang) {
      level = '极强';
    } else if (ratio >= pianQiang) {
      level = '偏强';
    } else if (ratio > pianRuo) {
      level = '中和';
    } else if (ratio > jiRuo) {
      level = '偏弱';
    } else {
      level = '极弱';
    }

    return WangShuaiResult(
      dayElement: me,
      party: party,
      level: level,
      strong: strong,
      deLing: deLing,
      deDi: deDi,
      deShi: deShi,
      xiYong: xiYong,
      jiShen: jiShen,
    );
  }

  /// 指定柱位的地支本气是否落在 [targets] 里
  static bool _zhiIn(List<String> pillars, int index, Set<String> targets) {
    if (index >= pillars.length || pillars[index].length < 2) return false;
    return targets.contains(WuXingUtil.zhiWuXing[pillars[index].substring(1, 2)]);
  }

  /// 除日干外的三个天干里是否有落在 [targets] 的
  static bool _ganIn(List<String> pillars, Set<String> targets) {
    for (var i = 0; i < pillars.length; i++) {
      if (i == 2 || pillars[i].length < 2) continue; // i == 2 为日柱，跳过日干
      if (targets.contains(WuXingUtil.ganWuXing[pillars[i].substring(0, 1)])) {
        return true;
      }
    }
    return false;
  }

  /// 去重后按木火土金水排序
  static List<String> _ordered(List<String> elements) =>
      WuXingUtil.elements.where(elements.contains).toList();
}

/// 格局：以月支本气所配十神取格。
class GeJuUtil {
  GeJuUtil._();

  static const Map<String, String> geNames = {
    '比肩': '建禄格',
    '劫财': '月刃格',
    '食神': '食神格',
    '伤官': '伤官格',
    '偏财': '偏财格',
    '正财': '正财格',
    '七杀': '七杀格',
    '正官': '正官格',
    '偏印': '偏印格',
    '正印': '正印格',
  };

  /// 月支本气
  static const Map<String, String> benQi = {
    '子': '癸', '丑': '己', '寅': '甲', '卯': '乙', '辰': '戊', '巳': '丙',
    '午': '丁', '未': '己', '申': '庚', '酉': '辛', '戌': '戊', '亥': '壬',
  };

  /// 月支本气所配十神，空串表示月支非法
  static String shiShenOf(String dayGan, String monthZhi) {
    final qi = benQi[monthZhi];
    if (qi == null) return '';
    return ShiShenUtil.fullOf(dayGan, qi);
  }

  static String of(String dayGan, String monthZhi) =>
      geNames[shiShenOf(dayGan, monthZhi)] ?? '';
}

/// 人元司令分野。
///
/// 取《渊海子平》的月令人元分野：交节后各段天数由不同藏干司权。
/// 天数自交节时刻按实际时间差计算，不做「交节当天算第一日」的取整。
class RenYuanUtil {
  RenYuanUtil._();

  /// 月支 → （该段天数上界，司权天干）
  static const Map<String, List<(int, String)>> table = {
    '寅': [(7, '戊'), (14, '丙'), (30, '甲')],
    '卯': [(10, '甲'), (30, '乙')],
    '辰': [(9, '乙'), (12, '癸'), (30, '戊')],
    '巳': [(7, '戊'), (14, '庚'), (30, '丙')],
    '午': [(10, '丙'), (19, '己'), (30, '丁')],
    '未': [(9, '丁'), (12, '乙'), (30, '己')],
    '申': [(7, '戊'), (14, '壬'), (30, '庚')],
    '酉': [(10, '庚'), (30, '辛')],
    '戌': [(9, '辛'), (12, '丁'), (30, '戊')],
    '亥': [(7, '戊'), (14, '甲'), (30, '壬')],
    '子': [(10, '壬'), (30, '癸')],
    '丑': [(9, '癸'), (12, '辛'), (30, '己')],
  };

  /// 交节后第 [days] 天的司权天干，负数或月支非法返回空串
  static String of(String monthZhi, double days) {
    final list = table[monthZhi];
    if (list == null || days < 0) return '';
    for (final e in list) {
      if (days < e.$1) return e.$2;
    }
    return list.last.$2;
  }

  /// 交节时刻「yyyy年MM月dd日HH时MM分SS秒」到出生时刻的天数差
  static double daysAfter(String jieQiTime, DateTime birth) {
    final jq = parseJieQiTime(jieQiTime);
    if (jq == null) return -1;
    return birth.difference(jq).inMinutes / 1440.0;
  }

  static final RegExp _jtimePattern = RegExp(
    r'(\d{1,4})年(\d{1,2})月(\d{1,2})日(\d{1,2})时(\d{1,2})分(\d{1,2})秒',
  );

  /// 解析节气时刻字符串，格式不认识返回 null
  static DateTime? parseJieQiTime(String value) {
    final m = _jtimePattern.firstMatch(value);
    if (m == null) return null;
    return DateTime(
      int.parse(m.group(1)!),
      int.parse(m.group(2)!),
      int.parse(m.group(3)!),
      int.parse(m.group(4)!),
      int.parse(m.group(5)!),
      int.parse(m.group(6)!),
    );
  }
}
