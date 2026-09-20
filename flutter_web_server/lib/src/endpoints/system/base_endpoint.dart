import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import '../../mappers/query_request_mapper.dart';
import '../../crud/crud_runtime_factory.dart';

/// 通用 CRUD Endpoint 基类（默认实现）。
///
/// 子类只需继承此基类即可获得常见 CRUD + query 方法；特殊业务查询
/// 直接写在具体 Endpoint 中。
/// 如果某个实体使用非标准字段，可以只覆盖差异：
/// class ResourceEndpoint extends BaseEndpoint<Resource, ResourceTable> {
//   ResourceEndpoint()
//       : super(
//           tenantIdField: 'organizationId',
//           deletedField: 'archived',
//           keywordFields: const ['name', 'code'],
//           fieldAliases: const {
//             'createdAt': 'createTime',
//           },
//         );
// }
abstract class BaseEndpoint<T extends TableRow, TTable extends Table>
    extends Endpoint {
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
  }) : service = _DefaultAutoCrudService<T, TTable>(
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
         runtime: runtime ?? CrudRuntimeFactory.create(),
         auditService: auditService,
       );

  BaseEndpoint.withService(this.service);

  @override
  bool get requireLogin => true;

  /// 当前实体使用的 CRUD Service。
  ///
  /// 普通实体由基类根据 [CrudEntityMeta] 自动创建；包含业务规则的实体
  /// 可以通过 [BaseEndpoint.withService] 注入自定义 [AutoCrudService]。
  final AutoCrudService<T, TTable> service;

  /// 查询请求参数转换器的静态实例
  static const QueryRequestMapper _queryMapper = QueryRequestMapper();

  /// 将请求参数解码为实体模型。
  T decodeModel(dynamic data) => service.decodeModel(data);

  /// 将 [QueryRequest] 类型的数据转换为核心查询DTO [QueryDTO]
  QueryDTO _toQueryDTO(QueryRequest query) => _queryMapper.toCore(query);

  /// 创建数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式）
  ///
  /// 返回：包含新建结果的[CommonResponse]，data字段为新建实体
  Future<CommonResponse> add(Session session, dynamic data) async {
    return CommonResponse.success(
      await service.create(session, decodeModel(data)),
    );
  }

  /// 获取指定ID的详情数据
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要获取详情的数据主键ID
  ///
  /// 返回：包含查询结果的[CommonResponse]
  Future<CommonResponse> getDetail(Session session, int id) async {
    return CommonResponse.success(await service.get(session, id));
  }

  /// 获取分页列表数据的接口（支持复杂查询）
  ///
  /// 执行支持高级查询的分页请求。前端传入的[QueryRequest]会经过
  /// [_queryMapper.toCore]转换为后端核心的查询请求对象（如服务层可能需要更丰富的结构，如过滤、排序、关键字等）。
  /// 然后调用service.query执行业务查询，返回[CrudPage<T>]结构，该结构含有数据及分页信息。
  /// 最后将结果数据和分页信息组装为标准接口响应[PageResponse]返回。
  ///
  /// - [session]：当前的Serverpod会话，包含登录上下文信息。
  /// - [query]：前端传入的查询结构体，含分页参数和其他自定义条件。
  ///
  /// 返回：包含查询结果列表及分页的 `PageResponse<T>`。
  ///
  /// 请注意：BaseEndpoint 是一个带泛型 T 的抽象类，继承自 Endpoint。
  /// Serverpod 的代码生成器扫描到 getList 的返回值 `Future<PageResponse<T>>` 时，会把 T 作为一个需要在客户端引用的类型，
  /// 从而生成了指向服务端 base_endpoint.dart 的 import——但客户端包里根本没有这个文件。
  /// 根本原因：getList 的返回类型 `Future<PageResponse<T>>` 中的 T 是泛型参数，生成器无法在客户端正确表达它，只能错误地引用服务端文件。
  /// 因此这里的返回类型必须使用 `Future<PageResponse<dynamic>>` 不能使用 `Future<PageResponse<T>>`
  Future<PageResponse<dynamic>> getList(
    Session session,
    QueryRequest query,
  ) async {
    // 将前端的 QueryRequest 结构转换为服务层可识别的核心查询对象
    final p = await service.getList(session, _toQueryDTO(query));
    return PageResponse.restPage(
      data: p.data,
      page: p.page,
      pageSize: p.pageSize,
      total: p.total,
    );
  }

  /// 更新数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式，须带主键ID）
  ///
  /// 返回：包含更新结果的[CommonResponse]，data字段为已更新实体
  Future<CommonResponse> update(Session session, dynamic data) async {
    return CommonResponse.success(
      await service.update(session, decodeModel(data)),
    );
  }

  /// 删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [id]：要删除的数据主键ID
  ///
  /// 返回：操作结果的[CommonResponse]，若成功返回null数据
  Future<CommonResponse> delete(Session session, int id) async {
    return CommonResponse.success(await service.delete(session, id));
  }

  /// 批量删除指定ID的数据实体
  ///
  /// - [session]：当前Serverpod会话
  /// - [ids]：要批量删除的主键ID列表
  ///
  /// 返回：包含批量删除结果信息的[CommonResponse]，例如总数、成功数、未找到数等。
  Future<CommonResponse> deleteBatch(Session session, List<int> ids) async {
    final result = await service.deleteBatch(session, ids);
    return CommonResponse.success(result.toJson());
  }
}

class _DefaultAutoCrudService<T extends TableRow, TTable extends Table>
    extends AutoCrudService<T, TTable> {
  _DefaultAutoCrudService(super.meta, {super.runtime, super.auditService});
}
