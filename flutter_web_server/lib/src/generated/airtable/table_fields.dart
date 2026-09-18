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

abstract class AirTableFields
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AirTableFields._({
    this.id,
    required this.field,
    required this.tablesId,
    this.tables,
    this.items,
  });

  factory AirTableFields({
    int? id,
    required String field,
    required int tablesId,
    _iiekz83j.AirTables? tables,
    List<_isilgdtt.AirTableItems>? items,
  }) = _AirTableFieldsImpl;

  factory AirTableFields.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTableFields(
      id: jsonSerialization['id'] as int?,
      field: jsonSerialization['field'] as String,
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

  static final t = AirTableFieldsTable();

  static const db = AirTableFieldsRepository._();

  @override
  int? id;

  String field;

  int tablesId;

  _iiekz83j.AirTables? tables;

  List<_isilgdtt.AirTableItems>? items;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AirTableFields]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AirTableFields copyWith({
    int? id,
    String? field,
    int? tablesId,
    _iiekz83j.AirTables? tables,
    List<_isilgdtt.AirTableItems>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AirTableFields',
      if (id != null) 'id': id,
      'field': field,
      'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJson(),
      if (items != null) 'items': items?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AirTableFields',
      if (id != null) 'id': id,
      'field': field,
      'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJsonForProtocol(),
      if (items != null)
        'items': items?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static AirTableFieldsInclude include({
    _iiekz83j.AirTablesInclude? tables,
    _isilgdtt.AirTableItemsIncludeList? items,
  }) {
    return AirTableFieldsInclude._(tables: tables, items: items);
  }

  static AirTableFieldsIncludeList includeList({
    _is.WhereExpressionBuilder<AirTableFieldsTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AirTableFieldsTable>? orderBy,
    _is.OrderByListBuilder<AirTableFieldsTable>? orderByList,
    AirTableFieldsInclude? include,
  }) {
    return AirTableFieldsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AirTableFields.t),
      orderByList: orderByList?.call(AirTableFields.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTableFieldsImpl extends AirTableFields {
  _AirTableFieldsImpl({
    int? id,
    required String field,
    required int tablesId,
    _iiekz83j.AirTables? tables,
    List<_isilgdtt.AirTableItems>? items,
  }) : super._(
         id: id,
         field: field,
         tablesId: tablesId,
         tables: tables,
         items: items,
       );

  /// Returns a shallow copy of this [AirTableFields]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AirTableFields copyWith({
    Object? id = _Undefined,
    String? field,
    int? tablesId,
    Object? tables = _Undefined,
    Object? items = _Undefined,
  }) {
    return AirTableFields(
      id: id is int? ? id : this.id,
      field: field ?? this.field,
      tablesId: tablesId ?? this.tablesId,
      tables: tables is _iiekz83j.AirTables? ? tables : this.tables?.copyWith(),
      items: items is List<_isilgdtt.AirTableItems>?
          ? items
          : this.items?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class AirTableFieldsUpdateTable extends _is.UpdateTable<AirTableFieldsTable> {
  AirTableFieldsUpdateTable(super.table);

  _is.ColumnValue<String, String> field(String value) =>
      _is.ColumnValue(table.field, value);

  _is.ColumnValue<int, int> tablesId(int value) =>
      _is.ColumnValue(table.tablesId, value);
}

class AirTableFieldsTable extends _is.Table<int?> {
  AirTableFieldsTable({super.tableRelation})
    : super(tableName: 'air_table_fields') {
    updateTable = AirTableFieldsUpdateTable(this);
    field = _is.ColumnString('field', this);
    tablesId = _is.ColumnInt('tablesId', this);
  }

  late final AirTableFieldsUpdateTable updateTable;

  late final _is.ColumnString field;

  late final _is.ColumnInt tablesId;

  _iiekz83j.AirTablesTable? _tables;

  _isilgdtt.AirTableItemsTable? ___items;

  _is.ManyRelation<_isilgdtt.AirTableItemsTable>? _items;

  _iiekz83j.AirTablesTable get tables {
    if (_tables != null) return _tables!;
    _tables = _is.createRelationTable(
      relationFieldName: 'tables',
      field: AirTableFields.t.tablesId,
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
      field: AirTableFields.t.id,
      foreignField: _isilgdtt.AirTableItems.t.fieldId,
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
      field: AirTableFields.t.id,
      foreignField: _isilgdtt.AirTableItems.t.fieldId,
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
  List<_is.Column> get columns => [id, field, tablesId];

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

class AirTableFieldsInclude extends _is.IncludeObject {
  AirTableFieldsInclude._({
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
  _is.Table<int?> get table => AirTableFields.t;
}

class AirTableFieldsIncludeList extends _is.IncludeList {
  AirTableFieldsIncludeList._({
    _is.WhereExpressionBuilder<AirTableFieldsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AirTableFields.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AirTableFields.t;
}

class AirTableFieldsRepository {
  const AirTableFieldsRepository._();

  final attach = const AirTableFieldsAttachRepository._();

  final attachRow = const AirTableFieldsAttachRowRepository._();

  /// Returns a list of [AirTableFields]s matching the given query parameters.
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
  Future<List<AirTableFields>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AirTableFieldsTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AirTableFieldsTable>? orderBy,
    _is.OrderByListBuilder<AirTableFieldsTable>? orderByList,
    _is.Transaction? transaction,
    AirTableFieldsInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AirTableFields>(
      where: where?.call(AirTableFields.t),
      orderBy: orderBy?.call(AirTableFields.t),
      orderByList: orderByList?.call(AirTableFields.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AirTableFields] matching the given query parameters.
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
  Future<AirTableFields?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AirTableFieldsTable>? where,
    int? offset,
    _is.OrderByBuilder<AirTableFieldsTable>? orderBy,
    _is.OrderByListBuilder<AirTableFieldsTable>? orderByList,
    _is.Transaction? transaction,
    AirTableFieldsInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AirTableFields>(
      where: where?.call(AirTableFields.t),
      orderBy: orderBy?.call(AirTableFields.t),
      orderByList: orderByList?.call(AirTableFields.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AirTableFields] by its [id] or null if no such row exists.
  Future<AirTableFields?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    AirTableFieldsInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AirTableFields>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AirTableFields]s in the list and returns the inserted rows.
  ///
  /// The returned [AirTableFields]s will have their `id` fields set.
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
  Future<List<AirTableFields>> insert(
    _is.DatabaseSession session,
    List<AirTableFields> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AirTableFields>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AirTableFields] and returns the inserted row.
  ///
  /// The returned [AirTableFields] will have its `id` field set.
  Future<AirTableFields> insertRow(
    _is.DatabaseSession session,
    AirTableFields row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AirTableFields>(row, transaction: transaction);
  }

  /// Upserts all [AirTableFields]s in the list and returns the resulting rows.
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
  /// The returned [AirTableFields]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTableFields>> upsert(
    _is.DatabaseSession session,
    List<AirTableFields> rows, {
    required _is.ColumnSelections<AirTableFieldsTable> conflictColumns,
    _is.ColumnSelections<AirTableFieldsTable>? updateColumns,
    _is.WhereExpressionBuilder<AirTableFieldsTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AirTableFields>(
      rows,
      conflictColumns: conflictColumns(AirTableFields.t),
      updateColumns: updateColumns?.call(AirTableFields.t),
      updateWhere: updateWhere?.call(AirTableFields.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AirTableFields] and returns the resulting row.
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
  /// The returned [AirTableFields] will have its `id` field set.
  Future<AirTableFields?> upsertRow(
    _is.DatabaseSession session,
    AirTableFields row, {
    required _is.ColumnSelections<AirTableFieldsTable> conflictColumns,
    _is.ColumnSelections<AirTableFieldsTable>? updateColumns,
    _is.WhereExpressionBuilder<AirTableFieldsTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AirTableFields>(
      row,
      conflictColumns: conflictColumns(AirTableFields.t),
      updateColumns: updateColumns?.call(AirTableFields.t),
      updateWhere: updateWhere?.call(AirTableFields.t),
      transaction: transaction,
    );
  }

  /// Updates all [AirTableFields]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTableFields>> update(
    _is.DatabaseSession session,
    List<AirTableFields> rows, {
    _is.ColumnSelections<AirTableFieldsTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AirTableFields>(
      rows,
      columns: columns?.call(AirTableFields.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AirTableFields]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AirTableFields> updateRow(
    _is.DatabaseSession session,
    AirTableFields row, {
    _is.ColumnSelections<AirTableFieldsTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AirTableFields>(
      row,
      columns: columns?.call(AirTableFields.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AirTableFields] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AirTableFields?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AirTableFieldsUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AirTableFields>(
      id,
      columnValues: columnValues(AirTableFields.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AirTableFields]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTableFields>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AirTableFieldsUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AirTableFieldsTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AirTableFieldsTable>? orderBy,
    _is.OrderByListBuilder<AirTableFieldsTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AirTableFields>(
      columnValues: columnValues(AirTableFields.t.updateTable),
      where: where(AirTableFields.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AirTableFields.t),
      orderByList: orderByList?.call(AirTableFields.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AirTableFields]s in the list and returns the deleted rows.
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
  Future<List<AirTableFields>> delete(
    _is.DatabaseSession session,
    List<AirTableFields> rows, {
    _is.OrderByBuilder<AirTableFieldsTable>? orderBy,
    _is.OrderByListBuilder<AirTableFieldsTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AirTableFields>(
      rows,
      orderBy: orderBy?.call(AirTableFields.t),
      orderByList: orderByList?.call(AirTableFields.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AirTableFields].
  Future<AirTableFields> deleteRow(
    _is.DatabaseSession session,
    AirTableFields row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AirTableFields>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTableFields>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AirTableFieldsTable> where,
    _is.OrderByBuilder<AirTableFieldsTable>? orderBy,
    _is.OrderByListBuilder<AirTableFieldsTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AirTableFields>(
      where: where(AirTableFields.t),
      orderBy: orderBy?.call(AirTableFields.t),
      orderByList: orderByList?.call(AirTableFields.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AirTableFieldsTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AirTableFields>(
      where: where?.call(AirTableFields.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AirTableFields] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AirTableFieldsTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AirTableFields>(
      where: where(AirTableFields.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AirTableFieldsAttachRepository {
  const AirTableFieldsAttachRepository._();

  /// Creates a relation between this [AirTableFields] and the given [AirTableItems]s
  /// by setting each [AirTableItems]'s foreign key `fieldId` to refer to this [AirTableFields].
  Future<void> items(
    _is.DatabaseSession session,
    AirTableFields airTableFields,
    List<_isilgdtt.AirTableItems> airTableItems, {
    _is.Transaction? transaction,
  }) async {
    if (airTableItems.any((e) => e.id == null)) {
      throw ArgumentError.notNull('airTableItems.id');
    }
    if (airTableFields.id == null) {
      throw ArgumentError.notNull('airTableFields.id');
    }

    var $airTableItems = airTableItems
        .map((e) => e.copyWith(fieldId: airTableFields.id))
        .toList();
    await session.db.update<_isilgdtt.AirTableItems>(
      $airTableItems,
      columns: [_isilgdtt.AirTableItems.t.fieldId],
      transaction: transaction,
    );
  }
}

class AirTableFieldsAttachRowRepository {
  const AirTableFieldsAttachRowRepository._();

  /// Creates a relation between the given [AirTableFields] and [AirTables]
  /// by setting the [AirTableFields]'s foreign key `tablesId` to refer to the [AirTables].
  Future<void> tables(
    _is.DatabaseSession session,
    AirTableFields airTableFields,
    _iiekz83j.AirTables tables, {
    _is.Transaction? transaction,
  }) async {
    if (airTableFields.id == null) {
      throw ArgumentError.notNull('airTableFields.id');
    }
    if (tables.id == null) {
      throw ArgumentError.notNull('tables.id');
    }

    var $airTableFields = airTableFields.copyWith(tablesId: tables.id);
    await session.db.updateRow<AirTableFields>(
      $airTableFields,
      columns: [AirTableFields.t.tablesId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [AirTableFields] and the given [AirTableItems]
  /// by setting the [AirTableItems]'s foreign key `fieldId` to refer to this [AirTableFields].
  Future<void> items(
    _is.DatabaseSession session,
    AirTableFields airTableFields,
    _isilgdtt.AirTableItems airTableItems, {
    _is.Transaction? transaction,
  }) async {
    if (airTableItems.id == null) {
      throw ArgumentError.notNull('airTableItems.id');
    }
    if (airTableFields.id == null) {
      throw ArgumentError.notNull('airTableFields.id');
    }

    var $airTableItems = airTableItems.copyWith(fieldId: airTableFields.id);
    await session.db.updateRow<_isilgdtt.AirTableItems>(
      $airTableItems,
      columns: [_isilgdtt.AirTableItems.t.fieldId],
      transaction: transaction,
    );
  }
}
