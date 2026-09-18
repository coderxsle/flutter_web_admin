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

/// 岗位信息表
abstract class SysPost
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysPost._({
    this.id,
    int? tenantId,
    required this.code,
    required this.name,
    required this.sort,
    required this.status,
    this.description,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now();

  factory SysPost({
    int? id,
    int? tenantId,
    required String code,
    required String name,
    required int sort,
    required int status,
    String? description,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysPostImpl;

  factory SysPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysPost(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      sort: jsonSerialization['sort'] as int,
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

  static final t = SysPostTable();

  static const db = SysPostRepository._();

  @override
  int? id;

  int tenantId;

  String code;

  String name;

  int sort;

  int status;

  String? description;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysPost]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysPost copyWith({
    int? id,
    int? tenantId,
    String? code,
    String? name,
    int? sort,
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
      '__className__': 'SysPost',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'code': code,
      'name': name,
      'sort': sort,
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
      '__className__': 'SysPost',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'code': code,
      'name': name,
      'sort': sort,
      'status': status,
      if (description != null) 'description': description,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysPostInclude include() {
    return SysPostInclude._();
  }

  static SysPostIncludeList includeList({
    _is.WhereExpressionBuilder<SysPostTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysPostTable>? orderBy,
    _is.OrderByListBuilder<SysPostTable>? orderByList,
    SysPostInclude? include,
  }) {
    return SysPostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysPost.t),
      orderByList: orderByList?.call(SysPost.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysPostImpl extends SysPost {
  _SysPostImpl({
    int? id,
    int? tenantId,
    required String code,
    required String name,
    required int sort,
    required int status,
    String? description,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         code: code,
         name: name,
         sort: sort,
         status: status,
         description: description,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysPost]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysPost copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? code,
    String? name,
    int? sort,
    int? status,
    Object? description = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysPost(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      code: code ?? this.code,
      name: name ?? this.name,
      sort: sort ?? this.sort,
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

class SysPostUpdateTable extends _is.UpdateTable<SysPostTable> {
  SysPostUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> code(String value) =>
      _is.ColumnValue(table.code, value);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<int, int> sort(int value) =>
      _is.ColumnValue(table.sort, value);

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

class SysPostTable extends _is.Table<int?> {
  SysPostTable({super.tableRelation}) : super(tableName: 'sys_post') {
    updateTable = SysPostUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    code = _is.ColumnString('code', this);
    name = _is.ColumnString('name', this);
    sort = _is.ColumnInt('sort', this);
    status = _is.ColumnInt('status', this);
    description = _is.ColumnString('description', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysPostUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString code;

  late final _is.ColumnString name;

  late final _is.ColumnInt sort;

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
    tenantId,
    code,
    name,
    sort,
    status,
    description,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysPostInclude extends _is.IncludeObject {
  SysPostInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysPost.t;
}

class SysPostIncludeList extends _is.IncludeList {
  SysPostIncludeList._({
    _is.WhereExpressionBuilder<SysPostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysPost.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysPost.t;
}

class SysPostRepository {
  const SysPostRepository._();

  /// Returns a list of [SysPost]s matching the given query parameters.
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
  Future<List<SysPost>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysPostTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysPostTable>? orderBy,
    _is.OrderByListBuilder<SysPostTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysPost>(
      where: where?.call(SysPost.t),
      orderBy: orderBy?.call(SysPost.t),
      orderByList: orderByList?.call(SysPost.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysPost] matching the given query parameters.
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
  Future<SysPost?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysPostTable>? where,
    int? offset,
    _is.OrderByBuilder<SysPostTable>? orderBy,
    _is.OrderByListBuilder<SysPostTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysPost>(
      where: where?.call(SysPost.t),
      orderBy: orderBy?.call(SysPost.t),
      orderByList: orderByList?.call(SysPost.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysPost] by its [id] or null if no such row exists.
  Future<SysPost?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysPost>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysPost]s in the list and returns the inserted rows.
  ///
  /// The returned [SysPost]s will have their `id` fields set.
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
  Future<List<SysPost>> insert(
    _is.DatabaseSession session,
    List<SysPost> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysPost>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysPost] and returns the inserted row.
  ///
  /// The returned [SysPost] will have its `id` field set.
  Future<SysPost> insertRow(
    _is.DatabaseSession session,
    SysPost row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysPost>(row, transaction: transaction);
  }

  /// Upserts all [SysPost]s in the list and returns the resulting rows.
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
  /// The returned [SysPost]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysPost>> upsert(
    _is.DatabaseSession session,
    List<SysPost> rows, {
    required _is.ColumnSelections<SysPostTable> conflictColumns,
    _is.ColumnSelections<SysPostTable>? updateColumns,
    _is.WhereExpressionBuilder<SysPostTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysPost>(
      rows,
      conflictColumns: conflictColumns(SysPost.t),
      updateColumns: updateColumns?.call(SysPost.t),
      updateWhere: updateWhere?.call(SysPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysPost] and returns the resulting row.
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
  /// The returned [SysPost] will have its `id` field set.
  Future<SysPost?> upsertRow(
    _is.DatabaseSession session,
    SysPost row, {
    required _is.ColumnSelections<SysPostTable> conflictColumns,
    _is.ColumnSelections<SysPostTable>? updateColumns,
    _is.WhereExpressionBuilder<SysPostTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysPost>(
      row,
      conflictColumns: conflictColumns(SysPost.t),
      updateColumns: updateColumns?.call(SysPost.t),
      updateWhere: updateWhere?.call(SysPost.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysPost]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysPost>> update(
    _is.DatabaseSession session,
    List<SysPost> rows, {
    _is.ColumnSelections<SysPostTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysPost>(
      rows,
      columns: columns?.call(SysPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysPost]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysPost> updateRow(
    _is.DatabaseSession session,
    SysPost row, {
    _is.ColumnSelections<SysPostTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysPost>(
      row,
      columns: columns?.call(SysPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysPost] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysPost?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysPostUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysPost>(
      id,
      columnValues: columnValues(SysPost.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysPost]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysPost>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysPostUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysPostTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysPostTable>? orderBy,
    _is.OrderByListBuilder<SysPostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysPost>(
      columnValues: columnValues(SysPost.t.updateTable),
      where: where(SysPost.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysPost.t),
      orderByList: orderByList?.call(SysPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysPost]s in the list and returns the deleted rows.
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
  Future<List<SysPost>> delete(
    _is.DatabaseSession session,
    List<SysPost> rows, {
    _is.OrderByBuilder<SysPostTable>? orderBy,
    _is.OrderByListBuilder<SysPostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysPost>(
      rows,
      orderBy: orderBy?.call(SysPost.t),
      orderByList: orderByList?.call(SysPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysPost].
  Future<SysPost> deleteRow(
    _is.DatabaseSession session,
    SysPost row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysPost>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysPost>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysPostTable> where,
    _is.OrderByBuilder<SysPostTable>? orderBy,
    _is.OrderByListBuilder<SysPostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysPost>(
      where: where(SysPost.t),
      orderBy: orderBy?.call(SysPost.t),
      orderByList: orderByList?.call(SysPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysPostTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysPost>(
      where: where?.call(SysPost.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysPost] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysPostTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysPost>(
      where: where(SysPost.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
