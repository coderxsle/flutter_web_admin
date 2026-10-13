import 'shi_shen_util.dart';
import 'wang_shuai_util.dart';
import 'wu_xing_util.dart';
import 'zang_gan_util.dart';

/// 一步运（大运 / 流年 / 流月）相对本命的吉凶评分。
class YunShiScore {
  const YunShiScore({
    required this.ganzhi,
    required this.score,
    required this.delta,
    required this.ganShiShen,
    required this.zhiShiShen,
    required this.grade,
  });

  /// 该步运的干支
  final String ganzhi;

  /// 0~100，基准 50 为平
  final int score;

  /// 相对基准分的偏移，正为扶、负为抑
  final int delta;

  /// 运干对日主的十神
  final String ganShiShen;

  /// 运支本气对日主的十神
  final String zhiShiShen;

  /// 吉凶档位
  final String grade;

  /// true 表示偏吉，用于折线图上色
  bool get good => score >= 65;

  /// 「辛巳 正官/正印」
  String get label => '$ganzhi $ganShiShen/$zhiShiShen';

  @override
  String toString() => '$label $score($grade)';
}

/// 运势评分：用神法（扶抑）。
///
/// 拿本命的喜用、忌神五行给该步运的干支打分：运干五行按满权重 20 计，
/// 运支按藏干加权（本气 0.6 / 中气 0.3 / 余气 0.1）共 30 计，命中喜用记正、
/// 命中忌神记负，落在基准分 50 上得到 0~100。
///
/// 这不是命理定论，只是把「这步运对本命是扶还是抑」折算成可以横向比较的数字。
class YunShiUtil {
  YunShiUtil._();

  /// 基准分，干支全中性时取它
  static const int base = 50;

  /// 运干满权重
  static const double ganWeight = 20;

  /// 运支满权重
  static const double zhiWeight = 30;

  static YunShiScore of(
    String ganzhi, {
    required String dayGan,
    required WangShuaiResult wangShuai,
  }) {
    final gan = ganzhi.isEmpty ? '' : ganzhi.substring(0, 1);
    final zhi = ganzhi.length >= 2 ? ganzhi.substring(1, 2) : '';

    final xi = wangShuai.xiYong;
    final ji = wangShuai.jiShen;

    final delta = _sign(WuXingUtil.ganOf(gan), xi, ji) * ganWeight +
        _zhiDelta(zhi, xi, ji) * zhiWeight;
    final rounded = delta.round();
    final score = (base + rounded).clamp(0, 100).toInt();

    return YunShiScore(
      ganzhi: ganzhi,
      score: score,
      delta: rounded,
      ganShiShen: ShiShenUtil.fullOf(dayGan, gan),
      zhiShiShen: _zhiShiShen(dayGan, zhi),
      grade: gradeOf(score),
    );
  }

  /// 批量打分，跳过不足两字的项
  static List<YunShiScore> list(
    List<String> ganzhiList, {
    required String dayGan,
    required WangShuaiResult wangShuai,
  }) =>
      [
        for (final g in ganzhiList)
          if (g.length >= 2) of(g, dayGan: dayGan, wangShuai: wangShuai),
      ];

  /// 运势分最高的那一步，列表为空返回 null
  static YunShiScore? best(List<YunShiScore> scores) {
    if (scores.isEmpty) return null;
    var best = scores.first;
    for (final s in scores) {
      if (s.score > best.score) best = s;
    }
    return best;
  }

  static String gradeOf(int score) {
    if (score >= 80) return '大吉';
    if (score >= 65) return '吉';
    if (score >= 50) return '平';
    if (score >= 35) return '欠佳';
    return '凶';
  }

  /// 地支本气所配十神
  static String _zhiShiShen(String dayGan, String zhi) {
    final benQi = GeJuUtil.benQi[zhi];
    return benQi == null ? '' : ShiShenUtil.fullOf(dayGan, benQi);
  }

  /// 地支藏干加权后的正负值，范围 -1~1
  static double _zhiDelta(String zhi, List<String> xi, List<String> ji) {
    var acc = 0.0;
    var total = 0.0;
    for (final (gan, weight) in ZangGanUtil.weightedOf(zhi)) {
      acc += _sign(WuXingUtil.ganOf(gan), xi, ji) * weight;
      total += weight;
    }
    return total == 0 ? 0 : acc / total;
  }

  /// 喜用记 +1、忌神记 -1、其余不计
  static int _sign(String element, List<String> xi, List<String> ji) {
    if (element.isEmpty) return 0;
    if (xi.contains(element)) return 1;
    if (ji.contains(element)) return -1;
    return 0;
  }
}
