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

/// 租户套餐表
abstract class SysTenantPackage
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysTenantPackage._({
    this.id,
    required this.name,
    required this.status,
    this.description,
    required this.menuIds,
    required this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysTenantPackage({
    int? id,
    required String name,
    required int status,
    String? description,
    required String menuIds,
    required String creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysTenantPackageImpl;

  factory SysTenantPackage.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysTenantPackage(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] as int,
      description: jsonSerialization['description'] as String?,
      menuIds: jsonSerialization['menuIds'] as String,
      creator: jsonSerialization['creator'] as String,
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

  static final t = SysTenantPackageTable();

  static const db = SysTenantPackageRepository._();

  @override
  int? id;

  String name;

  int status;

  String? description;

  String menuIds;

  String creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysTenantPackage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysTenantPackage copyWith({
    int? id,
    String? name,
    int? status,
    String? description,
    String? menuIds,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysTenantPackage',
      if (id != null) 'id': id,
      'name': name,
      'status': status,
      if (description != null) 'description': description,
      'menuIds': menuIds,
      'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SysTenantPackage',
      if (id != null) 'id': id,
      'name': name,
      'status': status,
      if (description != null) 'description': description,
      'menuIds': menuIds,
      'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysTenantPackageInclude include() {
    return SysTenantPackageInclude._();
  }

  static SysTenantPackageIncludeList includeList({
    _is.WhereExpressionBuilder<SysTenantPackageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysTenantPackageTable>? orderBy,
    _is.OrderByListBuilder<SysTenantPackageTable>? orderByList,
    SysTenantPackageInclude? include,
  }) {
    return SysTenantPackageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysTenantPackage.t),
      orderByList: orderByList?.call(SysTenantPackage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysTenantPackageImpl extends SysTenantPackage {
  _SysTenantPackageImpl({
    int? id,
    required String name,
    required int status,
    String? description,
    required String menuIds,
    required String creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         name: name,
         status: status,
         description: description,
         menuIds: menuIds,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysTenantPackage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysTenantPackage copyWith({
    Object? id = _Undefined,
    String? name,
    int? status,
    Object? description = _Undefined,
    String? menuIds,
    String? creator,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysTenantPackage(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      description: description is String? ? description : this.description,
      menuIds: menuIds ?? this.menuIds,
      creator: creator ?? this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysTenantPackageUpdateTable
    extends _is.UpdateTable<SysTenantPackageTable> {
  SysTenantPackageUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<int, int> status(int value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<String, String> menuIds(String value) =>
      _is.ColumnValue(table.menuIds, value);

  _is.ColumnValue<String, String> creator(String value) =>
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

class SysTenantPackageTable extends _is.Table<int?> {
  SysTenantPackageTable({super.tableRelation})
    : super(tableName: 'sys_tenant_package') {
    updateTable = SysTenantPackageUpdateTable(this);
    name = _is.ColumnString('name', this);
    status = _is.ColumnInt('status', this);
    description = _is.ColumnString('description', this);
    menuIds = _is.ColumnString('menuIds', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysTenantPackageUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnInt status;

  late final _is.ColumnString description;

  late final _is.ColumnString menuIds;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    status,
    description,
    menuIds,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysTenantPackageInclude extends _is.IncludeObject {
  SysTenantPackageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysTenantPackage.t;
}

class SysTenantPackageIncludeList extends _is.IncludeList {
  SysTenantPackageIncludeList._({
    _is.WhereExpressionBuilder<SysTenantPackageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysTenantPackage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysTenantPackage.t;
}

class SysTenantPackageRepository {
  const SysTenantPackageRepository._();

  /// Returns a list of [SysTenantPackage]s matching the given query parameters.
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
  Future<List<SysTenantPackage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysTenantPackageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysTenantPackageTable>? orderBy,
    _is.OrderByListBuilder<SysTenantPackageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysTenantPackage>(
      where: where?.call(SysTenantPackage.t),
      orderBy: orderBy?.call(SysTenantPackage.t),
      orderByList: orderByList?.call(SysTenantPackage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysTenantPackage] matching the given query parameters.
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
  Future<SysTenantPackage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysTenantPackageTable>? where,
    int? offset,
    _is.OrderByBuilder<SysTenantPackageTable>? orderBy,
    _is.OrderByListBuilder<SysTenantPackageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysTenantPackage>(
      where: where?.call(SysTenantPackage.t),
      orderBy: orderBy?.call(SysTenantPackage.t),
      orderByList: orderByList?.call(SysTenantPackage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysTenantPackage] by its [id] or null if no such row exists.
  Future<SysTenantPackage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysTenantPackage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysTenantPackage]s in the list and returns the inserted rows.
  ///
  /// The returned [SysTenantPackage]s will have their `id` fields set.
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
  Future<List<SysTenantPackage>> insert(
    _is.DatabaseSession session,
    List<SysTenantPackage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysTenantPackage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysTenantPackage] and returns the inserted row.
  ///
  /// The returned [SysTenantPackage] will have its `id` field set.
  Future<SysTenantPackage> insertRow(
    _is.DatabaseSession session,
    SysTenantPackage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysTenantPackage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SysTenantPackage]s in the list and returns the resulting rows.
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
  /// The returned [SysTenantPackage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysTenantPackage>> upsert(
    _is.DatabaseSession session,
    List<SysTenantPackage> rows, {
    required _is.ColumnSelections<SysTenantPackageTable> conflictColumns,
    _is.ColumnSelections<SysTenantPackageTable>? updateColumns,
    _is.WhereExpressionBuilder<SysTenantPackageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysTenantPackage>(
      rows,
      conflictColumns: conflictColumns(SysTenantPackage.t),
      updateColumns: updateColumns?.call(SysTenantPackage.t),
      updateWhere: updateWhere?.call(SysTenantPackage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysTenantPackage] and returns the resulting row.
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
  /// The returned [SysTenantPackage] will have its `id` field set.
  Future<SysTenantPackage?> upsertRow(
    _is.DatabaseSession session,
    SysTenantPackage row, {
    required _is.ColumnSelections<SysTenantPackageTable> conflictColumns,
    _is.ColumnSelections<SysTenantPackageTable>? updateColumns,
    _is.WhereExpressionBuilder<SysTenantPackageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysTenantPackage>(
      row,
      conflictColumns: conflictColumns(SysTenantPackage.t),
      updateColumns: updateColumns?.call(SysTenantPackage.t),
      updateWhere: updateWhere?.call(SysTenantPackage.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysTenantPackage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysTenantPackage>> update(
    _is.DatabaseSession session,
    List<SysTenantPackage> rows, {
    _is.ColumnSelections<SysTenantPackageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysTenantPackage>(
      rows,
      columns: columns?.call(SysTenantPackage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysTenantPackage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysTenantPackage> updateRow(
    _is.DatabaseSession session,
    SysTenantPackage row, {
    _is.ColumnSelections<SysTenantPackageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysTenantPackage>(
      row,
      columns: columns?.call(SysTenantPackage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysTenantPackage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysTenantPackage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysTenantPackageUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysTenantPackage>(
      id,
      columnValues: columnValues(SysTenantPackage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysTenantPackage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysTenantPackage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysTenantPackageUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SysTenantPackageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysTenantPackageTable>? orderBy,
    _is.OrderByListBuilder<SysTenantPackageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysTenantPackage>(
      columnValues: columnValues(SysTenantPackage.t.updateTable),
      where: where(SysTenantPackage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysTenantPackage.t),
      orderByList: orderByList?.call(SysTenantPackage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysTenantPackage]s in the list and returns the deleted rows.
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
  Future<List<SysTenantPackage>> delete(
    _is.DatabaseSession session,
    List<SysTenantPackage> rows, {
    _is.OrderByBuilder<SysTenantPackageTable>? orderBy,
    _is.OrderByListBuilder<SysTenantPackageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysTenantPackage>(
      rows,
      orderBy: orderBy?.call(SysTenantPackage.t),
      orderByList: orderByList?.call(SysTenantPackage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysTenantPackage].
  Future<SysTenantPackage> deleteRow(
    _is.DatabaseSession session,
    SysTenantPackage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysTenantPackage>(
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
  Future<List<SysTenantPackage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysTenantPackageTable> where,
    _is.OrderByBuilder<SysTenantPackageTable>? orderBy,
    _is.OrderByListBuilder<SysTenantPackageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysTenantPackage>(
      where: where(SysTenantPackage.t),
      orderBy: orderBy?.call(SysTenantPackage.t),
      orderByList: orderByList?.call(SysTenantPackage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysTenantPackageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysTenantPackage>(
      where: where?.call(SysTenantPackage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysTenantPackage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysTenantPackageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysTenantPackage>(
      where: where(SysTenantPackage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
