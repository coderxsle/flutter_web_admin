/// REST delegate 层的公共工具。
///
/// 这里只放**与具体资源无关**的翻译逻辑：
/// * 「HTTP 来的 JSON」→「Service 要的 Dart 值」的取值/校验；
/// * 「Service 的 `CommonResponse`」→「HTTP 语义」的失败判定。
///
/// ## 两条硬约定
///
/// 1. **PATCH 语义靠 `patchXxx` 系列**。本项目的 Service 更新方法普遍是
///    「全量覆盖」（`existing.name = req.name` 这种，缺字段就写 null/默认值），
///    所以 delegate 必须先用基线补齐、再整体交出去。判断「字段有没有出现」
///    只能靠 `Map.containsKey` —— 不能用 `?? fallback`，否则客户端**显式传
///    null**（想把 `description` 清空）会被静默忽略。
/// 2. **失败粒度**。Service 只有「成功 / 失败」一个粒度，HTTP 需要 400 / 404。
///    单条资源的「读不到 = 不存在 = 404」，其它失败一律 400（业务规则拒绝）。
library;

import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 读字符串：`null` / 纯空白 → `null`；其余去掉首尾空白。
///
/// 为什么空白也算 null：前端 Arco 表单提交空输入框会给 `""`，语义上就是「没填」。
String? trimmedString(Object? value) {
  if (value == null) return null;
  final text = value.toString().trim();
  return text.isEmpty ? null : text;
}

/// 读**必填**字符串；缺失或空白抛 400。
///
/// 在表现层挡而不是交给 Service：生成模型的非空字段（`DeptRequest.name`、
/// `MenuRequest.title` 等）在缺失时构造函数会直接抛，那会变成 500 ——
/// 对调用方来说「你没传 name」应该是 400。
String requiredText(Map<String, dynamic> body, String key) {
  final value = trimmedString(body[key]);
  if (value == null) {
    throw RestApiException.badRequest('$key 不能为空');
  }
  return value;
}

/// 读**必填**整型；缺失或非数字抛 400。
int requiredInt(Map<String, dynamic> body, String key) {
  final value = asIntOrNull(body[key]);
  if (value == null) {
    throw RestApiException.badRequest('$key 必须是整数');
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
  final List<dynamic> list =>
    list.map(asIntOrNull).whereType<int>().toList(),
  _ => null,
};

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

// ── 失败判定 ──────────────────────────────────────────────────────────────

/// Service 失败 → 抛 400（业务规则拒绝 / 参数不合法），业务码原样透传。
CommonResponse ensureOk(CommonResponse res) {
  if (res.isFailed) {
    throw RestApiException(400, res.message ?? '操作失败', code: res.code);
  }
  return res;
}

/// 单条读写的基线：失败或载荷为空 → 404。
///
/// 「读不到」在这一层只有一种含义 —— 记录不存在 / 已软删 / 不属于本租户，
/// 所以统一翻译成 404，而不是 Service 那个笼统的 50000。
T requireFound<T>(CommonResponse res, String what) {
  final data = res.isFailed ? null : res.data;
  if (data is! T) {
    throw RestApiException.notFound(res.message ?? '$what不存在或已删除');
  }
  return data;
}

/// 从批量删返回的汇总里取 `successCount`；拿不到就按 0。
int successCountOf(CommonResponse res) {
  final data = res.data;
  if (data is Map) {
    final value = data['successCount'];
    if (value is int) return value;
  }
  return 0;
}

/// 单条删除的 404 判定。
///
/// ⚠️ 本项目的删 Service 都是**批量删**（`delete(ids)`），而批量删在
/// 「一条都没命中」时**仍然返回成功**（data 里 `successCount: 0`），
/// 不会 `isFailed` —— 所以 `ensureOk` 判不出来，必须看计数。
void ensureDeleted(CommonResponse res, String what) {
  ensureOk(res);
  if (successCountOf(res) == 0) {
    throw RestApiException.notFound('$what不存在或已删除');
  }
}
