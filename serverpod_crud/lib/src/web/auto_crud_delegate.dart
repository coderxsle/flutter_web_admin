import 'package:serverpod/serverpod.dart';

import '../audit/audit_service.dart';
import '../core/models.dart';
import '../crud/auto_crud_service.dart';
import '../crud/base_service.dart';
import '../crud/crud_entity_meta.dart';
import '../models/query/query_dto.dart';
import '../models/query/query_sort.dart';
import '../runtime/crud_runtime.dart';
import 'crud_delegate.dart';
import 'rest_exception.dart';
import 'rest_page.dart';
import 'rest_request_extension.dart';


/// 供 [AutoCrudDelegate] 默认使用的具体 Service。
class _AutoCrudService<T extends TableRow> extends AutoCrudService<T, Table> {
  _AutoCrudService(super.meta, {super.runtime, super.auditService});
}

/// [CrudDelegate] 的标准实现。表类型由 `T` 在运行期反查，所以只写一个类型参数。
///
/// 显式传 `meta` / `service` 时给窄类型（如 `CrudEntityMeta<Book, BookTable>`）也能收 —— 它们的
/// 第二个类型参数是协变的，会被放宽到这里声明的 `Table`。
class AutoCrudDelegate<T extends TableRow> implements CrudDelegate<T> {
  AutoCrudDelegate({
    CrudEntityMeta<T, Table>? meta,
    BaseService<T, Table>? service,
    CrudRuntime? runtime,
    String tenantIdField = 'tenantId',
    String? deletedField,
    List<String>? keywordFields,
    Map<String, String> fieldAliases = const {},
    AuditService<T>? auditService,
    List<QuerySort>? defaultSort,

    /// defaultSort 为列表接口的默认排序（前端不带 `sort` 时生效）；不传则按表结构自动推导。
  }) : _hasExplicitService = service != null,
       service =
           service ??
           _AutoCrudService<T>(
             meta ??
                 CrudEntityMeta<T, Table>.auto(
                   tenantIdField: tenantIdField,
                   deletedField: deletedField,
                   keywordFields: keywordFields,
                   fieldAliases: fieldAliases,
                   runtime: runtime,
                   defaultSort: defaultSort,
                 ),
             runtime: runtime,
             auditService: auditService,
           ) {
    if (_hasExplicitService && auditService != null) {
      throw ArgumentError('service 与 auditService 只能给一个：传了 service 时审计要配在它里面。');
    }
  }

  /// 调用方是否自己传了 [service] —— 传了的话 `auditService` 参数的审计无处可用。
  final bool _hasExplicitService;

  final BaseService<T, Table> service;

  /// 把 `Map<String, dynamic>` 还原成模型。
  ///
  /// 用 `deserialize<T>` 而不是 `deserializeDynamicFieldValue`：
  /// 后者要求「每个字段值再包一层 `{className, data}`」的线格式，
  /// 而 `deserialize<T>(body, T)` 会直接命中生成的 `T.fromJson`，
  /// **接受浏览器发来的普通 JSON** —— 这一点已在本项目实测过。
  T decode(Map<String, dynamic> body) => Serverpod.instance.serializationManager.deserialize<T>(body, T);


  /// 创建接口：`POST /api/xxx/create`。
  @override
  Future<T> create(Session session, Map<String, dynamic> body) => service.create(session, decode(body));

  /// 删除接口：`POST /api/xxx/remove?id=123`。
  @override
  Future<void> remove(Session session, int id) async {
    final deleted = await service.delete(session, id);
    if (deleted == null) {
      throw RestException.notFound('记录不存在或已删除');
    }
  }
  
  /// 批量删除接口：`POST /api/xxx/removeBatch`。
  @override
  Future<CrudBatchResult> removeBatch(Session session, List<int> ids) => service.deleteBatch(session, ids);

  /// 更新接口：`POST /api/xxx/update?id=123`。
  @override
  Future<T> update(Session session, int id, Map<String, dynamic> body) async {
    // 先读当前行做基线，再让 body 覆盖它 —— PATCH 语义。
    // 基线必须用 `toJson()`（含 serverOnly 字段），否则更新会把密码
    // 这类前端拿不到的字段写成 NULL。
    final current = await service.get(session, id);
    if (current == null) {
      throw RestException.notFound('记录不存在或已删除');
    }
    final merged = <String, dynamic>{...current.toJson(), ...body, 'id': id};
    return service.update(session, decode(merged));
  }


  // 列表接口：`GET /api/xxx/list`。
  @override
  Future<Object?> list(Session session, Request request) async {
    // 这里只负责「没传就用默认」；超上限由 QueryEngine 按 CrudConfig.maxPageSize 夹。
    final req = QueryDTO(
      page: request.queryInt('page') ?? 1,
      pageSize: request.queryInt('pageSize') ?? QueryDTO.defaultPageSize,
      keyword: request.queryString('keyword'),
    );
    final page = await service.getList(session, req);
    return RestPage.fromCrudPage(page);
  }

  /// 详情接口：`GET /api/xxx/detail?id=123`。
  @override
  Future<T> detail(Session session, int id) async {
    final row = await service.get(session, id);
    if (row == null) {
      throw RestException.notFound('记录不存在或已删除');
    }
    return row;
  }

  
}

