/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../airtable/tables.dart' as _i2;
import '../airtable/table_items.dart' as _i3;

abstract class AirTableRows
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    _i2.AirTables? tables,
    List<_i3.AirTableItems>? items,
  }) = _AirTableRowsImpl;

  factory AirTableRows.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTableRows(
      id: jsonSerialization['id'] as int?,
      index: jsonSerialization['index'] as int,
      tablesId: jsonSerialization['tablesId'] as int,
      tables: jsonSerialization['tables'] == null
          ? null
          : _i2.AirTables.fromJson(
              (jsonSerialization['tables'] as Map<String, dynamic>)),
      items: (jsonSerialization['items'] as List?)
          ?.map((e) => _i3.AirTableItems.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = AirTableRowsTable();

  static const db = AirTableRowsRepository._();

  @override
  int? id;

  int index;

  int tablesId;

  _i2.AirTables? tables;

  List<_i3.AirTableItems>? items;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AirTableRows]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AirTableRows copyWith({
    int? id,
    int? index,
    int? tablesId,
    _i2.AirTables? tables,
    List<_i3.AirTableItems>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
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
      if (id != null) 'id': id,
      'index': index,
      'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJsonForProtocol(),
      if (items != null)
        'items': items?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static AirTableRowsInclude include({
    _i2.AirTablesInclude? tables,
    _i3.AirTableItemsIncludeList? items,
  }) {
    return AirTableRowsInclude._(
      tables: tables,
      items: items,
    );
  }

  static AirTableRowsIncludeList includeList({
    _i1.WhereExpressionBuilder<AirTableRowsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AirTableRowsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AirTableRowsTable>? orderByList,
    AirTableRowsInclude? include,
  }) {
    return AirTableRowsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AirTableRows.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AirTableRows.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTableRowsImpl extends AirTableRows {
  _AirTableRowsImpl({
    int? id,
    required int index,
    required int tablesId,
    _i2.AirTables? tables,
    List<_i3.AirTableItems>? items,
  }) : super._(
          id: id,
          index: index,
          tablesId: tablesId,
          tables: tables,
          items: items,
        );

  /// Returns a shallow copy of this [AirTableRows]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
      tables: tables is _i2.AirTables? ? tables : this.tables?.copyWith(),
      items: items is List<_i3.AirTableItems>?
          ? items
          : this.items?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class AirTableRowsTable extends _i1.Table<int?> {
  AirTableRowsTable({super.tableRelation})
      : super(tableName: 'air_table_rows') {
    index = _i1.ColumnInt(
      'index',
      this,
    );
    tablesId = _i1.ColumnInt(
      'tablesId',
      this,
    );
  }

  late final _i1.ColumnInt index;

  late final _i1.ColumnInt tablesId;

  _i2.AirTablesTable? _tables;

  _i3.AirTableItemsTable? ___items;

  _i1.ManyRelation<_i3.AirTableItemsTable>? _items;

  _i2.AirTablesTable get tables {
    if (_tables != null) return _tables!;
    _tables = _i1.createRelationTable(
      relationFieldName: 'tables',
      field: AirTableRows.t.tablesId,
      foreignField: _i2.AirTables.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AirTablesTable(tableRelation: foreignTableRelation),
    );
    return _tables!;
  }

  _i3.AirTableItemsTable get __items {
    if (___items != null) return ___items!;
    ___items = _i1.createRelationTable(
      relationFieldName: '__items',
      field: AirTableRows.t.id,
      foreignField: _i3.AirTableItems.t.rowId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AirTableItemsTable(tableRelation: foreignTableRelation),
    );
    return ___items!;
  }

  _i1.ManyRelation<_i3.AirTableItemsTable> get items {
    if (_items != null) return _items!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'items',
      field: AirTableRows.t.id,
      foreignField: _i3.AirTableItems.t.rowId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AirTableItemsTable(tableRelation: foreignTableRelation),
    );
    _items = _i1.ManyRelation<_i3.AirTableItemsTable>(
      tableWithRelations: relationTable,
      table: _i3.AirTableItemsTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _items!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        index,
        tablesId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'tables') {
      return tables;
    }
    if (relationField == 'items') {
      return __items;
    }
    return null;
  }
}

class AirTableRowsInclude extends _i1.IncludeObject {
  AirTableRowsInclude._({
    _i2.AirTablesInclude? tables,
    _i3.AirTableItemsIncludeList? items,
  }) {
    _tables = tables;
    _items = items;
  }

  _i2.AirTablesInclude? _tables;

  _i3.AirTableItemsIncludeList? _items;

  @override
  Map<String, _i1.Include?> get includes => {
        'tables': _tables,
        'items': _items,
      };

  @override
  _i1.Table<int?> get table => AirTableRows.t;
}

class AirTableRowsIncludeList extends _i1.IncludeList {
  AirTableRowsIncludeList._({
    _i1.WhereExpressionBuilder<AirTableRowsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AirTableRows.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AirTableRows.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AirTableRowsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AirTableRowsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AirTableRowsTable>? orderByList,
    _i1.Transaction? transaction,
    AirTableRowsInclude? include,
  }) async {
    return session.db.find<AirTableRows>(
      where: where?.call(AirTableRows.t),
      orderBy: orderBy?.call(AirTableRows.t),
      orderByList: orderByList?.call(AirTableRows.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AirTableRowsTable>? where,
    int? offset,
    _i1.OrderByBuilder<AirTableRowsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AirTableRowsTable>? orderByList,
    _i1.Transaction? transaction,
    AirTableRowsInclude? include,
  }) async {
    return session.db.findFirstRow<AirTableRows>(
      where: where?.call(AirTableRows.t),
      orderBy: orderBy?.call(AirTableRows.t),
      orderByList: orderByList?.call(AirTableRows.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [AirTableRows] by its [id] or null if no such row exists.
  Future<AirTableRows?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    AirTableRowsInclude? include,
  }) async {
    return session.db.findById<AirTableRows>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [AirTableRows]s in the list and returns the inserted rows.
  ///
  /// The returned [AirTableRows]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<AirTableRows>> insert(
    _i1.Session session,
    List<AirTableRows> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AirTableRows>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [AirTableRows] and returns the inserted row.
  ///
  /// The returned [AirTableRows] will have its `id` field set.
  Future<AirTableRows> insertRow(
    _i1.Session session,
    AirTableRows row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AirTableRows>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AirTableRows]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AirTableRows>> update(
    _i1.Session session,
    List<AirTableRows> rows, {
    _i1.ColumnSelections<AirTableRowsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AirTableRows>(
      rows,
      columns: columns?.call(AirTableRows.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AirTableRows]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AirTableRows> updateRow(
    _i1.Session session,
    AirTableRows row, {
    _i1.ColumnSelections<AirTableRowsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AirTableRows>(
      row,
      columns: columns?.call(AirTableRows.t),
      transaction: transaction,
    );
  }

  /// Deletes all [AirTableRows]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AirTableRows>> delete(
    _i1.Session session,
    List<AirTableRows> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AirTableRows>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AirTableRows].
  Future<AirTableRows> deleteRow(
    _i1.Session session,
    AirTableRows row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AirTableRows>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AirTableRows>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AirTableRowsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AirTableRows>(
      where: where(AirTableRows.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AirTableRowsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AirTableRows>(
      where: where?.call(AirTableRows.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class AirTableRowsAttachRepository {
  const AirTableRowsAttachRepository._();

  /// Creates a relation between this [AirTableRows] and the given [AirTableItems]s
  /// by setting each [AirTableItems]'s foreign key `rowId` to refer to this [AirTableRows].
  Future<void> items(
    _i1.Session session,
    AirTableRows airTableRows,
    List<_i3.AirTableItems> airTableItems, {
    _i1.Transaction? transaction,
  }) async {
    if (airTableItems.any((e) => e.id == null)) {
      throw ArgumentError.notNull('airTableItems.id');
    }
    if (airTableRows.id == null) {
      throw ArgumentError.notNull('airTableRows.id');
    }

    var $airTableItems =
        airTableItems.map((e) => e.copyWith(rowId: airTableRows.id)).toList();
    await session.db.update<_i3.AirTableItems>(
      $airTableItems,
      columns: [_i3.AirTableItems.t.rowId],
      transaction: transaction,
    );
  }
}

class AirTableRowsAttachRowRepository {
  const AirTableRowsAttachRowRepository._();

  /// Creates a relation between the given [AirTableRows] and [AirTables]
  /// by setting the [AirTableRows]'s foreign key `tablesId` to refer to the [AirTables].
  Future<void> tables(
    _i1.Session session,
    AirTableRows airTableRows,
    _i2.AirTables tables, {
    _i1.Transaction? transaction,
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
    _i1.Session session,
    AirTableRows airTableRows,
    _i3.AirTableItems airTableItems, {
    _i1.Transaction? transaction,
  }) async {
    if (airTableItems.id == null) {
      throw ArgumentError.notNull('airTableItems.id');
    }
    if (airTableRows.id == null) {
      throw ArgumentError.notNull('airTableRows.id');
    }

    var $airTableItems = airTableItems.copyWith(rowId: airTableRows.id);
    await session.db.updateRow<_i3.AirTableItems>(
      $airTableItems,
      columns: [_i3.AirTableItems.t.rowId],
      transaction: transaction,
    );
  }
}
