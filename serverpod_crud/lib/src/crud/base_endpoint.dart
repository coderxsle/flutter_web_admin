import 'package:serverpod/serverpod.dart';

import '../core/crud_models.dart';
import '../audit/audit_service.dart';
import '../models/query/query_dto.dart';
import '../models/query/query_condition.dart';
import '../models/query/query_request.dart';
import '../models/query/query_sort.dart';
import '../runtime/crud_runtime.dart';
import 'auto_crud_service.dart';
import 'base_service.dart';
import 'crud_entity_meta.dart';

/// 通用 CRUD Endpoint 基类。
///
/// Endpoint 只需提供一个已装配的 [BaseService]，即可获得标准的增删改查
/// 方法；特殊业务查询仍可直接添加到具体 Endpoint 中。返回值使用 CRUD 包
/// 自己的模型，避免基础包依赖业务项目的响应包装类型。
abstract class BaseCrudEndpoint<T extends TableRow, TTable extends Table>
    extends Endpoint {
  BaseCrudEndpoint(this.service);

  /// CRUD 接口默认要求登录，公开接口可在具体 Endpoint 中显式覆写。
  @override
  bool get requireLogin => true;

  final BaseService<T, TTable> service;

  /// 创建记录。
  Future<T> add(Session session, T data) => service.create(session, data);

  /// 查询详情；记录不存在时返回 null。
  Future<T?> getDetail(Session session, int id) => service.get(session, id);

  /// 分页查询。
  Future<CrudPage<dynamic>> getList(
    Session session,
    QueryRequest request,
  ) async {
    final page = await service.getList(session, _toQueryDto(request));
    // 使用 dynamic 作为协议返回泛型，避免 Serverpod 代码生成器在客户端
    // 生成指向服务端泛型 Endpoint 文件的导入。
    return CrudPage<dynamic>(
      data: page.data,
      page: page.page,
      pageSize: page.pageSize,
      total: page.total,
      totalPage: page.totalPage,
    );
  }

  /// 更新记录。
  Future<T> update(Session session, T data) => service.update(session, data);

  /// 删除单条记录；记录不存在时返回 null。
  Future<T?> delete(Session session, int id) => service.delete(session, id);

  /// 批量删除记录。
  Future<CrudBatchResult> deleteBatch(Session session, List<int> ids) {
    return service.deleteBatch(session, ids);
  }

  QueryDTO _toQueryDto(QueryRequest request) {
    return QueryDTO(
      page: request.page,
      pageSize: request.pageSize,
      keyword: request.keyword,
      filters: request.filters
          ?.map(
            (filter) => QueryCondition(
              field: filter.field,
              comparator: filter.comparator,
              value: filter.parsedValue,
            ),
          )
          .toList(),
      sort: request.sort
          ?.map((sort) => QuerySort(field: sort.field, order: sort.order))
          .toList(),
    );
  }
}

/// 基于 [CrudEntityMeta] 自动装配 Service 的 Endpoint 基类。
///
/// 具体模块只需实现 [createService] 提供实体对应的 Service。业务项目通常
/// 可以用一个很薄的 service 子类注入校验、审计或权限策略。
abstract class AutoCrudEndpoint<T extends TableRow, TTable extends Table>
    extends BaseCrudEndpoint<T, TTable> {
  AutoCrudEndpoint(
    CrudEntityMeta<T, TTable> meta, {
    CrudRuntime? runtime,
    AuditService<T>? auditService,
  }) : super(
         _createService(meta, runtime: runtime, auditService: auditService),
       );

  static AutoCrudService<T, TTable>
  _createService<T extends TableRow, TTable extends Table>(
    CrudEntityMeta<T, TTable> meta, {
    CrudRuntime? runtime,
    AuditService<T>? auditService,
  }) {
    return _DefaultAutoCrudService<T, TTable>(
      meta,
      runtime: runtime,
      auditService: auditService,
    );
  }
}

/// 业务模块默认使用的 Endpoint 入口。
///
/// 继承此类即可获得完整 CRUD 接口：
///
/// ```dart
/// class BookEndpoint extends BaseEndpoint<Book, BookTable> {
///   BookEndpoint();
/// }
/// ```
///
/// 默认按约定识别 `tenantId`、`isDeleted`/`deleted`，并将所有字符串列用于关键词查询。
/// 只有非标准字段约定才需要通过构造参数覆盖。
///
/// 需要注入自定义 Service 时，可直接继承 [BaseCrudEndpoint]。
abstract class BaseEndpoint<T extends TableRow, TTable extends Table>
    extends AutoCrudEndpoint<T, TTable> {
  BaseEndpoint({
    CrudEntityMeta<T, TTable>? meta,
    CrudRuntime? runtime,
    AuditService<T>? auditService,
    String tenantIdField = 'tenantId',
    String? deletedField,
    List<String>? keywordFields,
    Map<String, String> fieldAliases = const {},
    void Function(T model, int tenantId)? setTenantId,
    void Function(T model, bool deleted)? setDeleted,
    int? Function(T model)? getId,
  }) : super(
         meta ??
             CrudEntityMeta<T, TTable>.auto(
               tenantIdField: tenantIdField,
               deletedField: deletedField,
               keywordFields: keywordFields,
               fieldAliases: fieldAliases,
               setTenantId: setTenantId,
               setDeleted: setDeleted,
               getId: getId,
             ),
         runtime: runtime,
         auditService: auditService,
       );
}

class _DefaultAutoCrudService<T extends TableRow, TTable extends Table>
    extends AutoCrudService<T, TTable> {
  _DefaultAutoCrudService(super.meta, {super.runtime, super.auditService});
}
