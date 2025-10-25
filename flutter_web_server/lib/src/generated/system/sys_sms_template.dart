/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// 短信模板
abstract class SysSmsTemplate
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysSmsTemplate._({
    this.id,
    required this.type,
    required this.status,
    required this.code,
    required this.name,
    required this.content,
    required this.params,
    this.remark,
    required this.apiTemplateId,
    required this.channelId,
    required this.channelCode,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysSmsTemplate({
    int? id,
    required int type,
    required int status,
    required String code,
    required String name,
    required String content,
    required String params,
    String? remark,
    required String apiTemplateId,
    required int channelId,
    required String channelCode,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSmsTemplateImpl;

  factory SysSmsTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSmsTemplate(
      id: jsonSerialization['id'] as int?,
      type: jsonSerialization['type'] as int,
      status: jsonSerialization['status'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      content: jsonSerialization['content'] as String,
      params: jsonSerialization['params'] as String,
      remark: jsonSerialization['remark'] as String?,
      apiTemplateId: jsonSerialization['apiTemplateId'] as String,
      channelId: jsonSerialization['channelId'] as int,
      channelCode: jsonSerialization['channelCode'] as String,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysSmsTemplateTable();

  static const db = SysSmsTemplateRepository._();

  @override
  int? id;

  int type;

  int status;

  String code;

  String name;

  String content;

  String params;

  String? remark;

  String apiTemplateId;

  int channelId;

  String channelCode;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSmsTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysSmsTemplate copyWith({
    int? id,
    int? type,
    int? status,
    String? code,
    String? name,
    String? content,
    String? params,
    String? remark,
    String? apiTemplateId,
    int? channelId,
    String? channelCode,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'type': type,
      'status': status,
      'code': code,
      'name': name,
      'content': content,
      'params': params,
      if (remark != null) 'remark': remark,
      'apiTemplateId': apiTemplateId,
      'channelId': channelId,
      'channelCode': channelCode,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'type': type,
      'status': status,
      'code': code,
      'name': name,
      'content': content,
      'params': params,
      if (remark != null) 'remark': remark,
      'apiTemplateId': apiTemplateId,
      'channelId': channelId,
      'channelCode': channelCode,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysSmsTemplateInclude include() {
    return SysSmsTemplateInclude._();
  }

  static SysSmsTemplateIncludeList includeList({
    _i1.WhereExpressionBuilder<SysSmsTemplateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSmsTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSmsTemplateTable>? orderByList,
    SysSmsTemplateInclude? include,
  }) {
    return SysSmsTemplateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSmsTemplate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysSmsTemplate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysSmsTemplateImpl extends SysSmsTemplate {
  _SysSmsTemplateImpl({
    int? id,
    required int type,
    required int status,
    required String code,
    required String name,
    required String content,
    required String params,
    String? remark,
    required String apiTemplateId,
    required int channelId,
    required String channelCode,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          type: type,
          status: status,
          code: code,
          name: name,
          content: content,
          params: params,
          remark: remark,
          apiTemplateId: apiTemplateId,
          channelId: channelId,
          channelCode: channelCode,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysSmsTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysSmsTemplate copyWith({
    Object? id = _Undefined,
    int? type,
    int? status,
    String? code,
    String? name,
    String? content,
    String? params,
    Object? remark = _Undefined,
    String? apiTemplateId,
    int? channelId,
    String? channelCode,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSmsTemplate(
      id: id is int? ? id : this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      code: code ?? this.code,
      name: name ?? this.name,
      content: content ?? this.content,
      params: params ?? this.params,
      remark: remark is String? ? remark : this.remark,
      apiTemplateId: apiTemplateId ?? this.apiTemplateId,
      channelId: channelId ?? this.channelId,
      channelCode: channelCode ?? this.channelCode,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysSmsTemplateTable extends _i1.Table<int?> {
  SysSmsTemplateTable({super.tableRelation})
      : super(tableName: 'sys_sms_template') {
    type = _i1.ColumnInt(
      'type',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    params = _i1.ColumnString(
      'params',
      this,
    );
    remark = _i1.ColumnString(
      'remark',
      this,
    );
    apiTemplateId = _i1.ColumnString(
      'apiTemplateId',
      this,
    );
    channelId = _i1.ColumnInt(
      'channelId',
      this,
    );
    channelCode = _i1.ColumnString(
      'channelCode',
      this,
    );
    creator = _i1.ColumnString(
      'creator',
      this,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
      hasDefault: true,
    );
    updater = _i1.ColumnString(
      'updater',
      this,
    );
    updateTime = _i1.ColumnDateTime(
      'updateTime',
      this,
    );
    deleted = _i1.ColumnBool(
      'deleted',
      this,
    );
  }

  late final _i1.ColumnInt type;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString code;

  late final _i1.ColumnString name;

  late final _i1.ColumnString content;

  late final _i1.ColumnString params;

  late final _i1.ColumnString remark;

  late final _i1.ColumnString apiTemplateId;

  late final _i1.ColumnInt channelId;

  late final _i1.ColumnString channelCode;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        type,
        status,
        code,
        name,
        content,
        params,
        remark,
        apiTemplateId,
        channelId,
        channelCode,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysSmsTemplateInclude extends _i1.IncludeObject {
  SysSmsTemplateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysSmsTemplate.t;
}

class SysSmsTemplateIncludeList extends _i1.IncludeList {
  SysSmsTemplateIncludeList._({
    _i1.WhereExpressionBuilder<SysSmsTemplateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSmsTemplate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysSmsTemplate.t;
}

class SysSmsTemplateRepository {
  const SysSmsTemplateRepository._();

  /// Returns a list of [SysSmsTemplate]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<SysSmsTemplate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSmsTemplateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSmsTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSmsTemplateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysSmsTemplate>(
      where: where?.call(SysSmsTemplate.t),
      orderBy: orderBy?.call(SysSmsTemplate.t),
      orderByList: orderByList?.call(SysSmsTemplate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysSmsTemplate] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<SysSmsTemplate?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSmsTemplateTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysSmsTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSmsTemplateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysSmsTemplate>(
      where: where?.call(SysSmsTemplate.t),
      orderBy: orderBy?.call(SysSmsTemplate.t),
      orderByList: orderByList?.call(SysSmsTemplate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysSmsTemplate] by its [id] or null if no such row exists.
  Future<SysSmsTemplate?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysSmsTemplate>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysSmsTemplate]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSmsTemplate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysSmsTemplate>> insert(
    _i1.Session session,
    List<SysSmsTemplate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysSmsTemplate>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysSmsTemplate] and returns the inserted row.
  ///
  /// The returned [SysSmsTemplate] will have its `id` field set.
  Future<SysSmsTemplate> insertRow(
    _i1.Session session,
    SysSmsTemplate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSmsTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysSmsTemplate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysSmsTemplate>> update(
    _i1.Session session,
    List<SysSmsTemplate> rows, {
    _i1.ColumnSelections<SysSmsTemplateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysSmsTemplate>(
      rows,
      columns: columns?.call(SysSmsTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSmsTemplate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSmsTemplate> updateRow(
    _i1.Session session,
    SysSmsTemplate row, {
    _i1.ColumnSelections<SysSmsTemplateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSmsTemplate>(
      row,
      columns: columns?.call(SysSmsTemplate.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysSmsTemplate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysSmsTemplate>> delete(
    _i1.Session session,
    List<SysSmsTemplate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysSmsTemplate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysSmsTemplate].
  Future<SysSmsTemplate> deleteRow(
    _i1.Session session,
    SysSmsTemplate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSmsTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysSmsTemplate>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysSmsTemplateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysSmsTemplate>(
      where: where(SysSmsTemplate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSmsTemplateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysSmsTemplate>(
      where: where?.call(SysSmsTemplate.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
