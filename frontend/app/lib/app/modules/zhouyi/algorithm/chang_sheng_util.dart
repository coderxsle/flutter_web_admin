import 'zhouyi_constants.dart';

/// 十二长生：某个天干落在某个地支上所处的旺衰阶段。
///
/// 取法：阳干（甲丙戊庚壬）自长生位顺行，阴干（乙丁己辛癸）自长生位逆行。
/// 这是《渊海子平》以来最通行的一套，也是「禄在临官、刃在帝旺」能成立的那一套。
class ChangShengUtil {
  ChangShengUtil._();

  static const List<String> stages = [
    '长生', '沐浴', '冠带', '临官', '帝旺', '衰',
    '病', '死', '墓', '绝', '胎', '养',
  ];

  /// 各天干的长生位
  static const Map<String, String> changShengZhi = {
    '甲': '亥', '乙': '午', '丙': '寅', '丁': '酉', '戊': '寅',
    '己': '酉', '庚': '巳', '辛': '子', '壬': '申', '癸': '卯',
  };

  /// 阳干：顺行；其余为阴干，逆行
  static const Set<String> yangGan = {'甲', '丙', '戊', '庚', '壬'};

  /// 天干在某地支上的阶段，取不到返回空串
  static String of(String gan, String zhi) {
    final start = changShengZhi[gan];
    if (start == null || zhi.isEmpty) return '';
    final si = ZhouyiConst.shiErDiZhi.indexOf(start);
    final zi = ZhouyiConst.shiErDiZhi.indexOf(zhi);
    if (si < 0 || zi < 0) return '';
    final step = yangGan.contains(gan) ? (zi - si + 12) % 12 : (si - zi + 12) % 12;
    return stages[step];
  }

  /// 天干在多个地支上的阶段，缺字的位置返回空串
  static List<String> listOf(String gan, List<String> zhis) =>
      [for (final z in zhis) of(gan, z)];
}
