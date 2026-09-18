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

/// 邮件日志表
abstract class SysMailLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysMailLog._({
    this.id,
    this.userId,
    this.userType,
    required this.toMail,
    required this.accountId,
    required this.fromMail,
    required this.templateId,
    required this.templateCode,
    this.templateNickname,
    required this.templateTitle,
    required this.templateContent,
    required this.templateParams,
    required this.sendStatus,
    this.sendTime,
    this.sendMessageId,
    this.sendException,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysMailLog({
    int? id,
    int? userId,
    int? userType,
    required String toMail,
    required int accountId,
    required String fromMail,
    required int templateId,
    required String templateCode,
    String? templateNickname,
    required String templateTitle,
    required String templateContent,
    required String templateParams,
    required int sendStatus,
    DateTime? sendTime,
    String? sendMessageId,
    String? sendException,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysMailLogImpl;

  factory SysMailLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysMailLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int?,
      userType: jsonSerialization['userType'] as int?,
      toMail: jsonSerialization['toMail'] as String,
      accountId: jsonSerialization['accountId'] as int,
      fromMail: jsonSerialization['fromMail'] as String,
      templateId: jsonSerialization['templateId'] as int,
      templateCode: jsonSerialization['templateCode'] as String,
      templateNickname: jsonSerialization['templateNickname'] as String?,
      templateTitle: jsonSerialization['templateTitle'] as String,
      templateContent: jsonSerialization['templateContent'] as String,
      templateParams: jsonSerialization['templateParams'] as String,
      sendStatus: jsonSerialization['sendStatus'] as int,
      sendTime: jsonSerialization['sendTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['sendTime']),
      sendMessageId: jsonSerialization['sendMessageId'] as String?,
      sendException: jsonSerialization['sendException'] as String?,
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

  static final t = SysMailLogTable();

  static const db = SysMailLogRepository._();

  @override
  int? id;

  int? userId;

  int? userType;

  String toMail;

  int accountId;

  String fromMail;

  int templateId;

  String templateCode;

  String? templateNickname;

  String templateTitle;

  String templateContent;

  String templateParams;

  int sendStatus;

  DateTime? sendTime;

  String? sendMessageId;

  String? sendException;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysMailLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysMailLog copyWith({
    int? id,
    int? userId,
    int? userType,
    String? toMail,
    int? accountId,
    String? fromMail,
    int? templateId,
    String? templateCode,
    String? templateNickname,
    String? templateTitle,
    String? templateContent,
    String? templateParams,
    int? sendStatus,
    DateTime? sendTime,
    String? sendMessageId,
    String? sendException,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysMailLog',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (userType != null) 'userType': userType,
      'toMail': toMail,
      'accountId': accountId,
      'fromMail': fromMail,
      'templateId': templateId,
      'templateCode': templateCode,
      if (templateNickname != null) 'templateNickname': templateNickname,
      'templateTitle': templateTitle,
      'templateContent': templateContent,
      'templateParams': templateParams,
      'sendStatus': sendStatus,
      if (sendTime != null) 'sendTime': sendTime?.toJson(),
      if (sendMessageId != null) 'sendMessageId': sendMessageId,
      if (sendException != null) 'sendException': sendException,
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
      '__className__': 'SysMailLog',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (userType != null) 'userType': userType,
      'toMail': toMail,
      'accountId': accountId,
      'fromMail': fromMail,
      'templateId': templateId,
      'templateCode': templateCode,
      if (templateNickname != null) 'templateNickname': templateNickname,
      'templateTitle': templateTitle,
      'templateContent': templateContent,
      'templateParams': templateParams,
      'sendStatus': sendStatus,
      if (sendTime != null) 'sendTime': sendTime?.toJson(),
      if (sendMessageId != null) 'sendMessageId': sendMessageId,
      if (sendException != null) 'sendException': sendException,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysMailLogInclude include() {
    return SysMailLogInclude._();
  }

  static SysMailLogIncludeList includeList({
    _is.WhereExpressionBuilder<SysMailLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysMailLogTable>? orderBy,
    _is.OrderByListBuilder<SysMailLogTable>? orderByList,
    SysMailLogInclude? include,
  }) {
    return SysMailLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysMailLog.t),
      orderByList: orderByList?.call(SysMailLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysMailLogImpl extends SysMailLog {
  _SysMailLogImpl({
    int? id,
    int? userId,
    int? userType,
    required String toMail,
    required int accountId,
    required String fromMail,
    required int templateId,
    required String templateCode,
    String? templateNickname,
    required String templateTitle,
    required String templateContent,
    required String templateParams,
    required int sendStatus,
    DateTime? sendTime,
    String? sendMessageId,
    String? sendException,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         userId: userId,
         userType: userType,
         toMail: toMail,
         accountId: accountId,
         fromMail: fromMail,
         templateId: templateId,
         templateCode: templateCode,
         templateNickname: templateNickname,
         templateTitle: templateTitle,
         templateContent: templateContent,
         templateParams: templateParams,
         sendStatus: sendStatus,
         sendTime: sendTime,
         sendMessageId: sendMessageId,
         sendException: sendException,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysMailLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysMailLog copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    Object? userType = _Undefined,
    String? toMail,
    int? accountId,
    String? fromMail,
    int? templateId,
    String? templateCode,
    Object? templateNickname = _Undefined,
    String? templateTitle,
    String? templateContent,
    String? templateParams,
    int? sendStatus,
    Object? sendTime = _Undefined,
    Object? sendMessageId = _Undefined,
    Object? sendException = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysMailLog(
      id: id is int? ? id : this.id,
      userId: userId is int? ? userId : this.userId,
      userType: userType is int? ? userType : this.userType,
      toMail: toMail ?? this.toMail,
      accountId: accountId ?? this.accountId,
      fromMail: fromMail ?? this.fromMail,
      templateId: templateId ?? this.templateId,
      templateCode: templateCode ?? this.templateCode,
      templateNickname: templateNickname is String?
          ? templateNickname
          : this.templateNickname,
      templateTitle: templateTitle ?? this.templateTitle,
      templateContent: templateContent ?? this.templateContent,
      templateParams: templateParams ?? this.templateParams,
      sendStatus: sendStatus ?? this.sendStatus,
      sendTime: sendTime is DateTime? ? sendTime : this.sendTime,
      sendMessageId: sendMessageId is String?
          ? sendMessageId
          : this.sendMessageId,
      sendException: sendException is String?
          ? sendException
          : this.sendException,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysMailLogUpdateTable extends _is.UpdateTable<SysMailLogTable> {
  SysMailLogUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int? value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<int, int> userType(int? value) =>
      _is.ColumnValue(table.userType, value);

  _is.ColumnValue<String, String> toMail(String value) =>
      _is.ColumnValue(table.toMail, value);

  _is.ColumnValue<int, int> accountId(int value) =>
      _is.ColumnValue(table.accountId, value);

  _is.ColumnValue<String, String> fromMail(String value) =>
      _is.ColumnValue(table.fromMail, value);

  _is.ColumnValue<int, int> templateId(int value) =>
      _is.ColumnValue(table.templateId, value);

  _is.ColumnValue<String, String> templateCode(String value) =>
      _is.ColumnValue(table.templateCode, value);

  _is.ColumnValue<String, String> templateNickname(String? value) =>
      _is.ColumnValue(table.templateNickname, value);

  _is.ColumnValue<String, String> templateTitle(String value) =>
      _is.ColumnValue(table.templateTitle, value);

  _is.ColumnValue<String, String> templateContent(String value) =>
      _is.ColumnValue(table.templateContent, value);

  _is.ColumnValue<String, String> templateParams(String value) =>
      _is.ColumnValue(table.templateParams, value);

  _is.ColumnValue<int, int> sendStatus(int value) =>
      _is.ColumnValue(table.sendStatus, value);

  _is.ColumnValue<DateTime, DateTime> sendTime(DateTime? value) =>
      _is.ColumnValue(table.sendTime, value);

  _is.ColumnValue<String, String> sendMessageId(String? value) =>
      _is.ColumnValue(table.sendMessageId, value);

  _is.ColumnValue<String, String> sendException(String? value) =>
      _is.ColumnValue(table.sendException, value);

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

class SysMailLogTable extends _is.Table<int?> {
  SysMailLogTable({super.tableRelation}) : super(tableName: 'sys_mail_log') {
    updateTable = SysMailLogUpdateTable(this);
    userId = _is.ColumnInt('userId', this);
    userType = _is.ColumnInt('userType', this);
    toMail = _is.ColumnString('toMail', this);
    accountId = _is.ColumnInt('accountId', this);
    fromMail = _is.ColumnString('fromMail', this);
    templateId = _is.ColumnInt('templateId', this);
    templateCode = _is.ColumnString('templateCode', this);
    templateNickname = _is.ColumnString('templateNickname', this);
    templateTitle = _is.ColumnString('templateTitle', this);
    templateContent = _is.ColumnString('templateContent', this);
    templateParams = _is.ColumnString('templateParams', this);
    sendStatus = _is.ColumnInt('sendStatus', this);
    sendTime = _is.ColumnDateTime('sendTime', this);
    sendMessageId = _is.ColumnString('sendMessageId', this);
    sendException = _is.ColumnString('sendException', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysMailLogUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt userType;

  late final _is.ColumnString toMail;

  late final _is.ColumnInt accountId;

  late final _is.ColumnString fromMail;

  late final _is.ColumnInt templateId;

  late final _is.ColumnString templateCode;

  late final _is.ColumnString templateNickname;

  late final _is.ColumnString templateTitle;

  late final _is.ColumnString templateContent;

  late final _is.ColumnString templateParams;

  late final _is.ColumnInt sendStatus;

  late final _is.ColumnDateTime sendTime;

  late final _is.ColumnString sendMessageId;

  late final _is.ColumnString sendException;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    userType,
    toMail,
    accountId,
    fromMail,
    templateId,
    templateCode,
    templateNickname,
    templateTitle,
    templateContent,
    templateParams,
    sendStatus,
    sendTime,
    sendMessageId,
    sendException,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysMailLogInclude extends _is.IncludeObject {
  SysMailLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysMailLog.t;
}

class SysMailLogIncludeList extends _is.IncludeList {
  SysMailLogIncludeList._({
    _is.WhereExpressionBuilder<SysMailLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysMailLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysMailLog.t;
}

class SysMailLogRepository {
  const SysMailLogRepository._();

  /// Returns a list of [SysMailLog]s matching the given query parameters.
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
  Future<List<SysMailLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysMailLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysMailLogTable>? orderBy,
    _is.OrderByListBuilder<SysMailLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysMailLog>(
      where: where?.call(SysMailLog.t),
      orderBy: orderBy?.call(SysMailLog.t),
      orderByList: orderByList?.call(SysMailLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysMailLog] matching the given query parameters.
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
  Future<SysMailLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysMailLogTable>? where,
    int? offset,
    _is.OrderByBuilder<SysMailLogTable>? orderBy,
    _is.OrderByListBuilder<SysMailLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysMailLog>(
      where: where?.call(SysMailLog.t),
      orderBy: orderBy?.call(SysMailLog.t),
      orderByList: orderByList?.call(SysMailLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysMailLog] by its [id] or null if no such row exists.
  Future<SysMailLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysMailLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysMailLog]s in the list and returns the inserted rows.
  ///
  /// The returned [SysMailLog]s will have their `id` fields set.
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
  Future<List<SysMailLog>> insert(
    _is.DatabaseSession session,
    List<SysMailLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysMailLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysMailLog] and returns the inserted row.
  ///
  /// The returned [SysMailLog] will have its `id` field set.
  Future<SysMailLog> insertRow(
    _is.DatabaseSession session,
    SysMailLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysMailLog>(row, transaction: transaction);
  }

  /// Upserts all [SysMailLog]s in the list and returns the resulting rows.
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
  /// The returned [SysMailLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMailLog>> upsert(
    _is.DatabaseSession session,
    List<SysMailLog> rows, {
    required _is.ColumnSelections<SysMailLogTable> conflictColumns,
    _is.ColumnSelections<SysMailLogTable>? updateColumns,
    _is.WhereExpressionBuilder<SysMailLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysMailLog>(
      rows,
      conflictColumns: conflictColumns(SysMailLog.t),
      updateColumns: updateColumns?.call(SysMailLog.t),
      updateWhere: updateWhere?.call(SysMailLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysMailLog] and returns the resulting row.
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
  /// The returned [SysMailLog] will have its `id` field set.
  Future<SysMailLog?> upsertRow(
    _is.DatabaseSession session,
    SysMailLog row, {
    required _is.ColumnSelections<SysMailLogTable> conflictColumns,
    _is.ColumnSelections<SysMailLogTable>? updateColumns,
    _is.WhereExpressionBuilder<SysMailLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysMailLog>(
      row,
      conflictColumns: conflictColumns(SysMailLog.t),
      updateColumns: updateColumns?.call(SysMailLog.t),
      updateWhere: updateWhere?.call(SysMailLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysMailLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMailLog>> update(
    _is.DatabaseSession session,
    List<SysMailLog> rows, {
    _is.ColumnSelections<SysMailLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysMailLog>(
      rows,
      columns: columns?.call(SysMailLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysMailLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysMailLog> updateRow(
    _is.DatabaseSession session,
    SysMailLog row, {
    _is.ColumnSelections<SysMailLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysMailLog>(
      row,
      columns: columns?.call(SysMailLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysMailLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysMailLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysMailLogUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysMailLog>(
      id,
      columnValues: columnValues(SysMailLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysMailLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMailLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysMailLogUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysMailLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysMailLogTable>? orderBy,
    _is.OrderByListBuilder<SysMailLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysMailLog>(
      columnValues: columnValues(SysMailLog.t.updateTable),
      where: where(SysMailLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysMailLog.t),
      orderByList: orderByList?.call(SysMailLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysMailLog]s in the list and returns the deleted rows.
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
  Future<List<SysMailLog>> delete(
    _is.DatabaseSession session,
    List<SysMailLog> rows, {
    _is.OrderByBuilder<SysMailLogTable>? orderBy,
    _is.OrderByListBuilder<SysMailLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysMailLog>(
      rows,
      orderBy: orderBy?.call(SysMailLog.t),
      orderByList: orderByList?.call(SysMailLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysMailLog].
  Future<SysMailLog> deleteRow(
    _is.DatabaseSession session,
    SysMailLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysMailLog>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMailLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysMailLogTable> where,
    _is.OrderByBuilder<SysMailLogTable>? orderBy,
    _is.OrderByListBuilder<SysMailLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysMailLog>(
      where: where(SysMailLog.t),
      orderBy: orderBy?.call(SysMailLog.t),
      orderByList: orderByList?.call(SysMailLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysMailLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysMailLog>(
      where: where?.call(SysMailLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysMailLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysMailLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysMailLog>(
      where: where(SysMailLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
