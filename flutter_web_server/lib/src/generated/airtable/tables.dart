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
import '../airtable/table_fields.dart' as _i2;
import '../airtable/table_rows.dart' as _i3;

abstract class AirTables
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AirTables._({
    this.id,
    required this.name,
    this.fields,
    this.rows,
  });

  factory AirTables({
    int? id,
    required String name,
    List<_i2.AirTableFields>? fields,
    List<_i3.AirTableRows>? rows,
  }) = _AirTablesImpl;

  factory AirTables.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTables(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      fields: (jsonSerialization['fields'] as List?)
          ?.map((e) => _i2.AirTableFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      rows: (jsonSerialization['rows'] as List?)
          ?.map((e) => _i3.AirTableRows.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = AirTablesTable();

  static const db = AirTablesRepository._();

  @override
  int? id;

  String name;

  List<_i2.AirTableFields>? fields;

  List<_i3.AirTableRows>? rows;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AirTables]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AirTables copyWith({
    int? id,
    String? name,
    List<_i2.AirTableFields>? fields,
    List<_i3.AirTableRows>? rows,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
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
      if (id != null) 'id': id,
      'name': name,
      if (fields != null)
        'fields': fields?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (rows != null)
        'rows': rows?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static AirTablesInclude include({
    _i2.AirTableFieldsIncludeList? fields,
    _i3.AirTableRowsIncludeList? rows,
  }) {
    return AirTablesInclude._(
      fields: fields,
      rows: rows,
    );
  }

  static AirTablesIncludeList includeList({
    _i1.WhereExpressionBuilder<AirTablesTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AirTablesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AirTablesTable>? orderByList,
    AirTablesInclude? include,
  }) {
    return AirTablesIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AirTables.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AirTables.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTablesImpl extends AirTables {
  _AirTablesImpl({
    int? id,
    required String name,
    List<_i2.AirTableFields>? fields,
    List<_i3.AirTableRows>? rows,
  }) : super._(
          id: id,
          name: name,
          fields: fields,
          rows: rows,
        );

  /// Returns a shallow copy of this [AirTables]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
      fields: fields is List<_i2.AirTableFields>?
          ? fields
          : this.fields?.map((e0) => e0.copyWith()).toList(),
      rows: rows is List<_i3.AirTableRows>?
          ? rows
          : this.rows?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class AirTablesTable extends _i1.Table<int?> {
  AirTablesTable({super.tableRelation}) : super(tableName: 'air_tables') {
    name = _i1.ColumnString(
      'name',
      this,
    );
  }

  late final _i1.ColumnString name;

  _i2.AirTableFieldsTable? ___fields;

  _i1.ManyRelation<_i2.AirTableFieldsTable>? _fields;

  _i3.AirTableRowsTable? ___rows;

  _i1.ManyRelation<_i3.AirTableRowsTable>? _rows;

  _i2.AirTableFieldsTable get __fields {
    if (___fields != null) return ___fields!;
    ___fields = _i1.createRelationTable(
      relationFieldName: '__fields',
      field: AirTables.t.id,
      foreignField: _i2.AirTableFields.t.tablesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AirTableFieldsTable(tableRelation: foreignTableRelation),
    );
    return ___fields!;
  }

  _i3.AirTableRowsTable get __rows {
    if (___rows != null) return ___rows!;
    ___rows = _i1.createRelationTable(
      relationFieldName: '__rows',
      field: AirTables.t.id,
      foreignField: _i3.AirTableRows.t.tablesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AirTableRowsTable(tableRelation: foreignTableRelation),
    );
    return ___rows!;
  }

  _i1.ManyRelation<_i2.AirTableFieldsTable> get fields {
    if (_fields != null) return _fields!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'fields',
      field: AirTables.t.id,
      foreignField: _i2.AirTableFields.t.tablesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AirTableFieldsTable(tableRelation: foreignTableRelation),
    );
    _fields = _i1.ManyRelation<_i2.AirTableFieldsTable>(
      tableWithRelations: relationTable,
      table: _i2.AirTableFieldsTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _fields!;
  }

  _i1.ManyRelation<_i3.AirTableRowsTable> get rows {
    if (_rows != null) return _rows!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'rows',
      field: AirTables.t.id,
      foreignField: _i3.AirTableRows.t.tablesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AirTableRowsTable(tableRelation: foreignTableRelation),
    );
    _rows = _i1.ManyRelation<_i3.AirTableRowsTable>(
      tableWithRelations: relationTable,
      table: _i3.AirTableRowsTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _rows!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'fields') {
      return __fields;
    }
    if (relationField == 'rows') {
      return __rows;
    }
    return null;
  }
}

class AirTablesInclude extends _i1.IncludeObject {
  AirTablesInclude._({
    _i2.AirTableFieldsIncludeList? fields,
    _i3.AirTableRowsIncludeList? rows,
  }) {
    _fields = fields;
    _rows = rows;
  }

  _i2.AirTableFieldsIncludeList? _fields;

  _i3.AirTableRowsIncludeList? _rows;

  @override
  Map<String, _i1.Include?> get includes => {
        'fields': _fields,
        'rows': _rows,
      };

  @override
  _i1.Table<int?> get table => AirTables.t;
}

class AirTablesIncludeList extends _i1.IncludeList {
  AirTablesIncludeList._({
    _i1.WhereExpressionBuilder<AirTablesTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AirTables.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AirTables.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AirTablesTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AirTablesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AirTablesTable>? orderByList,
    _i1.Transaction? transaction,
    AirTablesInclude? include,
  }) async {
    return session.db.find<AirTables>(
      where: where?.call(AirTables.t),
      orderBy: orderBy?.call(AirTables.t),
      orderByList: orderByList?.call(AirTables.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AirTablesTable>? where,
    int? offset,
    _i1.OrderByBuilder<AirTablesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AirTablesTable>? orderByList,
    _i1.Transaction? transaction,
    AirTablesInclude? include,
  }) async {
    return session.db.findFirstRow<AirTables>(
      where: where?.call(AirTables.t),
      orderBy: orderBy?.call(AirTables.t),
      orderByList: orderByList?.call(AirTables.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [AirTables] by its [id] or null if no such row exists.
  Future<AirTables?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    AirTablesInclude? include,
  }) async {
    return session.db.findById<AirTables>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [AirTables]s in the list and returns the inserted rows.
  ///
  /// The returned [AirTables]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<AirTables>> insert(
    _i1.Session session,
    List<AirTables> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AirTables>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [AirTables] and returns the inserted row.
  ///
  /// The returned [AirTables] will have its `id` field set.
  Future<AirTables> insertRow(
    _i1.Session session,
    AirTables row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AirTables>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AirTables]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AirTables>> update(
    _i1.Session session,
    List<AirTables> rows, {
    _i1.ColumnSelections<AirTablesTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AirTables>(
      rows,
      columns: columns?.call(AirTables.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AirTables]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AirTables> updateRow(
    _i1.Session session,
    AirTables row, {
    _i1.ColumnSelections<AirTablesTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AirTables>(
      row,
      columns: columns?.call(AirTables.t),
      transaction: transaction,
    );
  }

  /// Deletes all [AirTables]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AirTables>> delete(
    _i1.Session session,
    List<AirTables> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AirTables>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AirTables].
  Future<AirTables> deleteRow(
    _i1.Session session,
    AirTables row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AirTables>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AirTables>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AirTablesTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AirTables>(
      where: where(AirTables.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AirTablesTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AirTables>(
      where: where?.call(AirTables.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class AirTablesAttachRepository {
  const AirTablesAttachRepository._();

  /// Creates a relation between this [AirTables] and the given [AirTableFields]s
  /// by setting each [AirTableFields]'s foreign key `tablesId` to refer to this [AirTables].
  Future<void> fields(
    _i1.Session session,
    AirTables airTables,
    List<_i2.AirTableFields> airTableFields, {
    _i1.Transaction? transaction,
  }) async {
    if (airTableFields.any((e) => e.id == null)) {
      throw ArgumentError.notNull('airTableFields.id');
    }
    if (airTables.id == null) {
      throw ArgumentError.notNull('airTables.id');
    }

    var $airTableFields =
        airTableFields.map((e) => e.copyWith(tablesId: airTables.id)).toList();
    await session.db.update<_i2.AirTableFields>(
      $airTableFields,
      columns: [_i2.AirTableFields.t.tablesId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [AirTables] and the given [AirTableRows]s
  /// by setting each [AirTableRows]'s foreign key `tablesId` to refer to this [AirTables].
  Future<void> rows(
    _i1.Session session,
    AirTables airTables,
    List<_i3.AirTableRows> airTableRows, {
    _i1.Transaction? transaction,
  }) async {
    if (airTableRows.any((e) => e.id == null)) {
      throw ArgumentError.notNull('airTableRows.id');
    }
    if (airTables.id == null) {
      throw ArgumentError.notNull('airTables.id');
    }

    var $airTableRows =
        airTableRows.map((e) => e.copyWith(tablesId: airTables.id)).toList();
    await session.db.update<_i3.AirTableRows>(
      $airTableRows,
      columns: [_i3.AirTableRows.t.tablesId],
      transaction: transaction,
    );
  }
}

class AirTablesAttachRowRepository {
  const AirTablesAttachRowRepository._();

  /// Creates a relation between this [AirTables] and the given [AirTableFields]
  /// by setting the [AirTableFields]'s foreign key `tablesId` to refer to this [AirTables].
  Future<void> fields(
    _i1.Session session,
    AirTables airTables,
    _i2.AirTableFields airTableFields, {
    _i1.Transaction? transaction,
  }) async {
    if (airTableFields.id == null) {
      throw ArgumentError.notNull('airTableFields.id');
    }
    if (airTables.id == null) {
      throw ArgumentError.notNull('airTables.id');
    }

    var $airTableFields = airTableFields.copyWith(tablesId: airTables.id);
    await session.db.updateRow<_i2.AirTableFields>(
      $airTableFields,
      columns: [_i2.AirTableFields.t.tablesId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [AirTables] and the given [AirTableRows]
  /// by setting the [AirTableRows]'s foreign key `tablesId` to refer to this [AirTables].
  Future<void> rows(
    _i1.Session session,
    AirTables airTables,
    _i3.AirTableRows airTableRows, {
    _i1.Transaction? transaction,
  }) async {
    if (airTableRows.id == null) {
      throw ArgumentError.notNull('airTableRows.id');
    }
    if (airTables.id == null) {
      throw ArgumentError.notNull('airTables.id');
    }

    var $airTableRows = airTableRows.copyWith(tablesId: airTables.id);
    await session.db.updateRow<_i3.AirTableRows>(
      $airTableRows,
      columns: [_i3.AirTableRows.t.tablesId],
      transaction: transaction,
    );
  }
}
