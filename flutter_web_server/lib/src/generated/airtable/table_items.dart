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
import '../airtable/table_rows.dart' as _i2;
import '../airtable/table_fields.dart' as _i3;
import '../airtable/table_items.dart' as _i4;
import '../airtable/tables.dart' as _i5;

abstract class AirTableItems
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    _i2.AirTableRows? row,
    required int fieldId,
    _i3.AirTableFields? field,
    int? itemId,
    _i4.AirTableItems? item,
    int? tablesId,
    _i5.AirTables? tables,
  }) = _AirTableItemsImpl;

  factory AirTableItems.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTableItems(
      id: jsonSerialization['id'] as int?,
      value: jsonSerialization['value'] as String,
      rowId: jsonSerialization['rowId'] as int,
      row: jsonSerialization['row'] == null
          ? null
          : _i2.AirTableRows.fromJson(
              (jsonSerialization['row'] as Map<String, dynamic>)),
      fieldId: jsonSerialization['fieldId'] as int,
      field: jsonSerialization['field'] == null
          ? null
          : _i3.AirTableFields.fromJson(
              (jsonSerialization['field'] as Map<String, dynamic>)),
      itemId: jsonSerialization['itemId'] as int?,
      item: jsonSerialization['item'] == null
          ? null
          : _i4.AirTableItems.fromJson(
              (jsonSerialization['item'] as Map<String, dynamic>)),
      tablesId: jsonSerialization['tablesId'] as int?,
      tables: jsonSerialization['tables'] == null
          ? null
          : _i5.AirTables.fromJson(
              (jsonSerialization['tables'] as Map<String, dynamic>)),
    );
  }

  static final t = AirTableItemsTable();

  static const db = AirTableItemsRepository._();

  @override
  int? id;

  String value;

  int rowId;

  _i2.AirTableRows? row;

  int fieldId;

  _i3.AirTableFields? field;

  int? itemId;

  _i4.AirTableItems? item;

  int? tablesId;

  _i5.AirTables? tables;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AirTableItems]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AirTableItems copyWith({
    int? id,
    String? value,
    int? rowId,
    _i2.AirTableRows? row,
    int? fieldId,
    _i3.AirTableFields? field,
    int? itemId,
    _i4.AirTableItems? item,
    int? tablesId,
    _i5.AirTables? tables,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
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
    _i2.AirTableRowsInclude? row,
    _i3.AirTableFieldsInclude? field,
    _i4.AirTableItemsInclude? item,
    _i5.AirTablesInclude? tables,
  }) {
    return AirTableItemsInclude._(
      row: row,
      field: field,
      item: item,
      tables: tables,
    );
  }

  static AirTableItemsIncludeList includeList({
    _i1.WhereExpressionBuilder<AirTableItemsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AirTableItemsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AirTableItemsTable>? orderByList,
    AirTableItemsInclude? include,
  }) {
    return AirTableItemsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AirTableItems.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AirTableItems.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTableItemsImpl extends AirTableItems {
  _AirTableItemsImpl({
    int? id,
    required String value,
    required int rowId,
    _i2.AirTableRows? row,
    required int fieldId,
    _i3.AirTableFields? field,
    int? itemId,
    _i4.AirTableItems? item,
    int? tablesId,
    _i5.AirTables? tables,
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
  @_i1.useResult
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
      row: row is _i2.AirTableRows? ? row : this.row?.copyWith(),
      fieldId: fieldId ?? this.fieldId,
      field: field is _i3.AirTableFields? ? field : this.field?.copyWith(),
      itemId: itemId is int? ? itemId : this.itemId,
      item: item is _i4.AirTableItems? ? item : this.item?.copyWith(),
      tablesId: tablesId is int? ? tablesId : this.tablesId,
      tables: tables is _i5.AirTables? ? tables : this.tables?.copyWith(),
    );
  }
}

class AirTableItemsTable extends _i1.Table<int?> {
  AirTableItemsTable({super.tableRelation})
      : super(tableName: 'air_table_items') {
    value = _i1.ColumnString(
      'value',
      this,
    );
    rowId = _i1.ColumnInt(
      'rowId',
      this,
    );
    fieldId = _i1.ColumnInt(
      'fieldId',
      this,
    );
    itemId = _i1.ColumnInt(
      'itemId',
      this,
    );
    tablesId = _i1.ColumnInt(
      'tablesId',
      this,
    );
  }

  late final _i1.ColumnString value;

  late final _i1.ColumnInt rowId;

  _i2.AirTableRowsTable? _row;

  late final _i1.ColumnInt fieldId;

  _i3.AirTableFieldsTable? _field;

  late final _i1.ColumnInt itemId;

  _i4.AirTableItemsTable? _item;

  late final _i1.ColumnInt tablesId;

  _i5.AirTablesTable? _tables;

  _i2.AirTableRowsTable get row {
    if (_row != null) return _row!;
    _row = _i1.createRelationTable(
      relationFieldName: 'row',
      field: AirTableItems.t.rowId,
      foreignField: _i2.AirTableRows.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AirTableRowsTable(tableRelation: foreignTableRelation),
    );
    return _row!;
  }

  _i3.AirTableFieldsTable get field {
    if (_field != null) return _field!;
    _field = _i1.createRelationTable(
      relationFieldName: 'field',
      field: AirTableItems.t.fieldId,
      foreignField: _i3.AirTableFields.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AirTableFieldsTable(tableRelation: foreignTableRelation),
    );
    return _field!;
  }

  _i4.AirTableItemsTable get item {
    if (_item != null) return _item!;
    _item = _i1.createRelationTable(
      relationFieldName: 'item',
      field: AirTableItems.t.itemId,
      foreignField: _i4.AirTableItems.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.AirTableItemsTable(tableRelation: foreignTableRelation),
    );
    return _item!;
  }

  _i5.AirTablesTable get tables {
    if (_tables != null) return _tables!;
    _tables = _i1.createRelationTable(
      relationFieldName: 'tables',
      field: AirTableItems.t.tablesId,
      foreignField: _i5.AirTables.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.AirTablesTable(tableRelation: foreignTableRelation),
    );
    return _tables!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        value,
        rowId,
        fieldId,
        itemId,
        tablesId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
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

class AirTableItemsInclude extends _i1.IncludeObject {
  AirTableItemsInclude._({
    _i2.AirTableRowsInclude? row,
    _i3.AirTableFieldsInclude? field,
    _i4.AirTableItemsInclude? item,
    _i5.AirTablesInclude? tables,
  }) {
    _row = row;
    _field = field;
    _item = item;
    _tables = tables;
  }

  _i2.AirTableRowsInclude? _row;

  _i3.AirTableFieldsInclude? _field;

  _i4.AirTableItemsInclude? _item;

  _i5.AirTablesInclude? _tables;

  @override
  Map<String, _i1.Include?> get includes => {
        'row': _row,
        'field': _field,
        'item': _item,
        'tables': _tables,
      };

  @override
  _i1.Table<int?> get table => AirTableItems.t;
}

class AirTableItemsIncludeList extends _i1.IncludeList {
  AirTableItemsIncludeList._({
    _i1.WhereExpressionBuilder<AirTableItemsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AirTableItems.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AirTableItems.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AirTableItemsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AirTableItemsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AirTableItemsTable>? orderByList,
    _i1.Transaction? transaction,
    AirTableItemsInclude? include,
  }) async {
    return session.db.find<AirTableItems>(
      where: where?.call(AirTableItems.t),
      orderBy: orderBy?.call(AirTableItems.t),
      orderByList: orderByList?.call(AirTableItems.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AirTableItemsTable>? where,
    int? offset,
    _i1.OrderByBuilder<AirTableItemsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AirTableItemsTable>? orderByList,
    _i1.Transaction? transaction,
    AirTableItemsInclude? include,
  }) async {
    return session.db.findFirstRow<AirTableItems>(
      where: where?.call(AirTableItems.t),
      orderBy: orderBy?.call(AirTableItems.t),
      orderByList: orderByList?.call(AirTableItems.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [AirTableItems] by its [id] or null if no such row exists.
  Future<AirTableItems?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    AirTableItemsInclude? include,
  }) async {
    return session.db.findById<AirTableItems>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [AirTableItems]s in the list and returns the inserted rows.
  ///
  /// The returned [AirTableItems]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<AirTableItems>> insert(
    _i1.Session session,
    List<AirTableItems> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AirTableItems>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [AirTableItems] and returns the inserted row.
  ///
  /// The returned [AirTableItems] will have its `id` field set.
  Future<AirTableItems> insertRow(
    _i1.Session session,
    AirTableItems row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AirTableItems>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AirTableItems]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AirTableItems>> update(
    _i1.Session session,
    List<AirTableItems> rows, {
    _i1.ColumnSelections<AirTableItemsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AirTableItems>(
      rows,
      columns: columns?.call(AirTableItems.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AirTableItems]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AirTableItems> updateRow(
    _i1.Session session,
    AirTableItems row, {
    _i1.ColumnSelections<AirTableItemsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AirTableItems>(
      row,
      columns: columns?.call(AirTableItems.t),
      transaction: transaction,
    );
  }

  /// Deletes all [AirTableItems]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AirTableItems>> delete(
    _i1.Session session,
    List<AirTableItems> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AirTableItems>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AirTableItems].
  Future<AirTableItems> deleteRow(
    _i1.Session session,
    AirTableItems row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AirTableItems>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AirTableItems>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AirTableItemsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AirTableItems>(
      where: where(AirTableItems.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AirTableItemsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AirTableItems>(
      where: where?.call(AirTableItems.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class AirTableItemsAttachRowRepository {
  const AirTableItemsAttachRowRepository._();

  /// Creates a relation between the given [AirTableItems] and [AirTableRows]
  /// by setting the [AirTableItems]'s foreign key `rowId` to refer to the [AirTableRows].
  Future<void> row(
    _i1.Session session,
    AirTableItems airTableItems,
    _i2.AirTableRows row, {
    _i1.Transaction? transaction,
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
    _i1.Session session,
    AirTableItems airTableItems,
    _i3.AirTableFields field, {
    _i1.Transaction? transaction,
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
    _i1.Session session,
    AirTableItems airTableItems,
    _i4.AirTableItems item, {
    _i1.Transaction? transaction,
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
    _i1.Session session,
    AirTableItems airTableItems,
    _i5.AirTables tables, {
    _i1.Transaction? transaction,
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
    _i1.Session session,
    AirTableItems airtableitems, {
    _i1.Transaction? transaction,
  }) async {
    if (airtableitems.id == null) {
      throw ArgumentError.notNull('airtableitems.id');
    }

    var $airtableitems = airtableitems.copyWith(itemId: null);
    await session.db.updateRow<AirTableItems>(
      $airtableitems,
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
    _i1.Session session,
    AirTableItems airtableitems, {
    _i1.Transaction? transaction,
  }) async {
    if (airtableitems.id == null) {
      throw ArgumentError.notNull('airtableitems.id');
    }

    var $airtableitems = airtableitems.copyWith(tablesId: null);
    await session.db.updateRow<AirTableItems>(
      $airtableitems,
      columns: [AirTableItems.t.tablesId],
      transaction: transaction,
    );
  }
}
