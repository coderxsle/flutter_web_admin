import 'package:serverpod/serverpod.dart';

import '../core/models.dart';
import 'rest_exception.dart';
import 'rest_page.dart';

/// 一个资源被 REST 化所需要的动作。
///
///  返回 [RestPage] 走分页信封，返回别的（比如部门树）走普通成功信封。
///  实现时请用 `extends` 而不是 `implements` —— [removeBatch] 有默认实现， 用 `implements` 的话要把每个方法（包括它）都重写一遍。
///
abstract class RestCrudDelegate<T> {
  /// `GET /getList` 列表。
  /// 过滤条件一律从 **query** 读（`request.queryInt('page')` 等）；
  /// 返回 [RestPage] 走分页信封，其它载荷走普通信封。
  Future<Object?> list(Session session, Request request);

  /// `GET /getDetail?id=123` 详情。找不到抛 [RestException.notFound]。
  ///
  /// ⚠️ `id` 走 **query 参数**，不是路径参数 —— 所以 `list` / `detail` 的路径都是纯字面量段，互不干扰。
  Future<Object?> detail(Session session, int id);

  /// 新增
  /// `POST /add` 
  Future<Object?> create(Session session, Map<String, dynamic> body);

  /// 更新
  /// `POST /update`
  Future<Object?> update(Session session, int id, Map<String, dynamic> body);

  /// 删除单条
  /// `POST /delete`
  Future<void> remove(Session session, int id);

  /// 批量删除。
  /// `POST /deleteBatch` 
  /// 返回逐 id 的成功 / 失败明细。
  Future<CrudBatchResult> removeBatch(Session session, List<int> ids) async {
    final normalized = ids.where((id) => id > 0).toSet().toList();
    final successIds = <int>[];
    final failedIds = <int>[];

    for (final id in normalized) {
      try {
        await remove(session, id);
        successIds.add(id);
      } on RestException catch (e) {
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
