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

/// 社交绑定表
abstract class SysSocialUserBind
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysSocialUserBind._({
    this.id,
    int? tenantId,
    required this.userId,
    required this.userType,
    required this.socialType,
    required this.socialUserId,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now();

  factory SysSocialUserBind({
    int? id,
    int? tenantId,
    required int userId,
    required int userType,
    required int socialType,
    required int socialUserId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSocialUserBindImpl;

  factory SysSocialUserBind.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSocialUserBind(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      socialType: jsonSerialization['socialType'] as int,
      socialUserId: jsonSerialization['socialUserId'] as int,
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

  static final t = SysSocialUserBindTable();

  static const db = SysSocialUserBindRepository._();

  @override
  int? id;

  int tenantId;

  int userId;

  int userType;

  int socialType;

  int socialUserId;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSocialUserBind]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysSocialUserBind copyWith({
    int? id,
    int? tenantId,
    int? userId,
    int? userType,
    int? socialType,
    int? socialUserId,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysSocialUserBind',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'userType': userType,
      'socialType': socialType,
      'socialUserId': socialUserId,
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
      '__className__': 'SysSocialUserBind',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'userType': userType,
      'socialType': socialType,
      'socialUserId': socialUserId,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysSocialUserBindInclude include() {
    return SysSocialUserBindInclude._();
  }

  static SysSocialUserBindIncludeList includeList({
    _is.WhereExpressionBuilder<SysSocialUserBindTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSocialUserBindTable>? orderBy,
    _is.OrderByListBuilder<SysSocialUserBindTable>? orderByList,
    SysSocialUserBindInclude? include,
  }) {
    return SysSocialUserBindIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSocialUserBind.t),
      orderByList: orderByList?.call(SysSocialUserBind.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysSocialUserBindImpl extends SysSocialUserBind {
  _SysSocialUserBindImpl({
    int? id,
    int? tenantId,
    required int userId,
    required int userType,
    required int socialType,
    required int socialUserId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         userId: userId,
         userType: userType,
         socialType: socialType,
         socialUserId: socialUserId,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysSocialUserBind]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysSocialUserBind copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    int? userType,
    int? socialType,
    int? socialUserId,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSocialUserBind(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      socialType: socialType ?? this.socialType,
      socialUserId: socialUserId ?? this.socialUserId,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysSocialUserBindUpdateTable
    extends _is.UpdateTable<SysSocialUserBindTable> {
  SysSocialUserBindUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> userId(int value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<int, int> userType(int value) =>
      _is.ColumnValue(table.userType, value);

  _is.ColumnValue<int, int> socialType(int value) =>
      _is.ColumnValue(table.socialType, value);

  _is.ColumnValue<int, int> socialUserId(int value) =>
      _is.ColumnValue(table.socialUserId, value);

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

class SysSocialUserBindTable extends _is.Table<int?> {
  SysSocialUserBindTable({super.tableRelation})
    : super(tableName: 'sys_social_user_bind') {
    updateTable = SysSocialUserBindUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    userId = _is.ColumnInt('userId', this);
    userType = _is.ColumnInt('userType', this);
    socialType = _is.ColumnInt('socialType', this);
    socialUserId = _is.ColumnInt('socialUserId', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysSocialUserBindUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt userType;

  late final _is.ColumnInt socialType;

  late final _is.ColumnInt socialUserId;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    userId,
    userType,
    socialType,
    socialUserId,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysSocialUserBindInclude extends _is.IncludeObject {
  SysSocialUserBindInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysSocialUserBind.t;
}

class SysSocialUserBindIncludeList extends _is.IncludeList {
  SysSocialUserBindIncludeList._({
    _is.WhereExpressionBuilder<SysSocialUserBindTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSocialUserBind.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysSocialUserBind.t;
}

class SysSocialUserBindRepository {
  const SysSocialUserBindRepository._();

  /// Returns a list of [SysSocialUserBind]s matching the given query parameters.
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
  Future<List<SysSocialUserBind>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSocialUserBindTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSocialUserBindTable>? orderBy,
    _is.OrderByListBuilder<SysSocialUserBindTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysSocialUserBind>(
      where: where?.call(SysSocialUserBind.t),
      orderBy: orderBy?.call(SysSocialUserBind.t),
      orderByList: orderByList?.call(SysSocialUserBind.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysSocialUserBind] matching the given query parameters.
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
  Future<SysSocialUserBind?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSocialUserBindTable>? where,
    int? offset,
    _is.OrderByBuilder<SysSocialUserBindTable>? orderBy,
    _is.OrderByListBuilder<SysSocialUserBindTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysSocialUserBind>(
      where: where?.call(SysSocialUserBind.t),
      orderBy: orderBy?.call(SysSocialUserBind.t),
      orderByList: orderByList?.call(SysSocialUserBind.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysSocialUserBind] by its [id] or null if no such row exists.
  Future<SysSocialUserBind?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysSocialUserBind>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysSocialUserBind]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSocialUserBind]s will have their `id` fields set.
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
  Future<List<SysSocialUserBind>> insert(
    _is.DatabaseSession session,
    List<SysSocialUserBind> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysSocialUserBind>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysSocialUserBind] and returns the inserted row.
  ///
  /// The returned [SysSocialUserBind] will have its `id` field set.
  Future<SysSocialUserBind> insertRow(
    _is.DatabaseSession session,
    SysSocialUserBind row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSocialUserBind>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SysSocialUserBind]s in the list and returns the resulting rows.
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
  /// The returned [SysSocialUserBind]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSocialUserBind>> upsert(
    _is.DatabaseSession session,
    List<SysSocialUserBind> rows, {
    required _is.ColumnSelections<SysSocialUserBindTable> conflictColumns,
    _is.ColumnSelections<SysSocialUserBindTable>? updateColumns,
    _is.WhereExpressionBuilder<SysSocialUserBindTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysSocialUserBind>(
      rows,
      conflictColumns: conflictColumns(SysSocialUserBind.t),
      updateColumns: updateColumns?.call(SysSocialUserBind.t),
      updateWhere: updateWhere?.call(SysSocialUserBind.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysSocialUserBind] and returns the resulting row.
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
  /// The returned [SysSocialUserBind] will have its `id` field set.
  Future<SysSocialUserBind?> upsertRow(
    _is.DatabaseSession session,
    SysSocialUserBind row, {
    required _is.ColumnSelections<SysSocialUserBindTable> conflictColumns,
    _is.ColumnSelections<SysSocialUserBindTable>? updateColumns,
    _is.WhereExpressionBuilder<SysSocialUserBindTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysSocialUserBind>(
      row,
      conflictColumns: conflictColumns(SysSocialUserBind.t),
      updateColumns: updateColumns?.call(SysSocialUserBind.t),
      updateWhere: updateWhere?.call(SysSocialUserBind.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysSocialUserBind]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSocialUserBind>> update(
    _is.DatabaseSession session,
    List<SysSocialUserBind> rows, {
    _is.ColumnSelections<SysSocialUserBindTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysSocialUserBind>(
      rows,
      columns: columns?.call(SysSocialUserBind.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysSocialUserBind]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSocialUserBind> updateRow(
    _is.DatabaseSession session,
    SysSocialUserBind row, {
    _is.ColumnSelections<SysSocialUserBindTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSocialUserBind>(
      row,
      columns: columns?.call(SysSocialUserBind.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSocialUserBind] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysSocialUserBind?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysSocialUserBindUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysSocialUserBind>(
      id,
      columnValues: columnValues(SysSocialUserBind.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysSocialUserBind]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSocialUserBind>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysSocialUserBindUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SysSocialUserBindTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSocialUserBindTable>? orderBy,
    _is.OrderByListBuilder<SysSocialUserBindTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysSocialUserBind>(
      columnValues: columnValues(SysSocialUserBind.t.updateTable),
      where: where(SysSocialUserBind.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSocialUserBind.t),
      orderByList: orderByList?.call(SysSocialUserBind.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysSocialUserBind]s in the list and returns the deleted rows.
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
  Future<List<SysSocialUserBind>> delete(
    _is.DatabaseSession session,
    List<SysSocialUserBind> rows, {
    _is.OrderByBuilder<SysSocialUserBindTable>? orderBy,
    _is.OrderByListBuilder<SysSocialUserBindTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysSocialUserBind>(
      rows,
      orderBy: orderBy?.call(SysSocialUserBind.t),
      orderByList: orderByList?.call(SysSocialUserBind.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysSocialUserBind].
  Future<SysSocialUserBind> deleteRow(
    _is.DatabaseSession session,
    SysSocialUserBind row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSocialUserBind>(
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
  Future<List<SysSocialUserBind>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysSocialUserBindTable> where,
    _is.OrderByBuilder<SysSocialUserBindTable>? orderBy,
    _is.OrderByListBuilder<SysSocialUserBindTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysSocialUserBind>(
      where: where(SysSocialUserBind.t),
      orderBy: orderBy?.call(SysSocialUserBind.t),
      orderByList: orderByList?.call(SysSocialUserBind.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSocialUserBindTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysSocialUserBind>(
      where: where?.call(SysSocialUserBind.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysSocialUserBind] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysSocialUserBindTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysSocialUserBind>(
      where: where(SysSocialUserBind.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
