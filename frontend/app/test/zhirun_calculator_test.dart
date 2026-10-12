import 'package:auto_shop_server/app/modules/zhouyi/algorithm/chn_chinese_calendar.dart';
import 'package:auto_shop_server/app/modules/zhouyi/algorithm/zhirun_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

/// 置闰法（古法）回归。锚点取《奇门遁甲统宗·置闰法》原文二例：
/// 康熙五十七年「五月十六甲子置闰芒种，六月初二己卯为夏至上局」，
/// 康熙五十六年「五月十一甲子为夏至符头已超三日」。
void main() {
  String dayGanzhi(int y, int m, int d) =>
      ChnChineseCalendar.instance.ganzhiStringWithYear(y, m, d, 12).substring(4, 6);

  group('古籍锚点', () {
    test('康熙五十七年置闰：符头干支逐日合于原文', () {
      // 原文三元：芒种上局五月初一己酉；闰奇上局十六甲子、中局廿一己巳、下局廿六甲戌
      const table = <List<Object>>[
        [5, 30, '己酉', 8, 0, false],
        [6, 4, '甲寅', 8, 1, false],
        [6, 9, '己未', 8, 2, false],
        [6, 14, '甲子', 8, 0, true],
        [6, 19, '己巳', 8, 1, true],
        [6, 24, '甲戌', 8, 2, true],
        [6, 29, '己卯', 9, 0, false],
        [7, 4, '甲申', 9, 1, false],
        [7, 9, '己丑', 9, 2, false],
      ];
      for (final row in table) {
        final m = row[0] as int;
        final d = row[1] as int;
        final s = ZhirunCalculator.slotOf(1718, m, d, 12, 0, 0);
        final reason = '1718-$m-$d';
        expect(dayGanzhi(1718, m, d), row[2], reason: reason);
        expect(s.jieqiIndex, row[3], reason: reason);
        expect(s.yuanIndex, row[4], reason: reason);
        expect(s.isLeap, row[5], reason: reason);
      }
    });

    test('康熙五十六年：夏至符头甲子超三日、冬至共超七日', () {
      final xiaZhi = ZhirunCalculator.slotOf(1717, 6, 22, 12, 0, 0);
      expect(xiaZhi.slotStartDate, '1717-06-19');
      expect(dayGanzhi(1717, 6, 19), '甲子');
      expect(xiaZhi.chaoDays, 3);

      // 原文「共超七日」按含首尾计，实差六日
      final dongZhi = ZhirunCalculator.slotOf(1717, 12, 22, 12, 0, 0);
      expect(dongZhi.slotStartDate, '1717-12-16');
      expect(dongZhi.chaoDays, 6);
    });

    test('交节时刻随排盘回填', () {
      // 闰奇内所行节气为芒种，交节时刻取芒种
      final leap = ZhirunCalculator.calculate(1718, 6, 20, 12, 0, 0);
      expect(leap.jieqiTime, contains('1718年06月06日'));
      expect(leap.jieqi, '芒种');
      expect(leap.juNumber, 3); // 芒种中元 阳三局
      expect(leap.dunType, 1);
      expect(leap.isLeap, isTrue);

      final xiaZhi = ZhirunCalculator.calculate(1718, 7, 1, 12, 0, 0);
      expect(xiaZhi.jieqiTime, contains('1718年06月22日'));
    });
  });

  group('出闰转夏至', () {
    test('夏至上中下三元：阴九、阴三、阴六局', () {
      final shang = ZhirunCalculator.calculate(1718, 7, 1, 12, 0, 0);
      expect(shang.jieqi, '夏至');
      expect(shang.dunType, 0);
      expect(shang.juNumber, 9);

      final zhong = ZhirunCalculator.calculate(1718, 7, 5, 12, 0, 0);
      expect(zhong.juNumber, 3);

      final xia = ZhirunCalculator.calculate(1718, 7, 10, 12, 0, 0);
      expect(xia.juNumber, 6);
    });

    test('闰奇上元阳六局', () {
      final r = ZhirunCalculator.calculate(1718, 6, 15, 12, 0, 0);
      expect(r.juNumber, 6);
      expect(r.isLeap, isTrue);
    });
  });

  group('符头与三元', () {
    test('一元管五日六十时辰，入夜二十三点换元', () {
      expect(ZhirunCalculator.calculate(1718, 6, 18, 22, 0, 0).juNumber, 6);
      expect(ZhirunCalculator.calculate(1718, 6, 18, 23, 0, 0).juNumber, 3);
    });

    test('一日之内不换局', () {
      for (var d = 1; d <= 28; d++) {
        final base = ZhirunCalculator.slotOf(2024, 6, d, 0, 0, 0);
        for (var h = 1; h < 23; h++) {
          final cur = ZhirunCalculator.slotOf(2024, 6, d, h, 0, 0);
          expect(cur.slotStartDate, base.slotStartDate, reason: '2024-6-$d $h 时');
          expect(cur.yuanIndex, base.yuanIndex, reason: '2024-6-$d $h 时');
        }
      }
    });

    test('局数恒在一至九局之内', () {
      for (var y = 1700; y <= 1900; y += 7) {
        for (var m = 1; m <= 12; m++) {
          final r = ZhirunCalculator.calculate(y, m, 15, 12, 0, 0);
          expect(r.juNumber, inInclusiveRange(1, 9), reason: '$y-$m');
        }
      }
    });

    test('阴阳遁随符头转折，不随交节日', () {
      // 芒种阳遁
      expect(ZhirunCalculator.calculate(2024, 6, 1, 12, 0, 0).dunType, 1);
      // 超神：夏至未至而符头先到，六月十四即入阴遁
      expect(ZhirunCalculator.calculate(2024, 6, 14, 12, 0, 0).dunType, 0);
      expect(ZhirunCalculator.calculate(2024, 8, 1, 12, 0, 0).dunType, 0);
      // 接气：冬至已至而符头未到，十二月廿五仍行大雪阴遁
      expect(ZhirunCalculator.calculate(2024, 12, 25, 12, 0, 0).dunType, 0);
      // 冬至槽自十二月廿六起，方转阳遁
      expect(ZhirunCalculator.calculate(2024, 12, 26, 12, 0, 0).dunType, 1);
    });
  });

  group('置闰规则', () {
    test('闰奇只落在芒种、大雪之后', () {
      var leaps = 0;
      for (var y = 1800; y <= 2100; y++) {
        for (var m = 1; m <= 12; m++) {
          for (final d in [1, 8, 15, 22]) {
            final s = ZhirunCalculator.slotOf(y, m, d, 12, 0, 0);
            if (!s.isLeap) continue;
            leaps++;
            expect(s.jieqiIndex == 8 || s.jieqiIndex == 20, isTrue,
                reason: '$y-$m-$d 闰奇落在 ${s.jieqiIndex}');
          }
        }
      }
      expect(leaps, greaterThan(0));
    });

    test('约三年一闰：十五日之闰抵岁差五日二分', () {
      final starts = <int>{};
      for (var y = 1800; y <= 2100; y++) {
        for (var m = 1; m <= 12; m++) {
          for (final d in [1, 4, 8, 12, 15, 19, 22, 26]) {
            final s = ZhirunCalculator.slotOf(y, m, d, 12, 0, 0);
            if (!s.isLeap) continue;
            final p = s.slotStartDate.split('-').map(int.parse).toList();
            final jd = ChnChineseCalendar.instance
                .dateToJuliandTimeWithYear(p[0], p[1], p[2], 0);
            starts.add((jd + 0.5).floor());
          }
        }
      }
      final list = starts.toList()..sort();
      final years = (list.last - list.first) / 365.2422;
      final perYear = list.length / years;
      // 岁差 365.2422-360=5.24 日，一闰十五日，故 2.86 年一闰
      expect(perYear, greaterThan(1 / 3.05));
      expect(perYear, lessThan(1 / 2.7));
    });

    test('二至槽超神不越九、接气不过置闰所推七日', () {
      var lo = 99, hi = -99;
      for (var y = 1800; y <= 2100; y++) {
        for (var m in [6, 12]) {
          for (final d in [1, 4, 8, 12, 15, 19, 22, 26]) {
            final s = ZhirunCalculator.slotOf(y, m, d, 12, 0, 0);
            if (s.yuanIndex != 0) continue;
            if (s.jieqiIndex != 9 && s.jieqiIndex != 21) continue;
            if (s.chaoDays < lo) lo = s.chaoDays;
            if (s.chaoDays > hi) hi = s.chaoDays;
          }
        }
      }
      expect(hi, lessThanOrEqualTo(7)); // 含首尾八日，再进则达「超九」置闰
      expect(lo, greaterThanOrEqualTo(-7));
    });
  });
}
