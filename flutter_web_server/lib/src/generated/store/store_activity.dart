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

abstract class StoreActivity
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StoreActivity._({
    this.id,
    required this.storeId,
    required this.name,
    required this.address,
    required this.description,
    required this.startTime,
    required this.endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now(),
       isDeleted = isDeleted ?? false;

  factory StoreActivity({
    int? id,
    required int storeId,
    required String name,
    required String address,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _StoreActivityImpl;

  factory StoreActivity.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreActivity(
      id: jsonSerialization['id'] as int?,
      storeId: jsonSerialization['storeId'] as int,
      name: jsonSerialization['name'] as String,
      address: jsonSerialization['address'] as String,
      description: jsonSerialization['description'] as String,
      startTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startTime'],
      ),
      endTime: _is.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isDeleted']),
    );
  }

  static final t = StoreActivityTable();

  static const db = StoreActivityRepository._();

  @override
  int? id;

  /// 店铺ID
  int storeId;

  /// 活动名称
  String name;

  /// 活动地点
  String address;

  /// 活动描述
  String description;

  /// 开始时间
  DateTime startTime;

  /// 结束时间
  DateTime endTime;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否已删除（默认值：false）
  bool isDeleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreActivity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StoreActivity copyWith({
    int? id,
    int? storeId,
    String? name,
    String? address,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreActivity',
      if (id != null) 'id': id,
      'storeId': storeId,
      'name': name,
      'address': address,
      'description': description,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StoreActivity',
      if (id != null) 'id': id,
      'storeId': storeId,
      'name': name,
      'address': address,
      'description': description,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static StoreActivityInclude include() {
    return StoreActivityInclude._();
  }

  static StoreActivityIncludeList includeList({
    _is.WhereExpressionBuilder<StoreActivityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreActivityTable>? orderBy,
    _is.OrderByListBuilder<StoreActivityTable>? orderByList,
    StoreActivityInclude? include,
  }) {
    return StoreActivityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreActivity.t),
      orderByList: orderByList?.call(StoreActivity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreActivityImpl extends StoreActivity {
  _StoreActivityImpl({
    int? id,
    required int storeId,
    required String name,
    required String address,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
         id: id,
         storeId: storeId,
         name: name,
         address: address,
         description: description,
         startTime: startTime,
         endTime: endTime,
         createTime: createTime,
         updateTime: updateTime,
         isDeleted: isDeleted,
       );

  /// Returns a shallow copy of this [StoreActivity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StoreActivity copyWith({
    Object? id = _Undefined,
    int? storeId,
    String? name,
    String? address,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return StoreActivity(
      id: id is int? ? id : this.id,
      storeId: storeId ?? this.storeId,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class StoreActivityUpdateTable extends _is.UpdateTable<StoreActivityTable> {
  StoreActivityUpdateTable(super.table);

  _is.ColumnValue<int, int> storeId(int value) =>
      _is.ColumnValue(table.storeId, value);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> address(String value) =>
      _is.ColumnValue(table.address, value);

  _is.ColumnValue<String, String> description(String value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<DateTime, DateTime> startTime(DateTime value) =>
      _is.ColumnValue(table.startTime, value);

  _is.ColumnValue<DateTime, DateTime> endTime(DateTime value) =>
      _is.ColumnValue(table.endTime, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> isDeleted(bool value) =>
      _is.ColumnValue(table.isDeleted, value);
}

class StoreActivityTable extends _is.Table<int?> {
  StoreActivityTable({super.tableRelation})
    : super(tableName: 'store_activity') {
    updateTable = StoreActivityUpdateTable(this);
    storeId = _is.ColumnInt('storeId', this);
    name = _is.ColumnString('name', this);
    address = _is.ColumnString('address', this);
    description = _is.ColumnString('description', this);
    startTime = _is.ColumnDateTime('startTime', this);
    endTime = _is.ColumnDateTime('endTime', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
    isDeleted = _is.ColumnBool('isDeleted', this, hasDefault: true);
  }

  late final StoreActivityUpdateTable updateTable;

  /// 店铺ID
  late final _is.ColumnInt storeId;

  /// 活动名称
  late final _is.ColumnString name;

  /// 活动地点
  late final _is.ColumnString address;

  /// 活动描述
  late final _is.ColumnString description;

  /// 开始时间
  late final _is.ColumnDateTime startTime;

  /// 结束时间
  late final _is.ColumnDateTime endTime;

  /// 记录创建时间
  late final _is.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _is.ColumnDateTime updateTime;

  /// 是否已删除（默认值：false）
  late final _is.ColumnBool isDeleted;

  @override
  List<_is.Column> get columns => [
    id,
    storeId,
    name,
    address,
    description,
    startTime,
    endTime,
    createTime,
    updateTime,
    isDeleted,
  ];
}

class StoreActivityInclude extends _is.IncludeObject {
  StoreActivityInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StoreActivity.t;
}

class StoreActivityIncludeList extends _is.IncludeList {
  StoreActivityIncludeList._({
    _is.WhereExpressionBuilder<StoreActivityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreActivity.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StoreActivity.t;
}

class StoreActivityRepository {
  const StoreActivityRepository._();

  /// Returns a list of [StoreActivity]s matching the given query parameters.
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
  Future<List<StoreActivity>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreActivityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreActivityTable>? orderBy,
    _is.OrderByListBuilder<StoreActivityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StoreActivity>(
      where: where?.call(StoreActivity.t),
      orderBy: orderBy?.call(StoreActivity.t),
      orderByList: orderByList?.call(StoreActivity.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StoreActivity] matching the given query parameters.
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
  Future<StoreActivity?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreActivityTable>? where,
    int? offset,
    _is.OrderByBuilder<StoreActivityTable>? orderBy,
    _is.OrderByListBuilder<StoreActivityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StoreActivity>(
      where: where?.call(StoreActivity.t),
      orderBy: orderBy?.call(StoreActivity.t),
      orderByList: orderByList?.call(StoreActivity.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StoreActivity] by its [id] or null if no such row exists.
  Future<StoreActivity?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StoreActivity>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StoreActivity]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreActivity]s will have their `id` fields set.
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
  Future<List<StoreActivity>> insert(
    _is.DatabaseSession session,
    List<StoreActivity> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StoreActivity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StoreActivity] and returns the inserted row.
  ///
  /// The returned [StoreActivity] will have its `id` field set.
  Future<StoreActivity> insertRow(
    _is.DatabaseSession session,
    StoreActivity row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreActivity>(row, transaction: transaction);
  }

  /// Upserts all [StoreActivity]s in the list and returns the resulting rows.
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
  /// The returned [StoreActivity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreActivity>> upsert(
    _is.DatabaseSession session,
    List<StoreActivity> rows, {
    required _is.ColumnSelections<StoreActivityTable> conflictColumns,
    _is.ColumnSelections<StoreActivityTable>? updateColumns,
    _is.WhereExpressionBuilder<StoreActivityTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StoreActivity>(
      rows,
      conflictColumns: conflictColumns(StoreActivity.t),
      updateColumns: updateColumns?.call(StoreActivity.t),
      updateWhere: updateWhere?.call(StoreActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StoreActivity] and returns the resulting row.
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
  /// The returned [StoreActivity] will have its `id` field set.
  Future<StoreActivity?> upsertRow(
    _is.DatabaseSession session,
    StoreActivity row, {
    required _is.ColumnSelections<StoreActivityTable> conflictColumns,
    _is.ColumnSelections<StoreActivityTable>? updateColumns,
    _is.WhereExpressionBuilder<StoreActivityTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StoreActivity>(
      row,
      conflictColumns: conflictColumns(StoreActivity.t),
      updateColumns: updateColumns?.call(StoreActivity.t),
      updateWhere: updateWhere?.call(StoreActivity.t),
      transaction: transaction,
    );
  }

  /// Updates all [StoreActivity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreActivity>> update(
    _is.DatabaseSession session,
    List<StoreActivity> rows, {
    _is.ColumnSelections<StoreActivityTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StoreActivity>(
      rows,
      columns: columns?.call(StoreActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StoreActivity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreActivity> updateRow(
    _is.DatabaseSession session,
    StoreActivity row, {
    _is.ColumnSelections<StoreActivityTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreActivity>(
      row,
      columns: columns?.call(StoreActivity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreActivity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreActivity?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StoreActivityUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreActivity>(
      id,
      columnValues: columnValues(StoreActivity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreActivity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreActivity>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StoreActivityUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StoreActivityTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreActivityTable>? orderBy,
    _is.OrderByListBuilder<StoreActivityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StoreActivity>(
      columnValues: columnValues(StoreActivity.t.updateTable),
      where: where(StoreActivity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreActivity.t),
      orderByList: orderByList?.call(StoreActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StoreActivity]s in the list and returns the deleted rows.
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
  Future<List<StoreActivity>> delete(
    _is.DatabaseSession session,
    List<StoreActivity> rows, {
    _is.OrderByBuilder<StoreActivityTable>? orderBy,
    _is.OrderByListBuilder<StoreActivityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StoreActivity>(
      rows,
      orderBy: orderBy?.call(StoreActivity.t),
      orderByList: orderByList?.call(StoreActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StoreActivity].
  Future<StoreActivity> deleteRow(
    _is.DatabaseSession session,
    StoreActivity row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreActivity>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreActivity>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoreActivityTable> where,
    _is.OrderByBuilder<StoreActivityTable>? orderBy,
    _is.OrderByListBuilder<StoreActivityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StoreActivity>(
      where: where(StoreActivity.t),
      orderBy: orderBy?.call(StoreActivity.t),
      orderByList: orderByList?.call(StoreActivity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreActivityTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StoreActivity>(
      where: where?.call(StoreActivity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StoreActivity] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoreActivityTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StoreActivity>(
      where: where(StoreActivity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
