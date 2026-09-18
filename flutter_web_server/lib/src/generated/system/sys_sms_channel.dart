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

/// 短信渠道
abstract class SysSmsChannel
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysSmsChannel._({
    this.id,
    required this.signature,
    required this.code,
    required this.status,
    this.description,
    required this.apiKey,
    this.apiSecret,
    this.callbackUrl,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysSmsChannel({
    int? id,
    required String signature,
    required String code,
    required int status,
    String? description,
    required String apiKey,
    String? apiSecret,
    String? callbackUrl,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSmsChannelImpl;

  factory SysSmsChannel.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSmsChannel(
      id: jsonSerialization['id'] as int?,
      signature: jsonSerialization['signature'] as String,
      code: jsonSerialization['code'] as String,
      status: jsonSerialization['status'] as int,
      description: jsonSerialization['description'] as String?,
      apiKey: jsonSerialization['apiKey'] as String,
      apiSecret: jsonSerialization['apiSecret'] as String?,
      callbackUrl: jsonSerialization['callbackUrl'] as String?,
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

  static final t = SysSmsChannelTable();

  static const db = SysSmsChannelRepository._();

  @override
  int? id;

  String signature;

  String code;

  int status;

  String? description;

  String apiKey;

  String? apiSecret;

  String? callbackUrl;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSmsChannel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysSmsChannel copyWith({
    int? id,
    String? signature,
    String? code,
    int? status,
    String? description,
    String? apiKey,
    String? apiSecret,
    String? callbackUrl,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysSmsChannel',
      if (id != null) 'id': id,
      'signature': signature,
      'code': code,
      'status': status,
      if (description != null) 'description': description,
      'apiKey': apiKey,
      if (apiSecret != null) 'apiSecret': apiSecret,
      if (callbackUrl != null) 'callbackUrl': callbackUrl,
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
      '__className__': 'SysSmsChannel',
      if (id != null) 'id': id,
      'signature': signature,
      'code': code,
      'status': status,
      if (description != null) 'description': description,
      'apiKey': apiKey,
      if (apiSecret != null) 'apiSecret': apiSecret,
      if (callbackUrl != null) 'callbackUrl': callbackUrl,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysSmsChannelInclude include() {
    return SysSmsChannelInclude._();
  }

  static SysSmsChannelIncludeList includeList({
    _is.WhereExpressionBuilder<SysSmsChannelTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSmsChannelTable>? orderBy,
    _is.OrderByListBuilder<SysSmsChannelTable>? orderByList,
    SysSmsChannelInclude? include,
  }) {
    return SysSmsChannelIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSmsChannel.t),
      orderByList: orderByList?.call(SysSmsChannel.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysSmsChannelImpl extends SysSmsChannel {
  _SysSmsChannelImpl({
    int? id,
    required String signature,
    required String code,
    required int status,
    String? description,
    required String apiKey,
    String? apiSecret,
    String? callbackUrl,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         signature: signature,
         code: code,
         status: status,
         description: description,
         apiKey: apiKey,
         apiSecret: apiSecret,
         callbackUrl: callbackUrl,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysSmsChannel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysSmsChannel copyWith({
    Object? id = _Undefined,
    String? signature,
    String? code,
    int? status,
    Object? description = _Undefined,
    String? apiKey,
    Object? apiSecret = _Undefined,
    Object? callbackUrl = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSmsChannel(
      id: id is int? ? id : this.id,
      signature: signature ?? this.signature,
      code: code ?? this.code,
      status: status ?? this.status,
      description: description is String? ? description : this.description,
      apiKey: apiKey ?? this.apiKey,
      apiSecret: apiSecret is String? ? apiSecret : this.apiSecret,
      callbackUrl: callbackUrl is String? ? callbackUrl : this.callbackUrl,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysSmsChannelUpdateTable extends _is.UpdateTable<SysSmsChannelTable> {
  SysSmsChannelUpdateTable(super.table);

  _is.ColumnValue<String, String> signature(String value) =>
      _is.ColumnValue(table.signature, value);

  _is.ColumnValue<String, String> code(String value) =>
      _is.ColumnValue(table.code, value);

  _is.ColumnValue<int, int> status(int value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<String, String> apiKey(String value) =>
      _is.ColumnValue(table.apiKey, value);

  _is.ColumnValue<String, String> apiSecret(String? value) =>
      _is.ColumnValue(table.apiSecret, value);

  _is.ColumnValue<String, String> callbackUrl(String? value) =>
      _is.ColumnValue(table.callbackUrl, value);

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

class SysSmsChannelTable extends _is.Table<int?> {
  SysSmsChannelTable({super.tableRelation})
    : super(tableName: 'sys_sms_channel') {
    updateTable = SysSmsChannelUpdateTable(this);
    signature = _is.ColumnString('signature', this);
    code = _is.ColumnString('code', this);
    status = _is.ColumnInt('status', this);
    description = _is.ColumnString('description', this);
    apiKey = _is.ColumnString('apiKey', this);
    apiSecret = _is.ColumnString('apiSecret', this);
    callbackUrl = _is.ColumnString('callbackUrl', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysSmsChannelUpdateTable updateTable;

  late final _is.ColumnString signature;

  late final _is.ColumnString code;

  late final _is.ColumnInt status;

  late final _is.ColumnString description;

  late final _is.ColumnString apiKey;

  late final _is.ColumnString apiSecret;

  late final _is.ColumnString callbackUrl;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    signature,
    code,
    status,
    description,
    apiKey,
    apiSecret,
    callbackUrl,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysSmsChannelInclude extends _is.IncludeObject {
  SysSmsChannelInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysSmsChannel.t;
}

class SysSmsChannelIncludeList extends _is.IncludeList {
  SysSmsChannelIncludeList._({
    _is.WhereExpressionBuilder<SysSmsChannelTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSmsChannel.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysSmsChannel.t;
}

class SysSmsChannelRepository {
  const SysSmsChannelRepository._();

  /// Returns a list of [SysSmsChannel]s matching the given query parameters.
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
  Future<List<SysSmsChannel>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSmsChannelTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSmsChannelTable>? orderBy,
    _is.OrderByListBuilder<SysSmsChannelTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysSmsChannel>(
      where: where?.call(SysSmsChannel.t),
      orderBy: orderBy?.call(SysSmsChannel.t),
      orderByList: orderByList?.call(SysSmsChannel.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysSmsChannel] matching the given query parameters.
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
  Future<SysSmsChannel?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSmsChannelTable>? where,
    int? offset,
    _is.OrderByBuilder<SysSmsChannelTable>? orderBy,
    _is.OrderByListBuilder<SysSmsChannelTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysSmsChannel>(
      where: where?.call(SysSmsChannel.t),
      orderBy: orderBy?.call(SysSmsChannel.t),
      orderByList: orderByList?.call(SysSmsChannel.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysSmsChannel] by its [id] or null if no such row exists.
  Future<SysSmsChannel?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysSmsChannel>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysSmsChannel]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSmsChannel]s will have their `id` fields set.
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
  Future<List<SysSmsChannel>> insert(
    _is.DatabaseSession session,
    List<SysSmsChannel> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysSmsChannel>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysSmsChannel] and returns the inserted row.
  ///
  /// The returned [SysSmsChannel] will have its `id` field set.
  Future<SysSmsChannel> insertRow(
    _is.DatabaseSession session,
    SysSmsChannel row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSmsChannel>(row, transaction: transaction);
  }

  /// Upserts all [SysSmsChannel]s in the list and returns the resulting rows.
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
  /// The returned [SysSmsChannel]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsChannel>> upsert(
    _is.DatabaseSession session,
    List<SysSmsChannel> rows, {
    required _is.ColumnSelections<SysSmsChannelTable> conflictColumns,
    _is.ColumnSelections<SysSmsChannelTable>? updateColumns,
    _is.WhereExpressionBuilder<SysSmsChannelTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysSmsChannel>(
      rows,
      conflictColumns: conflictColumns(SysSmsChannel.t),
      updateColumns: updateColumns?.call(SysSmsChannel.t),
      updateWhere: updateWhere?.call(SysSmsChannel.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysSmsChannel] and returns the resulting row.
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
  /// The returned [SysSmsChannel] will have its `id` field set.
  Future<SysSmsChannel?> upsertRow(
    _is.DatabaseSession session,
    SysSmsChannel row, {
    required _is.ColumnSelections<SysSmsChannelTable> conflictColumns,
    _is.ColumnSelections<SysSmsChannelTable>? updateColumns,
    _is.WhereExpressionBuilder<SysSmsChannelTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysSmsChannel>(
      row,
      conflictColumns: conflictColumns(SysSmsChannel.t),
      updateColumns: updateColumns?.call(SysSmsChannel.t),
      updateWhere: updateWhere?.call(SysSmsChannel.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysSmsChannel]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsChannel>> update(
    _is.DatabaseSession session,
    List<SysSmsChannel> rows, {
    _is.ColumnSelections<SysSmsChannelTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysSmsChannel>(
      rows,
      columns: columns?.call(SysSmsChannel.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysSmsChannel]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSmsChannel> updateRow(
    _is.DatabaseSession session,
    SysSmsChannel row, {
    _is.ColumnSelections<SysSmsChannelTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSmsChannel>(
      row,
      columns: columns?.call(SysSmsChannel.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSmsChannel] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysSmsChannel?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysSmsChannelUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysSmsChannel>(
      id,
      columnValues: columnValues(SysSmsChannel.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysSmsChannel]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsChannel>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysSmsChannelUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysSmsChannelTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSmsChannelTable>? orderBy,
    _is.OrderByListBuilder<SysSmsChannelTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysSmsChannel>(
      columnValues: columnValues(SysSmsChannel.t.updateTable),
      where: where(SysSmsChannel.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSmsChannel.t),
      orderByList: orderByList?.call(SysSmsChannel.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysSmsChannel]s in the list and returns the deleted rows.
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
  Future<List<SysSmsChannel>> delete(
    _is.DatabaseSession session,
    List<SysSmsChannel> rows, {
    _is.OrderByBuilder<SysSmsChannelTable>? orderBy,
    _is.OrderByListBuilder<SysSmsChannelTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysSmsChannel>(
      rows,
      orderBy: orderBy?.call(SysSmsChannel.t),
      orderByList: orderByList?.call(SysSmsChannel.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysSmsChannel].
  Future<SysSmsChannel> deleteRow(
    _is.DatabaseSession session,
    SysSmsChannel row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSmsChannel>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsChannel>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysSmsChannelTable> where,
    _is.OrderByBuilder<SysSmsChannelTable>? orderBy,
    _is.OrderByListBuilder<SysSmsChannelTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysSmsChannel>(
      where: where(SysSmsChannel.t),
      orderBy: orderBy?.call(SysSmsChannel.t),
      orderByList: orderByList?.call(SysSmsChannel.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSmsChannelTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysSmsChannel>(
      where: where?.call(SysSmsChannel.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysSmsChannel] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysSmsChannelTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysSmsChannel>(
      where: where(SysSmsChannel.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
