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

/// 用户和角色关联表
abstract class SysUserRole
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysUserRole._({
    this.id,
    int? tenantId,
    required this.userId,
    required this.roleId,
    required this.deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    this.updateTime,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now();

  factory SysUserRole({
    int? id,
    int? tenantId,
    required int userId,
    required int roleId,
    required bool deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _SysUserRoleImpl;

  factory SysUserRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysUserRole(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      userId: jsonSerialization['userId'] as int,
      roleId: jsonSerialization['roleId'] as int,
      deleted: _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
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

  static final t = SysUserRoleTable();

  static const db = SysUserRoleRepository._();

  @override
  int? id;

  int tenantId;

  int userId;

  int roleId;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime? updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysUserRole]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysUserRole copyWith({
    int? id,
    int? tenantId,
    int? userId,
    int? roleId,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysUserRole',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'roleId': roleId,
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
      '__className__': 'SysUserRole',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'roleId': roleId,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
    };
  }

  static SysUserRoleInclude include() {
    return SysUserRoleInclude._();
  }

  static SysUserRoleIncludeList includeList({
    _is.WhereExpressionBuilder<SysUserRoleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysUserRoleTable>? orderBy,
    _is.OrderByListBuilder<SysUserRoleTable>? orderByList,
    SysUserRoleInclude? include,
  }) {
    return SysUserRoleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysUserRole.t),
      orderByList: orderByList?.call(SysUserRole.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysUserRoleImpl extends SysUserRole {
  _SysUserRoleImpl({
    int? id,
    int? tenantId,
    required int userId,
    required int roleId,
    required bool deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         userId: userId,
         roleId: roleId,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysUserRole]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysUserRole copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    int? roleId,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    Object? updateTime = _Undefined,
  }) {
    return SysUserRole(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      roleId: roleId ?? this.roleId,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime is DateTime? ? updateTime : this.updateTime,
    );
  }
}

class SysUserRoleUpdateTable extends _is.UpdateTable<SysUserRoleTable> {
  SysUserRoleUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> userId(int value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<int, int> roleId(int value) =>
      _is.ColumnValue(table.roleId, value);

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

class SysUserRoleTable extends _is.Table<int?> {
  SysUserRoleTable({super.tableRelation}) : super(tableName: 'sys_user_role') {
    updateTable = SysUserRoleUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    userId = _is.ColumnInt('userId', this);
    roleId = _is.ColumnInt('roleId', this);
    deleted = _is.ColumnBool('deleted', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
  }

  late final SysUserRoleUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt roleId;

  late final _is.ColumnBool deleted;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    userId,
    roleId,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class SysUserRoleInclude extends _is.IncludeObject {
  SysUserRoleInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysUserRole.t;
}

class SysUserRoleIncludeList extends _is.IncludeList {
  SysUserRoleIncludeList._({
    _is.WhereExpressionBuilder<SysUserRoleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysUserRole.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysUserRole.t;
}

class SysUserRoleRepository {
  const SysUserRoleRepository._();

  /// Returns a list of [SysUserRole]s matching the given query parameters.
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
  Future<List<SysUserRole>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysUserRoleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysUserRoleTable>? orderBy,
    _is.OrderByListBuilder<SysUserRoleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysUserRole>(
      where: where?.call(SysUserRole.t),
      orderBy: orderBy?.call(SysUserRole.t),
      orderByList: orderByList?.call(SysUserRole.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysUserRole] matching the given query parameters.
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
  Future<SysUserRole?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysUserRoleTable>? where,
    int? offset,
    _is.OrderByBuilder<SysUserRoleTable>? orderBy,
    _is.OrderByListBuilder<SysUserRoleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysUserRole>(
      where: where?.call(SysUserRole.t),
      orderBy: orderBy?.call(SysUserRole.t),
      orderByList: orderByList?.call(SysUserRole.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysUserRole] by its [id] or null if no such row exists.
  Future<SysUserRole?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysUserRole>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysUserRole]s in the list and returns the inserted rows.
  ///
  /// The returned [SysUserRole]s will have their `id` fields set.
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
  Future<List<SysUserRole>> insert(
    _is.DatabaseSession session,
    List<SysUserRole> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysUserRole>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysUserRole] and returns the inserted row.
  ///
  /// The returned [SysUserRole] will have its `id` field set.
  Future<SysUserRole> insertRow(
    _is.DatabaseSession session,
    SysUserRole row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysUserRole>(row, transaction: transaction);
  }

  /// Upserts all [SysUserRole]s in the list and returns the resulting rows.
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
  /// The returned [SysUserRole]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysUserRole>> upsert(
    _is.DatabaseSession session,
    List<SysUserRole> rows, {
    required _is.ColumnSelections<SysUserRoleTable> conflictColumns,
    _is.ColumnSelections<SysUserRoleTable>? updateColumns,
    _is.WhereExpressionBuilder<SysUserRoleTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysUserRole>(
      rows,
      conflictColumns: conflictColumns(SysUserRole.t),
      updateColumns: updateColumns?.call(SysUserRole.t),
      updateWhere: updateWhere?.call(SysUserRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysUserRole] and returns the resulting row.
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
  /// The returned [SysUserRole] will have its `id` field set.
  Future<SysUserRole?> upsertRow(
    _is.DatabaseSession session,
    SysUserRole row, {
    required _is.ColumnSelections<SysUserRoleTable> conflictColumns,
    _is.ColumnSelections<SysUserRoleTable>? updateColumns,
    _is.WhereExpressionBuilder<SysUserRoleTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysUserRole>(
      row,
      conflictColumns: conflictColumns(SysUserRole.t),
      updateColumns: updateColumns?.call(SysUserRole.t),
      updateWhere: updateWhere?.call(SysUserRole.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysUserRole]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysUserRole>> update(
    _is.DatabaseSession session,
    List<SysUserRole> rows, {
    _is.ColumnSelections<SysUserRoleTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysUserRole>(
      rows,
      columns: columns?.call(SysUserRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysUserRole]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysUserRole> updateRow(
    _is.DatabaseSession session,
    SysUserRole row, {
    _is.ColumnSelections<SysUserRoleTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysUserRole>(
      row,
      columns: columns?.call(SysUserRole.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysUserRole] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysUserRole?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysUserRoleUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysUserRole>(
      id,
      columnValues: columnValues(SysUserRole.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysUserRole]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysUserRole>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysUserRoleUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysUserRoleTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysUserRoleTable>? orderBy,
    _is.OrderByListBuilder<SysUserRoleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysUserRole>(
      columnValues: columnValues(SysUserRole.t.updateTable),
      where: where(SysUserRole.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysUserRole.t),
      orderByList: orderByList?.call(SysUserRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysUserRole]s in the list and returns the deleted rows.
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
  Future<List<SysUserRole>> delete(
    _is.DatabaseSession session,
    List<SysUserRole> rows, {
    _is.OrderByBuilder<SysUserRoleTable>? orderBy,
    _is.OrderByListBuilder<SysUserRoleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysUserRole>(
      rows,
      orderBy: orderBy?.call(SysUserRole.t),
      orderByList: orderByList?.call(SysUserRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysUserRole].
  Future<SysUserRole> deleteRow(
    _is.DatabaseSession session,
    SysUserRole row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysUserRole>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysUserRole>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysUserRoleTable> where,
    _is.OrderByBuilder<SysUserRoleTable>? orderBy,
    _is.OrderByListBuilder<SysUserRoleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysUserRole>(
      where: where(SysUserRole.t),
      orderBy: orderBy?.call(SysUserRole.t),
      orderByList: orderByList?.call(SysUserRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysUserRoleTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysUserRole>(
      where: where?.call(SysUserRole.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysUserRole] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysUserRoleTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysUserRole>(
      where: where(SysUserRole.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
