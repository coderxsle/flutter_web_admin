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

abstract class AirTableFields
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    _i2.AirTables? tables,
    List<_i3.AirTableItems>? items,
  }) = _AirTableFieldsImpl;

  factory AirTableFields.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTableFields(
      id: jsonSerialization['id'] as int?,
      field: jsonSerialization['field'] as String,
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

  static final t = AirTableFieldsTable();

  static const db = AirTableFieldsRepository._();

  @override
  int? id;

  String field;

  int tablesId;

  _i2.AirTables? tables;

  List<_i3.AirTableItems>? items;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AirTableFields]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AirTableFields copyWith({
    int? id,
    String? field,
    int? tablesId,
    _i2.AirTables? tables,
    List<_i3.AirTableItems>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
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
      if (id != null) 'id': id,
      'field': field,
      'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJsonForProtocol(),
      if (items != null)
        'items': items?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static AirTableFieldsInclude include({
    _i2.AirTablesInclude? tables,
    _i3.AirTableItemsIncludeList? items,
  }) {
    return AirTableFieldsInclude._(
      tables: tables,
      items: items,
    );
  }

  static AirTableFieldsIncludeList includeList({
    _i1.WhereExpressionBuilder<AirTableFieldsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AirTableFieldsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AirTableFieldsTable>? orderByList,
    AirTableFieldsInclude? include,
  }) {
    return AirTableFieldsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AirTableFields.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AirTableFields.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTableFieldsImpl extends AirTableFields {
  _AirTableFieldsImpl({
    int? id,
    required String field,
    required int tablesId,
    _i2.AirTables? tables,
    List<_i3.AirTableItems>? items,
  }) : super._(
          id: id,
          field: field,
          tablesId: tablesId,
          tables: tables,
          items: items,
        );

  /// Returns a shallow copy of this [AirTableFields]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
      tables: tables is _i2.AirTables? ? tables : this.tables?.copyWith(),
      items: items is List<_i3.AirTableItems>?
          ? items
          : this.items?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class AirTableFieldsTable extends _i1.Table<int?> {
  AirTableFieldsTable({super.tableRelation})
      : super(tableName: 'air_table_fields') {
    field = _i1.ColumnString(
      'field',
      this,
    );
    tablesId = _i1.ColumnInt(
      'tablesId',
      this,
    );
  }

  late final _i1.ColumnString field;

  late final _i1.ColumnInt tablesId;

  _i2.AirTablesTable? _tables;

  _i3.AirTableItemsTable? ___items;

  _i1.ManyRelation<_i3.AirTableItemsTable>? _items;

  _i2.AirTablesTable get tables {
    if (_tables != null) return _tables!;
    _tables = _i1.createRelationTable(
      relationFieldName: 'tables',
      field: AirTableFields.t.tablesId,
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
      field: AirTableFields.t.id,
      foreignField: _i3.AirTableItems.t.fieldId,
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
      field: AirTableFields.t.id,
      foreignField: _i3.AirTableItems.t.fieldId,
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
        field,
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

class AirTableFieldsInclude extends _i1.IncludeObject {
  AirTableFieldsInclude._({
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
  _i1.Table<int?> get table => AirTableFields.t;
}

class AirTableFieldsIncludeList extends _i1.IncludeList {
  AirTableFieldsIncludeList._({
    _i1.WhereExpressionBuilder<AirTableFieldsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AirTableFields.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AirTableFields.t;
}

class AirTableFieldsRepository {
  const AirTableFieldsRepository._();

  final attach = const AirTableFieldsAttachRepository._();

  final attachRow = const AirTableFieldsAttachRowRepository._();

  final detach = const AirTableFieldsDetachRepository._();

  final detachRow = const AirTableFieldsDetachRowRepository._();

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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AirTableFieldsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AirTableFieldsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AirTableFieldsTable>? orderByList,
    _i1.Transaction? transaction,
    AirTableFieldsInclude? include,
  }) async {
    return session.db.find<AirTableFields>(
      where: where?.call(AirTableFields.t),
      orderBy: orderBy?.call(AirTableFields.t),
      orderByList: orderByList?.call(AirTableFields.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AirTableFieldsTable>? where,
    int? offset,
    _i1.OrderByBuilder<AirTableFieldsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AirTableFieldsTable>? orderByList,
    _i1.Transaction? transaction,
    AirTableFieldsInclude? include,
  }) async {
    return session.db.findFirstRow<AirTableFields>(
      where: where?.call(AirTableFields.t),
      orderBy: orderBy?.call(AirTableFields.t),
      orderByList: orderByList?.call(AirTableFields.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [AirTableFields] by its [id] or null if no such row exists.
  Future<AirTableFields?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    AirTableFieldsInclude? include,
  }) async {
    return session.db.findById<AirTableFields>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [AirTableFields]s in the list and returns the inserted rows.
  ///
  /// The returned [AirTableFields]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<AirTableFields>> insert(
    _i1.Session session,
    List<AirTableFields> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AirTableFields>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [AirTableFields] and returns the inserted row.
  ///
  /// The returned [AirTableFields] will have its `id` field set.
  Future<AirTableFields> insertRow(
    _i1.Session session,
    AirTableFields row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AirTableFields>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AirTableFields]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AirTableFields>> update(
    _i1.Session session,
    List<AirTableFields> rows, {
    _i1.ColumnSelections<AirTableFieldsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AirTableFields>(
      rows,
      columns: columns?.call(AirTableFields.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AirTableFields]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AirTableFields> updateRow(
    _i1.Session session,
    AirTableFields row, {
    _i1.ColumnSelections<AirTableFieldsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AirTableFields>(
      row,
      columns: columns?.call(AirTableFields.t),
      transaction: transaction,
    );
  }

  /// Deletes all [AirTableFields]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AirTableFields>> delete(
    _i1.Session session,
    List<AirTableFields> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AirTableFields>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AirTableFields].
  Future<AirTableFields> deleteRow(
    _i1.Session session,
    AirTableFields row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AirTableFields>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AirTableFields>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AirTableFieldsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AirTableFields>(
      where: where(AirTableFields.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AirTableFieldsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AirTableFields>(
      where: where?.call(AirTableFields.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class AirTableFieldsAttachRepository {
  const AirTableFieldsAttachRepository._();

  /// Creates a relation between this [AirTableFields] and the given [AirTableItems]s
  /// by setting each [AirTableItems]'s foreign key `fieldId` to refer to this [AirTableFields].
  Future<void> items(
    _i1.Session session,
    AirTableFields airTableFields,
    List<_i3.AirTableItems> airTableItems, {
    _i1.Transaction? transaction,
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
    await session.db.update<_i3.AirTableItems>(
      $airTableItems,
      columns: [_i3.AirTableItems.t.fieldId],
      transaction: transaction,
    );
  }
}

class AirTableFieldsAttachRowRepository {
  const AirTableFieldsAttachRowRepository._();

  /// Creates a relation between the given [AirTableFields] and [AirTables]
  /// by setting the [AirTableFields]'s foreign key `tablesId` to refer to the [AirTables].
  Future<void> tables(
    _i1.Session session,
    AirTableFields airTableFields,
    _i2.AirTables tables, {
    _i1.Transaction? transaction,
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
    _i1.Session session,
    AirTableFields airTableFields,
    _i3.AirTableItems airTableItems, {
    _i1.Transaction? transaction,
  }) async {
    if (airTableItems.id == null) {
      throw ArgumentError.notNull('airTableItems.id');
    }
    if (airTableFields.id == null) {
      throw ArgumentError.notNull('airTableFields.id');
    }

    var $airTableItems = airTableItems.copyWith(fieldId: airTableFields.id);
    await session.db.updateRow<_i3.AirTableItems>(
      $airTableItems,
      columns: [_i3.AirTableItems.t.fieldId],
      transaction: transaction,
    );
  }
}

class AirTableFieldsDetachRepository {
  const AirTableFieldsDetachRepository._();

  /// Detaches the relation between this [AirTableFields] and the given [AirTableItems]
  /// by setting the [AirTableItems]'s foreign key `fieldId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> items(
    _i1.Session session,
    List<_i3.AirTableItems> airTableItems, {
    _i1.Transaction? transaction,
  }) async {
    if (airTableItems.any((e) => e.id == null)) {
      throw ArgumentError.notNull('airTableItems.id');
    }

    var $airTableItems =
        airTableItems.map((e) => e.copyWith(fieldId: null)).toList();
    await session.db.update<_i3.AirTableItems>(
      $airTableItems,
      columns: [_i3.AirTableItems.t.fieldId],
      transaction: transaction,
    );
  }
}

class AirTableFieldsDetachRowRepository {
  const AirTableFieldsDetachRowRepository._();

  /// Detaches the relation between this [AirTableFields] and the given [AirTableItems]
  /// by setting the [AirTableItems]'s foreign key `fieldId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> items(
    _i1.Session session,
    _i3.AirTableItems airTableItems, {
    _i1.Transaction? transaction,
  }) async {
    if (airTableItems.id == null) {
      throw ArgumentError.notNull('airTableItems.id');
    }

    var $airTableItems = airTableItems.copyWith(fieldId: null);
    await session.db.updateRow<_i3.AirTableItems>(
      $airTableItems,
      columns: [_i3.AirTableItems.t.fieldId],
      transaction: transaction,
    );
  }
}
