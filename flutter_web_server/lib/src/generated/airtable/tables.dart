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
import '../airtable/table_rows.dart' as _iec57gt8;

abstract class AirTables
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AirTables._({this.id, required this.name, this.fields, this.rows});

  factory AirTables({
    int? id,
    required String name,
    List<_iu45wp51.AirTableFields>? fields,
    List<_iec57gt8.AirTableRows>? rows,
  }) = _AirTablesImpl;

  factory AirTables.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTables(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      fields: jsonSerialization['fields'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<List<_iu45wp51.AirTableFields>>(
              jsonSerialization['fields'],
            ),
      rows: jsonSerialization['rows'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<List<_iec57gt8.AirTableRows>>(
              jsonSerialization['rows'],
            ),
    );
  }

  static final t = AirTablesTable();

  static const db = AirTablesRepository._();

  @override
  int? id;

  String name;

  List<_iu45wp51.AirTableFields>? fields;

  List<_iec57gt8.AirTableRows>? rows;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AirTables]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AirTables copyWith({
    int? id,
    String? name,
    List<_iu45wp51.AirTableFields>? fields,
    List<_iec57gt8.AirTableRows>? rows,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AirTables',
      if (id != null) 'id': id,
      'name': name,
      if (fields != null)
        'fields': fields?.toJson(valueToJson: (v) => v.toJson()),
      if (rows != null) 'rows': rows?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AirTables',
      if (id != null) 'id': id,
      'name': name,
      if (fields != null)
        'fields': fields?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (rows != null)
        'rows': rows?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static AirTablesInclude include({
    _iu45wp51.AirTableFieldsIncludeList? fields,
    _iec57gt8.AirTableRowsIncludeList? rows,
  }) {
    return AirTablesInclude._(fields: fields, rows: rows);
  }

  static AirTablesIncludeList includeList({
    _is.WhereExpressionBuilder<AirTablesTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AirTablesTable>? orderBy,
    _is.OrderByListBuilder<AirTablesTable>? orderByList,
    AirTablesInclude? include,
  }) {
    return AirTablesIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AirTables.t),
      orderByList: orderByList?.call(AirTables.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTablesImpl extends AirTables {
  _AirTablesImpl({
    int? id,
    required String name,
    List<_iu45wp51.AirTableFields>? fields,
    List<_iec57gt8.AirTableRows>? rows,
  }) : super._(id: id, name: name, fields: fields, rows: rows);

  /// Returns a shallow copy of this [AirTables]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AirTables copyWith({
    Object? id = _Undefined,
    String? name,
    Object? fields = _Undefined,
    Object? rows = _Undefined,
  }) {
    return AirTables(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      fields: fields is List<_iu45wp51.AirTableFields>?
          ? fields
          : this.fields?.map((e0) => e0.copyWith()).toList(),
      rows: rows is List<_iec57gt8.AirTableRows>?
          ? rows
          : this.rows?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class AirTablesUpdateTable extends _is.UpdateTable<AirTablesTable> {
  AirTablesUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);
}

class AirTablesTable extends _is.Table<int?> {
  AirTablesTable({super.tableRelation}) : super(tableName: 'air_tables') {
    updateTable = AirTablesUpdateTable(this);
    name = _is.ColumnString('name', this);
  }

  late final AirTablesUpdateTable updateTable;

  late final _is.ColumnString name;

  _iu45wp51.AirTableFieldsTable? ___fields;

  _is.ManyRelation<_iu45wp51.AirTableFieldsTable>? _fields;

  _iec57gt8.AirTableRowsTable? ___rows;

  _is.ManyRelation<_iec57gt8.AirTableRowsTable>? _rows;

  _iu45wp51.AirTableFieldsTable get __fields {
    if (___fields != null) return ___fields!;
    ___fields = _is.createRelationTable(
      relationFieldName: '__fields',
      field: AirTables.t.id,
      foreignField: _iu45wp51.AirTableFields.t.tablesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iu45wp51.AirTableFieldsTable(tableRelation: foreignTableRelation),
    );
    return ___fields!;
  }

  _iec57gt8.AirTableRowsTable get __rows {
    if (___rows != null) return ___rows!;
    ___rows = _is.createRelationTable(
      relationFieldName: '__rows',
      field: AirTables.t.id,
      foreignField: _iec57gt8.AirTableRows.t.tablesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iec57gt8.AirTableRowsTable(tableRelation: foreignTableRelation),
    );
    return ___rows!;
  }

  _is.ManyRelation<_iu45wp51.AirTableFieldsTable> get fields {
    if (_fields != null) return _fields!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'fields',
      field: AirTables.t.id,
      foreignField: _iu45wp51.AirTableFields.t.tablesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iu45wp51.AirTableFieldsTable(tableRelation: foreignTableRelation),
    );
    _fields = _is.ManyRelation<_iu45wp51.AirTableFieldsTable>(
      tableWithRelations: relationTable,
      table: _iu45wp51.AirTableFieldsTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _fields!;
  }

  _is.ManyRelation<_iec57gt8.AirTableRowsTable> get rows {
    if (_rows != null) return _rows!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'rows',
      field: AirTables.t.id,
      foreignField: _iec57gt8.AirTableRows.t.tablesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iec57gt8.AirTableRowsTable(tableRelation: foreignTableRelation),
    );
    _rows = _is.ManyRelation<_iec57gt8.AirTableRowsTable>(
      tableWithRelations: relationTable,
      table: _iec57gt8.AirTableRowsTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _rows!;
  }

  @override
  List<_is.Column> get columns => [id, name];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'fields') {
      return __fields;
    }
    if (relationField == 'rows') {
      return __rows;
    }
    return null;
  }
}

class AirTablesInclude extends _is.IncludeObject {
  AirTablesInclude._({
    _iu45wp51.AirTableFieldsIncludeList? fields,
    _iec57gt8.AirTableRowsIncludeList? rows,
  }) {
    _fields = fields;
    _rows = rows;
  }

  _iu45wp51.AirTableFieldsIncludeList? _fields;

  _iec57gt8.AirTableRowsIncludeList? _rows;

  @override
  Map<String, _is.Include?> get includes => {'fields': _fields, 'rows': _rows};

  @override
  _is.Table<int?> get table => AirTables.t;
}

class AirTablesIncludeList extends _is.IncludeList {
  AirTablesIncludeList._({
    _is.WhereExpressionBuilder<AirTablesTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AirTables.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AirTables.t;
}

class AirTablesRepository {
  const AirTablesRepository._();

  final attach = const AirTablesAttachRepository._();

  final attachRow = const AirTablesAttachRowRepository._();

  /// Returns a list of [AirTables]s matching the given query parameters.
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
  Future<List<AirTables>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AirTablesTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AirTablesTable>? orderBy,
    _is.OrderByListBuilder<AirTablesTable>? orderByList,
    _is.Transaction? transaction,
    AirTablesInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AirTables>(
      where: where?.call(AirTables.t),
      orderBy: orderBy?.call(AirTables.t),
      orderByList: orderByList?.call(AirTables.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AirTables] matching the given query parameters.
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
  Future<AirTables?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AirTablesTable>? where,
    int? offset,
    _is.OrderByBuilder<AirTablesTable>? orderBy,
    _is.OrderByListBuilder<AirTablesTable>? orderByList,
    _is.Transaction? transaction,
    AirTablesInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AirTables>(
      where: where?.call(AirTables.t),
      orderBy: orderBy?.call(AirTables.t),
      orderByList: orderByList?.call(AirTables.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AirTables] by its [id] or null if no such row exists.
  Future<AirTables?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    AirTablesInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AirTables>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AirTables]s in the list and returns the inserted rows.
  ///
  /// The returned [AirTables]s will have their `id` fields set.
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
  Future<List<AirTables>> insert(
    _is.DatabaseSession session,
    List<AirTables> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AirTables>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AirTables] and returns the inserted row.
  ///
  /// The returned [AirTables] will have its `id` field set.
  Future<AirTables> insertRow(
    _is.DatabaseSession session,
    AirTables row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AirTables>(row, transaction: transaction);
  }

  /// Upserts all [AirTables]s in the list and returns the resulting rows.
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
  /// The returned [AirTables]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTables>> upsert(
    _is.DatabaseSession session,
    List<AirTables> rows, {
    required _is.ColumnSelections<AirTablesTable> conflictColumns,
    _is.ColumnSelections<AirTablesTable>? updateColumns,
    _is.WhereExpressionBuilder<AirTablesTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AirTables>(
      rows,
      conflictColumns: conflictColumns(AirTables.t),
      updateColumns: updateColumns?.call(AirTables.t),
      updateWhere: updateWhere?.call(AirTables.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AirTables] and returns the resulting row.
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
  /// The returned [AirTables] will have its `id` field set.
  Future<AirTables?> upsertRow(
    _is.DatabaseSession session,
    AirTables row, {
    required _is.ColumnSelections<AirTablesTable> conflictColumns,
    _is.ColumnSelections<AirTablesTable>? updateColumns,
    _is.WhereExpressionBuilder<AirTablesTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AirTables>(
      row,
      conflictColumns: conflictColumns(AirTables.t),
      updateColumns: updateColumns?.call(AirTables.t),
      updateWhere: updateWhere?.call(AirTables.t),
      transaction: transaction,
    );
  }

  /// Updates all [AirTables]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTables>> update(
    _is.DatabaseSession session,
    List<AirTables> rows, {
    _is.ColumnSelections<AirTablesTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AirTables>(
      rows,
      columns: columns?.call(AirTables.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AirTables]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AirTables> updateRow(
    _is.DatabaseSession session,
    AirTables row, {
    _is.ColumnSelections<AirTablesTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AirTables>(
      row,
      columns: columns?.call(AirTables.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AirTables] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AirTables?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AirTablesUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AirTables>(
      id,
      columnValues: columnValues(AirTables.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AirTables]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTables>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AirTablesUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AirTablesTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AirTablesTable>? orderBy,
    _is.OrderByListBuilder<AirTablesTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AirTables>(
      columnValues: columnValues(AirTables.t.updateTable),
      where: where(AirTables.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AirTables.t),
      orderByList: orderByList?.call(AirTables.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AirTables]s in the list and returns the deleted rows.
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
  Future<List<AirTables>> delete(
    _is.DatabaseSession session,
    List<AirTables> rows, {
    _is.OrderByBuilder<AirTablesTable>? orderBy,
    _is.OrderByListBuilder<AirTablesTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AirTables>(
      rows,
      orderBy: orderBy?.call(AirTables.t),
      orderByList: orderByList?.call(AirTables.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AirTables].
  Future<AirTables> deleteRow(
    _is.DatabaseSession session,
    AirTables row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AirTables>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AirTables>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AirTablesTable> where,
    _is.OrderByBuilder<AirTablesTable>? orderBy,
    _is.OrderByListBuilder<AirTablesTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AirTables>(
      where: where(AirTables.t),
      orderBy: orderBy?.call(AirTables.t),
      orderByList: orderByList?.call(AirTables.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AirTablesTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AirTables>(
      where: where?.call(AirTables.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AirTables] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AirTablesTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AirTables>(
      where: where(AirTables.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AirTablesAttachRepository {
  const AirTablesAttachRepository._();

  /// Creates a relation between this [AirTables] and the given [AirTableFields]s
  /// by setting each [AirTableFields]'s foreign key `tablesId` to refer to this [AirTables].
  Future<void> fields(
    _is.DatabaseSession session,
    AirTables airTables,
    List<_iu45wp51.AirTableFields> airTableFields, {
    _is.Transaction? transaction,
  }) async {
    if (airTableFields.any((e) => e.id == null)) {
      throw ArgumentError.notNull('airTableFields.id');
    }
    if (airTables.id == null) {
      throw ArgumentError.notNull('airTables.id');
    }

    var $airTableFields = airTableFields
        .map((e) => e.copyWith(tablesId: airTables.id))
        .toList();
    await session.db.update<_iu45wp51.AirTableFields>(
      $airTableFields,
      columns: [_iu45wp51.AirTableFields.t.tablesId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [AirTables] and the given [AirTableRows]s
  /// by setting each [AirTableRows]'s foreign key `tablesId` to refer to this [AirTables].
  Future<void> rows(
    _is.DatabaseSession session,
    AirTables airTables,
    List<_iec57gt8.AirTableRows> airTableRows, {
    _is.Transaction? transaction,
  }) async {
    if (airTableRows.any((e) => e.id == null)) {
      throw ArgumentError.notNull('airTableRows.id');
    }
    if (airTables.id == null) {
      throw ArgumentError.notNull('airTables.id');
    }

    var $airTableRows = airTableRows
        .map((e) => e.copyWith(tablesId: airTables.id))
        .toList();
    await session.db.update<_iec57gt8.AirTableRows>(
      $airTableRows,
      columns: [_iec57gt8.AirTableRows.t.tablesId],
      transaction: transaction,
    );
  }
}

class AirTablesAttachRowRepository {
  const AirTablesAttachRowRepository._();

  /// Creates a relation between this [AirTables] and the given [AirTableFields]
  /// by setting the [AirTableFields]'s foreign key `tablesId` to refer to this [AirTables].
  Future<void> fields(
    _is.DatabaseSession session,
    AirTables airTables,
    _iu45wp51.AirTableFields airTableFields, {
    _is.Transaction? transaction,
  }) async {
    if (airTableFields.id == null) {
      throw ArgumentError.notNull('airTableFields.id');
    }
    if (airTables.id == null) {
      throw ArgumentError.notNull('airTables.id');
    }

    var $airTableFields = airTableFields.copyWith(tablesId: airTables.id);
    await session.db.updateRow<_iu45wp51.AirTableFields>(
      $airTableFields,
      columns: [_iu45wp51.AirTableFields.t.tablesId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [AirTables] and the given [AirTableRows]
  /// by setting the [AirTableRows]'s foreign key `tablesId` to refer to this [AirTables].
  Future<void> rows(
    _is.DatabaseSession session,
    AirTables airTables,
    _iec57gt8.AirTableRows airTableRows, {
    _is.Transaction? transaction,
  }) async {
    if (airTableRows.id == null) {
      throw ArgumentError.notNull('airTableRows.id');
    }
    if (airTables.id == null) {
      throw ArgumentError.notNull('airTables.id');
    }

    var $airTableRows = airTableRows.copyWith(tablesId: airTables.id);
    await session.db.updateRow<_iec57gt8.AirTableRows>(
      $airTableRows,
      columns: [_iec57gt8.AirTableRows.t.tablesId],
      transaction: transaction,
    );
  }
}
