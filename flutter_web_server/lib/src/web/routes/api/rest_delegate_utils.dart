/// REST delegate 层的公共工具。
///
/// 这里只放**与具体资源无关**的翻译逻辑：
/// * 「HTTP 来的 JSON」→「Service 要的 Dart 值」的取值/校验；
/// * 「Service 的 `CommonResponse`」→「业务码」的失败判定。
///
/// ## 两条硬约定
///
/// 1. **PATCH 语义靠 `patchXxx` 系列**。本项目的 Service 更新方法普遍是
///    「全量覆盖」（`existing.name = req.name` 这种，缺字段就写 null/默认值），
///    所以 delegate 必须先用基线补齐、再整体交出去。判断「字段有没有出现」
///    只能靠 `Map.containsKey` —— 不能用 `?? fallback`，否则客户端**显式传
///    null**（想把 `description` 清空）会被静默忽略。
/// 2. **失败粒度**。Service 只有「成功 / 失败」一个粒度，业务码需要区分
///    「不存在」与「规则拒绝」。单条资源的「读不到 = 不存在 = 已软删 = 不属于本租户」
///    统一翻译成 `notFound`（业务码 40400），其它失败走 `ensureOk`
///    （业务码原样透传 Service 的 50000）。
///
///    ⚠️ 这里抛的 `RestApiException` **不会**让 HTTP 变成 4xx ——
///    `ServerpodEnvelopeBuilder.httpStatusFor` 会把业务失败压成 **200**，
///    只放行 401（理由见 `docs/rest-api-layer.md` §3.1 / §6.9）。
///    所以别把「抛异常」理解成「改状态码」，它改的是 body 里的 `code`。
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
/// 与 `POST /api/auth/refresh-token` 容忍 `refresh_token` 是同一条思路。
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
    throw RestApiException.badRequest('参数不合法：$key 必须是非空的正整数数组');
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
/// ⚠️ 这里的 `400` 只是 [RestApiException] 携带的**兜底分类**，本项目
/// 由 `ServerpodEnvelopeBuilder.httpStatusFor` 压成 **HTTP 200**；
/// 真正到客户端的区分信息在 body 的 `code`（见 `docs/rest-api-layer.md` §3.1）。
CommonResponse ensureOk(CommonResponse res) {
  if (res.isFailed) {
    throw RestApiException(400, res.message ?? '操作失败', code: res.code);
  }
  return res;
}

/// 单条读写的基线：「读不到」在业务上只有一种含义 ——
/// 记录不存在 / 已软删 / 不属于本租户，所以统一翻成 `notFound`
/// （body 业务码 `40400`），而不是 Service 那个笼统的 50000。
T requireFound<T>(CommonResponse res, String what) {
  final data = res.isFailed ? null : res.data;
  if (data is! T) {
    throw RestApiException.notFound(res.message ?? '$what不存在或已删除');
  }
  return data;
}

/// 从返回载荷里取某个计数键；取不到就按 0。
///
/// 三种载荷形状都要认：
/// * `CrudBatchResult` —— 改造后的标准形状（`BaseService.deleteBatch` 的产物）；
/// * `{total, successCount, notFoundCount}` 的 Map —— 旧 Service 的形状，
///   以及 airtable 那种手搓汇总；
/// * 其它 —— 按 0。
///
/// ⚠️ 少了第一支会让 [ensureDeleted] 恒判 404：`CrudBatchResult` 不是 `Map`，
/// 只认 Map 的话 `successCount` 永远读成 0，「一条都没命中」与「删成功了」
/// 就分不出来了。
int countOf(CommonResponse res, String key) {
  final data = res.data;
  if (data is CrudBatchResult) {
    return switch (key) {
      'total' => data.total,
      'successCount' => data.successCount,
      'notFoundCount' => data.notFoundCount,
      _ => 0,
    };
  }
  if (data is Map) {
    final value = data[key];
    if (value is int) return value;
  }
  return 0;
}

/// 从批量删返回的汇总里取 `successCount`；拿不到就按 0。
int successCountOf(CommonResponse res) => countOf(res, 'successCount');

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

/// 单条删除的「不存在」判定。
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
