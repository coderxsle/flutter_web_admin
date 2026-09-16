// import 'package:serverpod/serverpod.dart';
// import 'package:flutter_web_shared/flutter_web_shared.dart';
// import 'package:serverpod_crud/serverpod_crud.dart';
// import '../../mappers/query_request_mapper.dart';

// /// 通用 CRUD Endpoint 基类（默认实现）
// ///
// /// 子类只需提供 [service] 与 [decodeModel]，即可自动拥有常见 CRUD + query 方法。
// abstract class BaseEndpoint<T extends TableRow, TTable extends Table, S extends BaseService<T, TTable>> extends Endpoint {
//   @override
//   bool get requireLogin => true;

//   /// 将请求参数解码为实体模型。
//   T decodeModel(dynamic data);

//   S get service;

//   /// 查询请求参数转换器的静态实例
//   static const QueryRequestMapper _queryMapper = QueryRequestMapper();

//   /// 将 [QueryRequest] 类型的数据转换为核心查询DTO [QueryDTO]
//   QueryDTO _toQueryDTO(QueryRequest query) => _queryMapper.toCore(query);


//   /// 创建数据实体的接口
//   Future<CommonResponse> add(Session session, dynamic data) async {
//     return CommonResponse.success(await service.create(session, decodeModel(data)));
//   }


//   /// 获取指定ID的详情数据
//   Future<CommonResponse> getDetail(Session session, int id) async {
//     return CommonResponse.success(await service.get(session, id));
//   }


//   /// 获取分页列表数据的接口（支持复杂查询）
//   Future<PageResponse<dynamic>> getList(Session session, QueryRequest query) async {
//     // 将前端的 QueryRequest 结构转换为服务层可识别的核心查询对象
//     final p = await service.getList(session, _toQueryDTO(query));
//     return PageResponse.restPage(data: p.data, page: p.page, pageSize: p.pageSize, total: p.total );
//   }


//   /// 更新数据实体的接口
//   Future<CommonResponse> update(Session session, dynamic data) async {
//     return CommonResponse.success(await service.update(session, decodeModel(data)));
//   }


//   /// 删除指定ID的数据实体
//   Future<CommonResponse> delete(Session session, int id) async {
//     return CommonResponse.success(await service.delete(session, id));
//   }

  
//   /// 批量删除指定ID的数据实体
//   Future<CommonResponse> deleteBatch(Session session, List<int> ids) async {
//     final result = await service.deleteBatch(session, ids);
//     return CommonResponse.success(result.toJson());
//   }

// }

// /// 基于 [AutoCrudService.meta] 自动获取模型解码器的 Endpoint 基类，简化了 CRUD 相关接口的模型解码工作。
// /// 
// /// 泛型说明：
// /// - [T]：代表后端数据表对应的实体类型，通常需继承自 [TableRow]，如 User、Article 等。用于约束实体的数据结构。
// /// - [TTable]：代表此实体 (T) 使用的数据库表定义（继承自 [Table]），如 UserTable、ArticleTable，用于支持复杂查询、表结构元数据等。
// /// - [S]：处理此实体的自动CRUD服务类型（需继承 [AutoCrudService<T, TTable>]），负责提供模型的增删改查和 decode 逻辑。
// ///
// /// 实现思路：
// /// 通过覆写 [decodeModel] 方法，把外部（如 JSON 或 Map）传入的数据，直接交给服务的 [decodeModel] 统一解码，
// /// 使得各业务子类无需重复实现对象重建（反序列化）的细节，确保一致性并减少样板代码。

// abstract class AutoCrudEndpoint<T extends TableRow, TTable extends Table, S extends AutoCrudService<T, TTable>> extends BaseEndpoint<T, TTable, S> {
//   @override
//   T decodeModel(dynamic data) => service.decodeModel(data);
// }
