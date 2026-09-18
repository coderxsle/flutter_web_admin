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

/// 系统API表
abstract class SysApi implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysApi._({
    this.id,
    int? tenantId,
    required this.name,
    required this.path,
    required this.method,
    this.description,
    int? status,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    this.updateTime,
  }) : tenantId = tenantId ?? 0,
       status = status ?? 1,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now();

  factory SysApi({
    int? id,
    int? tenantId,
    required String name,
    required String path,
    required String method,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _SysApiImpl;

  factory SysApi.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysApi(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      path: jsonSerialization['path'] as String,
      method: jsonSerialization['method'] as String,
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as int?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  static final t = SysApiTable();

  static const db = SysApiRepository._();

  @override
  int? id;

  int tenantId;

  String name;

  String path;

  String method;

  String? description;

  int? status;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime? updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysApi]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysApi copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? path,
    String? method,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysApi',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'path': path,
      'method': method,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SysApi',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'path': path,
      'method': method,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
    };
  }

  static SysApiInclude include() {
    return SysApiInclude._();
  }

  static SysApiIncludeList includeList({
    _is.WhereExpressionBuilder<SysApiTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysApiTable>? orderBy,
    _is.OrderByListBuilder<SysApiTable>? orderByList,
    SysApiInclude? include,
  }) {
    return SysApiIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysApi.t),
      orderByList: orderByList?.call(SysApi.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysApiImpl extends SysApi {
  _SysApiImpl({
    int? id,
    int? tenantId,
    required String name,
    required String path,
    required String method,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         path: path,
         method: method,
         description: description,
         status: status,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysApi]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysApi copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    String? path,
    String? method,
    Object? description = _Undefined,
    Object? status = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    Object? updateTime = _Undefined,
  }) {
    return SysApi(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      path: path ?? this.path,
      method: method ?? this.method,
      description: description is String? ? description : this.description,
      status: status is int? ? status : this.status,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime is DateTime? ? updateTime : this.updateTime,
    );
  }
}

class SysApiUpdateTable extends _is.UpdateTable<SysApiTable> {
  SysApiUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> path(String value) =>
      _is.ColumnValue(table.path, value);

  _is.ColumnValue<String, String> method(String value) =>
      _is.ColumnValue(table.method, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<int, int> status(int? value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<bool, bool> deleted(bool value) =>
      _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) =>
      _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) =>
      _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime? value) =>
      _is.ColumnValue(table.updateTime, value);
}

class SysApiTable extends _is.Table<int?> {
  SysApiTable({super.tableRelation}) : super(tableName: 'sys_api') {
    updateTable = SysApiUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    name = _is.ColumnString('name', this);
    path = _is.ColumnString('path', this);
    method = _is.ColumnString('method', this);
    description = _is.ColumnString('description', this);
    status = _is.ColumnInt('status', this, hasDefault: true);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
  }

  late final SysApiUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString name;

  late final _is.ColumnString path;

  late final _is.ColumnString method;

  late final _is.ColumnString description;

  late final _is.ColumnInt status;

  late final _is.ColumnBool deleted;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    name,
    path,
    method,
    description,
    status,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class SysApiInclude extends _is.IncludeObject {
  SysApiInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysApi.t;
}

class SysApiIncludeList extends _is.IncludeList {
  SysApiIncludeList._({
    _is.WhereExpressionBuilder<SysApiTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysApi.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysApi.t;
}

class SysApiRepository {
  const SysApiRepository._();

  /// Returns a list of [SysApi]s matching the given query parameters.
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
  Future<List<SysApi>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysApiTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysApiTable>? orderBy,
    _is.OrderByListBuilder<SysApiTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysApi>(
      where: where?.call(SysApi.t),
      orderBy: orderBy?.call(SysApi.t),
      orderByList: orderByList?.call(SysApi.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysApi] matching the given query parameters.
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
  Future<SysApi?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysApiTable>? where,
    int? offset,
    _is.OrderByBuilder<SysApiTable>? orderBy,
    _is.OrderByListBuilder<SysApiTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysApi>(
      where: where?.call(SysApi.t),
      orderBy: orderBy?.call(SysApi.t),
      orderByList: orderByList?.call(SysApi.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysApi] by its [id] or null if no such row exists.
  Future<SysApi?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysApi>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysApi]s in the list and returns the inserted rows.
  ///
  /// The returned [SysApi]s will have their `id` fields set.
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
  Future<List<SysApi>> insert(
    _is.DatabaseSession session,
    List<SysApi> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysApi>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysApi] and returns the inserted row.
  ///
  /// The returned [SysApi] will have its `id` field set.
  Future<SysApi> insertRow(
    _is.DatabaseSession session,
    SysApi row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysApi>(row, transaction: transaction);
  }

  /// Upserts all [SysApi]s in the list and returns the resulting rows.
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
  /// The returned [SysApi]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysApi>> upsert(
    _is.DatabaseSession session,
    List<SysApi> rows, {
    required _is.ColumnSelections<SysApiTable> conflictColumns,
    _is.ColumnSelections<SysApiTable>? updateColumns,
    _is.WhereExpressionBuilder<SysApiTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysApi>(
      rows,
      conflictColumns: conflictColumns(SysApi.t),
      updateColumns: updateColumns?.call(SysApi.t),
      updateWhere: updateWhere?.call(SysApi.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysApi] and returns the resulting row.
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
  /// The returned [SysApi] will have its `id` field set.
  Future<SysApi?> upsertRow(
    _is.DatabaseSession session,
    SysApi row, {
    required _is.ColumnSelections<SysApiTable> conflictColumns,
    _is.ColumnSelections<SysApiTable>? updateColumns,
    _is.WhereExpressionBuilder<SysApiTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysApi>(
      row,
      conflictColumns: conflictColumns(SysApi.t),
      updateColumns: updateColumns?.call(SysApi.t),
      updateWhere: updateWhere?.call(SysApi.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysApi]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysApi>> update(
    _is.DatabaseSession session,
    List<SysApi> rows, {
    _is.ColumnSelections<SysApiTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysApi>(
      rows,
      columns: columns?.call(SysApi.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysApi]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysApi> updateRow(
    _is.DatabaseSession session,
    SysApi row, {
    _is.ColumnSelections<SysApiTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysApi>(
      row,
      columns: columns?.call(SysApi.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysApi] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysApi?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysApiUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysApi>(
      id,
      columnValues: columnValues(SysApi.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysApi]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysApi>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysApiUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysApiTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysApiTable>? orderBy,
    _is.OrderByListBuilder<SysApiTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysApi>(
      columnValues: columnValues(SysApi.t.updateTable),
      where: where(SysApi.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysApi.t),
      orderByList: orderByList?.call(SysApi.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysApi]s in the list and returns the deleted rows.
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
  Future<List<SysApi>> delete(
    _is.DatabaseSession session,
    List<SysApi> rows, {
    _is.OrderByBuilder<SysApiTable>? orderBy,
    _is.OrderByListBuilder<SysApiTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysApi>(
      rows,
      orderBy: orderBy?.call(SysApi.t),
      orderByList: orderByList?.call(SysApi.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysApi].
  Future<SysApi> deleteRow(
    _is.DatabaseSession session,
    SysApi row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysApi>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysApi>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysApiTable> where,
    _is.OrderByBuilder<SysApiTable>? orderBy,
    _is.OrderByListBuilder<SysApiTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysApi>(
      where: where(SysApi.t),
      orderBy: orderBy?.call(SysApi.t),
      orderByList: orderByList?.call(SysApi.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysApiTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysApi>(
      where: where?.call(SysApi.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysApi] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysApiTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysApi>(
      where: where(SysApi.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
