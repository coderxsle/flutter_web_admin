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

/// 患者档案访问审计日志；不得在日志中保存患者身份证号或病史内容。
abstract class ZhongyiPatientAccessLog implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiPatientAccessLog._({
    this.id,
    int? tenantId,
    this.patientId,
    required this.action,
    this.actorId,
    DateTime? accessTime,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       accessTime = accessTime ?? DateTime.now(),
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiPatientAccessLog({
    int? id,
    int? tenantId,
    int? patientId,
    required String action,
    int? actorId,
    DateTime? accessTime,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiPatientAccessLogImpl;

  factory ZhongyiPatientAccessLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiPatientAccessLog(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      patientId: jsonSerialization['patientId'] as int?,
      action: jsonSerialization['action'] as String,
      actorId: jsonSerialization['actorId'] as int?,
      accessTime: jsonSerialization['accessTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['accessTime']),
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

  static final t = ZhongyiPatientAccessLogTable();

  static const db = ZhongyiPatientAccessLogRepository._();

  @override
  int? id;

  int tenantId;

  int? patientId;

  String action;

  int? actorId;

  DateTime accessTime;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiPatientAccessLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiPatientAccessLog copyWith({
    int? id,
    int? tenantId,
    int? patientId,
    String? action,
    int? actorId,
    DateTime? accessTime,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiPatientAccessLog',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (patientId != null) 'patientId': patientId,
      'action': action,
      if (actorId != null) 'actorId': actorId,
      'accessTime': accessTime.toJson(),
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ZhongyiPatientAccessLog',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (patientId != null) 'patientId': patientId,
      'action': action,
      if (actorId != null) 'actorId': actorId,
      'accessTime': accessTime.toJson(),
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiPatientAccessLogInclude include() {
    return ZhongyiPatientAccessLogInclude._();
  }

  static ZhongyiPatientAccessLogIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiPatientAccessLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPatientAccessLogTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPatientAccessLogTable>? orderByList,
    ZhongyiPatientAccessLogInclude? include,
  }) {
    return ZhongyiPatientAccessLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiPatientAccessLog.t),
      orderByList: orderByList?.call(ZhongyiPatientAccessLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiPatientAccessLogImpl extends ZhongyiPatientAccessLog {
  _ZhongyiPatientAccessLogImpl({
    int? id,
    int? tenantId,
    int? patientId,
    required String action,
    int? actorId,
    DateTime? accessTime,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         patientId: patientId,
         action: action,
         actorId: actorId,
         accessTime: accessTime,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiPatientAccessLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiPatientAccessLog copyWith({
    Object? id = _Undefined,
    int? tenantId,
    Object? patientId = _Undefined,
    String? action,
    Object? actorId = _Undefined,
    DateTime? accessTime,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiPatientAccessLog(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      patientId: patientId is int? ? patientId : this.patientId,
      action: action ?? this.action,
      actorId: actorId is int? ? actorId : this.actorId,
      accessTime: accessTime ?? this.accessTime,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiPatientAccessLogUpdateTable extends _is.UpdateTable<ZhongyiPatientAccessLogTable> {
  ZhongyiPatientAccessLogUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> patientId(int? value) => _is.ColumnValue(table.patientId, value);

  _is.ColumnValue<String, String> action(String value) => _is.ColumnValue(table.action, value);

  _is.ColumnValue<int, int> actorId(int? value) => _is.ColumnValue(table.actorId, value);

  _is.ColumnValue<DateTime, DateTime> accessTime(DateTime value) => _is.ColumnValue(table.accessTime, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiPatientAccessLogTable extends _is.Table<int?> {
  ZhongyiPatientAccessLogTable({super.tableRelation}) : super(tableName: 'zhongyi_patient_access_log') {
    updateTable = ZhongyiPatientAccessLogUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    patientId = _is.ColumnInt('patientId', this);
    action = _is.ColumnString('action', this);
    actorId = _is.ColumnInt('actorId', this);
    accessTime = _is.ColumnDateTime('accessTime', this, hasDefault: true);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiPatientAccessLogUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnInt patientId;

  late final _is.ColumnString action;

  late final _is.ColumnInt actorId;

  late final _is.ColumnDateTime accessTime;

  late final _is.ColumnBool deleted;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    patientId,
    action,
    actorId,
    accessTime,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiPatientAccessLogInclude extends _is.IncludeObject {
  ZhongyiPatientAccessLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiPatientAccessLog.t;
}

class ZhongyiPatientAccessLogIncludeList extends _is.IncludeList {
  ZhongyiPatientAccessLogIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiPatientAccessLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiPatientAccessLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiPatientAccessLog.t;
}

class ZhongyiPatientAccessLogRepository {
  const ZhongyiPatientAccessLogRepository._();

  /// Returns a list of [ZhongyiPatientAccessLog]s matching the given query parameters.
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
  Future<List<ZhongyiPatientAccessLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPatientAccessLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPatientAccessLogTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPatientAccessLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiPatientAccessLog>(
      where: where?.call(ZhongyiPatientAccessLog.t),
      orderBy: orderBy?.call(ZhongyiPatientAccessLog.t),
      orderByList: orderByList?.call(ZhongyiPatientAccessLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiPatientAccessLog] matching the given query parameters.
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
  Future<ZhongyiPatientAccessLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPatientAccessLogTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiPatientAccessLogTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPatientAccessLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiPatientAccessLog>(
      where: where?.call(ZhongyiPatientAccessLog.t),
      orderBy: orderBy?.call(ZhongyiPatientAccessLog.t),
      orderByList: orderByList?.call(ZhongyiPatientAccessLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiPatientAccessLog] by its [id] or null if no such row exists.
  Future<ZhongyiPatientAccessLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiPatientAccessLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiPatientAccessLog]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiPatientAccessLog]s will have their `id` fields set.
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
  Future<List<ZhongyiPatientAccessLog>> insert(
    _is.DatabaseSession session,
    List<ZhongyiPatientAccessLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiPatientAccessLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiPatientAccessLog] and returns the inserted row.
  ///
  /// The returned [ZhongyiPatientAccessLog] will have its `id` field set.
  Future<ZhongyiPatientAccessLog> insertRow(
    _is.DatabaseSession session,
    ZhongyiPatientAccessLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiPatientAccessLog>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiPatientAccessLog]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiPatientAccessLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPatientAccessLog>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiPatientAccessLog> rows, {
    required _is.ColumnSelections<ZhongyiPatientAccessLogTable> conflictColumns,
    _is.ColumnSelections<ZhongyiPatientAccessLogTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiPatientAccessLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiPatientAccessLog>(
      rows,
      conflictColumns: conflictColumns(ZhongyiPatientAccessLog.t),
      updateColumns: updateColumns?.call(ZhongyiPatientAccessLog.t),
      updateWhere: updateWhere?.call(ZhongyiPatientAccessLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiPatientAccessLog] and returns the resulting row.
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
  /// The returned [ZhongyiPatientAccessLog] will have its `id` field set.
  Future<ZhongyiPatientAccessLog?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiPatientAccessLog row, {
    required _is.ColumnSelections<ZhongyiPatientAccessLogTable> conflictColumns,
    _is.ColumnSelections<ZhongyiPatientAccessLogTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiPatientAccessLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiPatientAccessLog>(
      row,
      conflictColumns: conflictColumns(ZhongyiPatientAccessLog.t),
      updateColumns: updateColumns?.call(ZhongyiPatientAccessLog.t),
      updateWhere: updateWhere?.call(ZhongyiPatientAccessLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiPatientAccessLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPatientAccessLog>> update(
    _is.DatabaseSession session,
    List<ZhongyiPatientAccessLog> rows, {
    _is.ColumnSelections<ZhongyiPatientAccessLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiPatientAccessLog>(
      rows,
      columns: columns?.call(ZhongyiPatientAccessLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiPatientAccessLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiPatientAccessLog> updateRow(
    _is.DatabaseSession session,
    ZhongyiPatientAccessLog row, {
    _is.ColumnSelections<ZhongyiPatientAccessLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiPatientAccessLog>(
      row,
      columns: columns?.call(ZhongyiPatientAccessLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ZhongyiPatientAccessLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiPatientAccessLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiPatientAccessLogUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiPatientAccessLog>(
      id,
      columnValues: columnValues(ZhongyiPatientAccessLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiPatientAccessLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPatientAccessLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiPatientAccessLogUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiPatientAccessLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPatientAccessLogTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPatientAccessLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiPatientAccessLog>(
      columnValues: columnValues(ZhongyiPatientAccessLog.t.updateTable),
      where: where(ZhongyiPatientAccessLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiPatientAccessLog.t),
      orderByList: orderByList?.call(ZhongyiPatientAccessLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiPatientAccessLog]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiPatientAccessLog>> delete(
    _is.DatabaseSession session,
    List<ZhongyiPatientAccessLog> rows, {
    _is.OrderByBuilder<ZhongyiPatientAccessLogTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPatientAccessLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiPatientAccessLog>(
      rows,
      orderBy: orderBy?.call(ZhongyiPatientAccessLog.t),
      orderByList: orderByList?.call(ZhongyiPatientAccessLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiPatientAccessLog].
  Future<ZhongyiPatientAccessLog> deleteRow(
    _is.DatabaseSession session,
    ZhongyiPatientAccessLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiPatientAccessLog>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPatientAccessLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiPatientAccessLogTable> where,
    _is.OrderByBuilder<ZhongyiPatientAccessLogTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPatientAccessLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiPatientAccessLog>(
      where: where(ZhongyiPatientAccessLog.t),
      orderBy: orderBy?.call(ZhongyiPatientAccessLog.t),
      orderByList: orderByList?.call(ZhongyiPatientAccessLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPatientAccessLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiPatientAccessLog>(
      where: where?.call(ZhongyiPatientAccessLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ZhongyiPatientAccessLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiPatientAccessLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiPatientAccessLog>(
      where: where(ZhongyiPatientAccessLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
