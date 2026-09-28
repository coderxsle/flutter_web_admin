/// REST delegate 层的公共工具。
library;

import 'package:flutter_web_server/src/common/common.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 其余去掉首尾空白。
String? trimmedString(Object? value) {
  if (value == null) return null;
  final text = value.toString().trim();
  return text.isEmpty ? null : text;
}

/// 读必填字符串；缺失或空白抛 400。
String requiredText(Map<String, dynamic> body, String key) {
  final value = trimmedString(body[key]);
  if (value == null) {
    throw RestException.badRequest('$key 不能为空');
  }
  return value;
}

/// 读必填整型；缺失或非数字抛 400。
int requiredInt(Map<String, dynamic> body, String key) {
  final value = asIntOrNull(body[key]);
  if (value == null) {
    throw RestException.badRequest('$key 必须是整数');
  }
  return value;
}

/// 布尔解析：容忍 `true` / `"true"` / `1` / `"1"`。
bool? asBoolOrNull(Object? value) => switch (value) {
  final bool v => v,
  final num v => v != 0,
  final String v => switch (v.trim().toLowerCase()) {
    'true' || '1' => true,
    'false' || '0' => false,
    _ => null,
  },
  _ => null,
};

/// 整型数组解析：非 List 或元素全非法 → `null`。
List<int>? asIntListOrNull(Object? value) => switch (value) {
  final List<dynamic> list => list.map(asIntOrNull).whereType<int>().toList(), _ => null,
};

/// 把「单值或数组」的 JSON 值归一成**去重后的正整数列表**。
///
/// 与 [asIntListOrNull] 的区别：那个是**严格**的「必须是 List，否则 null」，
/// 专门用在 PATCH 判定基线上（`patchIntList`）；
/// 这个是**宽松**解析，用在请求体里的 id 集合 —— 让 `{"id":1}` /
/// `{"ids":[1,2]}` / `{"ids":["1","2"]}` 三种写法都能走通，
/// 与框架的 `extractIds` 保持同一套容忍度。
///
/// 语义：非整数元素被丢弃，`<= 0` 被丢弃，结果去重。
List<int> normalizedIntList(Object? value) => switch (value) {
  final List<dynamic> list => list,
  null => const <dynamic>[],
  final Object single => [single],
}.map(asIntOrNull).whereType<int>().where((id) => id > 0).toSet().toList();

/// 读**必填**的整型数组字段（`{"userIds":[1,2]}` / `{"menuIds":[3]}`）。
///
/// 取不到、不是数组、或过滤后为空 → 抛 400。
///
/// [aliases] 用来兼容下划线写法（`user_ids` / `menu_ids`），
/// 与 `POST /api/auth/refreshToken` 容忍 `refresh_token` 是同一条思路。
///
/// 为什么在表现层挡而不是交给 Service：这些 Service 对空数组的处理是
/// 「返回一个 successCount: 0 的成功响应」（如 `UserService.resetPassword`），
/// 对调用方来说「我压根没传 ids」应该是 400，不是「操作成功但一个都没处理」。
List<int> requiredIntList(
  Map<String, dynamic> body,
  String key, {
  List<String> aliases = const [],
}) {
  final raw = [key, ...aliases]
      .map((name) => body[name])
      .firstWhere((value) => value != null, orElse: () => null);

  final ids = normalizedIntList(raw);
  if (ids.isEmpty) {
    throw RestException.badRequest('参数不合法：$key 必须是非空的正整数数组');
  }
  return ids;
}

// ── PATCH 语义 ────────────────────────────────────────────────────────────
//
// 「body 里出现过这个 key」才算改；没出现就沿用基线值。
// 注意必须用 `containsKey` —— 显式传 null 是「清空」，与「没传」不同。

/// PATCH：字符串字段。body 出现过 → 覆盖（可覆盖成 null），否则用 [fallback]。
String? patchText(Map<String, dynamic> body, String key, String? fallback) =>
    body.containsKey(key) ? trimmedString(body[key]) : fallback;

/// PATCH：整型字段。
int? patchInt(Map<String, dynamic> body, String key, int? fallback) =>
    body.containsKey(key) ? asIntOrNull(body[key]) : fallback;

/// PATCH：布尔字段。
bool? patchBool(Map<String, dynamic> body, String key, bool? fallback) =>
    body.containsKey(key) ? asBoolOrNull(body[key]) : fallback;

/// PATCH：整型数组字段。
List<int>? patchIntList(
  Map<String, dynamic> body,
  String key,
  List<int>? fallback,
) => body.containsKey(key) ? asIntListOrNull(body[key]) : fallback;

// 失败判定
/// Service 失败 → 抛业务失败（业务码原样透传，`code` 缺省时框架给 50000）。
///
/// ⚠️ 这里的 `400` 只是 [RestException] 携带的**兜底分类**，本项目
/// 由 `ServerpodEnvelopeBuilder.httpStatusFor` 压成 **HTTP 200**；
/// 真正到客户端的区分信息在 body 的 `code`（见 `docs/rest-api-layer.md` §3.1）。
CommonResponse ensureOk(CommonResponse res) {
  if (res.isFailed) {
    throw RestException(400, res.message ?? '操作失败', code: res.code);
  }
  return res;
}

/// 单条读写的基线：「读不到」在业务上只有一种含义 ——
/// 记录不存在 / 已软删 / 不属于本租户，所以统一翻成 `notFound`
/// （body 业务码 `40400`），而不是 Service 那个笼统的 50000。
T requireFound<T>(CommonResponse res, String what) {
  final data = res.isFailed ? null : res.data;
  if (data is! T) {
    throw RestException.notFound(res.message ?? '$what不存在或已删除');
  }
  return data;
}

/// 从返回载荷里取某个计数键；取不到就按 0。
///
/// 只认 Map 载荷（airtable 那种手搓汇总，如 `{'deletedCount': n}`）；
/// `CrudBatchResult` 走 [batchOf]。
int countOf(CommonResponse res, String key) {
  final data = res.data;
  if (data is Map) {
    final value = data[key];
    if (value is int) return value;
  }
  return 0;
}

/// 把批量删的 Service 返回值归一成 [CrudBatchResult]。
///
/// `POST /deleteBatch` 的响应体由前端 `BatchOperationResult<Id>`
/// （`total` / `successCount` / `notFoundCount` / `successIds` / `failedIds`）
/// 决定，所以 delegate 这一层必须把明细原样交出去，不能再退化成一个整数。
///
/// 两种历史形状都认：
/// * Service 直接返 `CrudBatchResult` —— **推荐**，明细齐全；
/// * Service 返 `{total, successCount, notFoundCount}` 的 Map —— 旧形状，
///   只能给出计数、`successIds` / `failedIds` 是空数组。留着是为了兼容
///   尚未改造的 Service，不报错但前端拿不到逐条明细。
CrudBatchResult batchOf(CommonResponse res) {
  final data = ensureOk(res).data;
  if (data is CrudBatchResult) return data;
  if (data is Map) {
    int read(String key) => data[key] is int ? data[key] as int : 0;
    return CrudBatchResult(
      total: read('total'),
      successCount: read('successCount'),
      notFoundCount: read('notFoundCount'),
    );
  }
  return const CrudBatchResult(total: 0, successCount: 0, notFoundCount: 0);
}
