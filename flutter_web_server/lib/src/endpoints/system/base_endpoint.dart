import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import '../../crud/crud_runtime_factory.dart';
import '../../mappers/query_request_mapper.dart';
import '../utils/json_param_codec.dart';

/// 通用 CRUD Endpoint 基类（默认实现）。
///
/// 子类只需继承此基类即可获得常见 CRUD + query 方法；特殊业务查询
/// 直接写在具体 Endpoint 中。
/// 如果某个实体使用非标准字段，可以只覆盖差异：
///
/// ```dart
/// class ResourceEndpoint extends BaseEndpoint<Resource, ResourceTable> {
///   ResourceEndpoint()
///       : super(
///           tenantIdField: 'organizationId',
///           deletedField: 'archived',
///           keywordFields: const ['name', 'code'],
///           fieldAliases: const {
///             'createdAt': 'createTime',
///           },
///         );
/// }
/// ```

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

  // ---------------------------------------------------------------------------
  // 「JSON 文本参数」接口（addByJsonParams / updateByJsonParams）共用的支持逻辑
  // ---------------------------------------------------------------------------
  //
  // ⚠️ 下面这些成员一律用下划线私有。BaseEndpoint 是 Endpoint 的子类，Serverpod 会把
  //    它上面的**公开**方法注册成 HTTP 路由（`/user/addByJsonParams` 就是这么来的），
  //    私有成员不会被扫描，所以放这里安全。

  /// 当前实体在数据库里**真实存在**的字段名集合，用作请求体的字段白名单。
  ///
  /// 取自 `service.table.columns`，因此 `!persist` 字段（如 `SysUser.type`）和
  /// 不存在于本表的关联表字段（如 `SysUser` 根本没有的 `roleIds`）都不在其中
  /// —— 这类字段被传进来时会被识别为「不认识的字段」。
  ///
  /// 端点实例在 Serverpod 里是启动时创建的单例，所以用 `late final` 只算一次。
  late final Set<String> _knownFieldNames = {
    for (final column in service.table.columns) column.fieldName,
  };

  /// 主键的字段名，用于拼报错信息。
  String get _idFieldName => service.idColumn(service.table).fieldName;

  /// 主键在请求体里可能出现的所有 key（字段名 + 数据库列名）。
  ///
  /// 既用于「取主键」，也用于「校验字段名时把主键排除掉」，两处保持同一套 key，
  /// 避免出现「主键取到了、却又被算成不认识的字段」这种自相矛盾。
  Set<String> get _primaryKeyKeys {
    final idColumn = service.idColumn(service.table);
    return {idColumn.fieldName, idColumn.columnName};
  }

  /// 把请求体的 key 分成「本实体真实存在的字段」与「不认识的字段」。
  ///
  /// - [excludeKeys]：要剔除的 key，调用方一般传主键（见 [_primaryKeyKeys]）
  ///
  /// 之所以分开返回，是为了让调用方能给出**有指向性**的报错：把拼错的字段名直接列出来，
  /// 而不是笼统地说一句「没有可更新的字段」让人猜。
  ({Set<String> known, Set<String> unknown}) _splitFieldNames(
    Map<String, dynamic> provided, {
    Set<String> excludeKeys = const {},
  }) {
    final known = <String>{};
    final unknown = <String>{};
    for (final key in provided.keys) {
      if (excludeKeys.contains(key)) continue;
      (_knownFieldNames.contains(key) ? known : unknown).add(key);
    }
    return (known: known, unknown: unknown);
  }

  /// 从请求体里取主键，兼容前端 `2` / `"2"` 两种写法。
  ///
  /// 取不到或非法（<= 0）时返回 null，由调用方给出业务报错。
  int? _extractPrimaryKey(Map<String, dynamic> provided) {
    for (final key in _primaryKeyKeys) {
      final id = switch (provided[key]) {
        final int v => v,
        final num v => v.toInt(),
        final String v => int.tryParse(v),
        _ => null,
      };
      if (id != null && id > 0) return id;
    }
    return null;
  }

  /// 把不认识的字段名拼成一段报错片段，供 [_splitFieldNames] 的调用方使用。
  String _describeUnknownFields(Set<String> unknown) =>
      unknown.isEmpty ? '' : '其中 ${unknown.join('、')} 不是本实体的字段；';

  /// 创建数据实体的接口， 适合单表新增数据。（**接收 JSON 对象文本**）
  ///
  /// 与 [add] 的差别只在入参形态（两者最终都走 `service.create`）：
  /// - [add] 的形参是 `dynamic`，Serverpod 要求带类型标签的线格式，前端无法自然构造；
  /// - [addByJsonParams] 的形参是 `String`，请求体传
  ///   `{"params": "{\"username\":\"chen_yu\"}"}` 即可（前端一行 `JSON.stringify`）。
  ///
  /// - [session]：当前的 Serverpod 会话
  /// - [params]：请求体，是**JSON 对象文本**（不是 JSON 对象本身），例如
  ///   `{"username": "chen_yu", "nickname": "陈宇"}`
  ///
  /// 注意：请求体里出现、但**不属于本实体列**的字段会被忽略（`!persist` 字段、
  /// 关联表字段如 `SysUser` 的 `roleIds` 都在此列）；但至少要有一个合法字段，
  /// 否则直接报错 —— 避免字段名拼错时插进去一条空数据还返回成功。
  ///
  /// 返回：包含新建结果的 [CommonResponse]，data 字段为新建实体
  Future<CommonResponse> addByJsonParams(Session session, String params) async {
    try {
      // 1. JSON 文本 → Map（与 updateByJsonParams 共用 JsonParamCodec，见 json_param_codec.dart）
      final provided = JsonParamCodec.decodeObject(params, paramName: 'params');

      // 2. 字段名校验（与 updateByJsonParams 共用 _splitFieldNames）
      final fields = _splitFieldNames(provided);
      if (fields.known.isEmpty) {
        return CommonResponse.failed(
          '没有可写入的字段，请检查字段名。'
          '${_describeUnknownFields(fields.unknown)}'
          '当前实体字段：${_knownFieldNames.join(', ')}',
        );
      }

      // 3. 真正落库
      return CommonResponse.success(
        await service.create(session, decodeModel(provided)),
      );
    } on JsonParamFormatException catch (e) {
      return CommonResponse.failed('参数不合法：${e.message}');
    } catch (e) {
      return CommonResponse.failed('新增失败：$e');
    }
  }

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
  Future<PageResponse<dynamic>> getList(Session session, QueryRequest query) async {
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
  ///
  /// ⚠️ 这是 **PUT（整行覆盖）** 语义：请求体被整体反序列化成一个新实体后整行写回，
  /// 请求里没出现的字段会被 `fromJson` 的默认值 / null 覆盖掉。对含
  /// `scope=serverOnly` 字段或外键的实体（如 SysUser 的 password、authUserId），
  /// 漏传即等于清空。需要「只改传过来的字段」请用 [updateByJsonParams]。
  /// 这个方法之所以保留，是为了给 serverpod 生成的 client 代码预留。
  Future<CommonResponse> update(Session session, dynamic data) async {
    return CommonResponse.success(await service.update(session, decodeModel(data)));
  }

  /// 部分更新数据实体的接口（**PATCH 语义**，接收 JSON 对象文本）
  ///
  /// 与 [update] 的差别：
  /// - [update] 把请求体整体反序列化成新实体再整行覆盖，缺字段即被默认值/null 覆盖；
  /// - [updateByJsonParams] 先按主键读出数据库当前行作为**基线**，只让请求里
  ///   **实际出现过的字段**去覆盖它，未出现的字段保持数据库原值。因此可以安全地
  ///   只传要改的字段，例如 `{"id": 2, "deptId": 2}` 或 `{"id": 2, "username": "chen.yu"}`。
  ///
  /// - [session]：当前的Serverpod会话
  /// - [params]：请求体，是**JSON 对象文本**（不是 JSON 对象本身）。必须带主键
  ///   （默认字段名 `id`），其余字段可选，例如 `{"id": 2, "deptId": 5}` 会被序列化成
  ///   字符串传进来。
  ///
  /// ⚠️ 为什么这里用 `String` 而不是 `dynamic` / `Map<String, dynamic>`：
  /// Serverpod 对这两个类型都会走 `deserializeDynamicFieldValue`，要求线格式是带
  /// 类型标签的 `{"className": "...", "data": {...}}`，**且每个字段值还要再包一层**
  /// （如 `{"id": {"className": "int", "data": 2}}`）；直接传普通 JSON 对象会抛
  /// `No deserialization found for type named null`。`Map<String, dynamic>` 只是把
  /// 报错换成 `got int instead`，同样不可用。详见 `json_param_codec.dart` 的类注释。
  ///
  /// 返回：包含更新结果的[CommonResponse]，data字段为更新后的**完整**实体
  Future<CommonResponse> updateByJsonParams(Session session, String params) async {
    try {
      // 1. JSON 文本 → Map（与 addByJsonParams 共用 JsonParamCodec）
      final provided = JsonParamCodec.decodeObject(params, paramName: 'params');

      // 2. 先取主键。
      //    这一步不能走 decodeModel —— 部分字段的请求体本来就可能缺必填字段，
      //    整体反序列化会直接抛异常，连 id 都拿不到。
      final id = _extractPrimaryKey(provided);
      if (id == null) {
        return CommonResponse.failed('参数不合法：必须提供有效的主键 $_idFieldName');
      }

      // 3. 校验字段名（与 addByJsonParams 共用 _splitFieldNames，只是这里要排除主键），
      //    避免拼错时静默「什么都没改」还返回成功。
      final fields = _splitFieldNames(provided, excludeKeys: _primaryKeyKeys);
      if (fields.known.isEmpty) {
        return CommonResponse.failed(
          '没有可更新的字段（已忽略主键），请检查字段名。'
          '${_describeUnknownFields(fields.unknown)}'
          '当前实体字段：${_knownFieldNames.join(', ')}',
        );
      }

      // 4. 读出当前行作为合并基线。
      //    注意必须用 toJson()，不能用 toJsonForProtocol() —— 后者不含
      //    scope=serverOnly 的字段（如 SysUser.password），会把它们合并成 null。
      final existing = await service.get(session, id);
      if (existing == null) {
        return CommonResponse.failed('数据不存在或已删除：id=$id');
      }

      // 5. 只让「请求里出现过的 key」覆盖基线值（显式传 null 也能清空字段）。
      final merged = <String, dynamic>{...existing.toJson(), ...provided};

      return CommonResponse.success(await service.update(session, decodeModel(merged)));
    } on JsonParamFormatException catch (e) {
      return CommonResponse.failed('参数不合法：${e.message}');
    } catch (e) {
      return CommonResponse.failed('部分更新失败：$e');
    }
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
