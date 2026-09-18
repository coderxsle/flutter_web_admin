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

/// 用户岗位表
abstract class SysUserPost
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysUserPost._({
    this.id,
    int? tenantId,
    required this.userId,
    required this.postId,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now();

  factory SysUserPost({
    int? id,
    int? tenantId,
    required int userId,
    required int postId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysUserPostImpl;

  factory SysUserPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysUserPost(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      userId: jsonSerialization['userId'] as int,
      postId: jsonSerialization['postId'] as int,
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

  static final t = SysUserPostTable();

  static const db = SysUserPostRepository._();

  @override
  int? id;

  int tenantId;

  int userId;

  int postId;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysUserPost]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysUserPost copyWith({
    int? id,
    int? tenantId,
    int? userId,
    int? postId,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysUserPost',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'postId': postId,
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
      '__className__': 'SysUserPost',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'postId': postId,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysUserPostInclude include() {
    return SysUserPostInclude._();
  }

  static SysUserPostIncludeList includeList({
    _is.WhereExpressionBuilder<SysUserPostTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysUserPostTable>? orderBy,
    _is.OrderByListBuilder<SysUserPostTable>? orderByList,
    SysUserPostInclude? include,
  }) {
    return SysUserPostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysUserPost.t),
      orderByList: orderByList?.call(SysUserPost.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysUserPostImpl extends SysUserPost {
  _SysUserPostImpl({
    int? id,
    int? tenantId,
    required int userId,
    required int postId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         userId: userId,
         postId: postId,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysUserPost]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysUserPost copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    int? postId,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysUserPost(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysUserPostUpdateTable extends _is.UpdateTable<SysUserPostTable> {
  SysUserPostUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> userId(int value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<int, int> postId(int value) =>
      _is.ColumnValue(table.postId, value);

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

class SysUserPostTable extends _is.Table<int?> {
  SysUserPostTable({super.tableRelation}) : super(tableName: 'sys_user_post') {
    updateTable = SysUserPostUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    userId = _is.ColumnInt('userId', this);
    postId = _is.ColumnInt('postId', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysUserPostUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt postId;

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
    postId,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysUserPostInclude extends _is.IncludeObject {
  SysUserPostInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysUserPost.t;
}

class SysUserPostIncludeList extends _is.IncludeList {
  SysUserPostIncludeList._({
    _is.WhereExpressionBuilder<SysUserPostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysUserPost.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysUserPost.t;
}

class SysUserPostRepository {
  const SysUserPostRepository._();

  /// Returns a list of [SysUserPost]s matching the given query parameters.
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
  Future<List<SysUserPost>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysUserPostTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysUserPostTable>? orderBy,
    _is.OrderByListBuilder<SysUserPostTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysUserPost>(
      where: where?.call(SysUserPost.t),
      orderBy: orderBy?.call(SysUserPost.t),
      orderByList: orderByList?.call(SysUserPost.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysUserPost] matching the given query parameters.
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
  Future<SysUserPost?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysUserPostTable>? where,
    int? offset,
    _is.OrderByBuilder<SysUserPostTable>? orderBy,
    _is.OrderByListBuilder<SysUserPostTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysUserPost>(
      where: where?.call(SysUserPost.t),
      orderBy: orderBy?.call(SysUserPost.t),
      orderByList: orderByList?.call(SysUserPost.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysUserPost] by its [id] or null if no such row exists.
  Future<SysUserPost?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysUserPost>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysUserPost]s in the list and returns the inserted rows.
  ///
  /// The returned [SysUserPost]s will have their `id` fields set.
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
  Future<List<SysUserPost>> insert(
    _is.DatabaseSession session,
    List<SysUserPost> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysUserPost>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysUserPost] and returns the inserted row.
  ///
  /// The returned [SysUserPost] will have its `id` field set.
  Future<SysUserPost> insertRow(
    _is.DatabaseSession session,
    SysUserPost row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysUserPost>(row, transaction: transaction);
  }

  /// Upserts all [SysUserPost]s in the list and returns the resulting rows.
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
  /// The returned [SysUserPost]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysUserPost>> upsert(
    _is.DatabaseSession session,
    List<SysUserPost> rows, {
    required _is.ColumnSelections<SysUserPostTable> conflictColumns,
    _is.ColumnSelections<SysUserPostTable>? updateColumns,
    _is.WhereExpressionBuilder<SysUserPostTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysUserPost>(
      rows,
      conflictColumns: conflictColumns(SysUserPost.t),
      updateColumns: updateColumns?.call(SysUserPost.t),
      updateWhere: updateWhere?.call(SysUserPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysUserPost] and returns the resulting row.
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
  /// The returned [SysUserPost] will have its `id` field set.
  Future<SysUserPost?> upsertRow(
    _is.DatabaseSession session,
    SysUserPost row, {
    required _is.ColumnSelections<SysUserPostTable> conflictColumns,
    _is.ColumnSelections<SysUserPostTable>? updateColumns,
    _is.WhereExpressionBuilder<SysUserPostTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysUserPost>(
      row,
      conflictColumns: conflictColumns(SysUserPost.t),
      updateColumns: updateColumns?.call(SysUserPost.t),
      updateWhere: updateWhere?.call(SysUserPost.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysUserPost]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysUserPost>> update(
    _is.DatabaseSession session,
    List<SysUserPost> rows, {
    _is.ColumnSelections<SysUserPostTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysUserPost>(
      rows,
      columns: columns?.call(SysUserPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysUserPost]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysUserPost> updateRow(
    _is.DatabaseSession session,
    SysUserPost row, {
    _is.ColumnSelections<SysUserPostTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysUserPost>(
      row,
      columns: columns?.call(SysUserPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysUserPost] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysUserPost?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysUserPostUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysUserPost>(
      id,
      columnValues: columnValues(SysUserPost.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysUserPost]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysUserPost>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysUserPostUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysUserPostTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysUserPostTable>? orderBy,
    _is.OrderByListBuilder<SysUserPostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysUserPost>(
      columnValues: columnValues(SysUserPost.t.updateTable),
      where: where(SysUserPost.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysUserPost.t),
      orderByList: orderByList?.call(SysUserPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysUserPost]s in the list and returns the deleted rows.
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
  Future<List<SysUserPost>> delete(
    _is.DatabaseSession session,
    List<SysUserPost> rows, {
    _is.OrderByBuilder<SysUserPostTable>? orderBy,
    _is.OrderByListBuilder<SysUserPostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysUserPost>(
      rows,
      orderBy: orderBy?.call(SysUserPost.t),
      orderByList: orderByList?.call(SysUserPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysUserPost].
  Future<SysUserPost> deleteRow(
    _is.DatabaseSession session,
    SysUserPost row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysUserPost>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysUserPost>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysUserPostTable> where,
    _is.OrderByBuilder<SysUserPostTable>? orderBy,
    _is.OrderByListBuilder<SysUserPostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysUserPost>(
      where: where(SysUserPost.t),
      orderBy: orderBy?.call(SysUserPost.t),
      orderByList: orderByList?.call(SysUserPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysUserPostTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysUserPost>(
      where: where?.call(SysUserPost.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysUserPost] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysUserPostTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysUserPost>(
      where: where(SysUserPost.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
