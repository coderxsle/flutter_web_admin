import 'zhouyi_constants.dart';

/// 四柱之间的一条干支关系。
class GanZhiRelationItem {
  const GanZhiRelationItem({
    required this.kind,
    required this.scope,
    required this.text,
    required this.auspicious,
  });

  /// 分组：天干 / 地支 / 合会
  final String kind;

  /// 命中的柱位，两柱关系为「年-月」，成局为「年 月 时」
  final String scope;

  /// 关系文本，如「甲己合土」
  final String text;

  /// 合会为 true、冲刑害为 false，仅用于区分配色
  final bool auspicious;

  /// 「年-月 甲己合土」
  String get label => '$scope $text';

  @override
  String toString() => label;
}

/// 四柱干支之间的合冲刑害与合会局。
///
/// 只算四柱本身：天干两两、地支两两，外加三支成局的三合与三会（含半合）。
/// 不含大运流年，也不做「隔位不成」「遥合力弱」之类的流派取舍 —— 同盘四柱一律平权比较。
class GanZhiRelation {
  GanZhiRelation._();

  /// 柱位名，下标与四柱一致
  static const List<String> pillarNames = ['年', '月', '日', '时'];

  /// 天干五合化气，下标取两干中较小的那个（甲己→土、乙庚→金…）
  static const List<String> heQi = ['土', '金', '水', '木', '火'];

  /// 三合局，中神为中间一位
  static const Map<String, String> sanHe = {
    '申子辰': '水',
    '亥卯未': '木',
    '寅午戌': '火',
    '巳酉丑': '金',
  };

  /// 三会方
  static const Map<String, String> sanHui = {
    '寅卯辰': '木',
    '巳午未': '火',
    '申酉戌': '金',
    '亥子丑': '水',
  };

  /// 三刑局：同局内任意两支相见即为相刑
  static const List<String> xingGroups = ['寅巳申', '丑戌未', '子卯'];

  /// 自刑地支：同支重见
  static const Set<String> ziXing = {'辰', '午', '酉', '亥'};

  /// 四柱地支，缺字的位置记空串
  static List<String> zhisOf(List<String> pillars) =>
      [for (final p in pillars) p.length >= 2 ? p.substring(1, 2) : ''];

  static List<GanZhiRelationItem> compute(List<String> pillars) {
    final out = <GanZhiRelationItem>[];
    if (pillars.length != 4) return out;

    final zhis = zhisOf(pillars);
    // 已成局的三合局，其内部两两不再单列半合
    final formed = sanHe.keys.where((ju) => _formed(zhis, ju)).toSet();

    for (var i = 0; i < 4; i++) {
      if (pillars[i].length < 2) continue;
      for (var j = i + 1; j < 4; j++) {
        if (pillars[j].length < 2) continue;
        final scope = '${pillarNames[i]}-${pillarNames[j]}';
        _ganPair(out, scope, pillars[i].substring(0, 1), pillars[j].substring(0, 1));
        _zhiPair(out, scope, zhis[i], zhis[j], formed);
      }
    }

    _ju(out, zhis);
    return out;
  }

  /// 天干两字的合冲：相隔五位为五合、相隔六位为相冲，其余返回空串
  static String ganPairKind(String a, String b) {
    final i = ZhouyiConst.shiTianGan.indexOf(a);
    final j = ZhouyiConst.shiTianGan.indexOf(b);
    if (i < 0 || j < 0 || i == j) return '';
    final d = (i - j).abs();
    if (d == 5) return '五合';
    return d == 6 ? '相冲' : '';
  }

  /// 五合所化之气，取两干中较小的那个（甲己→土、乙庚→金…）
  static String heQiOf(String a, String b) {
    final i = ZhouyiConst.shiTianGan.indexOf(a);
    final j = ZhouyiConst.shiTianGan.indexOf(b);
    if (i < 0 || j < 0 || (i - j).abs() != 5) return '';
    return heQi[i < j ? i : j];
  }

  /// 地支两字的关系名，可能同时命中多项（巳亥既冲又害），无关系返回空表。
  ///
  /// 只判到「三合同局」这一层；[compute] 里的半合还要看中神与是否已成局，
  /// 那部分依赖整个盘面，不在这里给。
  static List<String> zhiPairKinds(String a, String b) {
    final i = ZhouyiConst.shiErDiZhi.indexOf(a);
    final j = ZhouyiConst.shiErDiZhi.indexOf(b);
    if (i < 0 || j < 0) return const [];
    if (i == j) return ziXing.contains(a) ? const ['自刑'] : const [];

    final out = <String>[];
    final sum = (i + j) % 12;
    if (sum == 1) out.add('六合');
    if (sum == 7) out.add('六害');
    if ((i - j).abs() == 6) out.add('相冲');
    for (final g in xingGroups) {
      if (g.contains(a) && g.contains(b)) {
        out.add('相刑');
        break;
      }
    }
    for (final ju in sanHe.keys) {
      if (ju.contains(a) && ju.contains(b)) {
        out.add('三合');
        break;
      }
    }
    return out;
  }

  /// 两支是否同属一个三合局
  static bool sameSanHe(String a, String b) =>
      zhiPairKinds(a, b).contains('三合');

  /// 天干：相隔五位为五合、相隔六位为相冲（戊己居中无冲）
  static void _ganPair(
      List<GanZhiRelationItem> out, String scope, String a, String b) {
    switch (ganPairKind(a, b)) {
      case '五合':
        out.add(GanZhiRelationItem(
          kind: '天干',
          scope: scope,
          text: '$a$b合${heQiOf(a, b)}',
          auspicious: true,
        ));
      case '相冲':
        out.add(GanZhiRelationItem(
          kind: '天干',
          scope: scope,
          text: '$a$b相冲',
          auspicious: false,
        ));
    }
  }

  /// 地支：六合（和为 1）、六害（和为 7）、六冲（相隔六位）、相刑、自刑、半合
  static void _zhiPair(List<GanZhiRelationItem> out, String scope, String a,
      String b, Set<String> formedJu) {
    final i = ZhouyiConst.shiErDiZhi.indexOf(a);
    final j = ZhouyiConst.shiErDiZhi.indexOf(b);
    if (i < 0 || j < 0) return;

    for (final kind in zhiPairKinds(a, b)) {
      if (kind == '三合') continue; // 三合之外还要看中神与成局，另行判定
      out.add(GanZhiRelationItem(
        kind: '地支',
        scope: scope,
        text: '$a$b$kind',
        auspicious: kind == '六合',
      ));
    }

    // 同支只论自刑，不再论半合
    if (i == j) return;

    // 半合：三合局中的两支且带中神；该局已三支全时不再单列
    for (final entry in sanHe.entries) {
      final ju = entry.key;
      if (formedJu.contains(ju)) continue;
      if (!ju.contains(a) || !ju.contains(b)) continue;
      if (a != ju[1] && b != ju[1]) continue;
      out.add(GanZhiRelationItem(
        kind: '地支',
        scope: scope,
        text: '$a$b半合${entry.value}局',
        auspicious: true,
      ));
    }
  }

  /// 三合局与三会方：局中三支齐全才算成局
  static void _ju(List<GanZhiRelationItem> out, List<String> zhis) {
    sanHe.forEach((ju, wu) {
      if (!_formed(zhis, ju)) return;
      out.add(GanZhiRelationItem(
        kind: '合会',
        scope: _scopeOf(zhis, ju),
        text: '$ju三合$wu局',
        auspicious: true,
      ));
    });
    sanHui.forEach((ju, wu) {
      if (!_formed(zhis, ju)) return;
      out.add(GanZhiRelationItem(
        kind: '合会',
        scope: _scopeOf(zhis, ju),
        text: '$ju三会$wu方',
        auspicious: true,
      ));
    });
  }

  /// 局中三支是否都在四柱地支里。不能数命中的柱数 —— 同一支重见会误判成局。
  static bool _formed(List<String> zhis, String ju) =>
      ju.split('').every((z) => zhis.contains(z));

  /// 局中三支各自首次出现的柱位，按柱位顺序
  static String _scopeOf(List<String> zhis, String ju) {
    final hits = <int>[];
    for (final z in ju.split('')) {
      final i = zhis.indexOf(z);
      if (i >= 0) hits.add(i);
    }
    hits.sort();
    return hits.map((i) => pillarNames[i]).join(' ');
  }
}
