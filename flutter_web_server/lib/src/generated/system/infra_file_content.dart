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
import 'dart:typed_data' as _idt;
import 'package:serverpod/serverpod.dart' as _is;

/// 文件内容表
abstract class InfraFileContent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  InfraFileContent._({
    this.id,
    required this.configId,
    required this.path,
    required this.content,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraFileContent({
    int? id,
    required int configId,
    required String path,
    required _idt.ByteData content,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraFileContentImpl;

  factory InfraFileContent.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraFileContent(
      id: jsonSerialization['id'] as int?,
      configId: jsonSerialization['configId'] as int,
      path: jsonSerialization['path'] as String,
      content: _is.ByteDataJsonExtension.fromJson(jsonSerialization['content']),
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

  static final t = InfraFileContentTable();

  static const db = InfraFileContentRepository._();

  @override
  int? id;

  int configId;

  String path;

  _idt.ByteData content;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraFileContent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InfraFileContent copyWith({
    int? id,
    int? configId,
    String? path,
    _idt.ByteData? content,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InfraFileContent',
      if (id != null) 'id': id,
      'configId': configId,
      'path': path,
      'content': content.toJson(),
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
      '__className__': 'InfraFileContent',
      if (id != null) 'id': id,
      'configId': configId,
      'path': path,
      'content': content.toJson(),
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static InfraFileContentInclude include() {
    return InfraFileContentInclude._();
  }

  static InfraFileContentIncludeList includeList({
    _is.WhereExpressionBuilder<InfraFileContentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraFileContentTable>? orderBy,
    _is.OrderByListBuilder<InfraFileContentTable>? orderByList,
    InfraFileContentInclude? include,
  }) {
    return InfraFileContentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraFileContent.t),
      orderByList: orderByList?.call(InfraFileContent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InfraFileContentImpl extends InfraFileContent {
  _InfraFileContentImpl({
    int? id,
    required int configId,
    required String path,
    required _idt.ByteData content,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         configId: configId,
         path: path,
         content: content,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [InfraFileContent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InfraFileContent copyWith({
    Object? id = _Undefined,
    int? configId,
    String? path,
    _idt.ByteData? content,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraFileContent(
      id: id is int? ? id : this.id,
      configId: configId ?? this.configId,
      path: path ?? this.path,
      content: content ?? this.content.clone(),
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class InfraFileContentUpdateTable
    extends _is.UpdateTable<InfraFileContentTable> {
  InfraFileContentUpdateTable(super.table);

  _is.ColumnValue<int, int> configId(int value) =>
      _is.ColumnValue(table.configId, value);

  _is.ColumnValue<String, String> path(String value) =>
      _is.ColumnValue(table.path, value);

  _is.ColumnValue<_idt.ByteData, _idt.ByteData> content(_idt.ByteData value) =>
      _is.ColumnValue(table.content, value);

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

class InfraFileContentTable extends _is.Table<int?> {
  InfraFileContentTable({super.tableRelation})
    : super(tableName: 'infra_file_content') {
    updateTable = InfraFileContentUpdateTable(this);
    configId = _is.ColumnInt('configId', this);
    path = _is.ColumnString('path', this);
    content = _is.ColumnByteData('content', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final InfraFileContentUpdateTable updateTable;

  late final _is.ColumnInt configId;

  late final _is.ColumnString path;

  late final _is.ColumnByteData content;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    configId,
    path,
    content,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class InfraFileContentInclude extends _is.IncludeObject {
  InfraFileContentInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => InfraFileContent.t;
}

class InfraFileContentIncludeList extends _is.IncludeList {
  InfraFileContentIncludeList._({
    _is.WhereExpressionBuilder<InfraFileContentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraFileContent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => InfraFileContent.t;
}

class InfraFileContentRepository {
  const InfraFileContentRepository._();

  /// Returns a list of [InfraFileContent]s matching the given query parameters.
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
  Future<List<InfraFileContent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraFileContentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraFileContentTable>? orderBy,
    _is.OrderByListBuilder<InfraFileContentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InfraFileContent>(
      where: where?.call(InfraFileContent.t),
      orderBy: orderBy?.call(InfraFileContent.t),
      orderByList: orderByList?.call(InfraFileContent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InfraFileContent] matching the given query parameters.
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
  Future<InfraFileContent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraFileContentTable>? where,
    int? offset,
    _is.OrderByBuilder<InfraFileContentTable>? orderBy,
    _is.OrderByListBuilder<InfraFileContentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InfraFileContent>(
      where: where?.call(InfraFileContent.t),
      orderBy: orderBy?.call(InfraFileContent.t),
      orderByList: orderByList?.call(InfraFileContent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InfraFileContent] by its [id] or null if no such row exists.
  Future<InfraFileContent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InfraFileContent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InfraFileContent]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraFileContent]s will have their `id` fields set.
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
  Future<List<InfraFileContent>> insert(
    _is.DatabaseSession session,
    List<InfraFileContent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<InfraFileContent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [InfraFileContent] and returns the inserted row.
  ///
  /// The returned [InfraFileContent] will have its `id` field set.
  Future<InfraFileContent> insertRow(
    _is.DatabaseSession session,
    InfraFileContent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<InfraFileContent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [InfraFileContent]s in the list and returns the resulting rows.
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
  /// The returned [InfraFileContent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFileContent>> upsert(
    _is.DatabaseSession session,
    List<InfraFileContent> rows, {
    required _is.ColumnSelections<InfraFileContentTable> conflictColumns,
    _is.ColumnSelections<InfraFileContentTable>? updateColumns,
    _is.WhereExpressionBuilder<InfraFileContentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<InfraFileContent>(
      rows,
      conflictColumns: conflictColumns(InfraFileContent.t),
      updateColumns: updateColumns?.call(InfraFileContent.t),
      updateWhere: updateWhere?.call(InfraFileContent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [InfraFileContent] and returns the resulting row.
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
  /// The returned [InfraFileContent] will have its `id` field set.
  Future<InfraFileContent?> upsertRow(
    _is.DatabaseSession session,
    InfraFileContent row, {
    required _is.ColumnSelections<InfraFileContentTable> conflictColumns,
    _is.ColumnSelections<InfraFileContentTable>? updateColumns,
    _is.WhereExpressionBuilder<InfraFileContentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<InfraFileContent>(
      row,
      conflictColumns: conflictColumns(InfraFileContent.t),
      updateColumns: updateColumns?.call(InfraFileContent.t),
      updateWhere: updateWhere?.call(InfraFileContent.t),
      transaction: transaction,
    );
  }

  /// Updates all [InfraFileContent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFileContent>> update(
    _is.DatabaseSession session,
    List<InfraFileContent> rows, {
    _is.ColumnSelections<InfraFileContentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<InfraFileContent>(
      rows,
      columns: columns?.call(InfraFileContent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [InfraFileContent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraFileContent> updateRow(
    _is.DatabaseSession session,
    InfraFileContent row, {
    _is.ColumnSelections<InfraFileContentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraFileContent>(
      row,
      columns: columns?.call(InfraFileContent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InfraFileContent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InfraFileContent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InfraFileContentUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<InfraFileContent>(
      id,
      columnValues: columnValues(InfraFileContent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InfraFileContent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFileContent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InfraFileContentUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<InfraFileContentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraFileContentTable>? orderBy,
    _is.OrderByListBuilder<InfraFileContentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<InfraFileContent>(
      columnValues: columnValues(InfraFileContent.t.updateTable),
      where: where(InfraFileContent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraFileContent.t),
      orderByList: orderByList?.call(InfraFileContent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [InfraFileContent]s in the list and returns the deleted rows.
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
  Future<List<InfraFileContent>> delete(
    _is.DatabaseSession session,
    List<InfraFileContent> rows, {
    _is.OrderByBuilder<InfraFileContentTable>? orderBy,
    _is.OrderByListBuilder<InfraFileContentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<InfraFileContent>(
      rows,
      orderBy: orderBy?.call(InfraFileContent.t),
      orderByList: orderByList?.call(InfraFileContent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [InfraFileContent].
  Future<InfraFileContent> deleteRow(
    _is.DatabaseSession session,
    InfraFileContent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InfraFileContent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFileContent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InfraFileContentTable> where,
    _is.OrderByBuilder<InfraFileContentTable>? orderBy,
    _is.OrderByListBuilder<InfraFileContentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<InfraFileContent>(
      where: where(InfraFileContent.t),
      orderBy: orderBy?.call(InfraFileContent.t),
      orderByList: orderByList?.call(InfraFileContent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraFileContentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<InfraFileContent>(
      where: where?.call(InfraFileContent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InfraFileContent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InfraFileContentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InfraFileContent>(
      where: where(InfraFileContent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
