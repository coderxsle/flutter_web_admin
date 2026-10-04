import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 读取任意合法 JSON 请求体，兼容 FastapiAdmin 删除接口使用的裸 ID 数组。
Future<Object?> zhongyiJsonBody(Request request) async {
  final raw = await request.readAsString();
  if (raw.trim().isEmpty) return <String, dynamic>{};
  try {
    return jsonDecode(raw);
  } on FormatException {
    throw const RestException.badRequest('请求体不是合法 JSON');
  }
}

/// 解析批量删除接口的 ID；容忍裸数组、`{"ids":[...]}` 和 `{"id":...}`。
Future<List<int>> zhongyiRequiredIdList(Request request) async {
  final decoded = await zhongyiJsonBody(request);
  final raw = switch (decoded) {
    final List<dynamic> list => list,
    final Map map => map['ids'] ?? map['id'],
    _ => null,
  };
  final candidates = switch (raw) {
    final List<dynamic> list => list,
    null => const <dynamic>[],
    final Object single => [single],
  };
  final ids = candidates.map(asIntOrNull).whereType<int>().where((id) => id > 0).toSet().toList();
  if (ids.isEmpty) throw const RestException.badRequest('请提供有效的记录 ID');
  return ids;
}

/// 统一分页入参，限制最大页长避免一次性拉取过多档案。
({int page, int pageSize, int offset}) zhongyiPagination(Request request, {int defaultPageSize = 10}) {
  final page = request.queryInt('page_no') ?? request.queryInt('page') ?? 1;
  final pageSize = request.queryInt('page_size') ?? request.queryInt('pageSize') ?? defaultPageSize;
  if (page <= 0 || pageSize <= 0) throw const RestException.badRequest('分页参数必须是正整数');
  final boundedPageSize = pageSize.clamp(1, 100);
  return (page: page, pageSize: boundedPageSize, offset: (page - 1) * boundedPageSize);
}
