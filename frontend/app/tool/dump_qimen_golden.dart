/// 导出奇门排盘基准数据（golden）。
///
/// ```
/// dart run tool/dump_qimen_golden.dart > test/golden/qimen_golden.json
/// ```
///
/// 改排盘算法后重跑本脚本，与 test/golden/qimen_golden.json 对比即可判断
/// 盘面是否被改动。算法层是纯 Dart，不依赖 Flutter，可直接 dart run。
library;

import 'dart:convert';
import 'dart:io';

import '../test/support/qimen_golden_cases.dart';

void main() {
  final results = buildGoldenCases();
  stdout.write(const JsonEncoder.withIndent('  ').convert(results));
  stderr.writeln('共 ${results.length} 条盘面');
}
