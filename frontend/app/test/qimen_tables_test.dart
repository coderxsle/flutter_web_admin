import 'package:auto_shop_server/app/modules/zhouyi/algorithm/qimen_tables.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('表结构自检通过', () {
    expect(QimenTables.selfCheck(), isEmpty);
  });

  group('表长度', () {
    test('几张 9 项盘表', () {
      expect(QimenTables.jiuXing.length, 9);
      expect(QimenTables.baMen.length, 9);
      expect(QimenTables.qiYiYang.length, 9);
      expect(QimenTables.qiYiYin.length, 9);
    });

    test('六旬首相关三表同为 6 项', () {
      expect(QimenTables.xunShouZhi, hasLength(6));
      expect(QimenTables.xunShouGan, hasLength(6));
      expect(QimenTables.xunShouZhiOrder, hasLength(6));
    });

    test('八神 8 项、马星干支表 12 / 4 项', () {
      expect(QimenTables.baShenYang, hasLength(8));
      expect(QimenTables.baShenYin, hasLength(8));
      expect(QimenTables.diBaShenYang, hasLength(8));
      expect(QimenTables.diBaShenYin, hasLength(8));
      expect(QimenTables.maXingZhi, hasLength(12));
      expect(QimenTables.maXingYing, hasLength(4));
    });
  });

  group('洛书轨迹', () {
    test('恰好覆盖 1..9 除 5 外的八宫，5 宫寄二宫', () {
      expect(QimenTables.luoshu, [1, 8, 3, 4, 9, 2, 7, 6]);
      expect(QimenTables.luoshu.toSet(), {1, 2, 3, 4, 6, 7, 8, 9});
      expect(QimenTables.luoshu, isNot(contains(5)));
    });

    test('取下标：合法宫返回 0..7，5 宫直接报错而不是静默 -1', () {
      expect(QimenTables.luoshuPos(1), 0);
      expect(QimenTables.luoshuPos(9), 4);
      expect(() => QimenTables.luoshuPos(5), throwsArgumentError);
    });
  });

  group('旬空', () {
    // 相对宫号 1..9：子坎1、丑寅艮8、卯震3、辰巳巽4、午离9、未申坤2、酉兑7、戌亥乾6
    test('六旬各空两支，返回 0 基宫下标', () {
      expect(QimenTables.xunKongIndexOf('甲子戊'), {5}); // 戌亥 → 乾6
      expect(QimenTables.xunKongIndexOf('甲戌己'), {1, 6}); // 申 → 坤2、酉 → 兑7
      expect(QimenTables.xunKongIndexOf('甲申庚'), {8, 1}); // 午 → 离9、未 → 坤2
      expect(QimenTables.xunKongIndexOf('甲午辛'), {3}); // 辰巳 → 巽4
      expect(QimenTables.xunKongIndexOf('甲辰壬'), {7, 2}); // 寅 → 艮8、卯 → 震3
      expect(QimenTables.xunKongIndexOf('甲寅癸'), {0, 7}); // 子 → 坎1、丑 → 艮8
    });

    test('每旬空亡地支恰好两支，且互不重复', () {
      for (final entry in QimenTables.xunKongZhi.entries) {
        expect(entry.value, hasLength(2), reason: '${entry.key} 应空两支');
        expect(entry.value.toSet(), hasLength(2), reason: '${entry.key} 空亡地支重复');
      }
    });

    test('未知旬首返回空集合', () {
      expect(QimenTables.xunKongIndexOf('甲子丁'), isEmpty);
    });
  });

  group('环取', () {
    test('起点越界按模归位，不抛异常也不截断', () {
      const base = '戊己庚辛壬癸丁丙乙';
      expect(QimenTables.cycle(base, 0, 9), base);
      expect(QimenTables.cycle(base, 9, 9), base);
      expect(QimenTables.cycle(base, 1, 9), '己庚辛壬癸丁丙乙戊');
      expect(QimenTables.cycle(base, 12, 9), '辛壬癸丁丙乙戊己庚');
      expect(QimenTables.cycle(base, -3, 9), '丁丙乙戊己庚辛壬癸');
    });

    test('ring 与 cycle 同源', () {
      final list = QimenTables.qiYiYang;
      for (var start = -3; start < 12; start++) {
        expect(QimenTables.ring(list, start, 9).join(),
            QimenTables.cycle(list.join(), start, 9));
      }
    });
  });

  group('马星', () {
    test('三合局分组：申子辰马在寅、寅午戌马在申、亥卯未马在巳、巳酉丑马在亥', () {
      const want = {
        '申子辰': '寅',
        '寅午戌': '申',
        '亥卯未': '巳',
        '巳酉丑': '亥',
      };
      final groups = <String, String>{};
      for (var g = 0; g < 4; g++) {
        groups[QimenTables.maXingZhi.sublist(g * 3, g * 3 + 3).join()] =
            QimenTables.maXingYing[g];
      }
      expect(groups, want);
    });
  });

  group('宫号换算', () {
    test('at 取 1 基宫号，越界给空串', () {
      expect(QimenTables.at(QimenTables.jiuXing, 1), '蓬');
      expect(QimenTables.at(QimenTables.jiuXing, 9), '英');
      expect(QimenTables.at(QimenTables.jiuXing, 10), '');
      expect(QimenTables.at(QimenTables.jiuXing, 0), '');
    });

    test('gongIndexOf 正向偏移 1', () {
      expect(QimenTables.gongIndexOf(1), 0);
      expect(QimenTables.gongIndexOf(9), 8);
    });
  });
}
