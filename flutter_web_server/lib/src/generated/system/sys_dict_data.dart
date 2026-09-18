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

/// 字典数据表
abstract class SysDictData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysDictData._({
    this.id,
    this.tenantId,
    required this.code,
    required this.name,
    required this.value,
    this.color,
    required this.sort,
    required this.status,
    this.description,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
  }) : deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now();

  factory SysDictData({
    int? id,
    int? tenantId,
    required String code,
    required String name,
    required String value,
    String? color,
    required int sort,
    required int status,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) = _SysDictDataImpl;

  factory SysDictData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDictData(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      value: jsonSerialization['value'] as String,
      color: jsonSerialization['color'] as String?,
      sort: jsonSerialization['sort'] as int,
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

  static final t = SysDictDataTable();

  static const db = SysDictDataRepository._();

  @override
  int? id;

  int? tenantId;

  String code;

  String name;

  String value;

  String? color;

  int sort;

  int status;

  String? description;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysDictData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysDictData copyWith({
    int? id,
    int? tenantId,
    String? code,
    String? name,
    String? value,
    String? color,
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
      '__className__': 'SysDictData',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'code': code,
      'name': name,
      'value': value,
      if (color != null) 'color': color,
      'sort': sort,
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
      '__className__': 'SysDictData',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'code': code,
      'name': name,
      'value': value,
      if (color != null) 'color': color,
      'sort': sort,
      'status': status,
      if (description != null) 'description': description,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static SysDictDataInclude include() {
    return SysDictDataInclude._();
  }

  static SysDictDataIncludeList includeList({
    _is.WhereExpressionBuilder<SysDictDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysDictDataTable>? orderBy,
    _is.OrderByListBuilder<SysDictDataTable>? orderByList,
    SysDictDataInclude? include,
  }) {
    return SysDictDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDictData.t),
      orderByList: orderByList?.call(SysDictData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysDictDataImpl extends SysDictData {
  _SysDictDataImpl({
    int? id,
    int? tenantId,
    required String code,
    required String name,
    required String value,
    String? color,
    required int sort,
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
         code: code,
         name: name,
         value: value,
         color: color,
         sort: sort,
         status: status,
         description: description,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysDictData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysDictData copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    String? code,
    String? name,
    String? value,
    Object? color = _Undefined,
    int? sort,
    int? status,
    Object? description = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return SysDictData(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      code: code ?? this.code,
      name: name ?? this.name,
      value: value ?? this.value,
      color: color is String? ? color : this.color,
      sort: sort ?? this.sort,
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

class SysDictDataUpdateTable extends _is.UpdateTable<SysDictDataTable> {
  SysDictDataUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int? value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> code(String value) =>
      _is.ColumnValue(table.code, value);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> value(String value) =>
      _is.ColumnValue(table.value, value);

  _is.ColumnValue<String, String> color(String? value) =>
      _is.ColumnValue(table.color, value);

  _is.ColumnValue<int, int> sort(int value) =>
      _is.ColumnValue(table.sort, value);

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

class SysDictDataTable extends _is.Table<int?> {
  SysDictDataTable({super.tableRelation}) : super(tableName: 'sys_dict_data') {
    updateTable = SysDictDataUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this);
    code = _is.ColumnString('code', this);
    name = _is.ColumnString('name', this);
    value = _is.ColumnString('value', this);
    color = _is.ColumnString('color', this);
    sort = _is.ColumnInt('sort', this);
    status = _is.ColumnInt('status', this);
    description = _is.ColumnString('description', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
  }

  late final SysDictDataUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString code;

  late final _is.ColumnString name;

  late final _is.ColumnString value;

  late final _is.ColumnString color;

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
    code,
    name,
    value,
    color,
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

class SysDictDataInclude extends _is.IncludeObject {
  SysDictDataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysDictData.t;
}

class SysDictDataIncludeList extends _is.IncludeList {
  SysDictDataIncludeList._({
    _is.WhereExpressionBuilder<SysDictDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysDictData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysDictData.t;
}

class SysDictDataRepository {
  const SysDictDataRepository._();

  /// Returns a list of [SysDictData]s matching the given query parameters.
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
  Future<List<SysDictData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysDictDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysDictDataTable>? orderBy,
    _is.OrderByListBuilder<SysDictDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysDictData>(
      where: where?.call(SysDictData.t),
      orderBy: orderBy?.call(SysDictData.t),
      orderByList: orderByList?.call(SysDictData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysDictData] matching the given query parameters.
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
  Future<SysDictData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysDictDataTable>? where,
    int? offset,
    _is.OrderByBuilder<SysDictDataTable>? orderBy,
    _is.OrderByListBuilder<SysDictDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysDictData>(
      where: where?.call(SysDictData.t),
      orderBy: orderBy?.call(SysDictData.t),
      orderByList: orderByList?.call(SysDictData.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysDictData] by its [id] or null if no such row exists.
  Future<SysDictData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysDictData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysDictData]s in the list and returns the inserted rows.
  ///
  /// The returned [SysDictData]s will have their `id` fields set.
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
  Future<List<SysDictData>> insert(
    _is.DatabaseSession session,
    List<SysDictData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysDictData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysDictData] and returns the inserted row.
  ///
  /// The returned [SysDictData] will have its `id` field set.
  Future<SysDictData> insertRow(
    _is.DatabaseSession session,
    SysDictData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysDictData>(row, transaction: transaction);
  }

  /// Upserts all [SysDictData]s in the list and returns the resulting rows.
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
  /// The returned [SysDictData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysDictData>> upsert(
    _is.DatabaseSession session,
    List<SysDictData> rows, {
    required _is.ColumnSelections<SysDictDataTable> conflictColumns,
    _is.ColumnSelections<SysDictDataTable>? updateColumns,
    _is.WhereExpressionBuilder<SysDictDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysDictData>(
      rows,
      conflictColumns: conflictColumns(SysDictData.t),
      updateColumns: updateColumns?.call(SysDictData.t),
      updateWhere: updateWhere?.call(SysDictData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysDictData] and returns the resulting row.
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
  /// The returned [SysDictData] will have its `id` field set.
  Future<SysDictData?> upsertRow(
    _is.DatabaseSession session,
    SysDictData row, {
    required _is.ColumnSelections<SysDictDataTable> conflictColumns,
    _is.ColumnSelections<SysDictDataTable>? updateColumns,
    _is.WhereExpressionBuilder<SysDictDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysDictData>(
      row,
      conflictColumns: conflictColumns(SysDictData.t),
      updateColumns: updateColumns?.call(SysDictData.t),
      updateWhere: updateWhere?.call(SysDictData.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysDictData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysDictData>> update(
    _is.DatabaseSession session,
    List<SysDictData> rows, {
    _is.ColumnSelections<SysDictDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysDictData>(
      rows,
      columns: columns?.call(SysDictData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysDictData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysDictData> updateRow(
    _is.DatabaseSession session,
    SysDictData row, {
    _is.ColumnSelections<SysDictDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysDictData>(
      row,
      columns: columns?.call(SysDictData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysDictData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysDictData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysDictDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysDictData>(
      id,
      columnValues: columnValues(SysDictData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysDictData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysDictData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysDictDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysDictDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysDictDataTable>? orderBy,
    _is.OrderByListBuilder<SysDictDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysDictData>(
      columnValues: columnValues(SysDictData.t.updateTable),
      where: where(SysDictData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDictData.t),
      orderByList: orderByList?.call(SysDictData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysDictData]s in the list and returns the deleted rows.
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
  Future<List<SysDictData>> delete(
    _is.DatabaseSession session,
    List<SysDictData> rows, {
    _is.OrderByBuilder<SysDictDataTable>? orderBy,
    _is.OrderByListBuilder<SysDictDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysDictData>(
      rows,
      orderBy: orderBy?.call(SysDictData.t),
      orderByList: orderByList?.call(SysDictData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysDictData].
  Future<SysDictData> deleteRow(
    _is.DatabaseSession session,
    SysDictData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysDictData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysDictData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysDictDataTable> where,
    _is.OrderByBuilder<SysDictDataTable>? orderBy,
    _is.OrderByListBuilder<SysDictDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysDictData>(
      where: where(SysDictData.t),
      orderBy: orderBy?.call(SysDictData.t),
      orderByList: orderByList?.call(SysDictData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysDictDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysDictData>(
      where: where?.call(SysDictData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysDictData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysDictDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysDictData>(
      where: where(SysDictData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
