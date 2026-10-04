import 'dart:io';

import 'package:test/test.dart';

void main() {
  final root = Directory.current.path;
  final script = '$root/tool/import_fastapi_zhongyi.sql.sh';
  final source = '/Users/coderxslee/workspace/FastapiAdmin/backend/sql/postgres/10月3日备份.sql';

  test('导入脚本包含处方模板主表和明细表，并按主表后明细表顺序生成', () {
    final output = File('$root/tool/generated/zhongyi_fastapi_import.sql').readAsStringSync();

    expect(output, contains('INSERT INTO "zhongyi_prescription_template"'));
    expect(output, contains('INSERT INTO "zhongyi_prescription_template_item"'));
    expect(
      output.indexOf('INSERT INTO "zhongyi_prescription_template"'),
      lessThan(output.indexOf('INSERT INTO "zhongyi_prescription_template_item"')),
    );
    expect(output, contains('"dailyFrequency"'));
    expect(output, contains('"templateId"'));
    expect(output, contains('"isSubstitute"'));
    expect(output, contains("VALUES (3, 0, '四逆汤', 'public'"));
    expect(output, contains("'[]'"));
    expect(output, contains('true, false'));
    expect(output, contains('COALESCE(MAX("id"), 1)'));
    expect(output, contains('RAISE EXCEPTION'));
    expect(output, contains('ON CONFLICT ("id") DO UPDATE'));
  });

  test('脚本从参考备份生成模板数据，并同步两张表的序列', () {
    final target = Directory.systemTemp.createTempSync('zhongyi-import-test-');
    addTearDown(() => target.deleteSync(recursive: true));
    final generated = '${target.path}/import.sql';
    final result = Process.runSync('bash', [script, source, generated]);

    expect(result.exitCode, 0, reason: '${result.stderr}\n${result.stdout}');
    final output = File(generated).readAsStringSync();
    expect(output, contains('INSERT INTO "zhongyi_prescription_template"'));
    expect(output, contains('INSERT INTO "zhongyi_prescription_template_item"'));
    expect(output, contains('setval'));
    expect(output, contains('zhongyi_prescription_template_id_seq'));
    expect(output, contains('zhongyi_prescription_template_item_id_seq'));
    expect(RegExp('^INSERT INTO "zhongyi_prescription_template"', multiLine: true).allMatches(output), hasLength(13));
    expect(RegExp('^INSERT INTO "zhongyi_prescription_template_item"', multiLine: true).allMatches(output), hasLength(77));
  });

  test('源库 status 为 0/active 表示启用，写入目标库时必须取反为 1', () {
    final target = Directory.systemTemp.createTempSync('zhongyi-import-status-');
    addTearDown(() => target.deleteSync(recursive: true));
    final generated = '${target.path}/import.sql';
    final result = Process.runSync('bash', [script, source, generated]);
    expect(result.exitCode, 0, reason: '${result.stderr}\n${result.stdout}');

    const statusTables = {
      'zhongyi_bill',
      'zhongyi_bill_item',
      'zhongyi_cabinet',
      'zhongyi_medicine_inventory',
      'zhongyi_medicine',
    };
    final pattern = RegExp(r'^INSERT INTO "(\w+)" \((.*?)\) VALUES \((.*)\) ON CONFLICT', multiLine: true);
    var checked = 0;
    for (final match in pattern.allMatches(File(generated).readAsStringSync())) {
      final table = match.group(1)!;
      if (!statusTables.contains(table)) continue;
      final columns = match.group(2)!.replaceAll('"', '').split(', ');
      expect(_splitValues(match.group(3)!)[columns.indexOf('status')], '1', reason: table);
      checked++;
    }
    expect(checked, 1142);
  });
}

/// 按顶层逗号切分 VALUES 内容，忽略引号内的逗号和括号嵌套。
List<String> _splitValues(String raw) {
  final values = <String>[];
  var start = 0;
  String? quote;
  var depth = 0;
  for (var i = 0; i < raw.length; i++) {
    final char = raw[i];
    if (quote != null) {
      if (char == quote && raw[i - 1] != r'\') quote = null;
    } else if (char == "'" || char == '"') {
      quote = char;
    } else if (char == '(') {
      depth++;
    } else if (char == ')') {
      depth--;
    } else if (char == ',' && depth == 0) {
      values.add(raw.substring(start, i).trim());
      start = i + 1;
    }
  }
  values.add(raw.substring(start).trim());
  return values;
}
