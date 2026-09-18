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

/// 系统部门表 - 支持多租户、树形结构
abstract class SysDept
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysDept._({
    this.id,
    int? tenantId,
    int? parentId,
    this.name,
    this.sort,
    this.status,
    this.description,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       parentId = parentId ?? 0,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory SysDept({
    int? id,
    int? tenantId,
    int? parentId,
    String? name,
    int? sort,
    int? status,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _SysDeptImpl;

  factory SysDept.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDept(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      parentId: jsonSerialization['parentId'] as int?,
      name: jsonSerialization['name'] as String?,
      sort: jsonSerialization['sort'] as int?,
      status: jsonSerialization['status'] as int?,
      description: jsonSerialization['description'] as String?,
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

  static final t = SysDeptTable();

  static const db = SysDeptRepository._();

  @override
  int? id;

  int tenantId;

  int? parentId;

  String? name;

  int? sort;

  int? status;

  String? description;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysDept]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysDept copyWith({
    int? id,
    int? tenantId,
    int? parentId,
    String? name,
    int? sort,
    int? status,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysDept',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (parentId != null) 'parentId': parentId,
      if (name != null) 'name': name,
      if (sort != null) 'sort': sort,
      if (status != null) 'status': status,
      if (description != null) 'description': description,
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
      '__className__': 'SysDept',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (parentId != null) 'parentId': parentId,
      if (name != null) 'name': name,
      if (sort != null) 'sort': sort,
      if (status != null) 'status': status,
      if (description != null) 'description': description,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static SysDeptInclude include() {
    return SysDeptInclude._();
  }

  static SysDeptIncludeList includeList({
    _is.WhereExpressionBuilder<SysDeptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysDeptTable>? orderBy,
    _is.OrderByListBuilder<SysDeptTable>? orderByList,
    SysDeptInclude? include,
  }) {
    return SysDeptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDept.t),
      orderByList: orderByList?.call(SysDept.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysDeptImpl extends SysDept {
  _SysDeptImpl({
    int? id,
    int? tenantId,
    int? parentId,
    String? name,
    int? sort,
    int? status,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         parentId: parentId,
         name: name,
         sort: sort,
         status: status,
         description: description,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysDept]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysDept copyWith({
    Object? id = _Undefined,
    int? tenantId,
    Object? parentId = _Undefined,
    Object? name = _Undefined,
    Object? sort = _Undefined,
    Object? status = _Undefined,
    Object? description = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return SysDept(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      parentId: parentId is int? ? parentId : this.parentId,
      name: name is String? ? name : this.name,
      sort: sort is int? ? sort : this.sort,
      status: status is int? ? status : this.status,
      description: description is String? ? description : this.description,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class SysDeptUpdateTable extends _is.UpdateTable<SysDeptTable> {
  SysDeptUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> parentId(int? value) =>
      _is.ColumnValue(table.parentId, value);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<int, int> sort(int? value) =>
      _is.ColumnValue(table.sort, value);

  _is.ColumnValue<int, int> status(int? value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<bool, bool> deleted(bool value) =>
      _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) =>
      _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) =>
      _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);
}

class SysDeptTable extends _is.Table<int?> {
  SysDeptTable({super.tableRelation}) : super(tableName: 'sys_dept') {
    updateTable = SysDeptUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    parentId = _is.ColumnInt('parentId', this, hasDefault: true);
    name = _is.ColumnString('name', this);
    sort = _is.ColumnInt('sort', this);
    status = _is.ColumnInt('status', this);
    description = _is.ColumnString('description', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final SysDeptUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnInt parentId;

  late final _is.ColumnString name;

  late final _is.ColumnInt sort;

  late final _is.ColumnInt status;

  late final _is.ColumnString description;

  late final _is.ColumnBool deleted;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    parentId,
    name,
    sort,
    status,
    description,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class SysDeptInclude extends _is.IncludeObject {
  SysDeptInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysDept.t;
}

class SysDeptIncludeList extends _is.IncludeList {
  SysDeptIncludeList._({
    _is.WhereExpressionBuilder<SysDeptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysDept.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysDept.t;
}

class SysDeptRepository {
  const SysDeptRepository._();

  /// Returns a list of [SysDept]s matching the given query parameters.
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
  Future<List<SysDept>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysDeptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysDeptTable>? orderBy,
    _is.OrderByListBuilder<SysDeptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysDept>(
      where: where?.call(SysDept.t),
      orderBy: orderBy?.call(SysDept.t),
      orderByList: orderByList?.call(SysDept.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysDept] matching the given query parameters.
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
  Future<SysDept?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysDeptTable>? where,
    int? offset,
    _is.OrderByBuilder<SysDeptTable>? orderBy,
    _is.OrderByListBuilder<SysDeptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysDept>(
      where: where?.call(SysDept.t),
      orderBy: orderBy?.call(SysDept.t),
      orderByList: orderByList?.call(SysDept.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysDept] by its [id] or null if no such row exists.
  Future<SysDept?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysDept>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysDept]s in the list and returns the inserted rows.
  ///
  /// The returned [SysDept]s will have their `id` fields set.
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
  Future<List<SysDept>> insert(
    _is.DatabaseSession session,
    List<SysDept> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysDept>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysDept] and returns the inserted row.
  ///
  /// The returned [SysDept] will have its `id` field set.
  Future<SysDept> insertRow(
    _is.DatabaseSession session,
    SysDept row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysDept>(row, transaction: transaction);
  }

  /// Upserts all [SysDept]s in the list and returns the resulting rows.
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
  /// The returned [SysDept]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysDept>> upsert(
    _is.DatabaseSession session,
    List<SysDept> rows, {
    required _is.ColumnSelections<SysDeptTable> conflictColumns,
    _is.ColumnSelections<SysDeptTable>? updateColumns,
    _is.WhereExpressionBuilder<SysDeptTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysDept>(
      rows,
      conflictColumns: conflictColumns(SysDept.t),
      updateColumns: updateColumns?.call(SysDept.t),
      updateWhere: updateWhere?.call(SysDept.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysDept] and returns the resulting row.
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
  /// The returned [SysDept] will have its `id` field set.
  Future<SysDept?> upsertRow(
    _is.DatabaseSession session,
    SysDept row, {
    required _is.ColumnSelections<SysDeptTable> conflictColumns,
    _is.ColumnSelections<SysDeptTable>? updateColumns,
    _is.WhereExpressionBuilder<SysDeptTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysDept>(
      row,
      conflictColumns: conflictColumns(SysDept.t),
      updateColumns: updateColumns?.call(SysDept.t),
      updateWhere: updateWhere?.call(SysDept.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysDept]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysDept>> update(
    _is.DatabaseSession session,
    List<SysDept> rows, {
    _is.ColumnSelections<SysDeptTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysDept>(
      rows,
      columns: columns?.call(SysDept.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysDept]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysDept> updateRow(
    _is.DatabaseSession session,
    SysDept row, {
    _is.ColumnSelections<SysDeptTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysDept>(
      row,
      columns: columns?.call(SysDept.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysDept] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysDept?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysDeptUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysDept>(
      id,
      columnValues: columnValues(SysDept.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysDept]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysDept>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysDeptUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysDeptTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysDeptTable>? orderBy,
    _is.OrderByListBuilder<SysDeptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysDept>(
      columnValues: columnValues(SysDept.t.updateTable),
      where: where(SysDept.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDept.t),
      orderByList: orderByList?.call(SysDept.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysDept]s in the list and returns the deleted rows.
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
  Future<List<SysDept>> delete(
    _is.DatabaseSession session,
    List<SysDept> rows, {
    _is.OrderByBuilder<SysDeptTable>? orderBy,
    _is.OrderByListBuilder<SysDeptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysDept>(
      rows,
      orderBy: orderBy?.call(SysDept.t),
      orderByList: orderByList?.call(SysDept.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysDept].
  Future<SysDept> deleteRow(
    _is.DatabaseSession session,
    SysDept row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysDept>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysDept>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysDeptTable> where,
    _is.OrderByBuilder<SysDeptTable>? orderBy,
    _is.OrderByListBuilder<SysDeptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysDept>(
      where: where(SysDept.t),
      orderBy: orderBy?.call(SysDept.t),
      orderByList: orderByList?.call(SysDept.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysDeptTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysDept>(
      where: where?.call(SysDept.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysDept] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysDeptTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysDept>(
      where: where(SysDept.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
