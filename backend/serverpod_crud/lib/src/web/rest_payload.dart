import 'package:serverpod/serverpod.dart';

import 'rest_exception.dart';

/// 载荷归一化与请求体解析。
///
/// * [restJsonify] —— 把任意载荷（模型 / Map / List / DateTime 混合）转成
///   JSON 可编码结构，信封输出前统一走一遍；
/// * [encodeEnvelope] —— 信封 JSON → 响应体，**必须**用 Serverpod 的编码器；
/// * [asIntOrNull] / [extractIds] / [extractSingleId] —— 请求体里的数字与
///   id 列表解析，容忍浏览器发来的各种宽松写法。

/// 把载荷统一成 JSON 可编码结构。
///
/// 之所以需要它：delegate 返回的可能是 Serverpod 模型、`Map`、`List<模型>`，
/// 或者手搓的 `Map<String, dynamic>`（本项目 `DeptService` 就是手搓树）。
/// 表现层不该关心差异。
Object? restJsonify(Object? value) {
  if (value == null) return null;
  if (value is SerializableModel) return value.toJson();
  if (value is Map) {
    return value.map((key, v) => MapEntry(key.toString(), restJsonify(v)));
  }
  if (value is Iterable) return value.map(restJsonify).toList();
  if (value is DateTime) return value.toIso8601String();
  return value;
}

/// 把信封 JSON 编码成响应体。
///
/// ⚠️ **必须用 Serverpod 的编码器，不能用 `dart:convert` 的 `jsonEncode`。**
///
/// 原因是业务 Service 返回的载荷里常常混着**手搓的 `Map`**（本项目部门树 /
/// 菜单树就是这样），其中的 `createTime` / `updateTime` 是 `DateTime`
/// **对象**而不是字符串。`jsonEncode` 遇到 `DateTime` 会直接抛
/// `Converting object to an encodable object failed`（→ 500）；Serverpod 协议层
/// 用的是 `SerializationManager.encodeForProtocol`
/// （`serverpod/lib/src/server/server.dart:595`），它会把 `DateTime` 转成
/// ISO 串、把 `SerializableModel` 转成 `toJson()`。
///
/// 用同一个编码器，响应体形状才是天然的，而不是靠人肉对齐。
String encodeEnvelope(Map<String, dynamic> json) =>
    SerializationManager.encodeForProtocol(json);

/// 把 JSON 里的数字字段转成 `int?`（容忍 `"3"` 这种字符串写法）。
int? asIntOrNull(dynamic value) => switch (value) {
  final int v => v,
  final num v => v.toInt(),
  final String v => int.tryParse(v),
  _ => null,
};

/// 从请求体里取出待删除的 id 列表，同时兼容 `{"id":n}` / `{"ids":[…]}` /
/// 裸数组三种写法。取不到或全为非法值抛 400。
List<int> extractIds(Map<String, dynamic> body) {
  final raw = body['ids'] ?? body['id'];
  final candidates = switch (raw) {
    final List<dynamic> list => list,
    final Object single => [single],
    _ => const <dynamic>[],
  };
  final ids = candidates
      .map(asIntOrNull)
      .whereType<int>()
      .where((id) => id > 0)
      .toSet()
      .toList();
  if (ids.isEmpty) {
    throw const RestException.badRequest('参数不合法：请提供 id 或非空的 ids');
  }
  return ids;
}

/// 从请求体里取出**唯一**一个待删除 id，兼容 `{"id":n}` / `{"ids":[n]}`。
///
/// 给 `POST /delete`（单条删）用。给了多个 id 说明调用方用错了路由 ——
/// 那是 `POST /deleteBatch` 的活 —— 所以直接 400，不猜。
int extractSingleId(Map<String, dynamic> body) {
  final ids = extractIds(body);
  if (ids.length != 1) {
    throw RestException.badRequest(
      '参数不合法：单条删除只能给一个 id（收到 ${ids.length} 个），'
      '多条请用 POST /deleteBatch',
    );
  }
  return ids.first;
}
