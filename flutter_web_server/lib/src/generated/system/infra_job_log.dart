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

/// 定时任务日志表
abstract class InfraJobLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  InfraJobLog._({
    this.id,
    required this.jobId,
    required this.handlerName,
    this.handlerParam,
    required this.executeIndex,
    required this.beginTime,
    this.endTime,
    this.duration,
    required this.status,
    this.result,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraJobLog({
    int? id,
    required int jobId,
    required String handlerName,
    String? handlerParam,
    required int executeIndex,
    required DateTime beginTime,
    DateTime? endTime,
    int? duration,
    required int status,
    String? result,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraJobLogImpl;

  factory InfraJobLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraJobLog(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      handlerName: jsonSerialization['handlerName'] as String,
      handlerParam: jsonSerialization['handlerParam'] as String?,
      executeIndex: jsonSerialization['executeIndex'] as int,
      beginTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['beginTime'],
      ),
      endTime: jsonSerialization['endTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      duration: jsonSerialization['duration'] as int?,
      status: jsonSerialization['status'] as int,
      result: jsonSerialization['result'] as String?,
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

  static final t = InfraJobLogTable();

  static const db = InfraJobLogRepository._();

  @override
  int? id;

  int jobId;

  String handlerName;

  String? handlerParam;

  int executeIndex;

  DateTime beginTime;

  DateTime? endTime;

  int? duration;

  int status;

  String? result;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraJobLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InfraJobLog copyWith({
    int? id,
    int? jobId,
    String? handlerName,
    String? handlerParam,
    int? executeIndex,
    DateTime? beginTime,
    DateTime? endTime,
    int? duration,
    int? status,
    String? result,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InfraJobLog',
      if (id != null) 'id': id,
      'jobId': jobId,
      'handlerName': handlerName,
      if (handlerParam != null) 'handlerParam': handlerParam,
      'executeIndex': executeIndex,
      'beginTime': beginTime.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
      if (duration != null) 'duration': duration,
      'status': status,
      if (result != null) 'result': result,
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
      '__className__': 'InfraJobLog',
      if (id != null) 'id': id,
      'jobId': jobId,
      'handlerName': handlerName,
      if (handlerParam != null) 'handlerParam': handlerParam,
      'executeIndex': executeIndex,
      'beginTime': beginTime.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
      if (duration != null) 'duration': duration,
      'status': status,
      if (result != null) 'result': result,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static InfraJobLogInclude include() {
    return InfraJobLogInclude._();
  }

  static InfraJobLogIncludeList includeList({
    _is.WhereExpressionBuilder<InfraJobLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraJobLogTable>? orderBy,
    _is.OrderByListBuilder<InfraJobLogTable>? orderByList,
    InfraJobLogInclude? include,
  }) {
    return InfraJobLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraJobLog.t),
      orderByList: orderByList?.call(InfraJobLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InfraJobLogImpl extends InfraJobLog {
  _InfraJobLogImpl({
    int? id,
    required int jobId,
    required String handlerName,
    String? handlerParam,
    required int executeIndex,
    required DateTime beginTime,
    DateTime? endTime,
    int? duration,
    required int status,
    String? result,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         jobId: jobId,
         handlerName: handlerName,
         handlerParam: handlerParam,
         executeIndex: executeIndex,
         beginTime: beginTime,
         endTime: endTime,
         duration: duration,
         status: status,
         result: result,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [InfraJobLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InfraJobLog copyWith({
    Object? id = _Undefined,
    int? jobId,
    String? handlerName,
    Object? handlerParam = _Undefined,
    int? executeIndex,
    DateTime? beginTime,
    Object? endTime = _Undefined,
    Object? duration = _Undefined,
    int? status,
    Object? result = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraJobLog(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      handlerName: handlerName ?? this.handlerName,
      handlerParam: handlerParam is String? ? handlerParam : this.handlerParam,
      executeIndex: executeIndex ?? this.executeIndex,
      beginTime: beginTime ?? this.beginTime,
      endTime: endTime is DateTime? ? endTime : this.endTime,
      duration: duration is int? ? duration : this.duration,
      status: status ?? this.status,
      result: result is String? ? result : this.result,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class InfraJobLogUpdateTable extends _is.UpdateTable<InfraJobLogTable> {
  InfraJobLogUpdateTable(super.table);

  _is.ColumnValue<int, int> jobId(int value) =>
      _is.ColumnValue(table.jobId, value);

  _is.ColumnValue<String, String> handlerName(String value) =>
      _is.ColumnValue(table.handlerName, value);

  _is.ColumnValue<String, String> handlerParam(String? value) =>
      _is.ColumnValue(table.handlerParam, value);

  _is.ColumnValue<int, int> executeIndex(int value) =>
      _is.ColumnValue(table.executeIndex, value);

  _is.ColumnValue<DateTime, DateTime> beginTime(DateTime value) =>
      _is.ColumnValue(table.beginTime, value);

  _is.ColumnValue<DateTime, DateTime> endTime(DateTime? value) =>
      _is.ColumnValue(table.endTime, value);

  _is.ColumnValue<int, int> duration(int? value) =>
      _is.ColumnValue(table.duration, value);

  _is.ColumnValue<int, int> status(int value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<String, String> result(String? value) =>
      _is.ColumnValue(table.result, value);

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

class InfraJobLogTable extends _is.Table<int?> {
  InfraJobLogTable({super.tableRelation}) : super(tableName: 'infra_job_log') {
    updateTable = InfraJobLogUpdateTable(this);
    jobId = _is.ColumnInt('jobId', this);
    handlerName = _is.ColumnString('handlerName', this);
    handlerParam = _is.ColumnString('handlerParam', this);
    executeIndex = _is.ColumnInt('executeIndex', this);
    beginTime = _is.ColumnDateTime('beginTime', this);
    endTime = _is.ColumnDateTime('endTime', this);
    duration = _is.ColumnInt('duration', this);
    status = _is.ColumnInt('status', this);
    result = _is.ColumnString('result', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final InfraJobLogUpdateTable updateTable;

  late final _is.ColumnInt jobId;

  late final _is.ColumnString handlerName;

  late final _is.ColumnString handlerParam;

  late final _is.ColumnInt executeIndex;

  late final _is.ColumnDateTime beginTime;

  late final _is.ColumnDateTime endTime;

  late final _is.ColumnInt duration;

  late final _is.ColumnInt status;

  late final _is.ColumnString result;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    jobId,
    handlerName,
    handlerParam,
    executeIndex,
    beginTime,
    endTime,
    duration,
    status,
    result,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class InfraJobLogInclude extends _is.IncludeObject {
  InfraJobLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => InfraJobLog.t;
}

class InfraJobLogIncludeList extends _is.IncludeList {
  InfraJobLogIncludeList._({
    _is.WhereExpressionBuilder<InfraJobLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraJobLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => InfraJobLog.t;
}

class InfraJobLogRepository {
  const InfraJobLogRepository._();

  /// Returns a list of [InfraJobLog]s matching the given query parameters.
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
  Future<List<InfraJobLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraJobLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraJobLogTable>? orderBy,
    _is.OrderByListBuilder<InfraJobLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InfraJobLog>(
      where: where?.call(InfraJobLog.t),
      orderBy: orderBy?.call(InfraJobLog.t),
      orderByList: orderByList?.call(InfraJobLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InfraJobLog] matching the given query parameters.
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
  Future<InfraJobLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraJobLogTable>? where,
    int? offset,
    _is.OrderByBuilder<InfraJobLogTable>? orderBy,
    _is.OrderByListBuilder<InfraJobLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InfraJobLog>(
      where: where?.call(InfraJobLog.t),
      orderBy: orderBy?.call(InfraJobLog.t),
      orderByList: orderByList?.call(InfraJobLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InfraJobLog] by its [id] or null if no such row exists.
  Future<InfraJobLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InfraJobLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InfraJobLog]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraJobLog]s will have their `id` fields set.
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
  Future<List<InfraJobLog>> insert(
    _is.DatabaseSession session,
    List<InfraJobLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<InfraJobLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [InfraJobLog] and returns the inserted row.
  ///
  /// The returned [InfraJobLog] will have its `id` field set.
  Future<InfraJobLog> insertRow(
    _is.DatabaseSession session,
    InfraJobLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<InfraJobLog>(row, transaction: transaction);
  }

  /// Upserts all [InfraJobLog]s in the list and returns the resulting rows.
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
  /// The returned [InfraJobLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraJobLog>> upsert(
    _is.DatabaseSession session,
    List<InfraJobLog> rows, {
    required _is.ColumnSelections<InfraJobLogTable> conflictColumns,
    _is.ColumnSelections<InfraJobLogTable>? updateColumns,
    _is.WhereExpressionBuilder<InfraJobLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<InfraJobLog>(
      rows,
      conflictColumns: conflictColumns(InfraJobLog.t),
      updateColumns: updateColumns?.call(InfraJobLog.t),
      updateWhere: updateWhere?.call(InfraJobLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [InfraJobLog] and returns the resulting row.
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
  /// The returned [InfraJobLog] will have its `id` field set.
  Future<InfraJobLog?> upsertRow(
    _is.DatabaseSession session,
    InfraJobLog row, {
    required _is.ColumnSelections<InfraJobLogTable> conflictColumns,
    _is.ColumnSelections<InfraJobLogTable>? updateColumns,
    _is.WhereExpressionBuilder<InfraJobLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<InfraJobLog>(
      row,
      conflictColumns: conflictColumns(InfraJobLog.t),
      updateColumns: updateColumns?.call(InfraJobLog.t),
      updateWhere: updateWhere?.call(InfraJobLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [InfraJobLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraJobLog>> update(
    _is.DatabaseSession session,
    List<InfraJobLog> rows, {
    _is.ColumnSelections<InfraJobLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<InfraJobLog>(
      rows,
      columns: columns?.call(InfraJobLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [InfraJobLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraJobLog> updateRow(
    _is.DatabaseSession session,
    InfraJobLog row, {
    _is.ColumnSelections<InfraJobLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraJobLog>(
      row,
      columns: columns?.call(InfraJobLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InfraJobLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InfraJobLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InfraJobLogUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<InfraJobLog>(
      id,
      columnValues: columnValues(InfraJobLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InfraJobLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraJobLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InfraJobLogUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<InfraJobLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraJobLogTable>? orderBy,
    _is.OrderByListBuilder<InfraJobLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<InfraJobLog>(
      columnValues: columnValues(InfraJobLog.t.updateTable),
      where: where(InfraJobLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraJobLog.t),
      orderByList: orderByList?.call(InfraJobLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [InfraJobLog]s in the list and returns the deleted rows.
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
  Future<List<InfraJobLog>> delete(
    _is.DatabaseSession session,
    List<InfraJobLog> rows, {
    _is.OrderByBuilder<InfraJobLogTable>? orderBy,
    _is.OrderByListBuilder<InfraJobLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<InfraJobLog>(
      rows,
      orderBy: orderBy?.call(InfraJobLog.t),
      orderByList: orderByList?.call(InfraJobLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [InfraJobLog].
  Future<InfraJobLog> deleteRow(
    _is.DatabaseSession session,
    InfraJobLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InfraJobLog>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraJobLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InfraJobLogTable> where,
    _is.OrderByBuilder<InfraJobLogTable>? orderBy,
    _is.OrderByListBuilder<InfraJobLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<InfraJobLog>(
      where: where(InfraJobLog.t),
      orderBy: orderBy?.call(InfraJobLog.t),
      orderByList: orderByList?.call(InfraJobLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraJobLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<InfraJobLog>(
      where: where?.call(InfraJobLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InfraJobLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InfraJobLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InfraJobLog>(
      where: where(InfraJobLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
