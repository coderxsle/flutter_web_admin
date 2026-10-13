import 'zhouyi_constants.dart';

/// 命宫与身宫。
///
/// 取法（两宫均为流派分歧项，这里取最通行的一套，便于日后按流派替换）：
/// - 命宫：《渊海子平》十四/二十六减法 —— 月按节气月支记数（寅=1…丑=12），
///   时按子=1 顺记，两数相加，未过 14 者以 14 减、已过 14 者以 26 减，余数自子起数。
/// - 身宫：两数相加，过 12 减 12，同样自子起数。
/// - 两宫天干均以年干起五虎遁配出。
class MingGongUtil {
  MingGongUtil._();

  /// 五虎遁：年干 → 寅月天干
  static const Map<String, String> _wuHuDun = {
    '甲': '丙', '己': '丙',
    '乙': '戊', '庚': '戊',
    '丙': '庚', '辛': '庚',
    '丁': '壬', '壬': '壬',
    '戊': '甲', '癸': '甲',
  };

  /// 月支序（节气月）：寅 = 1 … 丑 = 12；空串返回 0
  static int monthNo(String monthZhi) {
    if (monthZhi.isEmpty) return 0;
    final i = ZhouyiConst.shiErDiZhi.indexOf(monthZhi);
    return i < 0 ? 0 : (i - 2 + 12) % 12 + 1;
  }

  /// 时支序：子 = 1 … 亥 = 12；空串返回 0
  static int hourNo(String hourZhi) {
    if (hourZhi.isEmpty) return 0;
    return ZhouyiConst.shiErDiZhi.indexOf(hourZhi) + 1;
  }

  /// 命宫地支；参数非法返回空串
  static String mingGongZhi(String monthZhi, String hourZhi) {
    final m = monthNo(monthZhi);
    final h = hourNo(hourZhi);
    if (m == 0 || h == 0) return '';
    final sum = m + h;
    var n = sum <= 14 ? 14 - sum : 26 - sum;
    if (n == 0) n = 12;
    if (n < 1 || n > 12) return '';
    return ZhouyiConst.shiErDiZhi[(n - 1) % 12];
  }

  /// 身宫地支；参数非法返回空串
  static String shenGongZhi(String monthZhi, String hourZhi) {
    final m = monthNo(monthZhi);
    final h = hourNo(hourZhi);
    if (m == 0 || h == 0) return '';
    var n = (m + h) % 12;
    if (n == 0) n = 12;
    return ZhouyiConst.shiErDiZhi[(n - 1) % 12];
  }

  /// 以年干起五虎遁，给指定地支配天干（作用同「该支作月支时的月干」）
  static String ganOf(String yearGan, String zhi) {
    final start = _wuHuDun[yearGan];
    if (start == null || zhi.isEmpty) return '';
    final zi = ZhouyiConst.shiErDiZhi.indexOf(zhi);
    if (zi < 0) return '';
    final si = ZhouyiConst.shiTianGan.indexOf(start);
    final offset = (zi - ZhouyiConst.shiErDiZhi.indexOf('寅') + 12) % 12;
    return ZhouyiConst.shiTianGan[(si + offset) % 10];
  }
}
