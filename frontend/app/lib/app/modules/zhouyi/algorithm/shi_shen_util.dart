import 'zhouyi_constants.dart';

/// 十神取用工具。
///
/// 与 [BaziCalculator] 里内联的十神环同源：以日干阴阳定「比劫」或「劫比」起排，
/// 索引目标天干在 [ZhouyiConst.shiTianGan] 中的位置即得十神。
class ShiShenUtil {
  ShiShenUtil._();

  /// 阳日干起排环（甲丙戊庚壬），索引 i 对应十天干同序
  static const String _yangRiganRing = '比劫食傷才財殺官梟印比劫食傷才財殺官梟印';

  /// 阴日干起排环（乙丁己辛癸）
  static const String _yinRiganRing = '劫比傷食財才官殺印梟劫比傷食財才官殺印梟';

  /// 十神简称到全称，算法取的是繁体字（傷財殺梟），此处转简体全称
  static const Map<String, String> fullName = {
    '比': '比肩',
    '劫': '劫财',
    '食': '食神',
    '傷': '伤官',
    '才': '偏财',
    '財': '正财',
    '殺': '七杀',
    '官': '正官',
    '梟': '偏印',
    '印': '正印',
  };

  /// 目标干支相对 [dayGan] 的十神简称；参数非法返回空串。
  ///
  /// [targetGanzhi] 传两字干支时只看其天干。
  static String of(String dayGan, String targetGanzhi) {
    if (dayGan.isEmpty || targetGanzhi.isEmpty) return '';
    final di = ZhouyiConst.shiTianGan.indexOf(dayGan.substring(0, 1));
    final ti = ZhouyiConst.shiTianGan.indexOf(targetGanzhi.substring(0, 1));
    if (di < 0 || ti < 0) return '';

    final yang = di % 2 == 0;
    final ring = yang ? _yangRiganRing : _yinRiganRing;
    final idx = (yang ? 10 - di : 10 - (di - 1)) + ti;
    if (idx < 0 || idx >= ring.length) return '';
    return ring.substring(idx, idx + 1);
  }

  /// 完整十神名，取不到时回落成简称
  static String fullOf(String dayGan, String targetGanzhi) {
    final short = of(dayGan, targetGanzhi);
    return fullName[short] ?? short;
  }
}
