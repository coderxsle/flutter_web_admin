/// 奇门排盘基准用例集与序列化。`tool/dump_qimen_golden.dart` 与
/// `test/qimen_calculator_golden_test.dart` 共用，避免两边漂移。
library;

import 'package:auto_shop_server/app/modules/zhouyi/algorithm/qimen_calculator.dart';
import 'package:auto_shop_server/app/modules/zhouyi/algorithm/zy_datetime_model.dart';

/// 八个节气附近的日期 × 24 小时，覆盖阴阳遁、六旬首、五宫寄二宫
const List<List<int>> kGoldenDays = [
  [2024, 1, 15],
  [2024, 3, 15],
  [2024, 5, 15],
  [2024, 7, 15],
  [2024, 9, 15],
  [2024, 11, 15],
  [2025, 2, 4],
  [2025, 6, 21],
];

/// 逐条排盘并序列化，两种起局法各一份
List<Map<String, dynamic>> buildGoldenCases() {
  final results = <Map<String, dynamic>>[];
  for (final d in kGoldenDays) {
    for (var h = 0; h < 24; h++) {
      final dt = ZYDatetimeModel(
        year: d[0],
        month: d[1],
        day: d[2],
        hour: h,
        minute: 30,
      );
      for (final method in QimenMethod.values) {
        results.add(serializeCase(dt, method));
      }
    }
  }
  return results;
}

/// 把一盘的全部可观测字段铺平成 map，任一字段变化都会让基准失配
Map<String, dynamic> serializeCase(ZYDatetimeModel dt, QimenMethod method) {
  final model = QimenCalculator().calculate(dt, method: method);
  final h = model.head;
  return {
    'input': '${dt.year}-${dt.month}-${dt.day} ${dt.hour}:${dt.minute}',
    'method': method.name,
    'head': {
      'yearGanzhi': h.yearGanzhi,
      'monthGanzhi': h.monthGanzhi,
      'dayGanzhi': h.dayGanzhi,
      'hourGanzhi': h.hourGanzhi,
      'yearEmpty': h.yearEmpty,
      'monthEmpty': h.monthEmpty,
      'dayEmpty': h.dayEmpty,
      'hourEmpty': h.hourEmpty,
      'sanYuan': h.sanYuan,
      'jieQi': h.jieQi,
      'nongli': h.nongli,
      'dunType': h.dunType,
      'jushu': h.jushu,
      'hourXunShou': h.hourXunShou,
      'zhiFu': h.zhiFu,
      'zhiShi': h.zhiShi,
    },
    'diPanQiyi': model.diPanQiyi,
    'jiuXing': model.jiuXing,
    'tianPanQiyi': model.tianPanQiyi,
    'baMen': model.baMen,
    'baShen': model.baShen,
    'anGan': model.anGan,
    'feiZhi': model.feiZhi,
    'diBaShen': model.diBaShen,
    'maXing': model.maXing,
    'diPanZhiFuIndex': model.diPanZhiFuIndex,
    'shiGanKeYing1': model.shiGanKeYing1,
    'shiGanKeYing2': model.shiGanKeYing2,
  };
}
