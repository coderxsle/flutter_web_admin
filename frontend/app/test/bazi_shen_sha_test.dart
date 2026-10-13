import 'package:flutter_test/flutter_test.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/shen_sha_calculator.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/shen_sha_tables.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/shi_shen_util.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/wu_xing_util.dart';

/// 神煞与辅属盘的工具层测试：只依赖基准表，不经过完整排盘。
void main() {
  group('华盖取用', () {
    /// 寅午戌见戌、申子辰见辰、巳酉丑见丑、亥卯未见未
    const cases = [
      ['寅', '戌'], ['午', '戌'], ['戌', '戌'],
      ['申', '辰'], ['子', '辰'], ['辰', '辰'],
      ['巳', '丑'], ['酉', '丑'], ['丑', '丑'],
      ['亥', '未'], ['卯', '未'], ['未', '未'],
    ];

    test('十二个年支各自映射到正确的目标支', () {
      for (final c in cases) {
        expect(ShenShaTables.huaGai[c[0]], c[1], reason: '年支 ${c[0]} 的华盖应为 ${c[1]}');
      }
    });

    test('命中的柱位正确，且不误报到月柱与日柱', () {
      for (final c in cases) {
        // 年支作基准，目标支只放在时支；月支与日支固定取子。
        // 年柱不参与断言：基准支本身就是目标支时（戌见戌），年柱同样该命中
        final result = ShenShaCalculator.compute(
          yearGanzhi: '甲${c[0]}',
          monthGanzhi: '甲子',
          dayGanzhi: '甲子',
          hourGanzhi: '甲${c[1]}',
        );
        expect(result[3], contains('华盖'),
            reason: '年支 ${c[0]} 见时支 ${c[1]} 应命中华盖');
        expect(result[1], isNot(contains('华盖')));
        expect(result[2], isNot(contains('华盖')));
      }
    });

    test('四柱地支都不见目标支时不出现华盖', () {
      // 年支寅属寅午戌组，华盖在戌；四柱无戌，故不该出现
      final result = ShenShaCalculator.compute(
        yearGanzhi: '甲寅',
        monthGanzhi: '丙申',
        dayGanzhi: '戊午',
        hourGanzhi: '庚辰',
      );
      for (final group in result) {
        expect(group, isNot(contains('华盖')));
      }
    });
  });

  group('神煞计算', () {
    test('日支同样可以作为取用基准', () {
      // 日支午属寅午戌组，华盖在戌，故日柱自身与其它戌支都该命中
      final result = ShenShaCalculator.compute(
        yearGanzhi: '甲子',
        monthGanzhi: '甲子',
        dayGanzhi: '戊午',
        hourGanzhi: '甲戌',
      );
      expect(result[3], contains('华盖'));
    });

    test('汇总去重，跨柱重复的只留一项', () {
      // 年支戌与日支戌都属寅午戌组，时支戌会同时被两条基准命中
      final result = ShenShaCalculator.compute(
        yearGanzhi: '甲戌',
        monthGanzhi: '甲子',
        dayGanzhi: '甲戌',
        hourGanzhi: '甲戌',
      );
      final summary = ShenShaCalculator.summary(result);
      expect(summary.where((e) => e == '华盖'), hasLength(1));
      expect(summary.toSet(), hasLength(summary.length));
    });

    test('干支格式非法时返回四个空组而不抛异常', () {
      final result = ShenShaCalculator.compute(
        yearGanzhi: '',
        monthGanzhi: '甲',
        dayGanzhi: '甲子',
        hourGanzhi: '甲子',
      );
      expect(result, hasLength(4));
      for (final group in result) {
        expect(group, isEmpty);
      }
    });

    test('每个神煞名都有释义', () {
      final result = ShenShaCalculator.compute(
        yearGanzhi: '甲子',
        monthGanzhi: '丙寅',
        dayGanzhi: '戊午',
        hourGanzhi: '庚申',
      );
      for (final name in ShenShaCalculator.summary(result)) {
        expect(ShenShaTables.meaning[name], isNotNull, reason: '$name 缺少释义');
        expect(ShenShaTables.meaning[name], isNotEmpty);
      }
    });

    test('天乙贵人与文昌按日干取用', () {
      // 甲日：天乙在丑未，文昌在巳
      final result = ShenShaCalculator.compute(
        yearGanzhi: '乙丑',
        monthGanzhi: '丁巳',
        dayGanzhi: '甲子',
        hourGanzhi: '甲子',
      );
      expect(result[0], contains('天乙贵人'));
      expect(result[1], contains('文昌贵人'));
    });
  });

  group('十神取用', () {
    test('阳日干：甲见甲为比肩、见庚为七杀', () {
      expect(ShiShenUtil.of('甲', '甲子'), '比');
      expect(ShiShenUtil.of('甲', '庚申'), '殺');
      expect(ShiShenUtil.of('甲', '丙寅'), '食');
      expect(ShiShenUtil.of('甲', '辛酉'), '官');
    });

    test('阴日干：乙见庚为正官、见辛为七杀', () {
      expect(ShiShenUtil.of('乙', '乙卯'), '比');
      expect(ShiShenUtil.of('乙', '庚申'), '官');
      expect(ShiShenUtil.of('乙', '辛酉'), '殺');
    });

    test('全称映射与非法入参', () {
      expect(ShiShenUtil.fullOf('甲', '庚申'), '七杀');
      expect(ShiShenUtil.of('', '甲子'), '');
      expect(ShiShenUtil.of('甲', ''), '');
    });
  });

  group('五行统计', () {
    test('天干与地支本气各计 1，合计 8', () {
      final count = WuXingUtil.count(['甲子', '乙丑', '丙寅', '丁卯']);
      expect(count['木'], 4); // 甲、乙、寅、卯
      expect(count['火'], 2); // 丙、丁
      expect(count['土'], 1); // 丑
      expect(count['金'], 0);
      expect(count['水'], 1); // 子
      expect(WuXingUtil.total(count), 8);
    });

    test('固定返回五个 key，缺失的五行个数为 0', () {
      final count = WuXingUtil.count(['甲子', '甲子', '甲子', '甲子']);
      expect(count.keys.toSet(), WuXingUtil.elements.toSet());
      expect(WuXingUtil.missing(count), contains('火'));
      // 木与水各 4 个并列最多
      expect(WuXingUtil.strongest(count), containsAll(['木', '水']));
    });

    test('干支不完整时跳过，不计数也不崩', () {
      final count = WuXingUtil.count(['甲子', '', '甲']);
      expect(WuXingUtil.total(count), 2);
    });
  });

  group('胎元', () {
    test('月干进一位、月支进三位', () {
      expect(FuShuUtil.taiYuan('丙寅'), '丁巳');
      expect(FuShuUtil.taiYuan('甲子'), '乙卯');
      expect(FuShuUtil.taiYuan('癸亥'), '甲寅');
    });

    test('环绕处理：天干到癸回甲、地支到亥回寅', () {
      expect(FuShuUtil.taiYuan('癸戌'), '甲丑');
    });

    test('入参非法返回空串', () {
      expect(FuShuUtil.taiYuan(''), '');
      expect(FuShuUtil.taiYuan('甲'), '');
    });
  });
}
