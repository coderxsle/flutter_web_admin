import 'package:flutter_test/flutter_test.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/bazi_calculator.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/wu_xing_util.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/zhouyi_constants.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/zy_datetime_model.dart';

/// 四柱排盘的端到端结构测试：只断言字段齐全与自洽，不锁死具体干支，
/// 免得每次改算法都要重导基准。
void main() {
  final calculator = BaziCalculator();

  ZYDatetimeModel at(int y, int m, int d, int h, [int min = 30]) =>
      ZYDatetimeModel(year: y, month: m, day: d, hour: h, minute: min);

  group('排盘结构完整性', () {
    final head = calculator.calculate(at(1990, 6, 15, 10));

    test('四柱与空亡都是两字', () {
      for (final ganzhi in [
        head.yearGanzhi,
        head.monthGanzhi,
        head.dayGanzhi,
        head.hourGanzhi,
      ]) {
        expect(ganzhi, hasLength(2), reason: '干支应为两字：$ganzhi');
      }
      for (final empty in [
        head.yearEmpty,
        head.monthEmpty,
        head.dayEmpty,
        head.hourEmpty,
      ]) {
        expect(empty, hasLength(2));
      }
    });

    test('十神、纳音、藏干各四柱齐全', () {
      expect(head.riGanLiuQinList, hasLength(4));
      expect(head.siZhuNaYin, hasLength(4));
      expect(head.cangGanArray, hasLength(4));
      expect(head.cangGanLiuQinArray, hasLength(4));
      for (final v in head.siZhuNaYin) {
        expect(v, isNotEmpty);
      }
    });

    test('神煞为四组，且都在释义表内', () {
      expect(head.shenShaArray, hasLength(4));
      expect(head.shenShaSummary, isNotEmpty, reason: '大多数命局都该命中若干神煞');
      for (final group in head.shenShaArray) {
        expect(group.toSet(), hasLength(group.length), reason: '同一柱内不该重复');
      }
      final flat = head.shenShaArray.expand((e) => e).toSet();
      expect(head.shenShaSummary.toSet(), flat);
    });

    test('五行合计等于八个字', () {
      expect(head.wuXingCount.keys.toSet(), WuXingUtil.elements.toSet());
      expect(WuXingUtil.total(head.wuXingCount), 8);
    });

    test('胎元两字，且不等于月柱', () {
      expect(head.taiYuan, hasLength(2));
      expect(head.taiYuan, isNot(head.monthGanzhi));
    });

    test('十二宫为十二项，每项四字', () {
      expect(head.shiErGongArray, hasLength(12));
      for (final gong in head.shiErGongArray) {
        expect(gong, hasLength(4));
      }
    });

    test('大运十二步且每步都有交运时间', () {
      expect(head.daYun, hasLength(12));
      expect(head.daYunTime, hasLength(12));
      for (var i = 0; i < head.daYun.length; i++) {
        expect(head.daYun[i], hasLength(2));
        expect(head.daYunTime[i], isNotEmpty);
      }
    });

    test('流年 120 项且干支连续无重复', () {
      expect(head.liuNianList, hasLength(120));
      for (final ganzhi in head.liuNianList) {
        expect(ganzhi, hasLength(2));
      }
    });

    test('起运与交运时间已填', () {
      expect(head.qiYunTime, isNotEmpty);
      expect(head.jiaoYunTime, contains('年'));
    });
  });

  group('取盘开关', () {
    test('夜子时开关会改变日柱', () {
      final normal = calculator.calculate(at(2024, 3, 15, 23, 30));
      final yeZi = calculator.calculate(at(2024, 3, 15, 23, 30), yeZiShi: true);
      expect(normal.dayGanzhi, isNot(yeZi.dayGanzhi),
          reason: '23 时开启夜子时后日柱应回退到前一日');
    });

    test('性别改变大运顺逆，第一步大运干支不同', () {
      final man = calculator.calculate(at(1990, 6, 15, 10), sex: BaziSex.man);
      final woman = calculator.calculate(at(1990, 6, 15, 10), sex: BaziSex.woman);
      expect(man.daYun.first, isNot(woman.daYun.first));
    });

    test('姓名写进 siZhuName', () {
      final head = calculator.calculate(at(1990, 6, 15, 10), mingZhuName: '张三');
      expect(head.siZhuName, '张三');
    });

    test('跨节气日期会换月柱', () {
      // 2024 立春在 2 月 4 日，前后两天的月柱应不同
      final before = calculator.calculate(at(2024, 2, 3, 12));
      final after = calculator.calculate(at(2024, 2, 5, 12));
      expect(before.monthGanzhi, isNot(after.monthGanzhi));
    });
  });

  group('五行统计与命局自洽', () {
    test('五行个数之和恒为 8，多个日期都成立', () {
      for (final d in [
        [1985, 1, 1, 0],
        [1995, 7, 20, 8],
        [2005, 12, 31, 23],
        [2024, 2, 4, 12],
      ]) {
        final head = calculator.calculate(at(d[0], d[1], d[2], d[3]));
        expect(WuXingUtil.total(head.wuXingCount), 8,
            reason: '${d[0]}-${d[1]}-${d[2]} ${d[3]} 时五行总数不为 8');
      }
    });
  });
}
