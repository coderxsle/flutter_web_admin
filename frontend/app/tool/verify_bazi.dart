/// 八字算法自检：绕开 flutter_tester（本机起不来），直接用纯 Dart 跑算法层断言。
///
/// 用法：`dart run tool/verify_bazi.dart`
/// 算法层（zhouyi/algorithm）不依赖 flutter，所以这一步可以在纯 Dart VM 上验证。
// ignore_for_file: avoid_print
library;

import 'dart:io';

import 'package:yun_men_yi_pan/app/modules/ba_zi/service/term_glossary.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/bazi_calculator.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/chang_sheng_util.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/cheng_gu_util.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/gan_zhi_relation.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/he_pan_util.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/liu_yue_ri_util.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/ming_gong_util.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/shen_sha_calculator.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/shen_sha_tables.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/shi_shen_util.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/wang_shuai_util.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/wu_xing_util.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/yun_shi_util.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/zang_gan_util.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/zhouyi_constants.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/zhouyi_models.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/zy_datetime_model.dart';

var _passed = 0;
var _failed = 0;

void check(bool ok, String msg) {
  if (ok) {
    _passed++;
  } else {
    _failed++;
    print('  FAIL: $msg');
  }
}

void group(String name, void Function() body) {
  print('\n[$name]');
  body();
}

bool sameSet(Iterable<Object?> a, Iterable<Object?> b) =>
    a.toSet().difference(b.toSet()).isEmpty &&
    b.toSet().difference(a.toSet()).isEmpty;

/// b 是否是 a 的下一组干支
bool nextGanzhi(String a, String b) {
  final gi = ZhouyiConst.shiTianGan.indexOf(a[0]);
  final zi = ZhouyiConst.shiErDiZhi.indexOf(a[1]);
  return b ==
      '${ZhouyiConst.shiTianGan[(gi + 1) % 10]}'
      '${ZhouyiConst.shiErDiZhi[(zi + 1) % 12]}';
}

void main() {
  final calculator = BaziCalculator();
  ZYDatetimeModel at(int y, int m, int d, int h, [int min = 30]) =>
      ZYDatetimeModel(year: y, month: m, day: d, hour: h, minute: min);

  // ---------------------------------------------------------------- 华盖
  group('华盖取用', () {
    const cases = [
      ['寅', '戌'], ['午', '戌'], ['戌', '戌'],
      ['申', '辰'], ['子', '辰'], ['辰', '辰'],
      ['巳', '丑'], ['酉', '丑'], ['丑', '丑'],
      ['亥', '未'], ['卯', '未'], ['未', '未'],
    ];

    for (final c in cases) {
      check(ShenShaTables.huaGai[c[0]] == c[1],
          '年支 ${c[0]} 的华盖应为 ${c[1]}，实为 ${ShenShaTables.huaGai[c[0]]}');
    }

    for (final c in cases) {
      final r = ShenShaCalculator.compute(
        yearGanzhi: '甲${c[0]}',
        monthGanzhi: '甲子',
        dayGanzhi: '甲子',
        hourGanzhi: '甲${c[1]}',
      );
      check(r[3].contains('华盖'), '年支 ${c[0]} 见时支 ${c[1]} 应命中华盖');
      check(!r[1].contains('华盖'), '月支子不该命中华盖（年支 ${c[0]}）');
      check(!r[2].contains('华盖'), '日支子不该命中华盖（年支 ${c[0]}）');
    }

    final none = ShenShaCalculator.compute(
      yearGanzhi: '甲寅',
      monthGanzhi: '丙申',
      dayGanzhi: '戊午',
      hourGanzhi: '庚辰',
    );
    check(none.every((g) => !g.contains('华盖')), '四柱无戌时不该出现华盖');

    final byDay = ShenShaCalculator.compute(
      yearGanzhi: '甲子',
      monthGanzhi: '甲子',
      dayGanzhi: '戊午',
      hourGanzhi: '甲戌',
    );
    check(byDay[3].contains('华盖'), '日支午也应能取华盖在戌');

    final dup = ShenShaCalculator.compute(
      yearGanzhi: '甲戌',
      monthGanzhi: '甲子',
      dayGanzhi: '甲戌',
      hourGanzhi: '甲戌',
    );
    final summary = ShenShaCalculator.summary(dup);
    check(summary.where((e) => e == '华盖').length == 1, '汇总里华盖应只出现一次');
    check(summary.toSet().length == summary.length, '汇总不应有重复项');

    final bad = ShenShaCalculator.compute(
      yearGanzhi: '',
      monthGanzhi: '甲',
      dayGanzhi: '甲子',
      hourGanzhi: '甲子',
    );
    check(bad.length == 4 && bad.every((g) => g.isEmpty), '非法干支应返回四个空组');

    // 天乙贵人、文昌以日干为基准，查的是四柱地支
    final noble = ShenShaCalculator.compute(
      yearGanzhi: '乙丑',
      monthGanzhi: '丁巳',
      dayGanzhi: '甲子',
      hourGanzhi: '甲子',
    );
    check(noble[0].contains('天乙贵人'), '甲日见年支丑应为天乙贵人');
    check(noble[1].contains('文昌贵人'), '甲日见月支巳应为文昌贵人');

    final all = ShenShaCalculator.compute(
      yearGanzhi: '甲子',
      monthGanzhi: '丙寅',
      dayGanzhi: '戊午',
      hourGanzhi: '庚申',
    );
    for (final n in ShenShaCalculator.summary(all)) {
      check((ShenShaTables.meaning[n] ?? '').isNotEmpty, '$n 缺少释义');
    }
  });

  // ---------------------------------------------------------------- 十神
  group('十神取用', () {
    check(ShiShenUtil.of('甲', '甲子') == '比', '甲见甲应为比肩');
    check(ShiShenUtil.of('甲', '庚申') == '殺', '甲见庚应为七杀');
    check(ShiShenUtil.of('甲', '丙寅') == '食', '甲见丙应为食神');
    check(ShiShenUtil.of('甲', '辛酉') == '官', '甲见辛应为正官');
    check(ShiShenUtil.of('乙', '庚申') == '官', '乙见庚应为正官');
    check(ShiShenUtil.of('乙', '辛酉') == '殺', '乙见辛应为七杀');
    check(ShiShenUtil.of('乙', '丁巳') == '食', '乙见丁应为食神');
    check(ShiShenUtil.fullOf('甲', '庚申') == '七杀', '十神全称映射');
    check(ShiShenUtil.of('', '甲子') == '' && ShiShenUtil.of('甲', '') == '',
        '十神非法入参应返回空串');
  });

  // ---------------------------------------------------------------- 五行
  group('五行统计', () {
    final c1 = WuXingUtil.count(['甲子', '乙丑', '丙寅', '丁卯']);
    check(c1['木'] == 4 && c1['火'] == 2 && c1['土'] == 1 && c1['金'] == 0 && c1['水'] == 1,
        '甲子/乙丑/丙寅/丁卯 的五行分布不对：$c1');
    check(WuXingUtil.total(c1) == 8, '五行合计应为 8');

    final c2 = WuXingUtil.count(['甲子', '甲子', '甲子', '甲子']);
    check(sameSet(c2.keys, WuXingUtil.elements), '固定返回五个 key');
    check(WuXingUtil.missing(c2).contains('火'), '火应为缺失五行');
    check(sameSet(WuXingUtil.strongest(c2), ['木', '水']), '木与水并列最多');

    check(WuXingUtil.total(WuXingUtil.count(['甲子', '', '甲'])) == 2,
        '残缺干支应被跳过');
  });

  // ---------------------------------------------------------------- 胎元
  group('胎元', () {
    check(FuShuUtil.taiYuan('丙寅') == '丁巳', '丙寅胎元应为丁巳');
    check(FuShuUtil.taiYuan('甲子') == '乙卯', '甲子胎元应为乙卯');
    check(FuShuUtil.taiYuan('癸亥') == '甲寅', '癸亥胎元应环绕为甲寅');
    check(FuShuUtil.taiYuan('癸戌') == '甲丑', '癸戌胎元应环绕为甲丑');
    check(FuShuUtil.taiYuan('') == '' && FuShuUtil.taiYuan('甲') == '',
        '胎元非法入参应返回空串');
  });

  // ---------------------------------------------------------------- 十二长生
  group('十二长生', () {
    check(ChangShengUtil.of('甲', '亥') == '长生', '甲长生在亥');
    check(ChangShengUtil.of('甲', '子') == '沐浴', '甲沐浴在子');
    check(ChangShengUtil.of('甲', '寅') == '临官', '甲禄在寅（临官）');
    check(ChangShengUtil.of('甲', '卯') == '帝旺', '甲刃在卯（帝旺）');

    check(ChangShengUtil.of('乙', '午') == '长生', '乙长生在午');
    check(ChangShengUtil.of('乙', '子') == '病', '乙阴干逆行，病在子');
    check(ChangShengUtil.of('乙', '卯') == '临官', '乙禄在卯');
    check(ChangShengUtil.of('乙', '寅') == '帝旺', '乙刃在寅');

    // 十干禄位（临官）逐一核对，是判断顺逆是否接反的最快办法
    const luWei = {
      '甲': '寅', '乙': '卯', '丙': '巳', '丁': '午', '戊': '巳',
      '己': '午', '庚': '申', '辛': '酉', '壬': '亥', '癸': '子',
    };
    luWei.forEach((gan, zhi) {
      check(ChangShengUtil.of(gan, zhi) == '临官', '$gan 的禄应在 $zhi');
    });

    for (final gan in ZhouyiConst.shiTianGan.split('')) {
      final got = ChangShengUtil.listOf(gan, ZhouyiConst.shiErDiZhi.split(''));
      check(got.every((e) => e.isNotEmpty), '$gan 在十二支上都应取到阶段');
      check(sameSet(got, ChangShengUtil.stages), '$gan 的十二长生应是十二个不同阶段');
    }

    check(ChangShengUtil.of('', '子') == '' && ChangShengUtil.of('甲', '') == '',
        '十二长生非法入参应返回空串');
    check(ChangShengUtil.listOf('甲', ['', '子']).length == 2, 'listOf 应逐位返回');
  });

  // ---------------------------------------------------------------- 干支关系
  group('干支关系', () {
    // 只把前两柱做成合法干支，后两柱留单字触发跳过，隔离出两两关系
    List<GanZhiRelationItem> pair(String a, String b) =>
        GanZhiRelation.compute([a, b, '甲', '甲']);

    List<String> texts(List<GanZhiRelationItem> items) =>
        items.map((e) => e.label).toList();

    const he = [
      ['甲', '己', '土'], ['乙', '庚', '金'], ['丙', '辛', '水'],
      ['丁', '壬', '木'], ['戊', '癸', '火'],
    ];
    for (final c in he) {
      final got = texts(pair('${c[0]}子', '${c[1]}丑'));
      check(got.any((e) => e.contains('${c[0]}${c[1]}合${c[2]}')),
          '${c[0]}${c[1]}应为五合化${c[2]}，实为 $got');
      check(got.any((e) => e.contains('子丑六合')), '子丑应六合');
    }

    for (final c in [
      ['甲', '庚'], ['乙', '辛'], ['丙', '壬'], ['丁', '癸'],
    ]) {
      check(texts(pair('${c[0]}子', '${c[1]}子')).any((e) => e.contains('${c[0]}${c[1]}相冲')),
          '${c[0]}${c[1]}应为天干相冲');
    }
    check(!texts(pair('戊子', '庚子')).any((e) => e.contains('相冲')), '戊庚相隔两位，不冲');
    check(!texts(pair('甲子', '甲子')).any((e) => e.contains('合')), '同干同支之间不应产生关系');

    for (final c in [
      ['子', '丑'], ['寅', '亥'], ['卯', '戌'],
      ['辰', '酉'], ['巳', '申'], ['午', '未'],
    ]) {
      check(texts(pair('甲${c[0]}', '甲${c[1]}')).any((e) => e.contains('${c[0]}${c[1]}六合')),
          '${c[0]}${c[1]}应六合');
    }

    for (final c in [
      ['子', '午'], ['丑', '未'], ['寅', '申'],
      ['卯', '酉'], ['辰', '戌'], ['巳', '亥'],
    ]) {
      check(texts(pair('甲${c[0]}', '甲${c[1]}')).any((e) => e.contains('${c[0]}${c[1]}相冲')),
          '${c[0]}${c[1]}应六冲');
    }

    for (final c in [
      ['子', '未'], ['丑', '午'], ['寅', '巳'],
      ['卯', '辰'], ['申', '亥'], ['酉', '戌'],
    ]) {
      check(texts(pair('甲${c[0]}', '甲${c[1]}')).any((e) => e.contains('${c[0]}${c[1]}六害')),
          '${c[0]}${c[1]}应六害');
    }

    for (final c in [
      ['寅', '巳'], ['巳', '申'], ['寅', '申'],
      ['丑', '戌'], ['戌', '未'], ['丑', '未'], ['子', '卯'],
    ]) {
      check(texts(pair('甲${c[0]}', '甲${c[1]}')).any((e) => e.contains('${c[0]}${c[1]}相刑')),
          '${c[0]}${c[1]}应相刑');
    }

    for (final z in ['辰', '午', '酉', '亥']) {
      check(texts(pair('甲$z', '甲$z')).any((e) => e.contains('$z$z自刑')), '$z 应自刑');
    }
    check(!texts(pair('甲子', '甲子')).any((e) => e.contains('自刑')), '子不自刑');

    final he3 = GanZhiRelation.compute(['甲申', '甲子', '甲辰', '甲寅']);
    check(he3.any((e) => e.text == '申子辰三合水局'), '申子辰应三合水局');
    check(he3.any((e) => e.scope == '年 月 日'), '三合局柱位应为年 月 日');
    check(!he3.any((e) => e.text.contains('半合')), '已成三合局时内部不再单列半合');

    final hui3 = GanZhiRelation.compute(['甲寅', '甲卯', '甲辰', '甲寅']);
    check(hui3.any((e) => e.text == '寅卯辰三会木方'), '寅卯辰应三会木方');
    check(hui3.any((e) => e.kind == '合会' && e.scope == '年 月 日'),
        '同支重见时柱位不应重复计数');

    // 巳午未缺未、寅午戌缺寅戌，午支重见不得凑成三会
    check(
        !GanZhiRelation.compute(['庚午', '壬午', '辛亥', '癸巳'])
            .any((e) => e.kind == '合会'),
        '同支重见不应误判成局');

    final banHe = GanZhiRelation.compute(['甲申', '甲子', '甲寅', '甲寅']);
    check(banHe.any((e) => e.text == '申子半合水局'), '申子应半合水局');
    check(!GanZhiRelation.compute(['甲申', '甲辰', '甲寅', '甲寅'])
            .any((e) => e.text.contains('半合')),
        '申辰缺中神子，属拱合不列半合');

    for (final r in hui3.where((e) => e.kind == '合会')) {
      check(r.auspicious, '合会应标记为吉');
      check(r.scope.split(' ').length == 3, '成局柱位应为三柱');
    }
    for (final r in he3.where((e) => e.text.contains('相冲') || e.text.contains('相刑'))) {
      check(!r.auspicious, '冲刑应不标吉：${r.label}');
    }

    check(GanZhiRelation.compute([]).isEmpty, '空入参应返回空');
    check(GanZhiRelation.compute(['甲子', '甲子', '甲子']).isEmpty, '柱数不为 4 应返回空');
    check(GanZhiRelation.compute(['甲子', '', '甲子', '']).isEmpty, '只剩一柱不应产生关系');
    check(GanZhiRelation.zhisOf(['甲子', '乙', '丙寅', '']).join() == '子寅',
        '取地支时应跳过残缺干支');
  });

  // ---------------------------------------------------------------- 命宫身宫
  group('命宫与身宫', () {
    check(MingGongUtil.monthNo('寅') == 1 && MingGongUtil.monthNo('丑') == 12,
        '月支序应为寅=1…丑=12');
    check(MingGongUtil.monthNo('子') == 11, '子月的月支序应为 11');
    check(MingGongUtil.hourNo('子') == 1 && MingGongUtil.hourNo('亥') == 12,
        '时支序应为子=1…亥=12');

    // 午月（5）+ 巳时（6）= 11，14 - 11 = 3，自子起数第三位为寅
    check(MingGongUtil.mingGongZhi('午', '巳') == '寅', '午月巳时的命宫应为寅');
    check(MingGongUtil.shenGongZhi('午', '巳') == '戌', '午月巳时的身宫应为戌');

    // 卯月（2）+ 亥时（12）= 14，余数为 0 时按 12 取，即亥
    check(MingGongUtil.mingGongZhi('卯', '亥') == '亥', '和为 14 时余数作 12 论');
    // 寅月（1）+ 亥时（12）= 13，14 - 13 = 1 → 子
    check(MingGongUtil.mingGongZhi('寅', '亥') == '子', '和为 13 时应落到子');
    // 丑月（12）+ 亥时（12）= 24，26 - 24 = 2 → 丑
    check(MingGongUtil.mingGongZhi('丑', '亥') == '丑', '和为 24 时应落到丑');

    for (final m in ZhouyiConst.shiErDiZhi.split('')) {
      for (final h in ZhouyiConst.shiErDiZhi.split('')) {
        final mg = MingGongUtil.mingGongZhi(m, h);
        final sg = MingGongUtil.shenGongZhi(m, h);
        if (mg.length != 1 || !ZhouyiConst.shiErDiZhi.contains(mg)) {
          check(false, '$m 月 $h 时的命宫地支非法：$mg');
        }
        if (sg.length != 1 || !ZhouyiConst.shiErDiZhi.contains(sg)) {
          check(false, '$m 月 $h 时的身宫地支非法：$sg');
        }
      }
    }

    check(MingGongUtil.ganOf('甲', '寅') == '丙', '甲年五虎遁：寅月为丙');
    check(MingGongUtil.ganOf('庚', '寅') == '戊', '乙庚之岁戊为头');
    check(MingGongUtil.ganOf('庚', '戌') == '丙', '庚年戌月应为丙');
    check(MingGongUtil.ganOf('癸', '卯') == '乙', '戊癸之年甲寅起，卯月为乙');
    check(MingGongUtil.ganOf('', '寅') == '' && MingGongUtil.ganOf('甲', '') == '',
        '五虎遁非法入参应返回空串');

    check(MingGongUtil.mingGongZhi('', '') == '' &&
            MingGongUtil.shenGongZhi('子', '') == '' &&
            MingGongUtil.mingGongZhi('甲', '子') == '',
        '命宫身宫非法入参应返回空串');
  });

  // ---------------------------------------------------------------- 格局
  group('格局取用', () {
    check(GeJuUtil.of('辛', '午') == '七杀格', '辛日午月本气丁为七杀');
    check(GeJuUtil.of('甲', '午') == '伤官格', '甲日午月本气丁为伤官');
    check(GeJuUtil.of('甲', '寅') == '建禄格', '甲日寅月本气甲为比肩');
    check(GeJuUtil.of('甲', '卯') == '月刃格', '甲日卯月本气乙为劫财');
    check(GeJuUtil.of('甲', '子') == '正印格', '甲日子月本气癸为正印');
    check(GeJuUtil.of('甲', '') == '' && GeJuUtil.of('', '午') == '',
        '格局非法入参应返回空串');

    for (final z in ZhouyiConst.shiErDiZhi.split('')) {
      check(GeJuUtil.of('甲', z).endsWith('格'), '甲日 $z 月应取到格局');
    }
  });

  // ---------------------------------------------------------------- 人元司令
  group('人元司令', () {
    check(RenYuanUtil.of('寅', 0) == '戊', '寅月交节起戊土司令');
    check(RenYuanUtil.of('寅', 6.9) == '戊', '寅月第七日仍属戊');
    check(RenYuanUtil.of('寅', 7) == '丙', '寅月第七日起丙火司令');
    check(RenYuanUtil.of('寅', 14) == '甲', '寅月第十四日起甲木司令');
    check(RenYuanUtil.of('寅', 100) == '甲', '超出表长应取最后一段');
    check(RenYuanUtil.of('卯', 0) == '甲' && RenYuanUtil.of('卯', 10) == '乙',
        '卯月前十日甲、之后乙');
    check(RenYuanUtil.of('子', 9) == '壬' && RenYuanUtil.of('子', 10) == '癸',
        '子月前十日壬、之后癸');
    check(RenYuanUtil.of('', 1) == '' && RenYuanUtil.of('寅', -1) == '',
        '人元司令非法入参应返回空串');

    for (final entry in RenYuanUtil.table.entries) {
      for (var d = 0.0; d < 30; d += 0.5) {
        check(RenYuanUtil.of(entry.key, d).isNotEmpty, '${entry.key} 月第 $d 天应有司令');
      }
    }

    final jq = RenYuanUtil.parseJieQiTime('2024年06月05日12时10分00秒');
    check(jq == DateTime(2024, 6, 5, 12, 10, 0), '节气时刻应能解析');
    check(RenYuanUtil.parseJieQiTime('2024-06-05') == null, '格式不认识应返回 null');
    check(
        RenYuanUtil.daysAfter(
                '2024年06月05日12时00分00秒', DateTime(2024, 6, 8, 12)) ==
            3.0,
        '交节后天数应精确到时刻');
    check(RenYuanUtil.daysAfter('bad', DateTime(2024, 1, 1)) == -1,
        '解析失败应返回 -1');
  });

  // ---------------------------------------------------------------- 旺衰喜忌
  group('旺衰与喜忌', () {
    final r = WangShuaiUtil.judge('辛', ['庚午', '壬午', '辛亥', '癸巳']);
    check(r.dayElement == '金', '辛日主应属金');
    check(r.party['比劫'] == 2 && r.party['印'] == 0, '比劫金 2、印土 0');
    check(r.party['食伤'] == 3 && r.party['财'] == 0 && r.party['官杀'] == 3,
        '食伤水 3、财木 0、官杀火 3');
    check(r.sameCount == 2 && r.otherCount == 6, '同党 2、异党 6');
    check(r.samePercent == '25.0%', '同党占比应为 25.0%，实为 ${r.samePercent}');
    check(!r.strong && r.level == '极弱', '同党只占四分之一，应判极弱');
    check(!r.deLing && !r.deDi && r.deShi, '该局只算得势');
    check(r.supportLabel == '得势', '三项摘要应为得势');
    check(sameSet(r.xiYong, ['土', '金']), '身弱喜印比：土、金');
    check(sameSet(r.jiShen, ['木', '火', '水']), '身弱忌财官食伤：木、火、水');

    final strong = WangShuaiUtil.judge('甲', ['甲寅', '甲子', '甲寅', '甲子']);
    check(strong.strong, '甲木通根寅子应判偏强以上');
    check(strong.xiYong.contains('金'), '身强喜官杀，金应入喜用');
    check(!strong.xiYong.contains('木'), '身强不应再以木为喜');
    check(strong.deLing && strong.deDi && strong.deShi, '甲木该局应三项俱全');

    check(WangShuaiUtil.judge('', ['甲子', '甲子', '甲子', '甲子']).dayElement == '',
        '日干非法时五行应为空');
    check(WangShuaiUtil.judge('甲', []).sameCount == 0, '空四柱应计 0');
    check(WuXingRelation.keWo('金') == '火' && WuXingRelation.woKe('金') == '木',
        '生克关系：金被火克、金克木');
    check(WuXingRelation.shengWo('水') == '金' && WuXingRelation.woSheng('水') == '木',
        '生克关系：金生水、水生木');
  });

  // ---------------------------------------------------------------- 称骨
  group('袁天罡称骨', () {
    check(ChengGuUtil.yearWeight.length == 60, '年重应覆盖六十甲子');
    check(ChengGuUtil.monthWeight.length == 12, '月重应十二项');
    check(ChengGuUtil.dayWeight.length == 30, '日重应三十项');
    check(ChengGuUtil.hourWeight.length == 12, '时重应十二项');

    for (var k = 21; k <= 72; k++) {
      final text = ChengGuUtil.song[k];
      if (text == null || text.isEmpty) check(false, '$k 钱缺少称骨歌');
    }

    // 例一：甲子年正月初一子时 = 1两2 + 6钱 + 5钱 + 1两6
    final a = ChengGuUtil.calc(
      yearGanzhi: '甲子', lunarMonth: 1, lunarDay: 1, hourZhi: '子');
    check(a.totalCents == 39, '甲子年正月初一子时应为 39 钱，实为 ${a.totalCents}');
    check(a.label == '三两九钱', '应为三两九钱，实为 ${a.label}');
    check(a.text.isNotEmpty, '三两九钱应有断语');

    // 例二：辛亥年正月初一子时 = 1两7 + 6钱 + 5钱 + 1两6
    final bEx = ChengGuUtil.calc(
      yearGanzhi: '辛亥', lunarMonth: 1, lunarDay: 1, hourZhi: '子');
    check(bEx.totalCents == 44 && bEx.label == '四两四钱',
        '辛亥年正月初一子时应为四两四钱，实为 ${bEx.label}');

    check(ChengGuUtil.yearWeight['癸亥'] == 7, '癸亥年重应为七钱');

    final mid = ChengGuResult(
      yearCents: 10, monthCents: 0, dayCents: 0, hourCents: 0);
    check(mid.label == '一两', '整两不应带「零钱」');
    check(
        ChengGuResult(yearCents: 0, monthCents: 5, dayCents: 0, hourCents: 0)
                .label ==
            '五钱',
        '不足一两应只写钱');

    // 闰月上半月算本月、下半月算下月
    final leapFirst = ChengGuUtil.calc(
      yearGanzhi: '甲子', lunarMonth: 3, lunarDay: 10, hourZhi: '子',
      leapMonth: true);
    final leapLast = ChengGuUtil.calc(
      yearGanzhi: '甲子', lunarMonth: 3, lunarDay: 20, hourZhi: '子',
      leapMonth: true);
    check(leapFirst.monthCents == ChengGuUtil.monthWeight[2], '闰月上半月仍按本月');
    check(leapLast.monthCents == ChengGuUtil.monthWeight[3], '闰月下半月按下月');

    final leapDec = ChengGuUtil.calc(
      yearGanzhi: '甲子', lunarMonth: 12, lunarDay: 20, hourZhi: '子',
      leapMonth: true);
    check(leapDec.monthCents == ChengGuUtil.monthWeight[0], '闰腊月下半月应跨到正月');

    for (final bad in [
      ChengGuUtil.calc(
          yearGanzhi: 'XX', lunarMonth: 1, lunarDay: 1, hourZhi: '子'),
      ChengGuUtil.calc(
          yearGanzhi: '甲子', lunarMonth: 0, lunarDay: 1, hourZhi: '子'),
      ChengGuUtil.calc(
          yearGanzhi: '甲子', lunarMonth: 1, lunarDay: 31, hourZhi: '子'),
      ChengGuUtil.calc(
          yearGanzhi: '甲子', lunarMonth: 1, lunarDay: 1, hourZhi: ''),
    ]) {
      check(bad.isEmpty, '称骨非法入参应返回空结果');
    }
  });

  // ---------------------------------------------------------------- 流月
  group('流月', () {
    final jia = LiuYueUtil.ofYear('甲');
    check(jia.length == 12, '流月应十二项');
    check(jia.first == '丙寅', '甲己之年丙作首，正月应为丙寅');
    check(jia.last == '丁丑', '十二月应为丁丑');
    check(jia[10] == '丙子', '十一月应为丙子');
    check(LiuYueUtil.ofYear('庚').first == '戊寅', '乙庚之岁戊为头');
    check(LiuYueUtil.ofYear('癸').first == '甲寅', '戊癸之年甲寅起');
    check(LiuYueUtil.ofYear('').isEmpty, '年干非法应返回空表');

    for (var i = 0; i < jia.length; i++) {
      check(jia[i].length == 2 && jia[i][1] == LiuYueUtil.monthZhi[i],
          '第 ${i + 1} 个流月地支应为 ${LiuYueUtil.monthZhi[i]}');
    }
    check(nextGanzhi(jia[0], jia[1]) && nextGanzhi(jia[10], jia[11]),
        '流月干支应逐月顺排');

    final y2024 = LiuYueUtil.ofYearNumber(2024);
    check(y2024.isNotEmpty && y2024.first == '丙寅', '2024 为甲辰年，正月应为丙寅');
    check(LiuYueUtil.ofYearNumber(2025).first == '戊寅', '2025 为乙巳年，正月应为戊寅');
  });

  // ---------------------------------------------------------------- 流日
  group('流日', () {
    check(LiuRiUtil.daysInMonth(2024, 2) == 29, '2024 年二月应 29 天');
    check(LiuRiUtil.daysInMonth(2023, 2) == 28, '2023 年二月应 28 天');
    check(LiuRiUtil.daysInMonth(2024, 0) == 0, '非法月份应返回 0');

    final feb = LiuRiUtil.ofMonth(2024, 2);
    check(feb.length == 29, '2024 年二月应排出 29 天');
    check(feb.every((e) => e.length == 2), '流日干支应为两字');
    check(LiuRiUtil.ofMonth(2024, 13).isEmpty, '非法月份应返回空表');

    final jan = LiuRiUtil.ofMonth(2024, 1);
    for (var i = 0; i + 1 < jan.length; i++) {
      if (!nextGanzhi(jan[i], jan[i + 1])) {
        check(false, '1 月第 ${i + 1} 天到第 ${i + 2} 天干支不连续');
      }
    }
    check(nextGanzhi(jan.last, feb.first), '跨月日柱应连续');
    check(nextGanzhi(LiuRiUtil.ofMonth(2023, 2).last, LiuRiUtil.ofMonth(2023, 3).first),
        '平年跨月日柱应连续');
  });

  // ---------------------------------------------------------------- 端到端
  group('排盘结构：1990-06-15 10:30 男', () {
    final head = calculator.calculate(at(1990, 6, 15, 10));

    for (final g in [head.yearGanzhi, head.monthGanzhi, head.dayGanzhi, head.hourGanzhi]) {
      check(g.length == 2, '干支应为两字：$g');
    }
    for (final e in [head.yearEmpty, head.monthEmpty, head.dayEmpty, head.hourEmpty]) {
      check(e.length == 2, '空亡应为两字：$e');
    }
    check(head.riGanLiuQinList.length == 4, '十神应四柱齐全');
    check(head.siZhuNaYin.length == 4 && head.siZhuNaYin.every((e) => e.isNotEmpty),
        '纳音应四柱齐全');
    check(head.cangGanArray.length == 4 && head.cangGanLiuQinArray.length == 4,
        '藏干与藏干十神应四柱齐全');
    check(head.shenShaArray.length == 4, '神煞应为四组');
    check(head.shenShaSummary.isNotEmpty, '该命局应命中若干神煞');
    check(
        sameSet(head.shenShaSummary, head.shenShaArray.expand((e) => e)),
        '神煞汇总应与四柱去重结果一致');
    check(head.wuXingCount.keys.length == 5 && WuXingUtil.total(head.wuXingCount) == 8,
        '五行应为五项且合计 8');
    check(head.taiYuan.length == 2 && head.taiYuan != head.monthGanzhi,
        '胎元应为两字且不等于月柱');
    check(head.changShengArray.length == 4 &&
            head.changShengArray.every((e) => ChangShengUtil.stages.contains(e)),
        '十二长生应四柱齐全且取值合法');
    for (final r in head.ganZhiRelation) {
      check(r.scope.isNotEmpty && r.text.isNotEmpty, '干支关系应带柱位与说明');
    }
    check(head.mingGong.length == 2 && head.shenGong.length == 2,
        '命宫与身宫应为干支两字');
    check(head.geJu.isNotEmpty && head.renYuan.isNotEmpty,
        '格局与人元司令应已填');
    check(head.wangShuai != null && head.wangShuai!.party.length == 5,
        '旺衰应分出比劫/印/食伤/财/官杀五组');
    check(head.chengGu != null && !head.chengGu!.isEmpty, '称骨应算出重量');
    check(head.chengGu!.totalCents >= 21 && head.chengGu!.totalCents <= 72,
        '称骨总数应落在 2两1 至 7两2 之间，实为 ${head.chengGu!.label}');
    check(head.shiErGongArray.length == 12 && head.shiErGongArray.every((e) => e.length == 4),
        '十二宫应为十二项、每项四字');
    check(head.daYun.length == 12 && head.daYunTime.length == 12,
        '大运应为十二步且每步都有交运时间');
    check(head.daYun.every((e) => e.length == 2), '大运干支应为两字');
    check(head.liuNianList.length == 120 && head.liuNianList.every((e) => e.length == 2),
        '流年应为 120 项、每项两字');
    check(head.qiYunTime.isNotEmpty && head.jiaoYunTime.contains('年'),
        '起运与交运时间应已填');

    print('  四柱：${head.yearGanzhi} ${head.monthGanzhi} ${head.dayGanzhi} ${head.hourGanzhi}');
    print('  空亡：${head.yearEmpty} ${head.monthEmpty} ${head.dayEmpty} ${head.hourEmpty}');
    print('  胎元：${head.taiYuan}');
    print('  长生：${head.changShengArray.join(' ')}（以日干 ${head.dayGanzhi.substring(0, 1)} 查四支）');
    print('  干支关系：${head.ganZhiRelation.isEmpty ? '无' : head.ganZhiRelation.map((e) => '${e.kind}·${e.label}').join('，')}');
    print('  命宫 ${head.mingGong}　身宫 ${head.shenGong}');
    final ws = head.wangShuai;
    if (ws != null) {
      print('  格局：${head.geJu}　人元：${head.renYuan}'
          '（交节后 ${head.renYuanDays.toStringAsFixed(1)} 天）');
      print('  旺衰：${ws.level}（${ws.supportLabel}）　同党 ${ws.sameCount} / '
          '异党 ${ws.otherCount} · ${ws.samePercent}');
      print('  喜用：${ws.xiYong.join('、')}　忌神：${ws.jiShen.join('、')}');
    }
    final cg = head.chengGu;
    if (cg != null && !cg.isEmpty) {
      print('  称骨：${cg.label}（${cg.detail}）');
      print('       ${cg.text}');
    }
    print('  五行：${WuXingUtil.elements.map((e) => '$e${head.wuXingCount[e]}').join(' ')}');
    print('  神煞：${head.shenShaSummary.join('、')}');
    for (var i = 0; i < 4; i++) {
      print('    ${['年柱', '月柱', '日柱', '时柱'][i]}：'
          '${head.shenShaArray[i].isEmpty ? '无' : head.shenShaArray[i].join('、')}');
    }
    print('  大运：${head.daYun.take(4).join(' ')} …');
  });

  group('取盘开关', () {
    final normal = calculator.calculate(at(2024, 3, 15, 23, 30));
    final yeZi = calculator.calculate(at(2024, 3, 15, 23, 30), yeZiShi: true);
    check(normal.dayGanzhi != yeZi.dayGanzhi,
        '夜子时应改变日柱（${normal.dayGanzhi} vs ${yeZi.dayGanzhi}）');

    final man = calculator.calculate(at(1990, 6, 15, 10), sex: BaziSex.man);
    final woman = calculator.calculate(at(1990, 6, 15, 10), sex: BaziSex.woman);
    check(man.daYun.first != woman.daYun.first, '性别应改变大运顺逆');

    final named = calculator.calculate(at(1990, 6, 15, 10), mingZhuName: '张三');
    check(named.siZhuName == '张三', '姓名应写进 siZhuName');

    final before = calculator.calculate(at(2024, 2, 3, 12));
    final after = calculator.calculate(at(2024, 2, 5, 12));
    check(before.monthGanzhi != after.monthGanzhi, '跨立春应换月柱');
  });

  group('多日期五行自洽', () {
    for (final d in [
      [1985, 1, 1, 0],
      [1995, 7, 20, 8],
      [2005, 12, 31, 23],
      [2024, 2, 4, 12],
    ]) {
      final head = calculator.calculate(at(d[0], d[1], d[2], d[3]));
      check(WuXingUtil.total(head.wuXingCount) == 8,
          '${d[0]}-${d[1]}-${d[2]} ${d[3]} 时五行总数应为 8');
      check(head.shenShaArray.length == 4,
          '${d[0]}-${d[1]}-${d[2]} ${d[3]} 时神煞应为四组');
      check(head.changShengArray.length == 4 &&
              head.changShengArray.every((e) => e.isNotEmpty),
          '${d[0]}-${d[1]}-${d[2]} ${d[3]} 时十二长生应四柱齐全');
      check(head.mingGong.length == 2 && head.geJu.isNotEmpty,
          '${d[0]}-${d[1]}-${d[2]} ${d[3]} 时命宫与格局应已填');
    }
  });

  // ---------------------------------------------------------------- 甲子历直录
  group('甲子历直录', () {
    check(ZhouyiConst.liuShiJiaZi.length == 60, '六十甲子应为 60 项');
    check(
        ZhouyiConst.liuShiJiaZi.first == '甲子' &&
            ZhouyiConst.liuShiJiaZi.last == '癸亥',
        '六十甲子应甲子起、癸亥止');
    for (var i = 0; i < 59; i++) {
      check(nextGanzhi(ZhouyiConst.liuShiJiaZi[i], ZhouyiConst.liuShiJiaZi[i + 1]),
          '六十甲子第 $i 与第 ${i + 1} 项应相邻');
    }

    // 与 1990-06-15 10:30 男命同一副八字，公历入口与直录入口应给出同一张盘
    final byDate = calculator.calculate(at(1990, 6, 15, 10), sex: BaziSex.man);
    final byPillar = calculator.fromPillars(
      yearGanzhi: byDate.yearGanzhi,
      monthGanzhi: byDate.monthGanzhi,
      dayGanzhi: byDate.dayGanzhi,
      hourGanzhi: byDate.hourGanzhi,
      mingZhuName: '张三',
    );

    check(byPillar.siZhuName == '张三', '直录盘应带上命主姓名');
    check(byPillar.yearGanzhi == byDate.yearGanzhi &&
            byPillar.monthGanzhi == byDate.monthGanzhi &&
            byPillar.dayGanzhi == byDate.dayGanzhi &&
            byPillar.hourGanzhi == byDate.hourGanzhi,
        '直录盘的四柱应与原盘一致');

    // 与时刻无关的部分必须与原盘逐项相同
    check(byPillar.riGanLiuQinList.join() == byDate.riGanLiuQinList.join(),
        '十神应与原盘一致');
    check(byPillar.siZhuNaYin.join() == byDate.siZhuNaYin.join(), '纳音应与原盘一致');
    check(byPillar.cangGanArray.join() == byDate.cangGanArray.join(), '藏干应与原盘一致');
    check(byPillar.cangGanLiuQinArray.join() == byDate.cangGanLiuQinArray.join(),
        '藏干十神应与原盘一致');
    check(byPillar.shenShaArray.join() == byDate.shenShaArray.join(), '神煞应与原盘一致');
    check(byPillar.wuXingCount.toString() == byDate.wuXingCount.toString(),
        '五行统计应与原盘一致');
    check(byPillar.changShengArray.join() == byDate.changShengArray.join(),
        '十二长生应与原盘一致');
    check(byPillar.taiYuan == byDate.taiYuan, '胎元应与原盘一致');
    check(byPillar.mingGong == byDate.mingGong &&
            byPillar.shenGong == byDate.shenGong,
        '命宫与身宫应与原盘一致');
    check(byPillar.geJu == byDate.geJu, '格局应与原盘一致');
    check(byPillar.wangShuai!.level == byDate.wangShuai!.level, '强弱应与原盘一致');
    check(byPillar.ganZhiRelation.map((e) => e.label).join() ==
            byDate.ganZhiRelation.map((e) => e.label).join(),
        '干支关系应与原盘一致');
    check(
        byPillar.yearEmpty == byDate.yearEmpty &&
            byPillar.dayEmpty == byDate.dayEmpty,
        '旬空应与原盘一致');

    // 依赖真实时刻的部分必须留空，界面据此隐藏
    check(byPillar.dateTimes.isEmpty, '直录盘不应有公历时间');
    check(byPillar.siZhuYangLi.isEmpty, '直录盘不应有公历生辰串');
    check(byPillar.nongli.isEmpty, '直录盘不应有农历');
    check(byPillar.jieQi.isEmpty && byPillar.zhongqi.isEmpty, '直录盘不应有节气');
    check(byPillar.renYuan.isEmpty, '直录盘不应有人元司令');
    check(byPillar.chengGu == null, '直录盘不应有称骨');
    check(byPillar.daYun.isEmpty && byPillar.daYunTime.isEmpty, '直录盘不应有大运');
    check(byPillar.liuNianList.isEmpty, '直录盘不应有流年');
    check(byPillar.shiErGongArray.isEmpty, '直录盘不应有十二宫');
    check(byPillar.qiYunTime.isEmpty && byPillar.jiaoYunTime.isEmpty,
        '直录盘不应有起运交运');

    final head44 = calculator.fromPillars(
      yearGanzhi: '甲子',
      monthGanzhi: '丙寅',
      dayGanzhi: '戊午',
      hourGanzhi: '壬子',
    );
    check(head44.wangShuai != null && head44.geJu.isNotEmpty,
        '任意四柱都应给出格局与旺衰');

    print('  直录四柱：${head44.yearGanzhi} ${head44.monthGanzhi} '
        '${head44.dayGanzhi} ${head44.hourGanzhi}');
    print('  十神：${head44.riGanLiuQinList.join(' ')}'
        '　纳音：${head44.siZhuNaYin.join(' ')}');
    print('  命宫 ${head44.mingGong}　身宫 ${head44.shenGong}　格局 ${head44.geJu}');
    print('  长生：${head44.changShengArray.join(' ')}');
    print('  旺衰：${head44.wangShuai!.level}（${head44.wangShuai!.supportLabel}）'
        '　喜用 ${head44.wangShuai!.xiYong.join('、')}');
  });

  // ---------------------------------------------------------------- 运势评分
  group('运势评分', () {
    final head = calculator.calculate(at(1990, 6, 15, 10), sex: BaziSex.man);
    final ws = head.wangShuai!;
    final dayGan = head.dayGanzhi.substring(0, 1);

    final scores = YunShiUtil.list(head.daYun, dayGan: dayGan, wangShuai: ws);
    check(scores.length == 12, '十二步大运都应打分');
    for (final s in scores) {
      check(s.score >= 0 && s.score <= 100, '${s.ganzhi} 的分应落在 0~100');
      check(s.grade.isNotEmpty, '${s.ganzhi} 应有吉凶档位');
      check(s.ganShiShen.isNotEmpty && s.zhiShiShen.isNotEmpty,
          '${s.ganzhi} 应给出运干与运支的十神');
      check(s.score == (YunShiUtil.base + s.delta).clamp(0, 100),
          '${s.ganzhi} 的分应与偏移自洽');
    }

    check(scores.any((s) => s.score > 50) && scores.any((s) => s.score < 50),
        '十二步大运里应吉凶都有');

    final maxScore = scores.map((e) => e.score).reduce((a, b) => a > b ? a : b);
    check(YunShiUtil.best(scores)?.score == maxScore, 'best 应取到最高分那一步');
    check(YunShiUtil.best(const []) == null, '空列表应返回 null');

    check(YunShiUtil.of('', dayGan: dayGan, wangShuai: ws).score == YunShiUtil.base,
        '空干支应落在基准分');

    // 该造极弱、喜土金忌木火水，故土金之运分高、水木火之运分低
    check(YunShiUtil.of('戊申', dayGan: dayGan, wangShuai: ws).score >= 85,
        '喜用干支（戊申）应给高分');
    check(YunShiUtil.of('壬子', dayGan: dayGan, wangShuai: ws).score <= 15,
        '忌神干支（壬子）应给低分');

    check(YunShiUtil.gradeOf(100) == '大吉' && YunShiUtil.gradeOf(0) == '凶',
        '档位两端应分别是「大吉」与「凶」');

    // 藏干计权：申（庚戊壬）三藏干两喜一忌，应得正分但不满
    final shenScore = YunShiUtil.of('戊申', dayGan: dayGan, wangShuai: ws);
    check(shenScore.delta == 44, '戊申的偏移应为 +44，实为 ${shenScore.delta}');
    check(ZangGanUtil.of('申').join() == '庚戊壬', '申的藏干应为庚戊壬');
    check(ZangGanUtil.of('').isEmpty && ZangGanUtil.of('X').isEmpty,
        '空串与非法地支的藏干应为空表');
    check(ZangGanUtil.weightedOf('子').length == 1 &&
            ZangGanUtil.weightedOf('寅').length == 3,
        '子一位藏干、寅三位藏干');

    print('  大运运势：'
        '${scores.map((e) => '${e.ganzhi}${e.score}').join(' ')}');
    print('  最高一步：${YunShiUtil.best(scores)!.label}');
  });

  // ---------------------------------------------------------------- 合盘
  group('合盘', () {
    final a = calculator.calculate(at(1990, 6, 15, 10), sex: BaziSex.man);
    final b = calculator.calculate(at(1992, 3, 8, 16), sex: BaziSex.woman);

    List<String> pillarsOf(ZYHourQimenHeadModel h) =>
        [h.yearGanzhi, h.monthGanzhi, h.dayGanzhi, h.hourGanzhi];

    final r = HePanUtil.compare(
      aPillars: pillarsOf(a),
      aWang: a.wangShuai!,
      bPillars: pillarsOf(b),
      bWang: b.wangShuai!,
      aName: '甲某',
      bName: '乙某',
      aNayin: a.siZhuNaYin[0],
      bNayin: b.siZhuNaYin[0],
    );

    check(r.items.length == 6, '合盘应有六项判词');
    check(r.score >= 0 && r.score <= 100, '合盘分应落在 0~100，实为 ${r.score}');
    check(r.score == (HePanUtil.base + r.totalPoint).clamp(0, 100),
        '合盘分应由基准分加各项得分得到');
    check(r.level.isNotEmpty && r.summary.startsWith(r.level),
        '总评应以档位开头');
    for (final it in r.items) {
      check(it.title.isNotEmpty && it.detail.isNotEmpty, '每项判词都应有标题与说明');
    }

    // 互换两造，分与档位都不该变
    final swapped = HePanUtil.compare(
      aPillars: pillarsOf(b),
      aWang: b.wangShuai!,
      bPillars: pillarsOf(a),
      bWang: a.wangShuai!,
      aName: '乙某',
      bName: '甲某',
      aNayin: b.siZhuNaYin[0],
      bNayin: a.siZhuNaYin[0],
    );
    check(swapped.score == r.score && swapped.level == r.level,
        '互换两造应得到同一分数（${swapped.score} vs ${r.score}）');

    // 地支两两关系：合害刑冲应能与盘内算法对上
    check(GanZhiRelation.zhiPairKinds('子', '午').contains('相冲'), '子午应相冲');
    check(GanZhiRelation.zhiPairKinds('卯', '戌').contains('六合'), '卯戌应六合');
    check(
        GanZhiRelation.zhiPairKinds('寅', '巳').contains('六害') &&
            GanZhiRelation.zhiPairKinds('寅', '巳').contains('相刑'),
        '寅巳应既相害又相刑');
    check(GanZhiRelation.zhiPairKinds('辰', '辰').contains('自刑'), '辰辰应自刑');
    check(GanZhiRelation.zhiPairKinds('子', '酉').isEmpty, '子酉之间无关系');
    check(GanZhiRelation.zhiPairKinds('X', '子').isEmpty, '非法地支应返回空表');
    check(
        GanZhiRelation.sameSanHe('申', '辰') &&
            GanZhiRelation.sameSanHe('申', '子') &&
            !GanZhiRelation.sameSanHe('申', '酉'),
        '申辰子同属水局、申酉应不同局');

    check(GanZhiRelation.ganPairKind('甲', '己') == '五合', '甲己应五合');
    check(GanZhiRelation.heQiOf('甲', '己') == '土', '甲己应合土');
    check(GanZhiRelation.ganPairKind('甲', '庚') == '相冲', '甲庚应相冲');
    check(GanZhiRelation.ganPairKind('甲', '丙') == '', '甲丙之间无合冲');
    check(GanZhiRelation.heQiOf('甲', '丙') == '', '非五合不应给出化气');

    // 日支六合的干支组合应比相冲的组合分高
    final hePair = HePanUtil.compare(
      aPillars: const ['甲子', '丙寅', '戊辰', '壬子'],
      aWang: WangShuaiUtil.judge('戊', const ['甲子', '丙寅', '戊辰', '壬子']),
      bPillars: const ['乙丑', '戊寅', '丁酉', '辛亥'],
      bWang: WangShuaiUtil.judge('丁', const ['乙丑', '戊寅', '丁酉', '辛亥']),
      aNayin: '海中金',
      bNayin: '海中金',
    );
    final chongPair = HePanUtil.compare(
      aPillars: const ['甲子', '丙寅', '戊辰', '壬子'],
      aWang: WangShuaiUtil.judge('戊', const ['甲子', '丙寅', '戊辰', '壬子']),
      bPillars: const ['乙丑', '戊寅', '丁卯', '辛亥'],
      bWang: WangShuaiUtil.judge('丁', const ['乙丑', '戊寅', '丁卯', '辛亥']),
      aNayin: '海中金',
      bNayin: '海中金',
    );
    check(hePair.score > chongPair.score,
        '夫妻宫相合的合盘分应比相害的高（${hePair.score} vs ${chongPair.score}）');
    HePanItem itemOf(HePanResult result, String title) =>
        result.items.firstWhere((e) => e.title == title);
    check(itemOf(hePair, '夫妻宫（日支）').point == 20, '辰酉六合应记 +20');
    check(itemOf(chongPair, '夫妻宫（日支）').point == -10, '辰卯相害应记 -10');
    check(itemOf(hePair, '生肖宫（年支）').point == 15, '子丑六合应记 +15');

    print('  合盘：${r.score} 分（${r.level}）');
    for (final it in r.items) {
      print('    ${it.title}　${it.point >= 0 ? '+' : ''}${it.point}　${it.detail}');
    }
    print('  总计：${r.summary}');
  });

  // ---------------------------------------------------------------- 术语百科
  group('术语百科', () {
    final all = TermGlossary.all();
    check(all.length >= 80, '术语表条目偏少，实为 ${all.length}');

    for (final e in all) {
      check(e.term.isNotEmpty && e.meaning.isNotEmpty, '「${e.term}」应有释义');
      check(TermGlossary.sectionOrder.contains(e.section),
          '「${e.term}」的分类应在展示顺序里');
    }

    final names = all.map((e) => e.term).toList();
    check(names.toSet().length == names.length, '术语不应重名');

    final counts = TermGlossary.counts();
    check(counts.values.fold(0, (a, b) => a + b) == all.length,
        '分类计数应与总条数一致');
    check(counts.keys.every(TermGlossary.sectionOrder.contains),
        '分类应都在展示顺序里');

    // 神煞一类应与结果页点标签看到的是同一份
    check(ShenShaTables.meaning.isNotEmpty, '神煞释义表不应为空');
    for (final entry in ShenShaTables.meaning.entries) {
      check(TermGlossary.meaningOf(entry.key) == entry.value,
          '神煞「${entry.key}」的释义应与神煞表一致');
    }

    // 算法会产出的名词都要有释义，否则结果页出现生词查不到
    for (final name in ShiShenUtil.fullName.values) {
      check(TermGlossary.meaningOf(name) != null, '十神「$name」应有释义');
    }
    for (final name in GeJuUtil.geNames.values) {
      check(TermGlossary.meaningOf(name) != null, '格局「$name」应有释义');
    }
    for (final stage in ChangShengUtil.stages) {
      check(TermGlossary.meaningOf(stage) != null, '长生「$stage」应有释义');
    }
    for (final name in [
      '天干五合', '天干相冲', '地支六合', '地支三合', '地支半合',
      '地支三会', '地支六冲', '地支六害', '地支相刑', '地支自刑',
      '命宫', '身宫', '起运', '交运', '大运', '流年', '流月', '流日',
      '同党', '异党', '旺衰', '喜用神', '忌神',
    ]) {
      check(TermGlossary.meaningOf(name) != null, '「$name」应有释义');
    }

    // 检索
    check(TermGlossary.search('').length == all.length, '空关键字应返回全部');
    check(TermGlossary.search('   ').length == all.length, '纯空格应视作空关键字');
    check(TermGlossary.search('这词一定不存在').isEmpty, '无匹配应返回空表');
    check(TermGlossary.meaningOf('这不存在的词') == null, '未收录的词应返回 null');

    final huaGai = TermGlossary.search('华盖');
    check(huaGai.any((e) => e.term == '华盖'), '搜「华盖」应命中该词条');
    check(
        huaGai.every((e) => e.term.contains('华盖') || e.meaning.contains('华盖')),
        '搜索结果都应含关键字');

    final sanHe = TermGlossary.search('三合');
    check(sanHe.any((e) => e.term == '地支三合'), '搜「三合」应命中「地支三合」');
    check(sanHe.any((e) => e.term == '地支半合'), '搜「三合」应命中「地支半合」的释义');
    check(sanHe.length >= 2, '搜「三合」应命中多条，实为 ${sanHe.length}');
    final grouped = TermGlossary.groupBySection(sanHe);
    check(grouped.keys.every(TermGlossary.sectionOrder.contains),
        '分组结果只应含已知分类');
    check(grouped.values.fold(0, (a, b) => a + b.length) == sanHe.length,
        '分组后条数不应增减');

    print('  收录 ${all.length} 条：'
        '${counts.entries.map((e) => '${e.key}${e.value}').join(' ')}');
  });

  print('\n──────────────────────────────');
  print('通过 $_passed，失败 $_failed');
  if (_failed > 0) exit(1);
}
