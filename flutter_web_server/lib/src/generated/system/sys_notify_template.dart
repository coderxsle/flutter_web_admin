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

/// 站内信模板表
abstract class SysNotifyTemplate
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysNotifyTemplate._({
    this.id,
    required this.name,
    required this.code,
    required this.nickname,
    required this.content,
    required this.type,
    this.params,
    required this.status,
    this.description,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysNotifyTemplate({
    int? id,
    required String name,
    required String code,
    required String nickname,
    required String content,
    required int type,
    String? params,
    required int status,
    String? description,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysNotifyTemplateImpl;

  factory SysNotifyTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysNotifyTemplate(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      nickname: jsonSerialization['nickname'] as String,
      content: jsonSerialization['content'] as String,
      type: jsonSerialization['type'] as int,
      params: jsonSerialization['params'] as String?,
      status: jsonSerialization['status'] as int,
      description: jsonSerialization['description'] as String?,
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

  static final t = SysNotifyTemplateTable();

  static const db = SysNotifyTemplateRepository._();

  @override
  int? id;

  String name;

  String code;

  String nickname;

  String content;

  int type;

  String? params;

  int status;

  String? description;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysNotifyTemplate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysNotifyTemplate copyWith({
    int? id,
    String? name,
    String? code,
    String? nickname,
    String? content,
    int? type,
    String? params,
    int? status,
    String? description,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysNotifyTemplate',
      if (id != null) 'id': id,
      'name': name,
      'code': code,
      'nickname': nickname,
      'content': content,
      'type': type,
      if (params != null) 'params': params,
      'status': status,
      if (description != null) 'description': description,
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
      '__className__': 'SysNotifyTemplate',
      if (id != null) 'id': id,
      'name': name,
      'code': code,
      'nickname': nickname,
      'content': content,
      'type': type,
      if (params != null) 'params': params,
      'status': status,
      if (description != null) 'description': description,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysNotifyTemplateInclude include() {
    return SysNotifyTemplateInclude._();
  }

  static SysNotifyTemplateIncludeList includeList({
    _is.WhereExpressionBuilder<SysNotifyTemplateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysNotifyTemplateTable>? orderBy,
    _is.OrderByListBuilder<SysNotifyTemplateTable>? orderByList,
    SysNotifyTemplateInclude? include,
  }) {
    return SysNotifyTemplateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysNotifyTemplate.t),
      orderByList: orderByList?.call(SysNotifyTemplate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysNotifyTemplateImpl extends SysNotifyTemplate {
  _SysNotifyTemplateImpl({
    int? id,
    required String name,
    required String code,
    required String nickname,
    required String content,
    required int type,
    String? params,
    required int status,
    String? description,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         name: name,
         code: code,
         nickname: nickname,
         content: content,
         type: type,
         params: params,
         status: status,
         description: description,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysNotifyTemplate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysNotifyTemplate copyWith({
    Object? id = _Undefined,
    String? name,
    String? code,
    String? nickname,
    String? content,
    int? type,
    Object? params = _Undefined,
    int? status,
    Object? description = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysNotifyTemplate(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      nickname: nickname ?? this.nickname,
      content: content ?? this.content,
      type: type ?? this.type,
      params: params is String? ? params : this.params,
      status: status ?? this.status,
      description: description is String? ? description : this.description,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysNotifyTemplateUpdateTable
    extends _is.UpdateTable<SysNotifyTemplateTable> {
  SysNotifyTemplateUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> code(String value) =>
      _is.ColumnValue(table.code, value);

  _is.ColumnValue<String, String> nickname(String value) =>
      _is.ColumnValue(table.nickname, value);

  _is.ColumnValue<String, String> content(String value) =>
      _is.ColumnValue(table.content, value);

  _is.ColumnValue<int, int> type(int value) =>
      _is.ColumnValue(table.type, value);

  _is.ColumnValue<String, String> params(String? value) =>
      _is.ColumnValue(table.params, value);

  _is.ColumnValue<int, int> status(int value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

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

class SysNotifyTemplateTable extends _is.Table<int?> {
  SysNotifyTemplateTable({super.tableRelation})
    : super(tableName: 'sys_notify_template') {
    updateTable = SysNotifyTemplateUpdateTable(this);
    name = _is.ColumnString('name', this);
    code = _is.ColumnString('code', this);
    nickname = _is.ColumnString('nickname', this);
    content = _is.ColumnString('content', this);
    type = _is.ColumnInt('type', this);
    params = _is.ColumnString('params', this);
    status = _is.ColumnInt('status', this);
    description = _is.ColumnString('description', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysNotifyTemplateUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString code;

  late final _is.ColumnString nickname;

  late final _is.ColumnString content;

  late final _is.ColumnInt type;

  late final _is.ColumnString params;

  late final _is.ColumnInt status;

  late final _is.ColumnString description;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    code,
    nickname,
    content,
    type,
    params,
    status,
    description,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysNotifyTemplateInclude extends _is.IncludeObject {
  SysNotifyTemplateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysNotifyTemplate.t;
}

class SysNotifyTemplateIncludeList extends _is.IncludeList {
  SysNotifyTemplateIncludeList._({
    _is.WhereExpressionBuilder<SysNotifyTemplateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysNotifyTemplate.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysNotifyTemplate.t;
}

class SysNotifyTemplateRepository {
  const SysNotifyTemplateRepository._();

  /// Returns a list of [SysNotifyTemplate]s matching the given query parameters.
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
  Future<List<SysNotifyTemplate>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysNotifyTemplateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysNotifyTemplateTable>? orderBy,
    _is.OrderByListBuilder<SysNotifyTemplateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysNotifyTemplate>(
      where: where?.call(SysNotifyTemplate.t),
      orderBy: orderBy?.call(SysNotifyTemplate.t),
      orderByList: orderByList?.call(SysNotifyTemplate.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysNotifyTemplate] matching the given query parameters.
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
  Future<SysNotifyTemplate?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysNotifyTemplateTable>? where,
    int? offset,
    _is.OrderByBuilder<SysNotifyTemplateTable>? orderBy,
    _is.OrderByListBuilder<SysNotifyTemplateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysNotifyTemplate>(
      where: where?.call(SysNotifyTemplate.t),
      orderBy: orderBy?.call(SysNotifyTemplate.t),
      orderByList: orderByList?.call(SysNotifyTemplate.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysNotifyTemplate] by its [id] or null if no such row exists.
  Future<SysNotifyTemplate?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysNotifyTemplate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysNotifyTemplate]s in the list and returns the inserted rows.
  ///
  /// The returned [SysNotifyTemplate]s will have their `id` fields set.
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
  Future<List<SysNotifyTemplate>> insert(
    _is.DatabaseSession session,
    List<SysNotifyTemplate> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysNotifyTemplate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysNotifyTemplate] and returns the inserted row.
  ///
  /// The returned [SysNotifyTemplate] will have its `id` field set.
  Future<SysNotifyTemplate> insertRow(
    _is.DatabaseSession session,
    SysNotifyTemplate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysNotifyTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SysNotifyTemplate]s in the list and returns the resulting rows.
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
  /// The returned [SysNotifyTemplate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysNotifyTemplate>> upsert(
    _is.DatabaseSession session,
    List<SysNotifyTemplate> rows, {
    required _is.ColumnSelections<SysNotifyTemplateTable> conflictColumns,
    _is.ColumnSelections<SysNotifyTemplateTable>? updateColumns,
    _is.WhereExpressionBuilder<SysNotifyTemplateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysNotifyTemplate>(
      rows,
      conflictColumns: conflictColumns(SysNotifyTemplate.t),
      updateColumns: updateColumns?.call(SysNotifyTemplate.t),
      updateWhere: updateWhere?.call(SysNotifyTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysNotifyTemplate] and returns the resulting row.
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
  /// The returned [SysNotifyTemplate] will have its `id` field set.
  Future<SysNotifyTemplate?> upsertRow(
    _is.DatabaseSession session,
    SysNotifyTemplate row, {
    required _is.ColumnSelections<SysNotifyTemplateTable> conflictColumns,
    _is.ColumnSelections<SysNotifyTemplateTable>? updateColumns,
    _is.WhereExpressionBuilder<SysNotifyTemplateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysNotifyTemplate>(
      row,
      conflictColumns: conflictColumns(SysNotifyTemplate.t),
      updateColumns: updateColumns?.call(SysNotifyTemplate.t),
      updateWhere: updateWhere?.call(SysNotifyTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysNotifyTemplate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysNotifyTemplate>> update(
    _is.DatabaseSession session,
    List<SysNotifyTemplate> rows, {
    _is.ColumnSelections<SysNotifyTemplateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysNotifyTemplate>(
      rows,
      columns: columns?.call(SysNotifyTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysNotifyTemplate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysNotifyTemplate> updateRow(
    _is.DatabaseSession session,
    SysNotifyTemplate row, {
    _is.ColumnSelections<SysNotifyTemplateTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysNotifyTemplate>(
      row,
      columns: columns?.call(SysNotifyTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysNotifyTemplate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysNotifyTemplate?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysNotifyTemplateUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysNotifyTemplate>(
      id,
      columnValues: columnValues(SysNotifyTemplate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysNotifyTemplate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysNotifyTemplate>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysNotifyTemplateUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SysNotifyTemplateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysNotifyTemplateTable>? orderBy,
    _is.OrderByListBuilder<SysNotifyTemplateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysNotifyTemplate>(
      columnValues: columnValues(SysNotifyTemplate.t.updateTable),
      where: where(SysNotifyTemplate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysNotifyTemplate.t),
      orderByList: orderByList?.call(SysNotifyTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysNotifyTemplate]s in the list and returns the deleted rows.
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
  Future<List<SysNotifyTemplate>> delete(
    _is.DatabaseSession session,
    List<SysNotifyTemplate> rows, {
    _is.OrderByBuilder<SysNotifyTemplateTable>? orderBy,
    _is.OrderByListBuilder<SysNotifyTemplateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysNotifyTemplate>(
      rows,
      orderBy: orderBy?.call(SysNotifyTemplate.t),
      orderByList: orderByList?.call(SysNotifyTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysNotifyTemplate].
  Future<SysNotifyTemplate> deleteRow(
    _is.DatabaseSession session,
    SysNotifyTemplate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysNotifyTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysNotifyTemplate>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysNotifyTemplateTable> where,
    _is.OrderByBuilder<SysNotifyTemplateTable>? orderBy,
    _is.OrderByListBuilder<SysNotifyTemplateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysNotifyTemplate>(
      where: where(SysNotifyTemplate.t),
      orderBy: orderBy?.call(SysNotifyTemplate.t),
      orderByList: orderByList?.call(SysNotifyTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysNotifyTemplateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysNotifyTemplate>(
      where: where?.call(SysNotifyTemplate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysNotifyTemplate] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysNotifyTemplateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysNotifyTemplate>(
      where: where(SysNotifyTemplate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
