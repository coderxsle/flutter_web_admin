/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_web_server/src/generated/protocol.dart' as _ii4hkddg;
import 'package:serverpod/serverpod.dart' as _is;
import '../airtable/table_items.dart' as _isilgdtt;
import '../airtable/tables.dart' as _iiekz83j;

abstract class AirTableRows
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AirTableRows._({
    this.id,
    required this.index,
    required this.tablesId,
    this.tables,
    this.items,
  });

  factory AirTableRows({
    int? id,
    required int index,
    required int tablesId,
    _iiekz83j.AirTables? tables,
    List<_isilgdtt.AirTableItems>? items,
  }) = _AirTableRowsImpl;

  factory AirTableRows.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTableRows(
      id: jsonSerialization['id'] as int?,
      index: jsonSerialization['index'] as int,
      tablesId: jsonSerialization['tablesId'] as int,
      tables: jsonSerialization['tables'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<_iiekz83j.AirTables>(
              jsonSerialization['tables'],
            ),
      items: jsonSerialization['items'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<List<_isilgdtt.AirTableItems>>(
              jsonSerialization['items'],
            ),
    );
  }

  static final t = AirTableRowsTable();

  static const db = AirTableRowsRepository._();

  @override
  int? id;

  int index;

  int tablesId;

  _iiekz83j.AirTables? tables;

  List<_isilgdtt.AirTableItems>? items;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AirTableRows]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AirTableRows copyWith({
    int? id,
    int? index,
    int? tablesId,
    _iiekz83j.AirTables? tables,
    List<_isilgdtt.AirTableItems>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AirTableRows',
      if (id != null) 'id': id,
      'index': index,
      'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJson(),
      if (items != null) 'items': items?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AirTableRows',
      if (id != null) 'id': id,
      'index': index,
      'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJsonForProtocol(),
      if (items != null)
        'items': items?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static AirTableRowsInclude include({
    _iiekz83j.AirTablesInclude? tables,
    _isilgdtt.AirTableItemsIncludeList? items,
  }) {
    return AirTableRowsInclude._(tables: tables, items: items);
  }

  static AirTableRowsIncludeList includeList({
    _is.WhereExpressionBuilder<AirTableRowsTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AirTableRowsTable>? orderBy,
    _is.OrderByListBuilder<AirTableRowsTable>? orderByList,
    AirTableRowsInclude? include,
  }) {
    return AirTableRowsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AirTableRows.t),
      orderByList: orderByList?.call(AirTableRows.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTableRowsImpl extends AirTableRows {
  _AirTableRowsImpl({
    int? id,
    required int index,
    required int tablesId,
    _iiekz83j.AirTables? tables,
    List<_isilgdtt.AirTableItems>? items,
  }) : super._(
         id: id,
         index: index,
         tablesId: tablesId,
         tables: tables,
         items: items,
       );

  /// Returns a shallow copy of this [AirTableRows]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AirTableRows copyWith({
    Object? id = _Undefined,
    int? index,
    int? tablesId,
    Object? tables = _Undefined,
    Object? items = _Undefined,
  }) {
    return AirTableRows(
      id: id is int? ? id : this.id,
      index: index ?? this.index,
      tablesId: tablesId ?? this.tablesId,
      tables: tables is _iiekz83j.AirTables? ? tables : this.tables?.copyWith(),
      items: items is List<_isilgdtt.AirTableItems>?
          ? items
          : this.items?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class AirTableRowsUpdateTable extends _is.UpdateTable<AirTableRowsTable> {
  AirTableRowsUpdateTable(super.table);

  _is.ColumnValue<int, int> index(int value) =>
      _is.ColumnValue(table.index, value);

  _is.ColumnValue<int, int> tablesId(int value) =>
      _is.ColumnValue(table.tablesId, value);
}

class AirTableRowsTable extends _is.Table<int?> {
  AirTableRowsTable({super.tableRelation})
    : super(tableName: 'air_table_rows') {
    updateTable = AirTableRowsUpdateTable(this);
    index = _is.ColumnInt('index', this);
    tablesId = _is.ColumnInt('tablesId', this);
  }

  late final AirTableRowsUpdateTable updateTable;

  late final _is.ColumnInt index;

  late final _is.ColumnInt tablesId;

  _iiekz83j.AirTablesTable? _tables;

  _isilgdtt.AirTableItemsTable? ___items;

  _is.ManyRelation<_isilgdtt.AirTableItemsTable>? _items;

  _iiekz83j.AirTablesTable get tables {
    if (_tables != null) return _tables!;
    _tables = _is.createRelationTable(
      relationFieldName: 'tables',
      field: AirTableRows.t.tablesId,
      foreignField: _iiekz83j.AirTables.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iiekz83j.AirTablesTable(tableRelation: foreignTableRelation),
    );
    return _tables!;
  }

  _isilgdtt.AirTableItemsTable get __items {
    if (___items != null) return ___items!;
    ___items = _is.createRelationTable(
      relationFieldName: '__items',
      field: AirTableRows.t.id,
      foreignField: _isilgdtt.AirTableItems.t.rowId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _isilgdtt.AirTableItemsTable(tableRelation: foreignTableRelation),
    );
    return ___items!;
  }

  _is.ManyRelation<_isilgdtt.AirTableItemsTable> get items {
    if (_items != null) return _items!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'items',
      field: AirTableRows.t.id,
      foreignField: _isilgdtt.AirTableItems.t.rowId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _isilgdtt.AirTableItemsTable(tableRelation: foreignTableRelation),
    );
    _items = _is.ManyRelation<_isilgdtt.AirTableItemsTable>(
      tableWithRelations: relationTable,
      table: _isilgdtt.AirTableItemsTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _items!;
  }

  @override
  List<_is.Column> get columns => [id, index, tablesId];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'tables') {
      return tables;
    }
    if (relationField == 'items') {
      return __items;
    }
    return null;
  }
}

class AirTableRowsInclude extends _is.IncludeObject {
  AirTableRowsInclude._({
    _iiekz83j.AirTablesInclude? tables,
    _isilgdtt.AirTableItemsIncludeList? items,
  }) {
    _tables = tables;
    _items = items;
  }

  _iiekz83j.AirTablesInclude? _tables;

  _isilgdtt.AirTableItemsIncludeList? _items;

  @override
  Map<String, _is.Include?> get includes => {
    'tables': _tables,
    'items': _items,
  };

  @override
  _is.Table<int?> get table => AirTableRows.t;
}

class AirTableRowsIncludeList extends _is.IncludeList {
  AirTableRowsIncludeList._({
    _is.WhereExpressionBuilder<AirTableRowsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AirTableRows.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AirTableRows.t;
}

class AirTableRowsRepository {
  const AirTableRowsRepository._();

  final attach = const AirTableRowsAttachRepository._();

  final attachRow = const AirTableRowsAttachRowRepository._();

  /// Returns a list of [AirTableRows]s matching the given query parameters.
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
  Future<List<AirTableRows>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AirTableRowsTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AirTableRowsTable>? orderBy,
    _is.OrderByListBuilder<AirTableRowsTable>? orderByList,
    _is.Transaction? transaction,
    AirTableRowsInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AirTableRows>(
      where: where?.call(AirTableRows.t),
      orderBy: orderBy?.call(AirTableRows.t),
      orderByList: orderByList?.call(AirTableRows.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AirTableRows] matching the given query parameters.
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
  Future<AirTableRows?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AirTableRowsTable>? where,
    int? offset,
    _is.OrderByBuilder<AirTableRowsTable>? orderBy,
    _is.OrderByListBuilder<AirTableRowsTable>? orderByList,
    _is.Transaction? transaction,
    AirTableRowsInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AirTableRows>(
      where: where?.call(AirTableRows.t),
      orderBy: orderBy?.call(AirTableRows.t),
      orderByList: orderByList?.call(AirTableRows.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AirTableRows] by its [id] or null if no such row exists.
  Future<AirTableRows?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    AirTableRowsInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AirTableRows>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AirTableRows]s in the list and returns the inserted rows.
  ///
  /// The returned [AirTableRows]s will have their `id` fields set.
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
  Future<List<AirTableRows>> insert(
    _is.DatabaseSession session,
    List<AirTableRows> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AirTableRows>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AirTableRows] and returns the inserted row.
  ///
  /// The returned [AirTableRows] will have its `id` field set.
  Future<AirTableRows> insertRow(
    _is.DatabaseSession session,
    AirTableRows row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AirTableRows>(row, transaction: transaction);
  }

  /// Upserts all [AirTableRows]s in the list and returns the resulting rows.
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
  /// The returned [AirTableRows]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTableRows>> upsert(
    _is.DatabaseSession session,
    List<AirTableRows> rows, {
    required _is.ColumnSelections<AirTableRowsTable> conflictColumns,
    _is.ColumnSelections<AirTableRowsTable>? updateColumns,
    _is.WhereExpressionBuilder<AirTableRowsTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AirTableRows>(
      rows,
      conflictColumns: conflictColumns(AirTableRows.t),
      updateColumns: updateColumns?.call(AirTableRows.t),
      updateWhere: updateWhere?.call(AirTableRows.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AirTableRows] and returns the resulting row.
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
  /// The returned [AirTableRows] will have its `id` field set.
  Future<AirTableRows?> upsertRow(
    _is.DatabaseSession session,
    AirTableRows row, {
    required _is.ColumnSelections<AirTableRowsTable> conflictColumns,
    _is.ColumnSelections<AirTableRowsTable>? updateColumns,
    _is.WhereExpressionBuilder<AirTableRowsTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AirTableRows>(
      row,
      conflictColumns: conflictColumns(AirTableRows.t),
      updateColumns: updateColumns?.call(AirTableRows.t),
      updateWhere: updateWhere?.call(AirTableRows.t),
      transaction: transaction,
    );
  }

  /// Updates all [AirTableRows]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTableRows>> update(
    _is.DatabaseSession session,
    List<AirTableRows> rows, {
    _is.ColumnSelections<AirTableRowsTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AirTableRows>(
      rows,
      columns: columns?.call(AirTableRows.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AirTableRows]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AirTableRows> updateRow(
    _is.DatabaseSession session,
    AirTableRows row, {
    _is.ColumnSelections<AirTableRowsTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AirTableRows>(
      row,
      columns: columns?.call(AirTableRows.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AirTableRows] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AirTableRows?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AirTableRowsUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AirTableRows>(
      id,
      columnValues: columnValues(AirTableRows.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AirTableRows]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTableRows>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AirTableRowsUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AirTableRowsTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AirTableRowsTable>? orderBy,
    _is.OrderByListBuilder<AirTableRowsTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AirTableRows>(
      columnValues: columnValues(AirTableRows.t.updateTable),
      where: where(AirTableRows.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AirTableRows.t),
      orderByList: orderByList?.call(AirTableRows.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AirTableRows]s in the list and returns the deleted rows.
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
  Future<List<AirTableRows>> delete(
    _is.DatabaseSession session,
    List<AirTableRows> rows, {
    _is.OrderByBuilder<AirTableRowsTable>? orderBy,
    _is.OrderByListBuilder<AirTableRowsTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AirTableRows>(
      rows,
      orderBy: orderBy?.call(AirTableRows.t),
      orderByList: orderByList?.call(AirTableRows.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AirTableRows].
  Future<AirTableRows> deleteRow(
    _is.DatabaseSession session,
    AirTableRows row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AirTableRows>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTableRows>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AirTableRowsTable> where,
    _is.OrderByBuilder<AirTableRowsTable>? orderBy,
    _is.OrderByListBuilder<AirTableRowsTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AirTableRows>(
      where: where(AirTableRows.t),
      orderBy: orderBy?.call(AirTableRows.t),
      orderByList: orderByList?.call(AirTableRows.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AirTableRowsTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AirTableRows>(
      where: where?.call(AirTableRows.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AirTableRows] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AirTableRowsTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AirTableRows>(
      where: where(AirTableRows.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AirTableRowsAttachRepository {
  const AirTableRowsAttachRepository._();

  /// Creates a relation between this [AirTableRows] and the given [AirTableItems]s
  /// by setting each [AirTableItems]'s foreign key `rowId` to refer to this [AirTableRows].
  Future<void> items(
    _is.DatabaseSession session,
    AirTableRows airTableRows,
    List<_isilgdtt.AirTableItems> airTableItems, {
    _is.Transaction? transaction,
  }) async {
    if (airTableItems.any((e) => e.id == null)) {
      throw ArgumentError.notNull('airTableItems.id');
    }
    if (airTableRows.id == null) {
      throw ArgumentError.notNull('airTableRows.id');
    }

    var $airTableItems = airTableItems
        .map((e) => e.copyWith(rowId: airTableRows.id))
        .toList();
    await session.db.update<_isilgdtt.AirTableItems>(
      $airTableItems,
      columns: [_isilgdtt.AirTableItems.t.rowId],
      transaction: transaction,
    );
  }
}

class AirTableRowsAttachRowRepository {
  const AirTableRowsAttachRowRepository._();

  /// Creates a relation between the given [AirTableRows] and [AirTables]
  /// by setting the [AirTableRows]'s foreign key `tablesId` to refer to the [AirTables].
  Future<void> tables(
    _is.DatabaseSession session,
    AirTableRows airTableRows,
    _iiekz83j.AirTables tables, {
    _is.Transaction? transaction,
  }) async {
    if (airTableRows.id == null) {
      throw ArgumentError.notNull('airTableRows.id');
    }
    if (tables.id == null) {
      throw ArgumentError.notNull('tables.id');
    }

    var $airTableRows = airTableRows.copyWith(tablesId: tables.id);
    await session.db.updateRow<AirTableRows>(
      $airTableRows,
      columns: [AirTableRows.t.tablesId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [AirTableRows] and the given [AirTableItems]
  /// by setting the [AirTableItems]'s foreign key `rowId` to refer to this [AirTableRows].
  Future<void> items(
    _is.DatabaseSession session,
    AirTableRows airTableRows,
    _isilgdtt.AirTableItems airTableItems, {
    _is.Transaction? transaction,
  }) async {
    if (airTableItems.id == null) {
      throw ArgumentError.notNull('airTableItems.id');
    }
    if (airTableRows.id == null) {
      throw ArgumentError.notNull('airTableRows.id');
    }

    var $airTableItems = airTableItems.copyWith(rowId: airTableRows.id);
    await session.db.updateRow<_isilgdtt.AirTableItems>(
      $airTableItems,
      columns: [_isilgdtt.AirTableItems.t.rowId],
      transaction: transaction,
    );
  }
}
