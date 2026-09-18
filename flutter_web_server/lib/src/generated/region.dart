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

/// 用于存储区域信息，如省市区等
abstract class Region implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Region._({this.id, String? name, String? pinyin, int? parentId})
    : name = name ?? '',
      pinyin = pinyin ?? '',
      parentId = parentId ?? 0;

  factory Region({int? id, String? name, String? pinyin, int? parentId}) =
      _RegionImpl;

  factory Region.fromJson(Map<String, dynamic> jsonSerialization) {
    return Region(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      pinyin: jsonSerialization['pinyin'] as String?,
      parentId: jsonSerialization['parentId'] as int?,
    );
  }

  static final t = RegionTable();

  static const db = RegionRepository._();

  @override
  int? id;

  /// 名称（默认空字符串）
  String name;

  /// 拼音（默认空字符串）
  String pinyin;

  /// 父级主键，无父级为 0
  int parentId;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Region]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Region copyWith({int? id, String? name, String? pinyin, int? parentId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Region',
      if (id != null) 'id': id,
      'name': name,
      'pinyin': pinyin,
      'parentId': parentId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Region',
      if (id != null) 'id': id,
      'name': name,
      'pinyin': pinyin,
      'parentId': parentId,
    };
  }

  static RegionInclude include() {
    return RegionInclude._();
  }

  static RegionIncludeList includeList({
    _is.WhereExpressionBuilder<RegionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RegionTable>? orderBy,
    _is.OrderByListBuilder<RegionTable>? orderByList,
    RegionInclude? include,
  }) {
    return RegionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RegionImpl extends Region {
  _RegionImpl({int? id, String? name, String? pinyin, int? parentId})
    : super._(id: id, name: name, pinyin: pinyin, parentId: parentId);

  /// Returns a shallow copy of this [Region]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Region copyWith({
    Object? id = _Undefined,
    String? name,
    String? pinyin,
    int? parentId,
  }) {
    return Region(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      pinyin: pinyin ?? this.pinyin,
      parentId: parentId ?? this.parentId,
    );
  }
}

class RegionUpdateTable extends _is.UpdateTable<RegionTable> {
  RegionUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> pinyin(String value) =>
      _is.ColumnValue(table.pinyin, value);

  _is.ColumnValue<int, int> parentId(int value) =>
      _is.ColumnValue(table.parentId, value);
}

class RegionTable extends _is.Table<int?> {
  RegionTable({super.tableRelation}) : super(tableName: 'region') {
    updateTable = RegionUpdateTable(this);
    name = _is.ColumnString('name', this, hasDefault: true);
    pinyin = _is.ColumnString('pinyin', this, hasDefault: true);
    parentId = _is.ColumnInt('parentId', this, hasDefault: true);
  }

  late final RegionUpdateTable updateTable;

  /// 名称（默认空字符串）
  late final _is.ColumnString name;

  /// 拼音（默认空字符串）
  late final _is.ColumnString pinyin;

  /// 父级主键，无父级为 0
  late final _is.ColumnInt parentId;

  @override
  List<_is.Column> get columns => [id, name, pinyin, parentId];
}

class RegionInclude extends _is.IncludeObject {
  RegionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Region.t;
}

class RegionIncludeList extends _is.IncludeList {
  RegionIncludeList._({
    _is.WhereExpressionBuilder<RegionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Region.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Region.t;
}

class RegionRepository {
  const RegionRepository._();

  /// Returns a list of [Region]s matching the given query parameters.
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
  Future<List<Region>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RegionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RegionTable>? orderBy,
    _is.OrderByListBuilder<RegionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Region>(
      where: where?.call(Region.t),
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Region] matching the given query parameters.
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
  Future<Region?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RegionTable>? where,
    int? offset,
    _is.OrderByBuilder<RegionTable>? orderBy,
    _is.OrderByListBuilder<RegionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Region>(
      where: where?.call(Region.t),
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Region] by its [id] or null if no such row exists.
  Future<Region?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Region>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Region]s in the list and returns the inserted rows.
  ///
  /// The returned [Region]s will have their `id` fields set.
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
  Future<List<Region>> insert(
    _is.DatabaseSession session,
    List<Region> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Region>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Region] and returns the inserted row.
  ///
  /// The returned [Region] will have its `id` field set.
  Future<Region> insertRow(
    _is.DatabaseSession session,
    Region row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Region>(row, transaction: transaction);
  }

  /// Upserts all [Region]s in the list and returns the resulting rows.
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
  /// The returned [Region]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Region>> upsert(
    _is.DatabaseSession session,
    List<Region> rows, {
    required _is.ColumnSelections<RegionTable> conflictColumns,
    _is.ColumnSelections<RegionTable>? updateColumns,
    _is.WhereExpressionBuilder<RegionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Region>(
      rows,
      conflictColumns: conflictColumns(Region.t),
      updateColumns: updateColumns?.call(Region.t),
      updateWhere: updateWhere?.call(Region.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Region] and returns the resulting row.
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
  /// The returned [Region] will have its `id` field set.
  Future<Region?> upsertRow(
    _is.DatabaseSession session,
    Region row, {
    required _is.ColumnSelections<RegionTable> conflictColumns,
    _is.ColumnSelections<RegionTable>? updateColumns,
    _is.WhereExpressionBuilder<RegionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Region>(
      row,
      conflictColumns: conflictColumns(Region.t),
      updateColumns: updateColumns?.call(Region.t),
      updateWhere: updateWhere?.call(Region.t),
      transaction: transaction,
    );
  }

  /// Updates all [Region]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Region>> update(
    _is.DatabaseSession session,
    List<Region> rows, {
    _is.ColumnSelections<RegionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Region>(
      rows,
      columns: columns?.call(Region.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Region]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Region> updateRow(
    _is.DatabaseSession session,
    Region row, {
    _is.ColumnSelections<RegionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Region>(
      row,
      columns: columns?.call(Region.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Region] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Region?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RegionUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Region>(
      id,
      columnValues: columnValues(Region.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Region]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Region>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RegionUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RegionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RegionTable>? orderBy,
    _is.OrderByListBuilder<RegionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Region>(
      columnValues: columnValues(Region.t.updateTable),
      where: where(Region.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Region]s in the list and returns the deleted rows.
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
  Future<List<Region>> delete(
    _is.DatabaseSession session,
    List<Region> rows, {
    _is.OrderByBuilder<RegionTable>? orderBy,
    _is.OrderByListBuilder<RegionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Region>(
      rows,
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Region].
  Future<Region> deleteRow(
    _is.DatabaseSession session,
    Region row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Region>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Region>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RegionTable> where,
    _is.OrderByBuilder<RegionTable>? orderBy,
    _is.OrderByListBuilder<RegionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Region>(
      where: where(Region.t),
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RegionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Region>(
      where: where?.call(Region.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Region] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RegionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Region>(
      where: where(Region.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
