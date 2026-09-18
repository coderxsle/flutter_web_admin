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
import 'package:serverpod/serverpod.dart' as _is;

/// 短信模板
abstract class SysSmsTemplate
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysSmsTemplate._({
    this.id,
    required this.type,
    required this.status,
    required this.code,
    required this.name,
    required this.content,
    required this.params,
    this.description,
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
    String? description,
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
      description: jsonSerialization['description'] as String?,
      apiTemplateId: jsonSerialization['apiTemplateId'] as String,
      channelId: jsonSerialization['channelId'] as int,
      channelCode: jsonSerialization['channelCode'] as String,
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
      deleted: _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
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

  String? description;

  String apiTemplateId;

  int channelId;

  String channelCode;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSmsTemplate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysSmsTemplate copyWith({
    int? id,
    int? type,
    int? status,
    String? code,
    String? name,
    String? content,
    String? params,
    String? description,
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
      '__className__': 'SysSmsTemplate',
      if (id != null) 'id': id,
      'type': type,
      'status': status,
      'code': code,
      'name': name,
      'content': content,
      'params': params,
      if (description != null) 'description': description,
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
      '__className__': 'SysSmsTemplate',
      if (id != null) 'id': id,
      'type': type,
      'status': status,
      'code': code,
      'name': name,
      'content': content,
      'params': params,
      if (description != null) 'description': description,
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
    _is.WhereExpressionBuilder<SysSmsTemplateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSmsTemplateTable>? orderBy,
    _is.OrderByListBuilder<SysSmsTemplateTable>? orderByList,
    SysSmsTemplateInclude? include,
  }) {
    return SysSmsTemplateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSmsTemplate.t),
      orderByList: orderByList?.call(SysSmsTemplate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
    String? description,
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
         description: description,
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
  @_is.useResult
  @override
  SysSmsTemplate copyWith({
    Object? id = _Undefined,
    int? type,
    int? status,
    String? code,
    String? name,
    String? content,
    String? params,
    Object? description = _Undefined,
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
      description: description is String? ? description : this.description,
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

class SysSmsTemplateUpdateTable extends _is.UpdateTable<SysSmsTemplateTable> {
  SysSmsTemplateUpdateTable(super.table);

  _is.ColumnValue<int, int> type(int value) =>
      _is.ColumnValue(table.type, value);

  _is.ColumnValue<int, int> status(int value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<String, String> code(String value) =>
      _is.ColumnValue(table.code, value);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> content(String value) =>
      _is.ColumnValue(table.content, value);

  _is.ColumnValue<String, String> params(String value) =>
      _is.ColumnValue(table.params, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<String, String> apiTemplateId(String value) =>
      _is.ColumnValue(table.apiTemplateId, value);

  _is.ColumnValue<int, int> channelId(int value) =>
      _is.ColumnValue(table.channelId, value);

  _is.ColumnValue<String, String> channelCode(String value) =>
      _is.ColumnValue(table.channelCode, value);

  _is.ColumnValue<String, String> creator(String? value) =>
      _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) =>
      _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> deleted(bool value) =>
      _is.ColumnValue(table.deleted, value);
}

class SysSmsTemplateTable extends _is.Table<int?> {
  SysSmsTemplateTable({super.tableRelation})
    : super(tableName: 'sys_sms_template') {
    updateTable = SysSmsTemplateUpdateTable(this);
    type = _is.ColumnInt('type', this);
    status = _is.ColumnInt('status', this);
    code = _is.ColumnString('code', this);
    name = _is.ColumnString('name', this);
    content = _is.ColumnString('content', this);
    params = _is.ColumnString('params', this);
    description = _is.ColumnString('description', this);
    apiTemplateId = _is.ColumnString('apiTemplateId', this);
    channelId = _is.ColumnInt('channelId', this);
    channelCode = _is.ColumnString('channelCode', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysSmsTemplateUpdateTable updateTable;

  late final _is.ColumnInt type;

  late final _is.ColumnInt status;

  late final _is.ColumnString code;

  late final _is.ColumnString name;

  late final _is.ColumnString content;

  late final _is.ColumnString params;

  late final _is.ColumnString description;

  late final _is.ColumnString apiTemplateId;

  late final _is.ColumnInt channelId;

  late final _is.ColumnString channelCode;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    type,
    status,
    code,
    name,
    content,
    params,
    description,
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

class SysSmsTemplateInclude extends _is.IncludeObject {
  SysSmsTemplateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysSmsTemplate.t;
}

class SysSmsTemplateIncludeList extends _is.IncludeList {
  SysSmsTemplateIncludeList._({
    _is.WhereExpressionBuilder<SysSmsTemplateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSmsTemplate.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysSmsTemplate.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSmsTemplateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSmsTemplateTable>? orderBy,
    _is.OrderByListBuilder<SysSmsTemplateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysSmsTemplate>(
      where: where?.call(SysSmsTemplate.t),
      orderBy: orderBy?.call(SysSmsTemplate.t),
      orderByList: orderByList?.call(SysSmsTemplate.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSmsTemplateTable>? where,
    int? offset,
    _is.OrderByBuilder<SysSmsTemplateTable>? orderBy,
    _is.OrderByListBuilder<SysSmsTemplateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysSmsTemplate>(
      where: where?.call(SysSmsTemplate.t),
      orderBy: orderBy?.call(SysSmsTemplate.t),
      orderByList: orderByList?.call(SysSmsTemplate.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysSmsTemplate] by its [id] or null if no such row exists.
  Future<SysSmsTemplate?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysSmsTemplate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysSmsTemplate]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSmsTemplate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsTemplate>> insert(
    _is.DatabaseSession session,
    List<SysSmsTemplate> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysSmsTemplate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysSmsTemplate] and returns the inserted row.
  ///
  /// The returned [SysSmsTemplate] will have its `id` field set.
  Future<SysSmsTemplate> insertRow(
    _is.DatabaseSession session,
    SysSmsTemplate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSmsTemplate>(row, transaction: transaction);
  }

  /// Upserts all [SysSmsTemplate]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [SysSmsTemplate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsTemplate>> upsert(
    _is.DatabaseSession session,
    List<SysSmsTemplate> rows, {
    required _is.ColumnSelections<SysSmsTemplateTable> conflictColumns,
    _is.ColumnSelections<SysSmsTemplateTable>? updateColumns,
    _is.WhereExpressionBuilder<SysSmsTemplateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysSmsTemplate>(
      rows,
      conflictColumns: conflictColumns(SysSmsTemplate.t),
      updateColumns: updateColumns?.call(SysSmsTemplate.t),
      updateWhere: updateWhere?.call(SysSmsTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysSmsTemplate] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [SysSmsTemplate] will have its `id` field set.
  Future<SysSmsTemplate?> upsertRow(
    _is.DatabaseSession session,
    SysSmsTemplate row, {
    required _is.ColumnSelections<SysSmsTemplateTable> conflictColumns,
    _is.ColumnSelections<SysSmsTemplateTable>? updateColumns,
    _is.WhereExpressionBuilder<SysSmsTemplateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysSmsTemplate>(
      row,
      conflictColumns: conflictColumns(SysSmsTemplate.t),
      updateColumns: updateColumns?.call(SysSmsTemplate.t),
      updateWhere: updateWhere?.call(SysSmsTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysSmsTemplate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsTemplate>> update(
    _is.DatabaseSession session,
    List<SysSmsTemplate> rows, {
    _is.ColumnSelections<SysSmsTemplateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysSmsTemplate>(
      rows,
      columns: columns?.call(SysSmsTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysSmsTemplate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSmsTemplate> updateRow(
    _is.DatabaseSession session,
    SysSmsTemplate row, {
    _is.ColumnSelections<SysSmsTemplateTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSmsTemplate>(
      row,
      columns: columns?.call(SysSmsTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSmsTemplate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysSmsTemplate?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysSmsTemplateUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysSmsTemplate>(
      id,
      columnValues: columnValues(SysSmsTemplate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysSmsTemplate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsTemplate>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysSmsTemplateUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysSmsTemplateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSmsTemplateTable>? orderBy,
    _is.OrderByListBuilder<SysSmsTemplateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysSmsTemplate>(
      columnValues: columnValues(SysSmsTemplate.t.updateTable),
      where: where(SysSmsTemplate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSmsTemplate.t),
      orderByList: orderByList?.call(SysSmsTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysSmsTemplate]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsTemplate>> delete(
    _is.DatabaseSession session,
    List<SysSmsTemplate> rows, {
    _is.OrderByBuilder<SysSmsTemplateTable>? orderBy,
    _is.OrderByListBuilder<SysSmsTemplateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysSmsTemplate>(
      rows,
      orderBy: orderBy?.call(SysSmsTemplate.t),
      orderByList: orderByList?.call(SysSmsTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysSmsTemplate].
  Future<SysSmsTemplate> deleteRow(
    _is.DatabaseSession session,
    SysSmsTemplate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSmsTemplate>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsTemplate>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysSmsTemplateTable> where,
    _is.OrderByBuilder<SysSmsTemplateTable>? orderBy,
    _is.OrderByListBuilder<SysSmsTemplateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysSmsTemplate>(
      where: where(SysSmsTemplate.t),
      orderBy: orderBy?.call(SysSmsTemplate.t),
      orderByList: orderByList?.call(SysSmsTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSmsTemplateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysSmsTemplate>(
      where: where?.call(SysSmsTemplate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysSmsTemplate] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysSmsTemplateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysSmsTemplate>(
      where: where(SysSmsTemplate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
