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

/// 站内信消息表
abstract class SysNotifyMessage
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysNotifyMessage._({
    this.id,
    int? tenantId,
    required this.userId,
    required this.userType,
    required this.templateId,
    required this.templateCode,
    required this.templateNickname,
    required this.templateContent,
    required this.templateType,
    required this.templateParams,
    required this.readStatus,
    this.readTime,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now();

  factory SysNotifyMessage({
    int? id,
    int? tenantId,
    required int userId,
    required int userType,
    required int templateId,
    required String templateCode,
    required String templateNickname,
    required String templateContent,
    required int templateType,
    required String templateParams,
    required bool readStatus,
    DateTime? readTime,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysNotifyMessageImpl;

  factory SysNotifyMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysNotifyMessage(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      templateId: jsonSerialization['templateId'] as int,
      templateCode: jsonSerialization['templateCode'] as String,
      templateNickname: jsonSerialization['templateNickname'] as String,
      templateContent: jsonSerialization['templateContent'] as String,
      templateType: jsonSerialization['templateType'] as int,
      templateParams: jsonSerialization['templateParams'] as String,
      readStatus: _is.BoolJsonExtension.fromJson(
        jsonSerialization['readStatus'],
      ),
      readTime: jsonSerialization['readTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['readTime']),
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

  static final t = SysNotifyMessageTable();

  static const db = SysNotifyMessageRepository._();

  @override
  int? id;

  int tenantId;

  int userId;

  int userType;

  int templateId;

  String templateCode;

  String templateNickname;

  String templateContent;

  int templateType;

  String templateParams;

  bool readStatus;

  DateTime? readTime;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysNotifyMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysNotifyMessage copyWith({
    int? id,
    int? tenantId,
    int? userId,
    int? userType,
    int? templateId,
    String? templateCode,
    String? templateNickname,
    String? templateContent,
    int? templateType,
    String? templateParams,
    bool? readStatus,
    DateTime? readTime,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysNotifyMessage',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'userType': userType,
      'templateId': templateId,
      'templateCode': templateCode,
      'templateNickname': templateNickname,
      'templateContent': templateContent,
      'templateType': templateType,
      'templateParams': templateParams,
      'readStatus': readStatus,
      if (readTime != null) 'readTime': readTime?.toJson(),
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
      '__className__': 'SysNotifyMessage',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'userType': userType,
      'templateId': templateId,
      'templateCode': templateCode,
      'templateNickname': templateNickname,
      'templateContent': templateContent,
      'templateType': templateType,
      'templateParams': templateParams,
      'readStatus': readStatus,
      if (readTime != null) 'readTime': readTime?.toJson(),
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysNotifyMessageInclude include() {
    return SysNotifyMessageInclude._();
  }

  static SysNotifyMessageIncludeList includeList({
    _is.WhereExpressionBuilder<SysNotifyMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysNotifyMessageTable>? orderBy,
    _is.OrderByListBuilder<SysNotifyMessageTable>? orderByList,
    SysNotifyMessageInclude? include,
  }) {
    return SysNotifyMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysNotifyMessage.t),
      orderByList: orderByList?.call(SysNotifyMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysNotifyMessageImpl extends SysNotifyMessage {
  _SysNotifyMessageImpl({
    int? id,
    int? tenantId,
    required int userId,
    required int userType,
    required int templateId,
    required String templateCode,
    required String templateNickname,
    required String templateContent,
    required int templateType,
    required String templateParams,
    required bool readStatus,
    DateTime? readTime,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         userId: userId,
         userType: userType,
         templateId: templateId,
         templateCode: templateCode,
         templateNickname: templateNickname,
         templateContent: templateContent,
         templateType: templateType,
         templateParams: templateParams,
         readStatus: readStatus,
         readTime: readTime,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysNotifyMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysNotifyMessage copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    int? userType,
    int? templateId,
    String? templateCode,
    String? templateNickname,
    String? templateContent,
    int? templateType,
    String? templateParams,
    bool? readStatus,
    Object? readTime = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysNotifyMessage(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      templateId: templateId ?? this.templateId,
      templateCode: templateCode ?? this.templateCode,
      templateNickname: templateNickname ?? this.templateNickname,
      templateContent: templateContent ?? this.templateContent,
      templateType: templateType ?? this.templateType,
      templateParams: templateParams ?? this.templateParams,
      readStatus: readStatus ?? this.readStatus,
      readTime: readTime is DateTime? ? readTime : this.readTime,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysNotifyMessageUpdateTable
    extends _is.UpdateTable<SysNotifyMessageTable> {
  SysNotifyMessageUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> userId(int value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<int, int> userType(int value) =>
      _is.ColumnValue(table.userType, value);

  _is.ColumnValue<int, int> templateId(int value) =>
      _is.ColumnValue(table.templateId, value);

  _is.ColumnValue<String, String> templateCode(String value) =>
      _is.ColumnValue(table.templateCode, value);

  _is.ColumnValue<String, String> templateNickname(String value) =>
      _is.ColumnValue(table.templateNickname, value);

  _is.ColumnValue<String, String> templateContent(String value) =>
      _is.ColumnValue(table.templateContent, value);

  _is.ColumnValue<int, int> templateType(int value) =>
      _is.ColumnValue(table.templateType, value);

  _is.ColumnValue<String, String> templateParams(String value) =>
      _is.ColumnValue(table.templateParams, value);

  _is.ColumnValue<bool, bool> readStatus(bool value) =>
      _is.ColumnValue(table.readStatus, value);

  _is.ColumnValue<DateTime, DateTime> readTime(DateTime? value) =>
      _is.ColumnValue(table.readTime, value);

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

class SysNotifyMessageTable extends _is.Table<int?> {
  SysNotifyMessageTable({super.tableRelation})
    : super(tableName: 'sys_notify_message') {
    updateTable = SysNotifyMessageUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    userId = _is.ColumnInt('userId', this);
    userType = _is.ColumnInt('userType', this);
    templateId = _is.ColumnInt('templateId', this);
    templateCode = _is.ColumnString('templateCode', this);
    templateNickname = _is.ColumnString('templateNickname', this);
    templateContent = _is.ColumnString('templateContent', this);
    templateType = _is.ColumnInt('templateType', this);
    templateParams = _is.ColumnString('templateParams', this);
    readStatus = _is.ColumnBool('readStatus', this);
    readTime = _is.ColumnDateTime('readTime', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysNotifyMessageUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt userType;

  late final _is.ColumnInt templateId;

  late final _is.ColumnString templateCode;

  late final _is.ColumnString templateNickname;

  late final _is.ColumnString templateContent;

  late final _is.ColumnInt templateType;

  late final _is.ColumnString templateParams;

  late final _is.ColumnBool readStatus;

  late final _is.ColumnDateTime readTime;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    userId,
    userType,
    templateId,
    templateCode,
    templateNickname,
    templateContent,
    templateType,
    templateParams,
    readStatus,
    readTime,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysNotifyMessageInclude extends _is.IncludeObject {
  SysNotifyMessageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysNotifyMessage.t;
}

class SysNotifyMessageIncludeList extends _is.IncludeList {
  SysNotifyMessageIncludeList._({
    _is.WhereExpressionBuilder<SysNotifyMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysNotifyMessage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysNotifyMessage.t;
}

class SysNotifyMessageRepository {
  const SysNotifyMessageRepository._();

  /// Returns a list of [SysNotifyMessage]s matching the given query parameters.
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
  Future<List<SysNotifyMessage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysNotifyMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysNotifyMessageTable>? orderBy,
    _is.OrderByListBuilder<SysNotifyMessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysNotifyMessage>(
      where: where?.call(SysNotifyMessage.t),
      orderBy: orderBy?.call(SysNotifyMessage.t),
      orderByList: orderByList?.call(SysNotifyMessage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysNotifyMessage] matching the given query parameters.
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
  Future<SysNotifyMessage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysNotifyMessageTable>? where,
    int? offset,
    _is.OrderByBuilder<SysNotifyMessageTable>? orderBy,
    _is.OrderByListBuilder<SysNotifyMessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysNotifyMessage>(
      where: where?.call(SysNotifyMessage.t),
      orderBy: orderBy?.call(SysNotifyMessage.t),
      orderByList: orderByList?.call(SysNotifyMessage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysNotifyMessage] by its [id] or null if no such row exists.
  Future<SysNotifyMessage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysNotifyMessage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysNotifyMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [SysNotifyMessage]s will have their `id` fields set.
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
  Future<List<SysNotifyMessage>> insert(
    _is.DatabaseSession session,
    List<SysNotifyMessage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysNotifyMessage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysNotifyMessage] and returns the inserted row.
  ///
  /// The returned [SysNotifyMessage] will have its `id` field set.
  Future<SysNotifyMessage> insertRow(
    _is.DatabaseSession session,
    SysNotifyMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysNotifyMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SysNotifyMessage]s in the list and returns the resulting rows.
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
  /// The returned [SysNotifyMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysNotifyMessage>> upsert(
    _is.DatabaseSession session,
    List<SysNotifyMessage> rows, {
    required _is.ColumnSelections<SysNotifyMessageTable> conflictColumns,
    _is.ColumnSelections<SysNotifyMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<SysNotifyMessageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysNotifyMessage>(
      rows,
      conflictColumns: conflictColumns(SysNotifyMessage.t),
      updateColumns: updateColumns?.call(SysNotifyMessage.t),
      updateWhere: updateWhere?.call(SysNotifyMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysNotifyMessage] and returns the resulting row.
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
  /// The returned [SysNotifyMessage] will have its `id` field set.
  Future<SysNotifyMessage?> upsertRow(
    _is.DatabaseSession session,
    SysNotifyMessage row, {
    required _is.ColumnSelections<SysNotifyMessageTable> conflictColumns,
    _is.ColumnSelections<SysNotifyMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<SysNotifyMessageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysNotifyMessage>(
      row,
      conflictColumns: conflictColumns(SysNotifyMessage.t),
      updateColumns: updateColumns?.call(SysNotifyMessage.t),
      updateWhere: updateWhere?.call(SysNotifyMessage.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysNotifyMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysNotifyMessage>> update(
    _is.DatabaseSession session,
    List<SysNotifyMessage> rows, {
    _is.ColumnSelections<SysNotifyMessageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysNotifyMessage>(
      rows,
      columns: columns?.call(SysNotifyMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysNotifyMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysNotifyMessage> updateRow(
    _is.DatabaseSession session,
    SysNotifyMessage row, {
    _is.ColumnSelections<SysNotifyMessageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysNotifyMessage>(
      row,
      columns: columns?.call(SysNotifyMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysNotifyMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysNotifyMessage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysNotifyMessageUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysNotifyMessage>(
      id,
      columnValues: columnValues(SysNotifyMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysNotifyMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysNotifyMessage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysNotifyMessageUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SysNotifyMessageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysNotifyMessageTable>? orderBy,
    _is.OrderByListBuilder<SysNotifyMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysNotifyMessage>(
      columnValues: columnValues(SysNotifyMessage.t.updateTable),
      where: where(SysNotifyMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysNotifyMessage.t),
      orderByList: orderByList?.call(SysNotifyMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysNotifyMessage]s in the list and returns the deleted rows.
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
  Future<List<SysNotifyMessage>> delete(
    _is.DatabaseSession session,
    List<SysNotifyMessage> rows, {
    _is.OrderByBuilder<SysNotifyMessageTable>? orderBy,
    _is.OrderByListBuilder<SysNotifyMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysNotifyMessage>(
      rows,
      orderBy: orderBy?.call(SysNotifyMessage.t),
      orderByList: orderByList?.call(SysNotifyMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysNotifyMessage].
  Future<SysNotifyMessage> deleteRow(
    _is.DatabaseSession session,
    SysNotifyMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysNotifyMessage>(
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
  Future<List<SysNotifyMessage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysNotifyMessageTable> where,
    _is.OrderByBuilder<SysNotifyMessageTable>? orderBy,
    _is.OrderByListBuilder<SysNotifyMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysNotifyMessage>(
      where: where(SysNotifyMessage.t),
      orderBy: orderBy?.call(SysNotifyMessage.t),
      orderByList: orderByList?.call(SysNotifyMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysNotifyMessageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysNotifyMessage>(
      where: where?.call(SysNotifyMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysNotifyMessage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysNotifyMessageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysNotifyMessage>(
      where: where(SysNotifyMessage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
