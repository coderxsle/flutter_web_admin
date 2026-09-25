import 'package:serverpod/serverpod.dart';

import '../core/crud_models.dart';
import '../crud/auto_crud_service.dart';
import '../crud/base_service.dart';
import '../crud/crud_entity_meta.dart';
import '../models/query/query_dto.dart';
import '../runtime/crud_runtime.dart';
import 'rest_api_exception.dart';
import 'rest_crud_delegate.dart';
import 'rest_page.dart';
import 'rest_request_extension.dart';

/// [RestCrudDelegate] 的标准实现 —— **唯一做真实数据映射的地方**。
///
/// 表由类型参数 `TTable` 显式指定。只想要一个类型参数时用
/// [AutoCrudDelegate]（表类型运行期反查）。
class AutoRestCrudDelegate<T extends TableRow, TTable extends Table>
    implements RestCrudDelegate<T> {
  AutoRestCrudDelegate({
    CrudEntityMeta<T, TTable>? meta,
    BaseService<T, TTable>? service,
    CrudRuntime? runtime,
    String tenantIdField = 'tenantId',
    String? deletedField,
    List<String>? keywordFields,
    Map<String, String> fieldAliases = const {},
    this.defaultPageSize = 20,
    this.maxPageSize = 100,
  }) : service =
           service ??
           _RestAutoCrudService<T, TTable>(
             meta ??
                 CrudEntityMeta<T, TTable>.auto(
                   tenantIdField: tenantIdField,
                   deletedField: deletedField,
                   keywordFields: keywordFields,
                   fieldAliases: fieldAliases,
                   runtime: runtime,
                 ),
             runtime: runtime,
           );

  final BaseService<T, TTable> service;
  final int defaultPageSize;

  /// 服务端收敛的分页上限（防止 `?pageSize=999999` 拖垮数据库）。
  final int maxPageSize;

  /// 把 `Map<String, dynamic>` 还原成模型。
  ///
  /// 用 `deserialize<T>` 而不是 `deserializeDynamicFieldValue`：
  /// 后者要求「每个字段值再包一层 `{className, data}`」的线格式，
  /// 而 `deserialize<T>(body, T)` 会直接命中生成的 `T.fromJson`，
  /// **接受浏览器发来的普通 JSON** —— 这一点已在本项目实测过。
  T decode(Map<String, dynamic> body) => Serverpod.instance.serializationManager.deserialize<T>(body, T);

  @override
  Future<Object?> list(Session session, Request request) async {
    final page = await service.getList(
      session,
      QueryDTO(
        page: request.queryInt('page') ?? 1,
        // `size` 是团队前端的写法（`{ page, size }`），`pageSize` 是本框架
        // 原生写法。两个都认，省掉一次「到底哪个才对」的对齐会议。
        pageSize:
            (request.queryInt('pageSize') ??
                    request.queryInt('size') ??
                    defaultPageSize)
                .clamp(1, maxPageSize),
        keyword: request.queryString('keyword'),
      ),
    );
    return RestPage.fromCrudPage(page);
  }

  @override
  Future<T> detail(Session session, int id) async {
    final row = await service.get(session, id);
    if (row == null) {
      throw RestApiException.notFound('记录不存在或已删除');
    }
    return row;
  }

  @override
  Future<T> create(Session session, Map<String, dynamic> body) =>
      service.create(session, decode(body));

  @override
  Future<T> update(Session session, int id, Map<String, dynamic> body) async {
    // 先读当前行做基线，再让 body 覆盖它 —— PATCH 语义。
    // 基线必须用 `toJson()`（含 serverOnly 字段），否则更新会把密码
    // 这类前端拿不到的字段写成 NULL。
    final current = await service.get(session, id);
    if (current == null) {
      throw RestApiException.notFound('记录不存在或已删除');
    }
    final merged = <String, dynamic>{...current.toJson(), ...body, 'id': id};
    return service.update(session, decode(merged));
  }

  @override
  Future<void> remove(Session session, int id) async {
    final deleted = await service.delete(session, id);
    if (deleted == null) {
      throw RestApiException.notFound('记录不存在或已删除');
    }
  }

  @override
  Future<CrudBatchResult> removeBatch(Session session, List<int> ids) =>
      service.deleteBatch(session, ids);
}

/// **单类型参数**版本：表类型在运行期由 `getTableForType(T)` 反查。
///
/// 这个类存在的唯一理由，就是让 `BaseRestRoute<SysUser>` 只写一个类型参数。
class AutoCrudDelegate<T extends TableRow>
    extends AutoRestCrudDelegate<T, Table> {
  AutoCrudDelegate({
    super.meta,
    super.service,
    super.runtime,
    super.tenantIdField,
    super.deletedField,
    super.keywordFields,
    super.fieldAliases,
    super.defaultPageSize,
    super.maxPageSize,
  });
}

/// 供 [AutoRestCrudDelegate] 默认使用的具体 Service。
class _RestAutoCrudService<T extends TableRow, TTable extends Table>
    extends AutoCrudService<T, TTable> {
  _RestAutoCrudService(super.meta, {super.runtime, super.auditService});
}
