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

/// 操作日志记录 V2 版本
abstract class SysOperateLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysOperateLog._({
    this.id,
    int? tenantId,
    required this.traceId,
    required this.userId,
    required this.userType,
    required this.type,
    required this.subType,
    required this.bizId,
    required this.action,
    required this.success,
    required this.extra,
    this.requestMethod,
    this.requestUrl,
    this.userIp,
    this.userAgent,
    this.creator,
    DateTime? createTime,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now();

  factory SysOperateLog({
    int? id,
    int? tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String type,
    required String subType,
    required int bizId,
    required String action,
    required bool success,
    required String extra,
    String? requestMethod,
    String? requestUrl,
    String? userIp,
    String? userAgent,
    String? creator,
    DateTime? createTime,
  }) = _SysOperateLogImpl;

  factory SysOperateLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysOperateLog(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      traceId: jsonSerialization['traceId'] as String,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      type: jsonSerialization['type'] as String,
      subType: jsonSerialization['subType'] as String,
      bizId: jsonSerialization['bizId'] as int,
      action: jsonSerialization['action'] as String,
      success: _is.BoolJsonExtension.fromJson(jsonSerialization['success']),
      extra: jsonSerialization['extra'] as String,
      requestMethod: jsonSerialization['requestMethod'] as String?,
      requestUrl: jsonSerialization['requestUrl'] as String?,
      userIp: jsonSerialization['userIp'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
    );
  }

  static final t = SysOperateLogTable();

  static const db = SysOperateLogRepository._();

  @override
  int? id;

  int tenantId;

  String traceId;

  int userId;

  int userType;

  String type;

  String subType;

  int bizId;

  String action;

  bool success;

  String extra;

  String? requestMethod;

  String? requestUrl;

  String? userIp;

  String? userAgent;

  String? creator;

  DateTime createTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysOperateLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysOperateLog copyWith({
    int? id,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? type,
    String? subType,
    int? bizId,
    String? action,
    bool? success,
    String? extra,
    String? requestMethod,
    String? requestUrl,
    String? userIp,
    String? userAgent,
    String? creator,
    DateTime? createTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysOperateLog',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'traceId': traceId,
      'userId': userId,
      'userType': userType,
      'type': type,
      'subType': subType,
      'bizId': bizId,
      'action': action,
      'success': success,
      'extra': extra,
      if (requestMethod != null) 'requestMethod': requestMethod,
      if (requestUrl != null) 'requestUrl': requestUrl,
      if (userIp != null) 'userIp': userIp,
      if (userAgent != null) 'userAgent': userAgent,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SysOperateLog',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'traceId': traceId,
      'userId': userId,
      'userType': userType,
      'type': type,
      'subType': subType,
      'bizId': bizId,
      'action': action,
      'success': success,
      'extra': extra,
      if (requestMethod != null) 'requestMethod': requestMethod,
      if (requestUrl != null) 'requestUrl': requestUrl,
      if (userIp != null) 'userIp': userIp,
      if (userAgent != null) 'userAgent': userAgent,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
    };
  }

  static SysOperateLogInclude include() {
    return SysOperateLogInclude._();
  }

  static SysOperateLogIncludeList includeList({
    _is.WhereExpressionBuilder<SysOperateLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysOperateLogTable>? orderBy,
    _is.OrderByListBuilder<SysOperateLogTable>? orderByList,
    SysOperateLogInclude? include,
  }) {
    return SysOperateLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysOperateLog.t),
      orderByList: orderByList?.call(SysOperateLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysOperateLogImpl extends SysOperateLog {
  _SysOperateLogImpl({
    int? id,
    int? tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String type,
    required String subType,
    required int bizId,
    required String action,
    required bool success,
    required String extra,
    String? requestMethod,
    String? requestUrl,
    String? userIp,
    String? userAgent,
    String? creator,
    DateTime? createTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         traceId: traceId,
         userId: userId,
         userType: userType,
         type: type,
         subType: subType,
         bizId: bizId,
         action: action,
         success: success,
         extra: extra,
         requestMethod: requestMethod,
         requestUrl: requestUrl,
         userIp: userIp,
         userAgent: userAgent,
         creator: creator,
         createTime: createTime,
       );

  /// Returns a shallow copy of this [SysOperateLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysOperateLog copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? type,
    String? subType,
    int? bizId,
    String? action,
    bool? success,
    String? extra,
    Object? requestMethod = _Undefined,
    Object? requestUrl = _Undefined,
    Object? userIp = _Undefined,
    Object? userAgent = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
  }) {
    return SysOperateLog(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      traceId: traceId ?? this.traceId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      bizId: bizId ?? this.bizId,
      action: action ?? this.action,
      success: success ?? this.success,
      extra: extra ?? this.extra,
      requestMethod: requestMethod is String?
          ? requestMethod
          : this.requestMethod,
      requestUrl: requestUrl is String? ? requestUrl : this.requestUrl,
      userIp: userIp is String? ? userIp : this.userIp,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
    );
  }
}

class SysOperateLogUpdateTable extends _is.UpdateTable<SysOperateLogTable> {
  SysOperateLogUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> traceId(String value) =>
      _is.ColumnValue(table.traceId, value);

  _is.ColumnValue<int, int> userId(int value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<int, int> userType(int value) =>
      _is.ColumnValue(table.userType, value);

  _is.ColumnValue<String, String> type(String value) =>
      _is.ColumnValue(table.type, value);

  _is.ColumnValue<String, String> subType(String value) =>
      _is.ColumnValue(table.subType, value);

  _is.ColumnValue<int, int> bizId(int value) =>
      _is.ColumnValue(table.bizId, value);

  _is.ColumnValue<String, String> action(String value) =>
      _is.ColumnValue(table.action, value);

  _is.ColumnValue<bool, bool> success(bool value) =>
      _is.ColumnValue(table.success, value);

  _is.ColumnValue<String, String> extra(String value) =>
      _is.ColumnValue(table.extra, value);

  _is.ColumnValue<String, String> requestMethod(String? value) =>
      _is.ColumnValue(table.requestMethod, value);

  _is.ColumnValue<String, String> requestUrl(String? value) =>
      _is.ColumnValue(table.requestUrl, value);

  _is.ColumnValue<String, String> userIp(String? value) =>
      _is.ColumnValue(table.userIp, value);

  _is.ColumnValue<String, String> userAgent(String? value) =>
      _is.ColumnValue(table.userAgent, value);

  _is.ColumnValue<String, String> creator(String? value) =>
      _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);
}

class SysOperateLogTable extends _is.Table<int?> {
  SysOperateLogTable({super.tableRelation})
    : super(tableName: 'sys_operate_log') {
    updateTable = SysOperateLogUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    traceId = _is.ColumnString('traceId', this);
    userId = _is.ColumnInt('userId', this);
    userType = _is.ColumnInt('userType', this);
    type = _is.ColumnString('type', this);
    subType = _is.ColumnString('subType', this);
    bizId = _is.ColumnInt('bizId', this);
    action = _is.ColumnString('action', this);
    success = _is.ColumnBool('success', this);
    extra = _is.ColumnString('extra', this);
    requestMethod = _is.ColumnString('requestMethod', this);
    requestUrl = _is.ColumnString('requestUrl', this);
    userIp = _is.ColumnString('userIp', this);
    userAgent = _is.ColumnString('userAgent', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
  }

  late final SysOperateLogUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString traceId;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt userType;

  late final _is.ColumnString type;

  late final _is.ColumnString subType;

  late final _is.ColumnInt bizId;

  late final _is.ColumnString action;

  late final _is.ColumnBool success;

  late final _is.ColumnString extra;

  late final _is.ColumnString requestMethod;

  late final _is.ColumnString requestUrl;

  late final _is.ColumnString userIp;

  late final _is.ColumnString userAgent;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    traceId,
    userId,
    userType,
    type,
    subType,
    bizId,
    action,
    success,
    extra,
    requestMethod,
    requestUrl,
    userIp,
    userAgent,
    creator,
    createTime,
  ];
}

class SysOperateLogInclude extends _is.IncludeObject {
  SysOperateLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysOperateLog.t;
}

class SysOperateLogIncludeList extends _is.IncludeList {
  SysOperateLogIncludeList._({
    _is.WhereExpressionBuilder<SysOperateLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysOperateLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysOperateLog.t;
}

class SysOperateLogRepository {
  const SysOperateLogRepository._();

  /// Returns a list of [SysOperateLog]s matching the given query parameters.
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
  Future<List<SysOperateLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysOperateLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysOperateLogTable>? orderBy,
    _is.OrderByListBuilder<SysOperateLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysOperateLog>(
      where: where?.call(SysOperateLog.t),
      orderBy: orderBy?.call(SysOperateLog.t),
      orderByList: orderByList?.call(SysOperateLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysOperateLog] matching the given query parameters.
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
  Future<SysOperateLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysOperateLogTable>? where,
    int? offset,
    _is.OrderByBuilder<SysOperateLogTable>? orderBy,
    _is.OrderByListBuilder<SysOperateLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysOperateLog>(
      where: where?.call(SysOperateLog.t),
      orderBy: orderBy?.call(SysOperateLog.t),
      orderByList: orderByList?.call(SysOperateLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysOperateLog] by its [id] or null if no such row exists.
  Future<SysOperateLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysOperateLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysOperateLog]s in the list and returns the inserted rows.
  ///
  /// The returned [SysOperateLog]s will have their `id` fields set.
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
  Future<List<SysOperateLog>> insert(
    _is.DatabaseSession session,
    List<SysOperateLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysOperateLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysOperateLog] and returns the inserted row.
  ///
  /// The returned [SysOperateLog] will have its `id` field set.
  Future<SysOperateLog> insertRow(
    _is.DatabaseSession session,
    SysOperateLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysOperateLog>(row, transaction: transaction);
  }

  /// Upserts all [SysOperateLog]s in the list and returns the resulting rows.
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
  /// The returned [SysOperateLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysOperateLog>> upsert(
    _is.DatabaseSession session,
    List<SysOperateLog> rows, {
    required _is.ColumnSelections<SysOperateLogTable> conflictColumns,
    _is.ColumnSelections<SysOperateLogTable>? updateColumns,
    _is.WhereExpressionBuilder<SysOperateLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysOperateLog>(
      rows,
      conflictColumns: conflictColumns(SysOperateLog.t),
      updateColumns: updateColumns?.call(SysOperateLog.t),
      updateWhere: updateWhere?.call(SysOperateLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysOperateLog] and returns the resulting row.
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
  /// The returned [SysOperateLog] will have its `id` field set.
  Future<SysOperateLog?> upsertRow(
    _is.DatabaseSession session,
    SysOperateLog row, {
    required _is.ColumnSelections<SysOperateLogTable> conflictColumns,
    _is.ColumnSelections<SysOperateLogTable>? updateColumns,
    _is.WhereExpressionBuilder<SysOperateLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysOperateLog>(
      row,
      conflictColumns: conflictColumns(SysOperateLog.t),
      updateColumns: updateColumns?.call(SysOperateLog.t),
      updateWhere: updateWhere?.call(SysOperateLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysOperateLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysOperateLog>> update(
    _is.DatabaseSession session,
    List<SysOperateLog> rows, {
    _is.ColumnSelections<SysOperateLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysOperateLog>(
      rows,
      columns: columns?.call(SysOperateLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysOperateLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysOperateLog> updateRow(
    _is.DatabaseSession session,
    SysOperateLog row, {
    _is.ColumnSelections<SysOperateLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysOperateLog>(
      row,
      columns: columns?.call(SysOperateLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysOperateLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysOperateLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysOperateLogUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysOperateLog>(
      id,
      columnValues: columnValues(SysOperateLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysOperateLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysOperateLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysOperateLogUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysOperateLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysOperateLogTable>? orderBy,
    _is.OrderByListBuilder<SysOperateLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysOperateLog>(
      columnValues: columnValues(SysOperateLog.t.updateTable),
      where: where(SysOperateLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysOperateLog.t),
      orderByList: orderByList?.call(SysOperateLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysOperateLog]s in the list and returns the deleted rows.
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
  Future<List<SysOperateLog>> delete(
    _is.DatabaseSession session,
    List<SysOperateLog> rows, {
    _is.OrderByBuilder<SysOperateLogTable>? orderBy,
    _is.OrderByListBuilder<SysOperateLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysOperateLog>(
      rows,
      orderBy: orderBy?.call(SysOperateLog.t),
      orderByList: orderByList?.call(SysOperateLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysOperateLog].
  Future<SysOperateLog> deleteRow(
    _is.DatabaseSession session,
    SysOperateLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysOperateLog>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysOperateLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysOperateLogTable> where,
    _is.OrderByBuilder<SysOperateLogTable>? orderBy,
    _is.OrderByListBuilder<SysOperateLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysOperateLog>(
      where: where(SysOperateLog.t),
      orderBy: orderBy?.call(SysOperateLog.t),
      orderByList: orderByList?.call(SysOperateLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysOperateLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysOperateLog>(
      where: where?.call(SysOperateLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysOperateLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysOperateLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysOperateLog>(
      where: where(SysOperateLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
