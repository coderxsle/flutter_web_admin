import 'package:serverpod/serverpod.dart';

import '../core/crud_models.dart';
import 'rest_api_exception.dart';
import 'rest_page.dart';

/// 一个资源被 REST 化所需要的动作。
///
/// 入参刻意用「HTTP 形状」而不是「模型形状」：
/// * [list] 拿到原始 [Request]，可以自己解释 query 参数（本项目用户列表有
///   9 个专用过滤字段，通用分页参数盖不住）；返回值也**不强制分页** ——
///   返回 [RestPage] 走分页信封，返回别的（比如部门树）走普通成功信封。
/// * [create] / [update] 拿到已解析的 JSON **body**，由 delegate 决定怎么
///   变成模型 —— 本项目每个资源都有专用 Request 模型（`UserRequest` /
///   `DeptRequest` / `MenuRequest`），这一层必须留出自由度。
///
/// 失败一律抛 [RestApiException]，成功直接返回载荷。
///
/// ⚠️ 实现时请用 `extends` 而不是 `implements` —— [removeBatch] 有默认实现，
/// 用 `implements` 的话要把每个方法（包括它）都重写一遍。
abstract class RestCrudDelegate<T> {
  /// `GET /getList` 列表。返回 [RestPage] 走分页信封，其它载荷走普通信封。
  ///
  /// 过滤条件一律从 **query** 读（`request.queryInt('page')` 等）；
  /// 分页参数名认 `pageSize`，同时兼容团队前端惯用的 `size`。
  Future<Object?> list(Session session, Request request);

  /// `GET /getDetail?id=123` 详情。找不到抛 [RestApiException.notFound]。
  ///
  /// ⚠️ `id` 走 **query 参数**，不是路径参数 —— 所以 `list` / `detail` 的路径
  /// 都是纯字面量段，互不干扰。
  ///
  /// ⚠️ 返回类型是 `Object?` 而不是 `T`：真实资源的详情常常带**组合字段**
  /// （本项目 `UserService.getDetail` 会额外拼上 `roleIds` / `roles`），
  /// 用 `T` 就装不下了。`AutoRestCrudDelegate` 仍然返回 `T` ——
  /// 那是 `Object?` 的合法协变覆写。
  Future<Object?> detail(Session session, int id);

  /// `POST /add` 新增。返回类型见 [detail] 的说明。
  Future<Object?> create(Session session, Map<String, dynamic> body);

  /// `POST /update` 更新，`id` 从 body 里取。
  ///
  /// 约定为 **PATCH 语义**（只改 body 里出现过的字段）—— 因为整行覆盖会在
  /// 客户端没拿到 `serverOnly` 字段时把它们写成 NULL（最典型的是把密码清空）。
  Future<Object?> update(Session session, int id, Map<String, dynamic> body);

  /// `POST /delete` 删除**单条**。找不到抛 [RestApiException.notFound]。
  Future<void> remove(Session session, int id);

  /// `POST /deleteBatch` 批量删除。返回逐 id 的成功 / 失败明细。
  ///
  /// 返回 [CrudBatchResult]（`total` / `successCount` / `notFoundCount` /
  /// `successIds` / `failedIds`）而不是一个整数 —— 前端要拿 `failedIds`
  /// 逐条提示，只有一个成功条数是不够用的。
  ///
  /// 默认实现逐个调用 [remove]，并把失败**继续**下去（旧实现是首个失败就
  /// 中断，等于一个坏 id 让整批都删不掉）。子类应覆写成一次 `deleteBatch`
  /// —— 那样才有真实的事务级别与审计，且 `successIds` / `failedIds` 由
  /// 数据库返回值反推，比「抛没抛异常」可靠。
  Future<CrudBatchResult> removeBatch(Session session, List<int> ids) async {
    final normalized = ids.where((id) => id > 0).toSet().toList();
    final successIds = <int>[];
    final failedIds = <int>[];

    for (final id in normalized) {
      try {
        await remove(session, id);
        successIds.add(id);
      } on RestApiException catch (e) {
        // 5xx 是「服务端真出错了」，不该被当成「这条删不掉」咽下去。
        if (e.httpStatus >= 500) rethrow;
        failedIds.add(id);
      }
    }

    return CrudBatchResult(
      total: normalized.length,
      successCount: successIds.length,
      notFoundCount: failedIds.length,
      successIds: successIds,
      failedIds: failedIds,
    );
  }
}
