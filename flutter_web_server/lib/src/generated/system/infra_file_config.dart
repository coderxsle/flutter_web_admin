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

/// 文件配置表
abstract class InfraFileConfig
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  InfraFileConfig._({
    this.id,
    required this.name,
    required this.storage,
    this.description,
    required this.master,
    required this.config,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraFileConfig({
    int? id,
    required String name,
    required int storage,
    String? description,
    required bool master,
    required String config,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraFileConfigImpl;

  factory InfraFileConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraFileConfig(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      storage: jsonSerialization['storage'] as int,
      description: jsonSerialization['description'] as String?,
      master: _is.BoolJsonExtension.fromJson(jsonSerialization['master']),
      config: jsonSerialization['config'] as String,
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
      deleted: _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
    );
  }

  static final t = InfraFileConfigTable();

  static const db = InfraFileConfigRepository._();

  @override
  int? id;

  String name;

  int storage;

  String? description;

  bool master;

  String config;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraFileConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InfraFileConfig copyWith({
    int? id,
    String? name,
    int? storage,
    String? description,
    bool? master,
    String? config,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InfraFileConfig',
      if (id != null) 'id': id,
      'name': name,
      'storage': storage,
      if (description != null) 'description': description,
      'master': master,
      'config': config,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InfraFileConfig',
      if (id != null) 'id': id,
      'name': name,
      'storage': storage,
      if (description != null) 'description': description,
      'master': master,
      'config': config,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static InfraFileConfigInclude include() {
    return InfraFileConfigInclude._();
  }

  static InfraFileConfigIncludeList includeList({
    _is.WhereExpressionBuilder<InfraFileConfigTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraFileConfigTable>? orderBy,
    _is.OrderByListBuilder<InfraFileConfigTable>? orderByList,
    InfraFileConfigInclude? include,
  }) {
    return InfraFileConfigIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraFileConfig.t),
      orderByList: orderByList?.call(InfraFileConfig.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InfraFileConfigImpl extends InfraFileConfig {
  _InfraFileConfigImpl({
    int? id,
    required String name,
    required int storage,
    String? description,
    required bool master,
    required String config,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         name: name,
         storage: storage,
         description: description,
         master: master,
         config: config,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [InfraFileConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InfraFileConfig copyWith({
    Object? id = _Undefined,
    String? name,
    int? storage,
    Object? description = _Undefined,
    bool? master,
    String? config,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraFileConfig(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      storage: storage ?? this.storage,
      description: description is String? ? description : this.description,
      master: master ?? this.master,
      config: config ?? this.config,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class InfraFileConfigUpdateTable extends _is.UpdateTable<InfraFileConfigTable> {
  InfraFileConfigUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<int, int> storage(int value) =>
      _is.ColumnValue(table.storage, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<bool, bool> master(bool value) =>
      _is.ColumnValue(table.master, value);

  _is.ColumnValue<String, String> config(String value) =>
      _is.ColumnValue(table.config, value);

  _is.ColumnValue<String, String> creator(String? value) =>
      _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) =>
      _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> deleted(bool value) =>
      _is.ColumnValue(table.deleted, value);
}

class InfraFileConfigTable extends _is.Table<int?> {
  InfraFileConfigTable({super.tableRelation})
    : super(tableName: 'infra_file_config') {
    updateTable = InfraFileConfigUpdateTable(this);
    name = _is.ColumnString('name', this);
    storage = _is.ColumnInt('storage', this);
    description = _is.ColumnString('description', this);
    master = _is.ColumnBool('master', this);
    config = _is.ColumnString('config', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final InfraFileConfigUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnInt storage;

  late final _is.ColumnString description;

  late final _is.ColumnBool master;

  late final _is.ColumnString config;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    storage,
    description,
    master,
    config,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class InfraFileConfigInclude extends _is.IncludeObject {
  InfraFileConfigInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => InfraFileConfig.t;
}

class InfraFileConfigIncludeList extends _is.IncludeList {
  InfraFileConfigIncludeList._({
    _is.WhereExpressionBuilder<InfraFileConfigTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraFileConfig.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => InfraFileConfig.t;
}

class InfraFileConfigRepository {
  const InfraFileConfigRepository._();

  /// Returns a list of [InfraFileConfig]s matching the given query parameters.
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
  Future<List<InfraFileConfig>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraFileConfigTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraFileConfigTable>? orderBy,
    _is.OrderByListBuilder<InfraFileConfigTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InfraFileConfig>(
      where: where?.call(InfraFileConfig.t),
      orderBy: orderBy?.call(InfraFileConfig.t),
      orderByList: orderByList?.call(InfraFileConfig.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InfraFileConfig] matching the given query parameters.
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
  Future<InfraFileConfig?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraFileConfigTable>? where,
    int? offset,
    _is.OrderByBuilder<InfraFileConfigTable>? orderBy,
    _is.OrderByListBuilder<InfraFileConfigTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InfraFileConfig>(
      where: where?.call(InfraFileConfig.t),
      orderBy: orderBy?.call(InfraFileConfig.t),
      orderByList: orderByList?.call(InfraFileConfig.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InfraFileConfig] by its [id] or null if no such row exists.
  Future<InfraFileConfig?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InfraFileConfig>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InfraFileConfig]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraFileConfig]s will have their `id` fields set.
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
  Future<List<InfraFileConfig>> insert(
    _is.DatabaseSession session,
    List<InfraFileConfig> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<InfraFileConfig>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [InfraFileConfig] and returns the inserted row.
  ///
  /// The returned [InfraFileConfig] will have its `id` field set.
  Future<InfraFileConfig> insertRow(
    _is.DatabaseSession session,
    InfraFileConfig row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<InfraFileConfig>(row, transaction: transaction);
  }

  /// Upserts all [InfraFileConfig]s in the list and returns the resulting rows.
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
  /// The returned [InfraFileConfig]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFileConfig>> upsert(
    _is.DatabaseSession session,
    List<InfraFileConfig> rows, {
    required _is.ColumnSelections<InfraFileConfigTable> conflictColumns,
    _is.ColumnSelections<InfraFileConfigTable>? updateColumns,
    _is.WhereExpressionBuilder<InfraFileConfigTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<InfraFileConfig>(
      rows,
      conflictColumns: conflictColumns(InfraFileConfig.t),
      updateColumns: updateColumns?.call(InfraFileConfig.t),
      updateWhere: updateWhere?.call(InfraFileConfig.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [InfraFileConfig] and returns the resulting row.
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
  /// The returned [InfraFileConfig] will have its `id` field set.
  Future<InfraFileConfig?> upsertRow(
    _is.DatabaseSession session,
    InfraFileConfig row, {
    required _is.ColumnSelections<InfraFileConfigTable> conflictColumns,
    _is.ColumnSelections<InfraFileConfigTable>? updateColumns,
    _is.WhereExpressionBuilder<InfraFileConfigTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<InfraFileConfig>(
      row,
      conflictColumns: conflictColumns(InfraFileConfig.t),
      updateColumns: updateColumns?.call(InfraFileConfig.t),
      updateWhere: updateWhere?.call(InfraFileConfig.t),
      transaction: transaction,
    );
  }

  /// Updates all [InfraFileConfig]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFileConfig>> update(
    _is.DatabaseSession session,
    List<InfraFileConfig> rows, {
    _is.ColumnSelections<InfraFileConfigTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<InfraFileConfig>(
      rows,
      columns: columns?.call(InfraFileConfig.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [InfraFileConfig]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraFileConfig> updateRow(
    _is.DatabaseSession session,
    InfraFileConfig row, {
    _is.ColumnSelections<InfraFileConfigTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraFileConfig>(
      row,
      columns: columns?.call(InfraFileConfig.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InfraFileConfig] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InfraFileConfig?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InfraFileConfigUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<InfraFileConfig>(
      id,
      columnValues: columnValues(InfraFileConfig.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InfraFileConfig]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFileConfig>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InfraFileConfigUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<InfraFileConfigTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraFileConfigTable>? orderBy,
    _is.OrderByListBuilder<InfraFileConfigTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<InfraFileConfig>(
      columnValues: columnValues(InfraFileConfig.t.updateTable),
      where: where(InfraFileConfig.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraFileConfig.t),
      orderByList: orderByList?.call(InfraFileConfig.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [InfraFileConfig]s in the list and returns the deleted rows.
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
  Future<List<InfraFileConfig>> delete(
    _is.DatabaseSession session,
    List<InfraFileConfig> rows, {
    _is.OrderByBuilder<InfraFileConfigTable>? orderBy,
    _is.OrderByListBuilder<InfraFileConfigTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<InfraFileConfig>(
      rows,
      orderBy: orderBy?.call(InfraFileConfig.t),
      orderByList: orderByList?.call(InfraFileConfig.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [InfraFileConfig].
  Future<InfraFileConfig> deleteRow(
    _is.DatabaseSession session,
    InfraFileConfig row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InfraFileConfig>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFileConfig>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InfraFileConfigTable> where,
    _is.OrderByBuilder<InfraFileConfigTable>? orderBy,
    _is.OrderByListBuilder<InfraFileConfigTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<InfraFileConfig>(
      where: where(InfraFileConfig.t),
      orderBy: orderBy?.call(InfraFileConfig.t),
      orderByList: orderByList?.call(InfraFileConfig.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraFileConfigTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<InfraFileConfig>(
      where: where?.call(InfraFileConfig.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InfraFileConfig] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InfraFileConfigTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InfraFileConfig>(
      where: where(InfraFileConfig.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
