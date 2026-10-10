import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'support/qimen_golden_cases.dart';

/// 盘面回归：基准 [test/golden/qimen_golden.json] 由重构前的实现导出，
/// 用来锁定「换查表方式不改盘面」。盘面生成逻辑改动后重跑
/// `dart run tool/dump_qimen_golden.dart > test/golden/qimen_golden.json`。
void main() {
  final goldenFile = File('test/golden/qimen_golden.json');

  test('基准文件存在且非空', () {
    expect(goldenFile.existsSync(), isTrue,
        reason: '缺少基准文件，先跑 dart run tool/dump_qimen_golden.dart');
    expect(goldenFile.lengthSync(), greaterThan(0));
  });

  test('全部盘面与基准逐条一致', () {
    final expected =
        jsonDecode(goldenFile.readAsStringSync()) as List<dynamic>;
    final actual = buildGoldenCases();

    expect(actual, hasLength(expected.length),
        reason: '用例条数变了，基准需要重新导出');

    for (var i = 0; i < expected.length; i++) {
      final want = expected[i] as Map<String, dynamic>;
      expect(actual[i], want,
          reason: '第 $i 条不一致：${want['input']} / ${want['method']}');
    }
  });

  test('每条盘面都是完整的 9 宫', () {
    for (final c in buildGoldenCases()) {
      for (final key in ['diPanQiyi', 'jiuXing', 'baMen', 'baShen', 'anGan', 'feiZhi']) {
        expect(c[key], hasLength(9), reason: '${c['input']} 的 $key 不是 9 宫');
      }
      expect((c['head'] as Map)['hourXunShou'], isNotEmpty);
      expect((c['head'] as Map)['zhiFu'], contains('落'));
      expect((c['head'] as Map)['zhiShi'], contains('落'));
    }
  });

  test('六旬首在用例集中全部出现', () {
    final seen = <String>{};
    for (final c in buildGoldenCases()) {
      seen.add((c['head'] as Map)['hourXunShou'] as String);
    }
    expect(seen, {'甲子戊', '甲戌己', '甲申庚', '甲午辛', '甲辰壬', '甲寅癸'});
  });
}
