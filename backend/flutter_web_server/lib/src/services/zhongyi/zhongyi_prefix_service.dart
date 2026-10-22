import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_audit.dart';
import 'package:path/path.dart' as path;
import 'package:serverpod/serverpod.dart';

/// 炮制前缀字典：JSON 文件持久化，App 与 Web 共用同一份数据。
class ZhongyiPrefixService {
  ZhongyiPrefixService._();

  static const String _configEnvKey = 'ZHONGYI_PREFIX_CONFIG';
  static const String _configFileName = 'zhongyi_prefixes.json';
  static const String customGroupTitle = '自定义';
  static const int maxPrefixLength = 5;

  static File? _configFile;
  static Future<void> _writeQueue = Future<void>.value();

  static Future<CommonResponse> list(Session session) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    try {
      return CommonResponse.success(await groups());
    } catch (_) {
      return CommonResponse.failed('获取炮制前缀失败');
    }
  }

  /// 新增自定义前缀；已存在则原样返回当前分组，避免重复项。
  static Future<CommonResponse> create(Session session, Map<String, dynamic> body) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();

    final prefix = '${body['prefix'] ?? ''}'.trim();
    if (prefix.isEmpty) return CommonResponse.validateFailed('前缀不能为空');
    if (prefix.length > maxPrefixLength) {
      return CommonResponse.validateFailed('前缀不能超过 $maxPrefixLength 个字符');
    }

    try {
      final before = await groups();
      final payload = await appendPrefix(prefix, '${body['groupTitle'] ?? ''}');
      if (!before.any((group) => (group['items'] as List).contains(prefix))) {
        await ZhongyiAudit.record(
          session,
          type: ZhongyiAudit.typeMedicinePrefix,
          action: 'create',
          bizId: 0,
          detail: {'prefix': prefix, 'groupTitle': '${body['groupTitle'] ?? ''}'.trim()},
        );
      }
      return CommonResponse.success(payload);
    } catch (_) {
      return CommonResponse.failed('新增炮制前缀失败');
    }
  }

  /// 读当前分组。
  static Future<List<Map<String, dynamic>>> groups() async => _toJson(await _readGroups());

  /// 追加前缀并落盘；已存在不重复写入。
  static Future<List<Map<String, dynamic>>> appendPrefix(String prefix, String groupTitle) async {
    final groups = await _readGroups();
    if (groups.any((group) => group.items.contains(prefix))) return _toJson(groups);

    final title = groupTitle.trim().isEmpty ? customGroupTitle : groupTitle.trim();
    final group = groups.firstWhere(
      (item) => item.title == title,
      orElse: () {
        final created = _PrefixGroup(title, []);
        groups.add(created);
        return created;
      },
    );
    group.items.add(prefix);
    await _save(groups);
    return _toJson(groups);
  }

  static List<Map<String, dynamic>> _toJson(List<_PrefixGroup> groups) =>
      [for (final group in groups) {'title': group.title, 'items': List<String>.of(group.items)}];

  static Future<List<_PrefixGroup>> _readGroups() async {
    final file = _configFile ??= await _resolveConfigFile();
    if (!await file.exists()) return [];
    final decoded = jsonDecode(await file.readAsString());
    if (decoded is! List) throw StateError('$file 格式不正确');
    return [
      for (final item in decoded.whereType<Map>())
        _PrefixGroup(
          '${item['title'] ?? ''}'.trim(),
          [for (final value in (item['items'] as List? ?? const [])) '$value'.trim()],
        )..items.removeWhere((value) => value.isEmpty),
    ];
  }

  /// 写入串行化 + 临时文件替换，避免并发请求写出半截 JSON。
  static Future<void> _save(List<_PrefixGroup> groups) {
    final payload = const JsonEncoder.withIndent('  ').convert(_toJson(groups));
    final task = _writeQueue.then((_) async {
      final file = _configFile ??= await _resolveConfigFile();
      await file.parent.create(recursive: true);
      final temp = File('${file.path}.tmp');
      await temp.writeAsString('$payload\n', flush: true);
      await temp.rename(file.path);
    });
    _writeQueue = task.catchError((_) {});
    return task;
  }

  /// 依次找：环境变量 → 常见工作目录 → 服务工程目录。
  static Future<File> _resolveConfigFile() async {
    final current = Directory.current.path;
    final script = path.dirname(path.dirname(Platform.script.toFilePath()));
    final candidates = [
      Platform.environment[_configEnvKey],
      path.join(current, 'data', _configFileName),
      path.join(current, 'flutter_web_server', 'data', _configFileName),
      path.join(current, 'server', 'flutter_web_server', 'data', _configFileName),
      path.join(script, 'data', _configFileName),
    ].whereType<String>();

    for (final candidate in candidates) {
      final file = File(candidate);
      if (await file.exists()) return file;
    }
    final fallback = File(path.join(current, 'data', _configFileName));
    return fallback;
  }
}

class _PrefixGroup {
  _PrefixGroup(this.title, this.items);

  final String title;
  final List<String> items;
}
