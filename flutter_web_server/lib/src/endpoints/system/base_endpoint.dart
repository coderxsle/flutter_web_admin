import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import '../../mappers/query_request_mapper.dart';

/// 通用 CRUD Endpoint 基类（默认实现）
///
/// 子类只需提供 [service] 与 [decodeModel]，即可自动拥有常见 CRUD + query 方法。
abstract class BaseEndpoint<T extends TableRow, TTable extends Table, S extends BaseService<T, TTable>> extends Endpoint {
  @override
  bool get requireLogin => true;

  /// 将请求参数解码为实体模型。
  T decodeModel(dynamic data);

  /// 提供具体的业务 Service 实现（需由子类重载）。
  /// 
  /// 每个具体子 Endpoint 应返回其对应的 BaseService 实例，
  /// 用于执行 CRUD 操作的具体逻辑。
  S get service;

  /// 查询请求参数转换器的静态实例
  static const QueryRequestMapper _queryMapper = QueryRequestMapper();

  /// 将 [QueryRequest] 类型的数据转换为核心查询DTO [QueryDTO]
  QueryDTO _toQueryDTO(QueryRequest query) => _queryMapper.toCore(query);


  /// 创建数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式）
  /// 
  /// 返回：包含新建结果的[CommonResponse]，data字段为新建实体
  Future<CommonResponse> add(Session session, dynamic data) async {
    return CommonResponse.success(await service.create(session, decodeModel(data)));
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
  /// 返回：包含查询结果列表及分页的[PageResponse<T>]。
  /// 
  /// 请注意：BaseEndpoint 是一个带泛型 T 的抽象类，继承自 Endpoint。
  /// Serverpod 的代码生成器扫描到 getList 的返回值 Future<PageResponse<T>> 时，会把 T 作为一个需要在客户端引用的类型，
  /// 从而生成了指向服务端 base_endpoint.dart 的 import——但客户端包里根本没有这个文件。
  /// 根本原因：getList 的返回类型 Future<PageResponse<T>> 中的 T 是泛型参数，生成器无法在客户端正确表达它，只能错误地引用服务端文件。
  /// 因此这里的返回类型必须使用 Future<PageResponse<dynamic>> 不能使用 Future<PageResponse<T>>
  Future<PageResponse<dynamic>> getList(Session session, QueryRequest query) async {
    // 将前端的 QueryRequest 结构转换为服务层可识别的核心查询对象
    final p = await service.getList(session, _toQueryDTO(query));
    return PageResponse.restPage(data: p.data, page: p.page, pageSize: p.pageSize, total: p.total );
  }


  /// 更新数据实体的接口
  ///
  /// - [session]：当前的Serverpod会话
  /// - [data]：前端传入的实体数据（通常为JSON或Map形式，须带主键ID）
  ///
  /// 返回：包含更新结果的[CommonResponse]，data字段为已更新实体
  Future<CommonResponse> update(Session session, dynamic data) async {
    return CommonResponse.success(await service.update(session, decodeModel(data)));
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

/// 基于 [AutoCrudService.meta] 自动获取模型解码器的 Endpoint 基类，简化了 CRUD 相关接口的模型解码工作。
/// 
/// 泛型说明：
/// - [T]：代表后端数据表对应的实体类型，通常需继承自 [TableRow]，如 User、Article 等。用于约束实体的数据结构。
/// - [TTable]：代表此实体 (T) 使用的数据库表定义（继承自 [Table]），如 UserTable、ArticleTable，用于支持复杂查询、表结构元数据等。
/// - [S]：处理此实体的自动CRUD服务类型（需继承 [AutoCrudService<T, TTable>]），负责提供模型的增删改查和 decode 逻辑。
///
/// 实现思路：
/// 通过覆写 [decodeModel] 方法，把外部（如 JSON 或 Map）传入的数据，直接交给服务的 [decodeModel] 统一解码，
/// 使得各业务子类无需重复实现对象重建（反序列化）的细节，确保一致性并减少样板代码。

abstract class AutoCrudEndpoint<T extends TableRow, TTable extends Table, S extends AutoCrudService<T, TTable>> extends BaseEndpoint<T, TTable, S> {
  @override
  T decodeModel(dynamic data) => service.decodeModel(data);
}
