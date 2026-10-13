import 'zhouyi_constants.dart';

/// 五行映射与统计。
///
/// 统计口径：四柱天干各计 1、四柱地支按其本气各计 1，合计 8 个字。
/// 这是最常见也最易解释的「八字五行个数」，不含藏干计权。
class WuXingUtil {
  WuXingUtil._();

  /// 展示顺序：木火土金水
  static const List<String> elements = ['木', '火', '土', '金', '水'];

  static const Map<String, String> ganWuXing = {
    '甲': '木', '乙': '木',
    '丙': '火', '丁': '火',
    '戊': '土', '己': '土',
    '庚': '金', '辛': '金',
    '壬': '水', '癸': '水',
  };

  /// 地支本气
  static const Map<String, String> zhiWuXing = {
    '子': '水', '丑': '土', '寅': '木', '卯': '木', '辰': '土', '巳': '火',
    '午': '火', '未': '土', '申': '金', '酉': '金', '戌': '土', '亥': '水',
  };

  /// 天干对应的五行，取不到返回空串
  static String ganOf(String gan) => ganWuXing[gan] ?? '';

  /// 统四柱八字的五行个数，固定返回五个 key
  static Map<String, int> count(List<String> ganzhiList) {
    final result = {for (final e in elements) e: 0};
    for (final ganzhi in ganzhiList) {
      if (ganzhi.length < 2) continue;
      final gan = ganWuXing[ganzhi.substring(0, 1)];
      final zhi = zhiWuXing[ganzhi.substring(1, 2)];
      if (gan != null) result[gan] = result[gan]! + 1;
      if (zhi != null) result[zhi] = result[zhi]! + 1;
    }
    return result;
  }

  /// 个数最多的一批五行（并列时全部返回）
  static List<String> strongest(Map<String, int> count) {
    if (count.isEmpty) return [];
    final max = count.values.reduce((a, b) => a > b ? a : b);
    if (max == 0) return [];
    return elements.where((e) => count[e] == max).toList();
  }

  /// 个数最少的一批五行；没有任何计数的五行也在此列出（含缺失的）
  static List<String> weakest(Map<String, int> count) {
    if (count.isEmpty) return [];
    final min = count.values.reduce((a, b) => a < b ? a : b);
    return elements.where((e) => count[e] == min).toList();
  }

  /// 完全未出现（个数为 0）的五行
  static List<String> missing(Map<String, int> count) =>
      elements.where((e) => (count[e] ?? 0) == 0).toList();

  /// 五行总数，用于条形比例
  static int total(Map<String, int> count) =>
      count.values.fold(0, (sum, v) => sum + v);
}

/// 四柱辅属盘（胎元等）。
class FuShuUtil {
  FuShuUtil._();

  /// 胎元：月柱天干进一位、地支进三位。如月柱丙寅 → 胎元丁巳
  static String taiYuan(String monthGanzhi) {
    if (monthGanzhi.length < 2) return '';
    final gi = ZhouyiConst.shiTianGan.indexOf(monthGanzhi.substring(0, 1));
    final zi = ZhouyiConst.shiErDiZhi.indexOf(monthGanzhi.substring(1, 2));
    if (gi < 0 || zi < 0) return '';
    return '${ZhouyiConst.shiTianGan[(gi + 1) % 10]}'
        '${ZhouyiConst.shiErDiZhi[(zi + 3) % 12]}';
  }
}
