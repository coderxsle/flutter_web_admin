import 'zhouyi_constants.dart';

/// 地支藏干（人元）。
///
/// 每支的藏干串按本气、中气、余气的顺序书写，与字符顺序一致。
/// 五行个数与旺衰判断走的仍是「本气各计 1」的口径；[weightedOf] 的权重只在
/// 需要含藏干计权的场合（如运势评分）使用，两套口径不要混用。
class ZangGanUtil {
  ZangGanUtil._();

  /// 子→亥 的藏干串
  static const List<String> values = [
    '癸', '己癸辛', '甲丙戊', '乙', '戊乙癸', '丙戊庚',
    '丁己', '己乙丁', '庚戊壬', '辛', '戊辛丁', '壬甲',
  ];

  /// 本气、中气、余气的权重
  static const List<double> weights = [0.6, 0.3, 0.1];

  /// 地支所含天干，非法地支返回空表
  static List<String> of(String zhi) {
    if (zhi.isEmpty) return const [];
    final i = ZhouyiConst.shiErDiZhi.indexOf(zhi);
    return i < 0 ? const [] : values[i].split('');
  }

  /// 藏干及其权重，两表等长；支上藏干多于三位时，多出的按最后一位权重计
  static List<(String, double)> weightedOf(String zhi) {
    final gans = of(zhi);
    return [
      for (var i = 0; i < gans.length; i++)
        (gans[i], i < weights.length ? weights[i] : weights.last),
    ];
  }

  /// 四柱的地支，缺字的位置记空串
  static List<String> zhisOf(List<String> pillars) =>
      [for (final p in pillars) p.length >= 2 ? p.substring(1, 2) : ''];
}
