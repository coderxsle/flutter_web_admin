import 'dart:convert';
import 'dart:io';

import 'package:flutter_web_server/src/common/common.dart';
import 'package:path/path.dart' as path;

/// 从本地 JSON 文件读取并维护 CRUD 示例人员数据。
class PersonJsonService {
  static Future<Map<String, dynamic>>? _loadFuture;
  static File? _dataFile;

  /// 获取分页列表。
  static Future<CommonResponse> getList({
    int page = 1,
    int size = 10,
    String? name,
    String? status,
    String? categoryId,
  }) async {
    final document = await _document();
    var records = _recordList(document);
    final keyword = name?.trim();
    if (keyword != null && keyword.isNotEmpty) {
      records = records.where((record) => '${record['name'] ?? ''}'.contains(keyword)).toList();
    }
    if (status != null && status.isNotEmpty) {
      records = records.where((record) => '${record['status'] ?? ''}' == status).toList();
    }
    if (categoryId != null && categoryId.isNotEmpty) {
      final categoryIds = _categoryIds(await _document(), categoryId);
      records = records.where((record) => categoryIds.contains('${record['categoryId']}')).toList();
    }

    final safePage = page < 1 ? 1 : page;
    final safeSize = size < 1 ? 10 : size;
    final start = (safePage - 1) * safeSize;
    final end = start + safeSize;
    final pageRecords = start >= records.length
        ? <Map<String, dynamic>>[]
        : records.sublist(start, end.clamp(start, records.length));

    return CommonResponse.success({'records': pageRecords, 'total': records.length});
  }

  /// 获取单条详情。
  static Future<CommonResponse> getDetail(int id) async {
    final record = _recordList(
      await _document(),
    ).cast<Map<String, dynamic>?>().firstWhere((item) => _asInt(item?['id']) == id, orElse: () => null);
    return record == null ? CommonResponse.validateFailed('人员不存在') : CommonResponse.success(record);
  }

  /// 新增人员。
  static Future<CommonResponse> add(Map<String, dynamic> body) async {
    final document = await _document();
    final records = _recordList(document);
    final id =
        records.map((record) => _asInt(record['id']) ?? 0).fold(0, (maxId, value) => value > maxId ? value : maxId) + 1;
    final record = _normalizeRecord({...body, 'id': id});
    record['createTime'] = _text(record['createTime']).isEmpty ? _formatDateTime(DateTime.now()) : record['createTime'];
    records.add(record);
    document['records'] = records;
    await _save(document);
    return CommonResponse.success(record);
  }

  /// 修改人员。
  static Future<CommonResponse> update(Map<String, dynamic> body) async {
    final id = _asInt(body['id']);
    if (id == null) return CommonResponse.validateFailed('请求体缺少合法的 id');

    final document = await _document();
    final records = _recordList(document);
    final index = records.indexWhere((record) => _asInt(record['id']) == id);
    if (index < 0) return CommonResponse.validateFailed('人员不存在');

    final existing = records[index];
    final record = _normalizeRecord({...existing, ...body, 'id': id});
    record['createTime'] = _text(record['createTime']).isEmpty ? existing['createTime'] : record['createTime'];
    records[index] = record;
    document['records'] = records;
    await _save(document);
    return CommonResponse.success(record);
  }

  /// 删除单条人员。
  static Future<CommonResponse> delete(int id) async {
    final document = await _document();
    final records = _recordList(document);
    final removed = records.any((record) => _asInt(record['id']) == id);
    if (!removed) return CommonResponse.validateFailed('人员不存在');
    records.removeWhere((record) => _asInt(record['id']) == id);
    document['records'] = records;
    await _save(document);
    return CommonResponse.success(true);
  }

  /// 批量删除人员。
  static Future<CommonResponse> deleteBatch(List<int> ids) async {
    if (ids.isEmpty) return CommonResponse.validateFailed('ids 不能为空');

    final document = await _document();
    final records = _recordList(document);
    final existingIds = records.map((record) => _asInt(record['id'])).whereType<int>().toSet();
    final successIds = ids.where(existingIds.contains).toSet().toList();
    final failedIds = ids.where((id) => !existingIds.contains(id)).toSet().toList();
    records.removeWhere((record) => successIds.contains(_asInt(record['id'])));
    document['records'] = records;
    await _save(document);

    return CommonResponse.success({
      'total': ids.length,
      'successCount': successIds.length,
      'notFoundCount': failedIds.length,
      'successIds': successIds,
      'failedIds': failedIds,
    });
  }

  /// 获取人员分类树。
  static Future<CommonResponse> getCategoryTree() async {
    final document = await _document();
    final rawCategories = document['categories'] as List? ?? const [];
    if (rawCategories.any((item) => item is Map && item['children'] is List)) {
      return CommonResponse.success(_nestedCategoryList(rawCategories));
    }

    final nodes = <String, Map<String, dynamic>>{};
    for (final item in rawCategories) {
      final node = Map<String, dynamic>.from(item as Map);
      node['children'] = <Map<String, dynamic>>[];
      nodes['${node['id']}'] = node;
    }

    final roots = <Map<String, dynamic>>[];
    for (final node in nodes.values) {
      final parentId = node['pid'];
      final parent = parentId == null ? null : nodes['$parentId'];
      if (parent == null) {
        roots.add(node);
      } else {
        (parent['children'] as List<Map<String, dynamic>>).add(node);
      }
    }
    return CommonResponse.success(roots);
  }

  static Set<String> _categoryIds(Map<String, dynamic> document, String selectedId) {
    final ids = <String>{};

    void collect(List<dynamic> items, bool inherited) {
      for (final item in items) {
        if (item is! Map) continue;
        final node = Map<String, dynamic>.from(item);
        final matched = inherited || '${node['id']}' == selectedId;
        if (matched) ids.add('${node['id']}');
        final children = node['children'];
        if (children is List) collect(children, matched);
      }
    }

    collect(document['categories'] as List? ?? const [], false);
    return ids;
  }

  static List<Map<String, dynamic>> _nestedCategoryList(List<dynamic> items) {
    return items.whereType<Map>().map((item) {
      final node = Map<String, dynamic>.from(item);
      final children = node['children'];
      if (children is List) {
        node['children'] = _nestedCategoryList(children);
      } else {
        node.remove('children');
      }
      return node;
    }).toList();
  }

  /// 获取表单所需的字典选项。
  static Future<CommonResponse> getOptions() async {
    final document = await _document();
    return CommonResponse.success(Map<String, dynamic>.from(document['options'] as Map? ?? const {}));
  }

  static Future<Map<String, dynamic>> _document() => _loadFuture ??= _readDocument();

  static Future<Map<String, dynamic>> _readDocument() async {
    final file = await _resolveDataFile();
    final decoded = jsonDecode(await file.readAsString());
    if (decoded is! Map) throw StateError('人员 JSON 数据格式不正确');
    _dataFile = file;
    return Map<String, dynamic>.from(decoded);
  }

  static Future<File> _resolveDataFile() async {
    final current = Directory.current.path;
    final candidates = [
      path.join(current, 'data', 'person.json'),
      path.join(current, 'flutter_web_server', 'data', 'person.json'),
      path.join(current, 'server', 'flutter_web_server', 'data', 'person.json'),
    ];
    for (final candidate in candidates) {
      final file = File(candidate);
      if (await file.exists()) return file;
    }
    throw StateError('找不到人员数据文件 data/person.json');
  }

  static Future<void> _save(Map<String, dynamic> document) async {
    final file = _dataFile ?? await _resolveDataFile();
    await file.writeAsString(const JsonEncoder.withIndent('  ').convert(document));
  }

  static List<Map<String, dynamic>> _recordList(Map<String, dynamic> document) {
    return (document['records'] as List? ?? const [])
        .map((item) => _normalizeRecord(Map<String, dynamic>.from(item as Map)))
        .toList();
  }

  static Map<String, dynamic> _normalizeRecord(Map<String, dynamic> record) {
    final normalized = <String, dynamic>{...record};
    normalized['id'] = _asInt(normalized['id']);
    normalized['name'] = _text(normalized['name']);
    normalized['account'] = _text(normalized['account']);
    normalized['avatar'] = _text(normalized['avatar']);
    normalized['gender'] = _asInt(normalized['gender']) ?? 3;
    normalized['phone'] = _text(normalized['phone']);
    normalized['email'] = _text(normalized['email']);
    normalized['createTime'] = _text(normalized['createTime']);
    normalized['address'] = _text(normalized['address']);
    normalized['age'] = _asInt(normalized['age']);
    normalized['status'] = _asInt(normalized['status']) ?? 1;
    normalized['hobby'] = normalized['hobby'] is List
        ? (normalized['hobby'] as List).map((item) => '$item').toList()
        : <String>[];
    normalized['remark'] = _text(normalized['remark']);
    normalized['categoryId'] = _text(normalized['categoryId']);
    return normalized;
  }

  static int? _asInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse('$value');
  }

  static String _text(Object? value, {String fallback = ''}) {
    final text = value?.toString().trim();
    return text == null || text.isEmpty ? fallback : text;
  }

  static String _formatDateTime(DateTime value) {
    String twoDigits(int number) => number.toString().padLeft(2, '0');
    return '${value.year}-${twoDigits(value.month)}-${twoDigits(value.day)} ${twoDigits(value.hour)}:${twoDigits(value.minute)}:${twoDigits(value.second)}';
  }
}
