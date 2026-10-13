import 'shen_sha_tables.dart';

/// 四柱神煞计算。
///
/// 以日干为基准的一类（天乙、太极、文昌、禄神、羊刃、金舆、国印）与
/// 以年支、日支为基准的一类，都是去查四柱**地支**；天德与月德以月支为基准，
/// 其中月德只见天干，天德值可能落在干上也可能落在支上。
class ShenShaCalculator {
  ShenShaCalculator._();

  /// 返回四柱各自命中的神煞，顺序为 [[年柱], [月柱], [日柱], [时柱]]。
  ///
  /// 四柱干支任一格式非法时返回四个空组，不抛异常。
  static List<List<String>> compute({
    required String yearGanzhi,
    required String monthGanzhi,
    required String dayGanzhi,
    required String hourGanzhi,
  }) {
    final pillars = [yearGanzhi, monthGanzhi, dayGanzhi, hourGanzhi];
    if (pillars.any((p) => p.length < 2)) {
      return List.generate(4, (_) => <String>[]);
    }

    final out = List.generate(4, (_) => <String>[]);
    final dayGan = dayGanzhi.substring(0, 1);
    final monthZhi = monthGanzhi.substring(1, 2);

    // 以日干为基准查四柱地支：贵人、禄刃、金舆、国印均属这一类
    _zhi(out, pillars, '天乙贵人', ShenShaTables.tianYiGuiRen[dayGan]);
    _zhi(out, pillars, '太极贵人', ShenShaTables.taiJiGuiRen[dayGan]);
    _zhi(out, pillars, '文昌贵人', ShenShaTables.wenChang[dayGan]);
    _zhi(out, pillars, '禄神', ShenShaTables.luShen[dayGan]);
    _zhi(out, pillars, '羊刃', ShenShaTables.yangRen[dayGan]);
    _zhi(out, pillars, '金舆', ShenShaTables.jinYu[dayGan]);
    _zhi(out, pillars, '国印贵人', ShenShaTables.guoYin[dayGan]);

    // 以年支与日支为基准查四柱地支
    for (final base in {yearGanzhi.substring(1, 2), dayGanzhi.substring(1, 2)}) {
      _zhi(out, pillars, '驿马', ShenShaTables.yiMa[base]);
      _zhi(out, pillars, '桃花', ShenShaTables.taoHua[base]);
      _zhi(out, pillars, '华盖', ShenShaTables.huaGai[base]);
      _zhi(out, pillars, '将星', ShenShaTables.jiangXing[base]);
      _zhi(out, pillars, '劫煞', ShenShaTables.jieSha[base]);
      _zhi(out, pillars, '亡神', ShenShaTables.wangShen[base]);
      _zhi(out, pillars, '孤辰', ShenShaTables.guChen[base]);
      _zhi(out, pillars, '寡宿', ShenShaTables.guaSu[base]);
      _zhi(out, pillars, '红鸾', ShenShaTables.hongLuan[base]);
      _zhi(out, pillars, '天喜', ShenShaTables.tianXi[base]);
    }

    // 月支取：天德的值可能落在干上也可能落在支上，两边都试
    final tianDe = ShenShaTables.tianDe[monthZhi];
    if (tianDe != null) {
      _gan(out, pillars, '天德贵人', tianDe);
      _zhi(out, pillars, '天德贵人', tianDe);
    }
    _gan(out, pillars, '月德贵人', ShenShaTables.yueDe[monthZhi]);

    return out;
  }

  /// 四柱神煞去重汇总，保持「先命中的排在前面」的稳定顺序
  static List<String> summary(List<List<String>> shenSha) {
    final seen = <String>{};
    final out = <String>[];
    for (final group in shenSha) {
      for (final name in group) {
        if (seen.add(name)) out.add(name);
      }
    }
    return out;
  }

  /// 基准表给出的是「命中任一字」，逐个比对四柱天干
  static void _gan(
    List<List<String>> out,
    List<String> pillars,
    String name,
    String? targets,
  ) {
    if (targets == null || targets.isEmpty) return;
    for (var i = 0; i < pillars.length; i++) {
      if (targets.contains(pillars[i].substring(0, 1)) && !out[i].contains(name)) {
        out[i].add(name);
      }
    }
  }

  /// 同上，比对的是四柱地支
  static void _zhi(
    List<List<String>> out,
    List<String> pillars,
    String name,
    String? targets,
  ) {
    if (targets == null || targets.isEmpty) return;
    for (var i = 0; i < pillars.length; i++) {
      if (targets.contains(pillars[i].substring(1, 2)) && !out[i].contains(name)) {
        out[i].add(name);
      }
    }
  }
}
