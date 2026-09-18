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

/// 字典类型表
abstract class SysDictCode
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysDictCode._({
    this.id,
    int? tenantId,
    required this.name,
    required this.code,
    required this.status,
    this.description,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
  }) : tenantId = tenantId ?? 0,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now();

  factory SysDictCode({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    required int status,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) = _SysDictCodeImpl;

  factory SysDictCode.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDictCode(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      status: jsonSerialization['status'] as int,
      description: jsonSerialization['description'] as String?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
    );
  }

  static final t = SysDictCodeTable();

  static const db = SysDictCodeRepository._();

  @override
  int? id;

  int? tenantId;

  String name;

  String code;

  int status;

  String? description;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysDictCode]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysDictCode copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? code,
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
      '__className__': 'SysDictCode',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'name': name,
      'code': code,
      'status': status,
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
      '__className__': 'SysDictCode',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'name': name,
      'code': code,
      'status': status,
      if (description != null) 'description': description,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static SysDictCodeInclude include() {
    return SysDictCodeInclude._();
  }

  static SysDictCodeIncludeList includeList({
    _is.WhereExpressionBuilder<SysDictCodeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysDictCodeTable>? orderBy,
    _is.OrderByListBuilder<SysDictCodeTable>? orderByList,
    SysDictCodeInclude? include,
  }) {
    return SysDictCodeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDictCode.t),
      orderByList: orderByList?.call(SysDictCode.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysDictCodeImpl extends SysDictCode {
  _SysDictCodeImpl({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    required int status,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         code: code,
         status: status,
         description: description,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysDictCode]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysDictCode copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    String? name,
    String? code,
    int? status,
    Object? description = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return SysDictCode(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      name: name ?? this.name,
      code: code ?? this.code,
      status: status ?? this.status,
      description: description is String? ? description : this.description,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class SysDictCodeUpdateTable extends _is.UpdateTable<SysDictCodeTable> {
  SysDictCodeUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int? value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> code(String value) =>
      _is.ColumnValue(table.code, value);

  _is.ColumnValue<int, int> status(int value) =>
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

class SysDictCodeTable extends _is.Table<int?> {
  SysDictCodeTable({super.tableRelation}) : super(tableName: 'sys_dict_code') {
    updateTable = SysDictCodeUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    name = _is.ColumnString('name', this);
    code = _is.ColumnString('code', this);
    status = _is.ColumnInt('status', this);
    description = _is.ColumnString('description', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
  }

  late final SysDictCodeUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString name;

  late final _is.ColumnString code;

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
    name,
    code,
    status,
    description,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class SysDictCodeInclude extends _is.IncludeObject {
  SysDictCodeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysDictCode.t;
}

class SysDictCodeIncludeList extends _is.IncludeList {
  SysDictCodeIncludeList._({
    _is.WhereExpressionBuilder<SysDictCodeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysDictCode.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysDictCode.t;
}

class SysDictCodeRepository {
  const SysDictCodeRepository._();

  /// Returns a list of [SysDictCode]s matching the given query parameters.
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
  Future<List<SysDictCode>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysDictCodeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysDictCodeTable>? orderBy,
    _is.OrderByListBuilder<SysDictCodeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysDictCode>(
      where: where?.call(SysDictCode.t),
      orderBy: orderBy?.call(SysDictCode.t),
      orderByList: orderByList?.call(SysDictCode.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysDictCode] matching the given query parameters.
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
  Future<SysDictCode?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysDictCodeTable>? where,
    int? offset,
    _is.OrderByBuilder<SysDictCodeTable>? orderBy,
    _is.OrderByListBuilder<SysDictCodeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysDictCode>(
      where: where?.call(SysDictCode.t),
      orderBy: orderBy?.call(SysDictCode.t),
      orderByList: orderByList?.call(SysDictCode.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysDictCode] by its [id] or null if no such row exists.
  Future<SysDictCode?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysDictCode>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysDictCode]s in the list and returns the inserted rows.
  ///
  /// The returned [SysDictCode]s will have their `id` fields set.
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
  Future<List<SysDictCode>> insert(
    _is.DatabaseSession session,
    List<SysDictCode> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysDictCode>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysDictCode] and returns the inserted row.
  ///
  /// The returned [SysDictCode] will have its `id` field set.
  Future<SysDictCode> insertRow(
    _is.DatabaseSession session,
    SysDictCode row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysDictCode>(row, transaction: transaction);
  }

  /// Upserts all [SysDictCode]s in the list and returns the resulting rows.
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
  /// The returned [SysDictCode]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysDictCode>> upsert(
    _is.DatabaseSession session,
    List<SysDictCode> rows, {
    required _is.ColumnSelections<SysDictCodeTable> conflictColumns,
    _is.ColumnSelections<SysDictCodeTable>? updateColumns,
    _is.WhereExpressionBuilder<SysDictCodeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysDictCode>(
      rows,
      conflictColumns: conflictColumns(SysDictCode.t),
      updateColumns: updateColumns?.call(SysDictCode.t),
      updateWhere: updateWhere?.call(SysDictCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysDictCode] and returns the resulting row.
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
  /// The returned [SysDictCode] will have its `id` field set.
  Future<SysDictCode?> upsertRow(
    _is.DatabaseSession session,
    SysDictCode row, {
    required _is.ColumnSelections<SysDictCodeTable> conflictColumns,
    _is.ColumnSelections<SysDictCodeTable>? updateColumns,
    _is.WhereExpressionBuilder<SysDictCodeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysDictCode>(
      row,
      conflictColumns: conflictColumns(SysDictCode.t),
      updateColumns: updateColumns?.call(SysDictCode.t),
      updateWhere: updateWhere?.call(SysDictCode.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysDictCode]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysDictCode>> update(
    _is.DatabaseSession session,
    List<SysDictCode> rows, {
    _is.ColumnSelections<SysDictCodeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysDictCode>(
      rows,
      columns: columns?.call(SysDictCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysDictCode]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysDictCode> updateRow(
    _is.DatabaseSession session,
    SysDictCode row, {
    _is.ColumnSelections<SysDictCodeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysDictCode>(
      row,
      columns: columns?.call(SysDictCode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysDictCode] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysDictCode?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysDictCodeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysDictCode>(
      id,
      columnValues: columnValues(SysDictCode.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysDictCode]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysDictCode>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysDictCodeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysDictCodeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysDictCodeTable>? orderBy,
    _is.OrderByListBuilder<SysDictCodeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysDictCode>(
      columnValues: columnValues(SysDictCode.t.updateTable),
      where: where(SysDictCode.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDictCode.t),
      orderByList: orderByList?.call(SysDictCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysDictCode]s in the list and returns the deleted rows.
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
  Future<List<SysDictCode>> delete(
    _is.DatabaseSession session,
    List<SysDictCode> rows, {
    _is.OrderByBuilder<SysDictCodeTable>? orderBy,
    _is.OrderByListBuilder<SysDictCodeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysDictCode>(
      rows,
      orderBy: orderBy?.call(SysDictCode.t),
      orderByList: orderByList?.call(SysDictCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysDictCode].
  Future<SysDictCode> deleteRow(
    _is.DatabaseSession session,
    SysDictCode row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysDictCode>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysDictCode>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysDictCodeTable> where,
    _is.OrderByBuilder<SysDictCodeTable>? orderBy,
    _is.OrderByListBuilder<SysDictCodeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysDictCode>(
      where: where(SysDictCode.t),
      orderBy: orderBy?.call(SysDictCode.t),
      orderByList: orderByList?.call(SysDictCode.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysDictCodeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysDictCode>(
      where: where?.call(SysDictCode.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysDictCode] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysDictCodeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysDictCode>(
      where: where(SysDictCode.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
