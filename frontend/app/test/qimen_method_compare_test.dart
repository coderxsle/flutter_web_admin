import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/qimen_calculator.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/qimen_method_compare.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/zhirun_calculator.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/algorithm/zy_datetime_model.dart';
import 'package:flutter_test/flutter_test.dart';

final QimenCalculator _calc = QimenCalculator();

ZYDatetimeModel _at(DateTime day, int shichen) => ZYDatetimeModel(
      year: day.year,
      month: day.month,
      day: day.day,
      hour: QimenMethodCompare.shichenHours[shichen],
      minute: 30,
    );

/// 直接按真实排盘判定两法此刻是否不同，用作对比卡数据的对照基准
bool _differs(DateTime day, int shichen) {
  final dt = _at(day, shichen);
  final a = _calc.calculate(dt, method: QimenMethod.chaibu).head;
  final b = _calc.calculate(dt, method: QimenMethod.zhirun).head;
  return !(a.jieQi == b.jieQi &&
      a.sanYuan == b.sanYuan &&
      a.dunType == b.dunType &&
      a.jushu == b.jushu);
}

void main() {
  group('年度统计', () {
    test('2026 年差异 90 天、954 时辰、23 段', () {
      final compare = QimenMethodCompare.ofYear(2026);
      expect(compare.year, 2026);
      expect(compare.dayDiff, 90);
      expect(compare.shichenDiff, 954);
      expect(compare.segments.length, 23);
    });

    test('相邻年份各算各的，不串年', () {
      expect(QimenMethodCompare.ofYear(2025).shichenDiff, 812);
      expect(QimenMethodCompare.ofYear(2027).shichenDiff, 2340);
    });

    test('段内时辰数之和等于全年差异时辰数', () {
      final compare = QimenMethodCompare.ofYear(2026);
      final sum = compare.segments
          .fold<int>(0, (acc, s) => acc + s.shichenCount);
      expect(sum, compare.shichenDiff);
    });
  });

  group('段边界与真实排盘对齐', () {
    test('段内首尾时辰不同，段外紧邻时辰相同', () {
      final compare = QimenMethodCompare.ofYear(2026);
      for (final s in compare.segments) {
        expect(_differs(s.startDay, s.startShichen), isTrue,
            reason: '段首 ${s.startDay} 第 ${s.startShichen} 时辰');
        expect(_differs(s.endDay, s.endShichen), isTrue,
            reason: '段尾 ${s.endDay} 第 ${s.endShichen} 时辰');
        if (s.startShichen == 0) {
          expect(
            _differs(s.startDay.subtract(const Duration(days: 1)),
                QimenMethodCompare.shichenHours.length - 1),
            isFalse,
            reason: '段前一时辰 ${s.startDay}',
          );
        } else {
          expect(_differs(s.startDay, s.startShichen - 1), isFalse,
              reason: '段前一时辰 ${s.startDay}');
        }
      }
    });

    test('段的起止跨月跨年也连续', () {
      final compare = QimenMethodCompare.ofYear(2026);
      for (final s in compare.segments) {
        expect(s.startDay.year, 2026);
        expect(s.endDay.year, 2026);
        expect(s.shichenCount, greaterThan(0));
        expect(s.endShichen, inInclusiveRange(0, 11));
      }
    });

    test('2026 年唯一跨阴阳遁的两段', () {
      final compare = QimenMethodCompare.ofYear(2026);
      final dunSegments =
          compare.segments.where((s) => s.dunDiffers).toList();
      expect(dunSegments.length, 2);
      expect(dunSegments.first.startDay.month, 6);
      expect(dunSegments.last.startDay.month, 12);
      // 芒种→夏至、大雪→冬至，两次二至前后
      expect(dunSegments.first.chaibuJu, contains('芒种'));
      expect(dunSegments.first.zhirunJu, contains('夏至'));
      expect(dunSegments.last.zhirunJu, contains('冬至'));
    });
  });

  group('单点对照', () {
    test('对照结果与真实排盘一致', () {
      for (final t in [
        [2026, 6, 20, 12],
        [2026, 10, 5, 12],
        [2026, 3, 1, 12],
        [2027, 8, 9, 6],
      ]) {
        final dt = ZYDatetimeModel(
            year: t[0], month: t[1], day: t[2], hour: t[3], minute: 0);
        final snapshot = QimenMethodCompare.at(dt);
        final a = _calc.calculate(dt, method: QimenMethod.chaibu).head;
        final b = _calc.calculate(dt, method: QimenMethod.zhirun).head;
        expect(snapshot.chaibuJu, QimenMethodCompare.juLabel(a));
        expect(snapshot.zhirunJu, QimenMethodCompare.juLabel(b));
        expect(snapshot.same, a.jushu == b.jushu && a.dunType == b.dunType);
      }
    });

    test('闰奇期间置闰法仍行重演的节气', () {
      // 2024-12-11 起大雪闰奇十五日；拆补 12-22 已交冬至，置闰仍在大雪下元
      expect(ZhirunCalculator.slotOf(2024, 12, 22, 12, 0, 0).isLeap, isTrue);
      final winter = QimenMethodCompare.at(
          ZYDatetimeModel(year: 2024, month: 12, day: 22, hour: 12, minute: 0));
      expect(winter.chaibuJu, '冬至下元 阳遁4局');
      expect(winter.zhirunJu, '大雪下元 阴遁1局');
      expect(winter.dunDiffers, isTrue);

      // 2030-06-13 起芒种闰奇十五日，第二、三元落在拆补已交夏至之后
      expect(ZhirunCalculator.slotOf(2030, 6, 24, 12, 0, 0).isLeap, isTrue);
      final summer = QimenMethodCompare.at(
          ZYDatetimeModel(year: 2030, month: 6, day: 24, hour: 12, minute: 0));
      expect(summer.chaibuJu, '夏至下元 阴遁6局');
      expect(summer.zhirunJu, '芒种下元 阳遁9局');
      expect(summer.dunDiffers, isTrue);
    });

    test('局名格式与盘面头部一致', () {
      final dt = ZYDatetimeModel(year: 2026, month: 6, day: 20, hour: 12);
      expect(QimenMethodCompare.at(dt).chaibuJu, '芒种上元 阳遁6局');
      expect(QimenMethodCompare.at(dt).zhirunJu, '夏至上元 阴遁9局');
    });
  });

  group('闰奇统计', () {
    test('2026 年无闰奇，差异全出自超神接气', () {
      final compare = QimenMethodCompare.ofYear(2026);
      expect(compare.leapCount, 0);
      expect(compare.leapText, isNull);
      expect(compare.leapShichenDiff, 0);
      expect(compare.shichenDiff, 954);
    });

    test('闰奇年的次数、出处与落在闰奇期内的差异时辰', () {
      final winter = QimenMethodCompare.ofYear(2024);
      expect(winter.leapCount, 1);
      expect(winter.leapText, '12-11 起大雪');
      expect(winter.leapShichenDiff, 51);
      expect(winter.leapShichenDiff, lessThan(winter.shichenDiff));

      final summer = QimenMethodCompare.ofYear(2030);
      expect(summer.leapCount, 1);
      expect(summer.leapText, '06-13 起芒种');
      expect(summer.leapShichenDiff, 76);

      expect(QimenMethodCompare.ofYear(2025).leapCount, 0);
    });

    test('落在闰奇期内的差异时辰，逐时辰复算一致', () {
      final compare = QimenMethodCompare.ofYear(2024);
      var counted = 0;
      for (final s in compare.segments) {
        var day = s.startDay;
        var shichen = s.startShichen;
        for (var i = 0; i < s.shichenCount; i++) {
          final leap = ZhirunCalculator.slotOf(
            day.year,
            day.month,
            day.day,
            12,
            0,
            0,
          ).isLeap;
          if (leap) counted++;
          if (shichen == QimenMethodCompare.shichenHours.length - 1) {
            day = day.add(const Duration(days: 1));
            shichen = 0;
          } else {
            shichen++;
          }
        }
      }
      expect(counted, compare.leapShichenDiff);
    });
  });

  group('表格局名', () {
    test('紧凑局名去掉空格与遁字', () {
      expect(QimenMethodCompare.juCompact('大雪上元 阴遁4局'), '大雪上元阴4局');
      expect(QimenMethodCompare.juCompact('芒种上元 阳遁6局'), '芒种上元阳6局');
    });

    test('跨三元时用箭头相连，同节气不复述', () {
      expect(
        QimenMethodCompare.juCompact('立秋上元 阴遁2局', '立秋中元 阴遁5局'),
        '立秋上元阴2局→中元阴5局',
      );
      expect(
        QimenMethodCompare.juCompact('大雪上元 阴遁4局', '冬至上元 阳遁1局'),
        '大雪上元阴4局→冬至上元阳1局',
      );
    });

    test('小暑小寒这类同首字的节气不会被误删', () {
      expect(
        QimenMethodCompare.juCompact('小暑上元 阴遁8局', '小寒上元 阳遁2局'),
        '小暑上元阴8局→小寒上元阳2局',
      );
    });

    test('段末局与真实排盘一致', () {
      final compare = QimenMethodCompare.ofYear(2026);
      for (final s in compare.segments) {
        final a = _calc
            .calculate(_at(s.endDay, s.endShichen), method: QimenMethod.chaibu)
            .head;
        final b = _calc
            .calculate(_at(s.endDay, s.endShichen), method: QimenMethod.zhirun)
            .head;
        expect(s.chaibuJuEnd, QimenMethodCompare.juLabel(a),
            reason: '段末拆补 ${s.endDay}');
        expect(s.zhirunJuEnd, QimenMethodCompare.juLabel(b),
            reason: '段末置闰 ${s.endDay}');
      }
    });
  });
}
