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
import '../airtable/table_fields.dart' as _iu45wp51;
import '../airtable/table_items.dart' as _isilgdtt;
import '../airtable/table_rows.dart' as _iec57gt8;
import '../airtable/tables.dart' as _iiekz83j;

abstract class AirTableItems
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AirTableItems._({
    this.id,
    required this.value,
    required this.rowId,
    this.row,
    required this.fieldId,
    this.field,
    this.itemId,
    this.item,
    this.tablesId,
    this.tables,
  });

  factory AirTableItems({
    int? id,
    required String value,
    required int rowId,
    _iec57gt8.AirTableRows? row,
    required int fieldId,
    _iu45wp51.AirTableFields? field,
    int? itemId,
    _isilgdtt.AirTableItems? item,
    int? tablesId,
    _iiekz83j.AirTables? tables,
  }) = _AirTableItemsImpl;

  factory AirTableItems.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTableItems(
      id: jsonSerialization['id'] as int?,
      value: jsonSerialization['value'] as String,
      rowId: jsonSerialization['rowId'] as int,
      row: jsonSerialization['row'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<_iec57gt8.AirTableRows>(
              jsonSerialization['row'],
            ),
      fieldId: jsonSerialization['fieldId'] as int,
      field: jsonSerialization['field'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<_iu45wp51.AirTableFields>(
              jsonSerialization['field'],
            ),
      itemId: jsonSerialization['itemId'] as int?,
      item: jsonSerialization['item'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<_isilgdtt.AirTableItems>(
              jsonSerialization['item'],
            ),
      tablesId: jsonSerialization['tablesId'] as int?,
      tables: jsonSerialization['tables'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<_iiekz83j.AirTables>(
              jsonSerialization['tables'],
            ),
    );
  }

  static final t = AirTableItemsTable();

  static const db = AirTableItemsRepository._();

  @override
  int? id;

  String value;

  int rowId;

  _iec57gt8.AirTableRows? row;

  int fieldId;

  _iu45wp51.AirTableFields? field;

  int? itemId;

  _isilgdtt.AirTableItems? item;

  int? tablesId;

  _iiekz83j.AirTables? tables;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AirTableItems]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AirTableItems copyWith({
    int? id,
    String? value,
    int? rowId,
    _iec57gt8.AirTableRows? row,
    int? fieldId,
    _iu45wp51.AirTableFields? field,
    int? itemId,
    _isilgdtt.AirTableItems? item,
    int? tablesId,
    _iiekz83j.AirTables? tables,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AirTableItems',
      if (id != null) 'id': id,
      'value': value,
      'rowId': rowId,
      if (row != null) 'row': row?.toJson(),
      'fieldId': fieldId,
      if (field != null) 'field': field?.toJson(),
      if (itemId != null) 'itemId': itemId,
      if (item != null) 'item': item?.toJson(),
      if (tablesId != null) 'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AirTableItems',
      if (id != null) 'id': id,
      'value': value,
      'rowId': rowId,
      if (row != null) 'row': row?.toJsonForProtocol(),
      'fieldId': fieldId,
      if (field != null) 'field': field?.toJsonForProtocol(),
      if (itemId != null) 'itemId': itemId,
      if (item != null) 'item': item?.toJsonForProtocol(),
      if (tablesId != null) 'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJsonForProtocol(),
    };
  }

  static AirTableItemsInclude include({
    _iec57gt8.AirTableRowsInclude? row,
    _iu45wp51.AirTableFieldsInclude? field,
    _isilgdtt.AirTableItemsInclude? item,
    _iiekz83j.AirTablesInclude? tables,
  }) {
    return AirTableItemsInclude._(
      row: row,
      field: field,
      item: item,
      tables: tables,
    );
  }

  static AirTableItemsIncludeList includeList({
    _is.WhereExpressionBuilder<AirTableItemsTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AirTableItemsTable>? orderBy,
    _is.OrderByListBuilder<AirTableItemsTable>? orderByList,
    AirTableItemsInclude? include,
  }) {
    return AirTableItemsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AirTableItems.t),
      orderByList: orderByList?.call(AirTableItems.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTableItemsImpl extends AirTableItems {
  _AirTableItemsImpl({
    int? id,
    required String value,
    required int rowId,
    _iec57gt8.AirTableRows? row,
    required int fieldId,
    _iu45wp51.AirTableFields? field,
    int? itemId,
    _isilgdtt.AirTableItems? item,
    int? tablesId,
    _iiekz83j.AirTables? tables,
  }) : super._(
         id: id,
         value: value,
         rowId: rowId,
         row: row,
         fieldId: fieldId,
         field: field,
         itemId: itemId,
         item: item,
         tablesId: tablesId,
         tables: tables,
       );

  /// Returns a shallow copy of this [AirTableItems]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AirTableItems copyWith({
    Object? id = _Undefined,
    String? value,
    int? rowId,
    Object? row = _Undefined,
    int? fieldId,
    Object? field = _Undefined,
    Object? itemId = _Undefined,
    Object? item = _Undefined,
    Object? tablesId = _Undefined,
    Object? tables = _Undefined,
  }) {
    return AirTableItems(
      id: id is int? ? id : this.id,
      value: value ?? this.value,
      rowId: rowId ?? this.rowId,
      row: row is _iec57gt8.AirTableRows? ? row : this.row?.copyWith(),
      fieldId: fieldId ?? this.fieldId,
      field: field is _iu45wp51.AirTableFields?
          ? field
          : this.field?.copyWith(),
      itemId: itemId is int? ? itemId : this.itemId,
      item: item is _isilgdtt.AirTableItems? ? item : this.item?.copyWith(),
      tablesId: tablesId is int? ? tablesId : this.tablesId,
      tables: tables is _iiekz83j.AirTables? ? tables : this.tables?.copyWith(),
    );
  }
}

class AirTableItemsUpdateTable extends _is.UpdateTable<AirTableItemsTable> {
  AirTableItemsUpdateTable(super.table);

  _is.ColumnValue<String, String> value(String value) =>
      _is.ColumnValue(table.value, value);

  _is.ColumnValue<int, int> rowId(int value) =>
      _is.ColumnValue(table.rowId, value);

  _is.ColumnValue<int, int> fieldId(int value) =>
      _is.ColumnValue(table.fieldId, value);

  _is.ColumnValue<int, int> itemId(int? value) =>
      _is.ColumnValue(table.itemId, value);

  _is.ColumnValue<int, int> tablesId(int? value) =>
      _is.ColumnValue(table.tablesId, value);
}

class AirTableItemsTable extends _is.Table<int?> {
  AirTableItemsTable({super.tableRelation})
    : super(tableName: 'air_table_items') {
    updateTable = AirTableItemsUpdateTable(this);
    value = _is.ColumnString('value', this);
    rowId = _is.ColumnInt('rowId', this);
    fieldId = _is.ColumnInt('fieldId', this);
    itemId = _is.ColumnInt('itemId', this);
    tablesId = _is.ColumnInt('tablesId', this);
  }

  late final AirTableItemsUpdateTable updateTable;

  late final _is.ColumnString value;

  late final _is.ColumnInt rowId;

  _iec57gt8.AirTableRowsTable? _row;

  late final _is.ColumnInt fieldId;

  _iu45wp51.AirTableFieldsTable? _field;

  late final _is.ColumnInt itemId;

  _isilgdtt.AirTableItemsTable? _item;

  late final _is.ColumnInt tablesId;

  _iiekz83j.AirTablesTable? _tables;

  _iec57gt8.AirTableRowsTable get row {
    if (_row != null) return _row!;
    _row = _is.createRelationTable(
      relationFieldName: 'row',
      field: AirTableItems.t.rowId,
      foreignField: _iec57gt8.AirTableRows.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iec57gt8.AirTableRowsTable(tableRelation: foreignTableRelation),
    );
    return _row!;
  }

  _iu45wp51.AirTableFieldsTable get field {
    if (_field != null) return _field!;
    _field = _is.createRelationTable(
      relationFieldName: 'field',
      field: AirTableItems.t.fieldId,
      foreignField: _iu45wp51.AirTableFields.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iu45wp51.AirTableFieldsTable(tableRelation: foreignTableRelation),
    );
    return _field!;
  }

  _isilgdtt.AirTableItemsTable get item {
    if (_item != null) return _item!;
    _item = _is.createRelationTable(
      relationFieldName: 'item',
      field: AirTableItems.t.itemId,
      foreignField: _isilgdtt.AirTableItems.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _isilgdtt.AirTableItemsTable(tableRelation: foreignTableRelation),
    );
    return _item!;
  }

  _iiekz83j.AirTablesTable get tables {
    if (_tables != null) return _tables!;
    _tables = _is.createRelationTable(
      relationFieldName: 'tables',
      field: AirTableItems.t.tablesId,
      foreignField: _iiekz83j.AirTables.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iiekz83j.AirTablesTable(tableRelation: foreignTableRelation),
    );
    return _tables!;
  }

  @override
  List<_is.Column> get columns => [id, value, rowId, fieldId, itemId, tablesId];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'row') {
      return row;
    }
    if (relationField == 'field') {
      return field;
    }
    if (relationField == 'item') {
      return item;
    }
    if (relationField == 'tables') {
      return tables;
    }
    return null;
  }
}

class AirTableItemsInclude extends _is.IncludeObject {
  AirTableItemsInclude._({
    _iec57gt8.AirTableRowsInclude? row,
    _iu45wp51.AirTableFieldsInclude? field,
    _isilgdtt.AirTableItemsInclude? item,
    _iiekz83j.AirTablesInclude? tables,
  }) {
    _row = row;
    _field = field;
    _item = item;
    _tables = tables;
  }

  _iec57gt8.AirTableRowsInclude? _row;

  _iu45wp51.AirTableFieldsInclude? _field;

  _isilgdtt.AirTableItemsInclude? _item;

  _iiekz83j.AirTablesInclude? _tables;

  @override
  Map<String, _is.Include?> get includes => {
    'row': _row,
    'field': _field,
    'item': _item,
    'tables': _tables,
  };

  @override
  _is.Table<int?> get table => AirTableItems.t;
}

class AirTableItemsIncludeList extends _is.IncludeList {
  AirTableItemsIncludeList._({
    _is.WhereExpressionBuilder<AirTableItemsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AirTableItems.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AirTableItems.t;
}

class AirTableItemsRepository {
  const AirTableItemsRepository._();

  final attachRow = const AirTableItemsAttachRowRepository._();

  final detachRow = const AirTableItemsDetachRowRepository._();

  /// Returns a list of [AirTableItems]s matching the given query parameters.
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
  Future<List<AirTableItems>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AirTableItemsTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AirTableItemsTable>? orderBy,
    _is.OrderByListBuilder<AirTableItemsTable>? orderByList,
    _is.Transaction? transaction,
    AirTableItemsInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AirTableItems>(
      where: where?.call(AirTableItems.t),
      orderBy: orderBy?.call(AirTableItems.t),
      orderByList: orderByList?.call(AirTableItems.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AirTableItems] matching the given query parameters.
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
  Future<AirTableItems?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AirTableItemsTable>? where,
    int? offset,
    _is.OrderByBuilder<AirTableItemsTable>? orderBy,
    _is.OrderByListBuilder<AirTableItemsTable>? orderByList,
    _is.Transaction? transaction,
    AirTableItemsInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AirTableItems>(
      where: where?.call(AirTableItems.t),
      orderBy: orderBy?.call(AirTableItems.t),
      orderByList: orderByList?.call(AirTableItems.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AirTableItems] by its [id] or null if no such row exists.
  Future<AirTableItems?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    AirTableItemsInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AirTableItems>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AirTableItems]s in the list and returns the inserted rows.
  ///
  /// The returned [AirTableItems]s will have their `id` fields set.
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
  Future<List<AirTableItems>> insert(
    _is.DatabaseSession session,
    List<AirTableItems> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AirTableItems>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AirTableItems] and returns the inserted row.
  ///
  /// The returned [AirTableItems] will have its `id` field set.
  Future<AirTableItems> insertRow(
    _is.DatabaseSession session,
    AirTableItems row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AirTableItems>(row, transaction: transaction);
  }

  /// Upserts all [AirTableItems]s in the list and returns the resulting rows.
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
  /// The returned [AirTableItems]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTableItems>> upsert(
    _is.DatabaseSession session,
    List<AirTableItems> rows, {
    required _is.ColumnSelections<AirTableItemsTable> conflictColumns,
    _is.ColumnSelections<AirTableItemsTable>? updateColumns,
    _is.WhereExpressionBuilder<AirTableItemsTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AirTableItems>(
      rows,
      conflictColumns: conflictColumns(AirTableItems.t),
      updateColumns: updateColumns?.call(AirTableItems.t),
      updateWhere: updateWhere?.call(AirTableItems.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AirTableItems] and returns the resulting row.
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
  /// The returned [AirTableItems] will have its `id` field set.
  Future<AirTableItems?> upsertRow(
    _is.DatabaseSession session,
    AirTableItems row, {
    required _is.ColumnSelections<AirTableItemsTable> conflictColumns,
    _is.ColumnSelections<AirTableItemsTable>? updateColumns,
    _is.WhereExpressionBuilder<AirTableItemsTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AirTableItems>(
      row,
      conflictColumns: conflictColumns(AirTableItems.t),
      updateColumns: updateColumns?.call(AirTableItems.t),
      updateWhere: updateWhere?.call(AirTableItems.t),
      transaction: transaction,
    );
  }

  /// Updates all [AirTableItems]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTableItems>> update(
    _is.DatabaseSession session,
    List<AirTableItems> rows, {
    _is.ColumnSelections<AirTableItemsTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AirTableItems>(
      rows,
      columns: columns?.call(AirTableItems.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AirTableItems]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AirTableItems> updateRow(
    _is.DatabaseSession session,
    AirTableItems row, {
    _is.ColumnSelections<AirTableItemsTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AirTableItems>(
      row,
      columns: columns?.call(AirTableItems.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AirTableItems] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AirTableItems?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AirTableItemsUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AirTableItems>(
      id,
      columnValues: columnValues(AirTableItems.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AirTableItems]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTableItems>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AirTableItemsUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AirTableItemsTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AirTableItemsTable>? orderBy,
    _is.OrderByListBuilder<AirTableItemsTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AirTableItems>(
      columnValues: columnValues(AirTableItems.t.updateTable),
      where: where(AirTableItems.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AirTableItems.t),
      orderByList: orderByList?.call(AirTableItems.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AirTableItems]s in the list and returns the deleted rows.
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
  Future<List<AirTableItems>> delete(
    _is.DatabaseSession session,
    List<AirTableItems> rows, {
    _is.OrderByBuilder<AirTableItemsTable>? orderBy,
    _is.OrderByListBuilder<AirTableItemsTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AirTableItems>(
      rows,
      orderBy: orderBy?.call(AirTableItems.t),
      orderByList: orderByList?.call(AirTableItems.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AirTableItems].
  Future<AirTableItems> deleteRow(
    _is.DatabaseSession session,
    AirTableItems row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AirTableItems>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTableItems>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AirTableItemsTable> where,
    _is.OrderByBuilder<AirTableItemsTable>? orderBy,
    _is.OrderByListBuilder<AirTableItemsTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AirTableItems>(
      where: where(AirTableItems.t),
      orderBy: orderBy?.call(AirTableItems.t),
      orderByList: orderByList?.call(AirTableItems.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AirTableItemsTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AirTableItems>(
      where: where?.call(AirTableItems.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AirTableItems] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AirTableItemsTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AirTableItems>(
      where: where(AirTableItems.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AirTableItemsAttachRowRepository {
  const AirTableItemsAttachRowRepository._();

  /// Creates a relation between the given [AirTableItems] and [AirTableRows]
  /// by setting the [AirTableItems]'s foreign key `rowId` to refer to the [AirTableRows].
  Future<void> row(
    _is.DatabaseSession session,
    AirTableItems airTableItems,
    _iec57gt8.AirTableRows row, {
    _is.Transaction? transaction,
  }) async {
    if (airTableItems.id == null) {
      throw ArgumentError.notNull('airTableItems.id');
    }
    if (row.id == null) {
      throw ArgumentError.notNull('row.id');
    }

    var $airTableItems = airTableItems.copyWith(rowId: row.id);
    await session.db.updateRow<AirTableItems>(
      $airTableItems,
      columns: [AirTableItems.t.rowId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [AirTableItems] and [AirTableFields]
  /// by setting the [AirTableItems]'s foreign key `fieldId` to refer to the [AirTableFields].
  Future<void> field(
    _is.DatabaseSession session,
    AirTableItems airTableItems,
    _iu45wp51.AirTableFields field, {
    _is.Transaction? transaction,
  }) async {
    if (airTableItems.id == null) {
      throw ArgumentError.notNull('airTableItems.id');
    }
    if (field.id == null) {
      throw ArgumentError.notNull('field.id');
    }

    var $airTableItems = airTableItems.copyWith(fieldId: field.id);
    await session.db.updateRow<AirTableItems>(
      $airTableItems,
      columns: [AirTableItems.t.fieldId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [AirTableItems] and [AirTableItems]
  /// by setting the [AirTableItems]'s foreign key `itemId` to refer to the [AirTableItems].
  Future<void> item(
    _is.DatabaseSession session,
    AirTableItems airTableItems,
    _isilgdtt.AirTableItems item, {
    _is.Transaction? transaction,
  }) async {
    if (airTableItems.id == null) {
      throw ArgumentError.notNull('airTableItems.id');
    }
    if (item.id == null) {
      throw ArgumentError.notNull('item.id');
    }

    var $airTableItems = airTableItems.copyWith(itemId: item.id);
    await session.db.updateRow<AirTableItems>(
      $airTableItems,
      columns: [AirTableItems.t.itemId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [AirTableItems] and [AirTables]
  /// by setting the [AirTableItems]'s foreign key `tablesId` to refer to the [AirTables].
  Future<void> tables(
    _is.DatabaseSession session,
    AirTableItems airTableItems,
    _iiekz83j.AirTables tables, {
    _is.Transaction? transaction,
  }) async {
    if (airTableItems.id == null) {
      throw ArgumentError.notNull('airTableItems.id');
    }
    if (tables.id == null) {
      throw ArgumentError.notNull('tables.id');
    }

    var $airTableItems = airTableItems.copyWith(tablesId: tables.id);
    await session.db.updateRow<AirTableItems>(
      $airTableItems,
      columns: [AirTableItems.t.tablesId],
      transaction: transaction,
    );
  }
}

class AirTableItemsDetachRowRepository {
  const AirTableItemsDetachRowRepository._();

  /// Detaches the relation between this [AirTableItems] and the [AirTableItems] set in `item`
  /// by setting the [AirTableItems]'s foreign key `itemId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> item(
    _is.DatabaseSession session,
    AirTableItems airTableItems, {
    _is.Transaction? transaction,
  }) async {
    if (airTableItems.id == null) {
      throw ArgumentError.notNull('airTableItems.id');
    }

    var $airTableItems = airTableItems.copyWith(itemId: null);
    await session.db.updateRow<AirTableItems>(
      $airTableItems,
      columns: [AirTableItems.t.itemId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [AirTableItems] and the [AirTables] set in `tables`
  /// by setting the [AirTableItems]'s foreign key `tablesId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> tables(
    _is.DatabaseSession session,
    AirTableItems airTableItems, {
    _is.Transaction? transaction,
  }) async {
    if (airTableItems.id == null) {
      throw ArgumentError.notNull('airTableItems.id');
    }

    var $airTableItems = airTableItems.copyWith(tablesId: null);
    await session.db.updateRow<AirTableItems>(
      $airTableItems,
      columns: [AirTableItems.t.tablesId],
      transaction: transaction,
    );
  }
}
