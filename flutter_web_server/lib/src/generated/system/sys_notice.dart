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

/// 通知公告表
abstract class SysNotice
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysNotice._({
    this.id,
    int? tenantId,
    required this.title,
    required this.content,
    required this.type,
    required this.status,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now();

  factory SysNotice({
    int? id,
    int? tenantId,
    required String title,
    required String content,
    required int type,
    required int status,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysNoticeImpl;

  factory SysNotice.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysNotice(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      title: jsonSerialization['title'] as String,
      content: jsonSerialization['content'] as String,
      type: jsonSerialization['type'] as int,
      status: jsonSerialization['status'] as int,
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

  static final t = SysNoticeTable();

  static const db = SysNoticeRepository._();

  @override
  int? id;

  int tenantId;

  String title;

  String content;

  int type;

  int status;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysNotice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysNotice copyWith({
    int? id,
    int? tenantId,
    String? title,
    String? content,
    int? type,
    int? status,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysNotice',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'title': title,
      'content': content,
      'type': type,
      'status': status,
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
      '__className__': 'SysNotice',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'title': title,
      'content': content,
      'type': type,
      'status': status,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysNoticeInclude include() {
    return SysNoticeInclude._();
  }

  static SysNoticeIncludeList includeList({
    _is.WhereExpressionBuilder<SysNoticeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysNoticeTable>? orderBy,
    _is.OrderByListBuilder<SysNoticeTable>? orderByList,
    SysNoticeInclude? include,
  }) {
    return SysNoticeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysNotice.t),
      orderByList: orderByList?.call(SysNotice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysNoticeImpl extends SysNotice {
  _SysNoticeImpl({
    int? id,
    int? tenantId,
    required String title,
    required String content,
    required int type,
    required int status,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         title: title,
         content: content,
         type: type,
         status: status,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysNotice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysNotice copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? title,
    String? content,
    int? type,
    int? status,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysNotice(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      status: status ?? this.status,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysNoticeUpdateTable extends _is.UpdateTable<SysNoticeTable> {
  SysNoticeUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> title(String value) =>
      _is.ColumnValue(table.title, value);

  _is.ColumnValue<String, String> content(String value) =>
      _is.ColumnValue(table.content, value);

  _is.ColumnValue<int, int> type(int value) =>
      _is.ColumnValue(table.type, value);

  _is.ColumnValue<int, int> status(int value) =>
      _is.ColumnValue(table.status, value);

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

class SysNoticeTable extends _is.Table<int?> {
  SysNoticeTable({super.tableRelation}) : super(tableName: 'sys_notice') {
    updateTable = SysNoticeUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    title = _is.ColumnString('title', this);
    content = _is.ColumnString('content', this);
    type = _is.ColumnInt('type', this);
    status = _is.ColumnInt('status', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysNoticeUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString title;

  late final _is.ColumnString content;

  late final _is.ColumnInt type;

  late final _is.ColumnInt status;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    title,
    content,
    type,
    status,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysNoticeInclude extends _is.IncludeObject {
  SysNoticeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysNotice.t;
}

class SysNoticeIncludeList extends _is.IncludeList {
  SysNoticeIncludeList._({
    _is.WhereExpressionBuilder<SysNoticeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysNotice.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysNotice.t;
}

class SysNoticeRepository {
  const SysNoticeRepository._();

  /// Returns a list of [SysNotice]s matching the given query parameters.
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
  Future<List<SysNotice>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysNoticeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysNoticeTable>? orderBy,
    _is.OrderByListBuilder<SysNoticeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysNotice>(
      where: where?.call(SysNotice.t),
      orderBy: orderBy?.call(SysNotice.t),
      orderByList: orderByList?.call(SysNotice.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysNotice] matching the given query parameters.
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
  Future<SysNotice?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysNoticeTable>? where,
    int? offset,
    _is.OrderByBuilder<SysNoticeTable>? orderBy,
    _is.OrderByListBuilder<SysNoticeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysNotice>(
      where: where?.call(SysNotice.t),
      orderBy: orderBy?.call(SysNotice.t),
      orderByList: orderByList?.call(SysNotice.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysNotice] by its [id] or null if no such row exists.
  Future<SysNotice?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysNotice>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysNotice]s in the list and returns the inserted rows.
  ///
  /// The returned [SysNotice]s will have their `id` fields set.
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
  Future<List<SysNotice>> insert(
    _is.DatabaseSession session,
    List<SysNotice> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysNotice>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysNotice] and returns the inserted row.
  ///
  /// The returned [SysNotice] will have its `id` field set.
  Future<SysNotice> insertRow(
    _is.DatabaseSession session,
    SysNotice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysNotice>(row, transaction: transaction);
  }

  /// Upserts all [SysNotice]s in the list and returns the resulting rows.
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
  /// The returned [SysNotice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysNotice>> upsert(
    _is.DatabaseSession session,
    List<SysNotice> rows, {
    required _is.ColumnSelections<SysNoticeTable> conflictColumns,
    _is.ColumnSelections<SysNoticeTable>? updateColumns,
    _is.WhereExpressionBuilder<SysNoticeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysNotice>(
      rows,
      conflictColumns: conflictColumns(SysNotice.t),
      updateColumns: updateColumns?.call(SysNotice.t),
      updateWhere: updateWhere?.call(SysNotice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysNotice] and returns the resulting row.
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
  /// The returned [SysNotice] will have its `id` field set.
  Future<SysNotice?> upsertRow(
    _is.DatabaseSession session,
    SysNotice row, {
    required _is.ColumnSelections<SysNoticeTable> conflictColumns,
    _is.ColumnSelections<SysNoticeTable>? updateColumns,
    _is.WhereExpressionBuilder<SysNoticeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysNotice>(
      row,
      conflictColumns: conflictColumns(SysNotice.t),
      updateColumns: updateColumns?.call(SysNotice.t),
      updateWhere: updateWhere?.call(SysNotice.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysNotice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysNotice>> update(
    _is.DatabaseSession session,
    List<SysNotice> rows, {
    _is.ColumnSelections<SysNoticeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysNotice>(
      rows,
      columns: columns?.call(SysNotice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysNotice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysNotice> updateRow(
    _is.DatabaseSession session,
    SysNotice row, {
    _is.ColumnSelections<SysNoticeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysNotice>(
      row,
      columns: columns?.call(SysNotice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysNotice] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysNotice?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysNoticeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysNotice>(
      id,
      columnValues: columnValues(SysNotice.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysNotice]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysNotice>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysNoticeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysNoticeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysNoticeTable>? orderBy,
    _is.OrderByListBuilder<SysNoticeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysNotice>(
      columnValues: columnValues(SysNotice.t.updateTable),
      where: where(SysNotice.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysNotice.t),
      orderByList: orderByList?.call(SysNotice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysNotice]s in the list and returns the deleted rows.
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
  Future<List<SysNotice>> delete(
    _is.DatabaseSession session,
    List<SysNotice> rows, {
    _is.OrderByBuilder<SysNoticeTable>? orderBy,
    _is.OrderByListBuilder<SysNoticeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysNotice>(
      rows,
      orderBy: orderBy?.call(SysNotice.t),
      orderByList: orderByList?.call(SysNotice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysNotice].
  Future<SysNotice> deleteRow(
    _is.DatabaseSession session,
    SysNotice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysNotice>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysNotice>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysNoticeTable> where,
    _is.OrderByBuilder<SysNoticeTable>? orderBy,
    _is.OrderByListBuilder<SysNoticeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysNotice>(
      where: where(SysNotice.t),
      orderBy: orderBy?.call(SysNotice.t),
      orderByList: orderByList?.call(SysNotice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysNoticeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysNotice>(
      where: where?.call(SysNotice.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysNotice] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysNoticeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysNotice>(
      where: where(SysNotice.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
