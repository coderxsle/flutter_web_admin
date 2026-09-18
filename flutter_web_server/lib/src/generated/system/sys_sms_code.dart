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

/// 手机验证码
abstract class SysSmsCode
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysSmsCode._({
    this.id,
    int? tenantId,
    required this.mobile,
    required this.code,
    required this.createIp,
    required this.scene,
    required this.todayIndex,
    required this.used,
    this.usedTime,
    this.usedIp,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now();

  factory SysSmsCode({
    int? id,
    int? tenantId,
    required String mobile,
    required String code,
    required String createIp,
    required int scene,
    required int todayIndex,
    required int used,
    DateTime? usedTime,
    String? usedIp,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSmsCodeImpl;

  factory SysSmsCode.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSmsCode(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      mobile: jsonSerialization['mobile'] as String,
      code: jsonSerialization['code'] as String,
      createIp: jsonSerialization['createIp'] as String,
      scene: jsonSerialization['scene'] as int,
      todayIndex: jsonSerialization['todayIndex'] as int,
      used: jsonSerialization['used'] as int,
      usedTime: jsonSerialization['usedTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['usedTime']),
      usedIp: jsonSerialization['usedIp'] as String?,
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

  static final t = SysSmsCodeTable();

  static const db = SysSmsCodeRepository._();

  @override
  int? id;

  int tenantId;

  String mobile;

  String code;

  String createIp;

  int scene;

  int todayIndex;

  int used;

  DateTime? usedTime;

  String? usedIp;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSmsCode]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysSmsCode copyWith({
    int? id,
    int? tenantId,
    String? mobile,
    String? code,
    String? createIp,
    int? scene,
    int? todayIndex,
    int? used,
    DateTime? usedTime,
    String? usedIp,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysSmsCode',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'mobile': mobile,
      'code': code,
      'createIp': createIp,
      'scene': scene,
      'todayIndex': todayIndex,
      'used': used,
      if (usedTime != null) 'usedTime': usedTime?.toJson(),
      if (usedIp != null) 'usedIp': usedIp,
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
      '__className__': 'SysSmsCode',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'mobile': mobile,
      'code': code,
      'createIp': createIp,
      'scene': scene,
      'todayIndex': todayIndex,
      'used': used,
      if (usedTime != null) 'usedTime': usedTime?.toJson(),
      if (usedIp != null) 'usedIp': usedIp,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysSmsCodeInclude include() {
    return SysSmsCodeInclude._();
  }

  static SysSmsCodeIncludeList includeList({
    _is.WhereExpressionBuilder<SysSmsCodeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSmsCodeTable>? orderBy,
    _is.OrderByListBuilder<SysSmsCodeTable>? orderByList,
    SysSmsCodeInclude? include,
  }) {
    return SysSmsCodeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSmsCode.t),
      orderByList: orderByList?.call(SysSmsCode.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysSmsCodeImpl extends SysSmsCode {
  _SysSmsCodeImpl({
    int? id,
    int? tenantId,
    required String mobile,
    required String code,
    required String createIp,
    required int scene,
    required int todayIndex,
    required int used,
    DateTime? usedTime,
    String? usedIp,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         mobile: mobile,
         code: code,
         createIp: createIp,
         scene: scene,
         todayIndex: todayIndex,
         used: used,
         usedTime: usedTime,
         usedIp: usedIp,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysSmsCode]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysSmsCode copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? mobile,
    String? code,
    String? createIp,
    int? scene,
    int? todayIndex,
    int? used,
    Object? usedTime = _Undefined,
    Object? usedIp = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSmsCode(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      mobile: mobile ?? this.mobile,
      code: code ?? this.code,
      createIp: createIp ?? this.createIp,
      scene: scene ?? this.scene,
      todayIndex: todayIndex ?? this.todayIndex,
      used: used ?? this.used,
      usedTime: usedTime is DateTime? ? usedTime : this.usedTime,
      usedIp: usedIp is String? ? usedIp : this.usedIp,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysSmsCodeUpdateTable extends _is.UpdateTable<SysSmsCodeTable> {
  SysSmsCodeUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> mobile(String value) =>
      _is.ColumnValue(table.mobile, value);

  _is.ColumnValue<String, String> code(String value) =>
      _is.ColumnValue(table.code, value);

  _is.ColumnValue<String, String> createIp(String value) =>
      _is.ColumnValue(table.createIp, value);

  _is.ColumnValue<int, int> scene(int value) =>
      _is.ColumnValue(table.scene, value);

  _is.ColumnValue<int, int> todayIndex(int value) =>
      _is.ColumnValue(table.todayIndex, value);

  _is.ColumnValue<int, int> used(int value) =>
      _is.ColumnValue(table.used, value);

  _is.ColumnValue<DateTime, DateTime> usedTime(DateTime? value) =>
      _is.ColumnValue(table.usedTime, value);

  _is.ColumnValue<String, String> usedIp(String? value) =>
      _is.ColumnValue(table.usedIp, value);

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

class SysSmsCodeTable extends _is.Table<int?> {
  SysSmsCodeTable({super.tableRelation}) : super(tableName: 'sys_sms_code') {
    updateTable = SysSmsCodeUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    mobile = _is.ColumnString('mobile', this);
    code = _is.ColumnString('code', this);
    createIp = _is.ColumnString('createIp', this);
    scene = _is.ColumnInt('scene', this);
    todayIndex = _is.ColumnInt('todayIndex', this);
    used = _is.ColumnInt('used', this);
    usedTime = _is.ColumnDateTime('usedTime', this);
    usedIp = _is.ColumnString('usedIp', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysSmsCodeUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString mobile;

  late final _is.ColumnString code;

  late final _is.ColumnString createIp;

  late final _is.ColumnInt scene;

  late final _is.ColumnInt todayIndex;

  late final _is.ColumnInt used;

  late final _is.ColumnDateTime usedTime;

  late final _is.ColumnString usedIp;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    mobile,
    code,
    createIp,
    scene,
    todayIndex,
    used,
    usedTime,
    usedIp,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysSmsCodeInclude extends _is.IncludeObject {
  SysSmsCodeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysSmsCode.t;
}

class SysSmsCodeIncludeList extends _is.IncludeList {
  SysSmsCodeIncludeList._({
    _is.WhereExpressionBuilder<SysSmsCodeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSmsCode.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysSmsCode.t;
}

class SysSmsCodeRepository {
  const SysSmsCodeRepository._();

  /// Returns a list of [SysSmsCode]s matching the given query parameters.
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
  Future<List<SysSmsCode>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSmsCodeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSmsCodeTable>? orderBy,
    _is.OrderByListBuilder<SysSmsCodeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysSmsCode>(
      where: where?.call(SysSmsCode.t),
      orderBy: orderBy?.call(SysSmsCode.t),
      orderByList: orderByList?.call(SysSmsCode.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysSmsCode] matching the given query parameters.
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
  Future<SysSmsCode?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSmsCodeTable>? where,
    int? offset,
    _is.OrderByBuilder<SysSmsCodeTable>? orderBy,
    _is.OrderByListBuilder<SysSmsCodeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysSmsCode>(
      where: where?.call(SysSmsCode.t),
      orderBy: orderBy?.call(SysSmsCode.t),
      orderByList: orderByList?.call(SysSmsCode.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysSmsCode] by its [id] or null if no such row exists.
  Future<SysSmsCode?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysSmsCode>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysSmsCode]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSmsCode]s will have their `id` fields set.
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
  Future<List<SysSmsCode>> insert(
    _is.DatabaseSession session,
    List<SysSmsCode> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysSmsCode>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysSmsCode] and returns the inserted row.
  ///
  /// The returned [SysSmsCode] will have its `id` field set.
  Future<SysSmsCode> insertRow(
    _is.DatabaseSession session,
    SysSmsCode row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSmsCode>(row, transaction: transaction);
  }

  /// Upserts all [SysSmsCode]s in the list and returns the resulting rows.
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
  /// The returned [SysSmsCode]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsCode>> upsert(
    _is.DatabaseSession session,
    List<SysSmsCode> rows, {
    required _is.ColumnSelections<SysSmsCodeTable> conflictColumns,
    _is.ColumnSelections<SysSmsCodeTable>? updateColumns,
    _is.WhereExpressionBuilder<SysSmsCodeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysSmsCode>(
      rows,
      conflictColumns: conflictColumns(SysSmsCode.t),
      updateColumns: updateColumns?.call(SysSmsCode.t),
      updateWhere: updateWhere?.call(SysSmsCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysSmsCode] and returns the resulting row.
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
  /// The returned [SysSmsCode] will have its `id` field set.
  Future<SysSmsCode?> upsertRow(
    _is.DatabaseSession session,
    SysSmsCode row, {
    required _is.ColumnSelections<SysSmsCodeTable> conflictColumns,
    _is.ColumnSelections<SysSmsCodeTable>? updateColumns,
    _is.WhereExpressionBuilder<SysSmsCodeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysSmsCode>(
      row,
      conflictColumns: conflictColumns(SysSmsCode.t),
      updateColumns: updateColumns?.call(SysSmsCode.t),
      updateWhere: updateWhere?.call(SysSmsCode.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysSmsCode]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsCode>> update(
    _is.DatabaseSession session,
    List<SysSmsCode> rows, {
    _is.ColumnSelections<SysSmsCodeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysSmsCode>(
      rows,
      columns: columns?.call(SysSmsCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysSmsCode]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSmsCode> updateRow(
    _is.DatabaseSession session,
    SysSmsCode row, {
    _is.ColumnSelections<SysSmsCodeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSmsCode>(
      row,
      columns: columns?.call(SysSmsCode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSmsCode] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysSmsCode?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysSmsCodeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysSmsCode>(
      id,
      columnValues: columnValues(SysSmsCode.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysSmsCode]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsCode>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysSmsCodeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysSmsCodeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSmsCodeTable>? orderBy,
    _is.OrderByListBuilder<SysSmsCodeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysSmsCode>(
      columnValues: columnValues(SysSmsCode.t.updateTable),
      where: where(SysSmsCode.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSmsCode.t),
      orderByList: orderByList?.call(SysSmsCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysSmsCode]s in the list and returns the deleted rows.
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
  Future<List<SysSmsCode>> delete(
    _is.DatabaseSession session,
    List<SysSmsCode> rows, {
    _is.OrderByBuilder<SysSmsCodeTable>? orderBy,
    _is.OrderByListBuilder<SysSmsCodeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysSmsCode>(
      rows,
      orderBy: orderBy?.call(SysSmsCode.t),
      orderByList: orderByList?.call(SysSmsCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysSmsCode].
  Future<SysSmsCode> deleteRow(
    _is.DatabaseSession session,
    SysSmsCode row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSmsCode>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsCode>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysSmsCodeTable> where,
    _is.OrderByBuilder<SysSmsCodeTable>? orderBy,
    _is.OrderByListBuilder<SysSmsCodeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysSmsCode>(
      where: where(SysSmsCode.t),
      orderBy: orderBy?.call(SysSmsCode.t),
      orderByList: orderByList?.call(SysSmsCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSmsCodeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysSmsCode>(
      where: where?.call(SysSmsCode.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysSmsCode] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysSmsCodeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysSmsCode>(
      where: where(SysSmsCode.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
