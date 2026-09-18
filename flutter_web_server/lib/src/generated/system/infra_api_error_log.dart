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

/// 系统异常日志
abstract class InfraApiErrorLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  InfraApiErrorLog._({
    this.id,
    int? tenantId,
    required this.traceId,
    required this.userId,
    required this.userType,
    required this.applicationName,
    required this.requestMethod,
    required this.requestUrl,
    required this.requestParams,
    required this.userIp,
    required this.userAgent,
    required this.exceptionTime,
    required this.exceptionName,
    required this.exceptionMessage,
    required this.exceptionRootCauseMessage,
    required this.exceptionStackTrace,
    required this.exceptionClassName,
    required this.exceptionFileName,
    required this.exceptionMethodName,
    required this.exceptionLineNumber,
    required this.processStatus,
    this.processTime,
    this.processUserId,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now();

  factory InfraApiErrorLog({
    int? id,
    int? tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String applicationName,
    required String requestMethod,
    required String requestUrl,
    required String requestParams,
    required String userIp,
    required String userAgent,
    required DateTime exceptionTime,
    required String exceptionName,
    required String exceptionMessage,
    required String exceptionRootCauseMessage,
    required String exceptionStackTrace,
    required String exceptionClassName,
    required String exceptionFileName,
    required String exceptionMethodName,
    required int exceptionLineNumber,
    required int processStatus,
    DateTime? processTime,
    int? processUserId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraApiErrorLogImpl;

  factory InfraApiErrorLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraApiErrorLog(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      traceId: jsonSerialization['traceId'] as String,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      applicationName: jsonSerialization['applicationName'] as String,
      requestMethod: jsonSerialization['requestMethod'] as String,
      requestUrl: jsonSerialization['requestUrl'] as String,
      requestParams: jsonSerialization['requestParams'] as String,
      userIp: jsonSerialization['userIp'] as String,
      userAgent: jsonSerialization['userAgent'] as String,
      exceptionTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['exceptionTime'],
      ),
      exceptionName: jsonSerialization['exceptionName'] as String,
      exceptionMessage: jsonSerialization['exceptionMessage'] as String,
      exceptionRootCauseMessage:
          jsonSerialization['exceptionRootCauseMessage'] as String,
      exceptionStackTrace: jsonSerialization['exceptionStackTrace'] as String,
      exceptionClassName: jsonSerialization['exceptionClassName'] as String,
      exceptionFileName: jsonSerialization['exceptionFileName'] as String,
      exceptionMethodName: jsonSerialization['exceptionMethodName'] as String,
      exceptionLineNumber: jsonSerialization['exceptionLineNumber'] as int,
      processStatus: jsonSerialization['processStatus'] as int,
      processTime: jsonSerialization['processTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['processTime'],
            ),
      processUserId: jsonSerialization['processUserId'] as int?,
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

  static final t = InfraApiErrorLogTable();

  static const db = InfraApiErrorLogRepository._();

  @override
  int? id;

  int tenantId;

  String traceId;

  int userId;

  int userType;

  String applicationName;

  String requestMethod;

  String requestUrl;

  String requestParams;

  String userIp;

  String userAgent;

  DateTime exceptionTime;

  String exceptionName;

  String exceptionMessage;

  String exceptionRootCauseMessage;

  String exceptionStackTrace;

  String exceptionClassName;

  String exceptionFileName;

  String exceptionMethodName;

  int exceptionLineNumber;

  int processStatus;

  DateTime? processTime;

  int? processUserId;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraApiErrorLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InfraApiErrorLog copyWith({
    int? id,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? applicationName,
    String? requestMethod,
    String? requestUrl,
    String? requestParams,
    String? userIp,
    String? userAgent,
    DateTime? exceptionTime,
    String? exceptionName,
    String? exceptionMessage,
    String? exceptionRootCauseMessage,
    String? exceptionStackTrace,
    String? exceptionClassName,
    String? exceptionFileName,
    String? exceptionMethodName,
    int? exceptionLineNumber,
    int? processStatus,
    DateTime? processTime,
    int? processUserId,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InfraApiErrorLog',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'traceId': traceId,
      'userId': userId,
      'userType': userType,
      'applicationName': applicationName,
      'requestMethod': requestMethod,
      'requestUrl': requestUrl,
      'requestParams': requestParams,
      'userIp': userIp,
      'userAgent': userAgent,
      'exceptionTime': exceptionTime.toJson(),
      'exceptionName': exceptionName,
      'exceptionMessage': exceptionMessage,
      'exceptionRootCauseMessage': exceptionRootCauseMessage,
      'exceptionStackTrace': exceptionStackTrace,
      'exceptionClassName': exceptionClassName,
      'exceptionFileName': exceptionFileName,
      'exceptionMethodName': exceptionMethodName,
      'exceptionLineNumber': exceptionLineNumber,
      'processStatus': processStatus,
      if (processTime != null) 'processTime': processTime?.toJson(),
      if (processUserId != null) 'processUserId': processUserId,
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
      '__className__': 'InfraApiErrorLog',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'traceId': traceId,
      'userId': userId,
      'userType': userType,
      'applicationName': applicationName,
      'requestMethod': requestMethod,
      'requestUrl': requestUrl,
      'requestParams': requestParams,
      'userIp': userIp,
      'userAgent': userAgent,
      'exceptionTime': exceptionTime.toJson(),
      'exceptionName': exceptionName,
      'exceptionMessage': exceptionMessage,
      'exceptionRootCauseMessage': exceptionRootCauseMessage,
      'exceptionStackTrace': exceptionStackTrace,
      'exceptionClassName': exceptionClassName,
      'exceptionFileName': exceptionFileName,
      'exceptionMethodName': exceptionMethodName,
      'exceptionLineNumber': exceptionLineNumber,
      'processStatus': processStatus,
      if (processTime != null) 'processTime': processTime?.toJson(),
      if (processUserId != null) 'processUserId': processUserId,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static InfraApiErrorLogInclude include() {
    return InfraApiErrorLogInclude._();
  }

  static InfraApiErrorLogIncludeList includeList({
    _is.WhereExpressionBuilder<InfraApiErrorLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraApiErrorLogTable>? orderBy,
    _is.OrderByListBuilder<InfraApiErrorLogTable>? orderByList,
    InfraApiErrorLogInclude? include,
  }) {
    return InfraApiErrorLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraApiErrorLog.t),
      orderByList: orderByList?.call(InfraApiErrorLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InfraApiErrorLogImpl extends InfraApiErrorLog {
  _InfraApiErrorLogImpl({
    int? id,
    int? tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String applicationName,
    required String requestMethod,
    required String requestUrl,
    required String requestParams,
    required String userIp,
    required String userAgent,
    required DateTime exceptionTime,
    required String exceptionName,
    required String exceptionMessage,
    required String exceptionRootCauseMessage,
    required String exceptionStackTrace,
    required String exceptionClassName,
    required String exceptionFileName,
    required String exceptionMethodName,
    required int exceptionLineNumber,
    required int processStatus,
    DateTime? processTime,
    int? processUserId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         traceId: traceId,
         userId: userId,
         userType: userType,
         applicationName: applicationName,
         requestMethod: requestMethod,
         requestUrl: requestUrl,
         requestParams: requestParams,
         userIp: userIp,
         userAgent: userAgent,
         exceptionTime: exceptionTime,
         exceptionName: exceptionName,
         exceptionMessage: exceptionMessage,
         exceptionRootCauseMessage: exceptionRootCauseMessage,
         exceptionStackTrace: exceptionStackTrace,
         exceptionClassName: exceptionClassName,
         exceptionFileName: exceptionFileName,
         exceptionMethodName: exceptionMethodName,
         exceptionLineNumber: exceptionLineNumber,
         processStatus: processStatus,
         processTime: processTime,
         processUserId: processUserId,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [InfraApiErrorLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InfraApiErrorLog copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? applicationName,
    String? requestMethod,
    String? requestUrl,
    String? requestParams,
    String? userIp,
    String? userAgent,
    DateTime? exceptionTime,
    String? exceptionName,
    String? exceptionMessage,
    String? exceptionRootCauseMessage,
    String? exceptionStackTrace,
    String? exceptionClassName,
    String? exceptionFileName,
    String? exceptionMethodName,
    int? exceptionLineNumber,
    int? processStatus,
    Object? processTime = _Undefined,
    Object? processUserId = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraApiErrorLog(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      traceId: traceId ?? this.traceId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      applicationName: applicationName ?? this.applicationName,
      requestMethod: requestMethod ?? this.requestMethod,
      requestUrl: requestUrl ?? this.requestUrl,
      requestParams: requestParams ?? this.requestParams,
      userIp: userIp ?? this.userIp,
      userAgent: userAgent ?? this.userAgent,
      exceptionTime: exceptionTime ?? this.exceptionTime,
      exceptionName: exceptionName ?? this.exceptionName,
      exceptionMessage: exceptionMessage ?? this.exceptionMessage,
      exceptionRootCauseMessage:
          exceptionRootCauseMessage ?? this.exceptionRootCauseMessage,
      exceptionStackTrace: exceptionStackTrace ?? this.exceptionStackTrace,
      exceptionClassName: exceptionClassName ?? this.exceptionClassName,
      exceptionFileName: exceptionFileName ?? this.exceptionFileName,
      exceptionMethodName: exceptionMethodName ?? this.exceptionMethodName,
      exceptionLineNumber: exceptionLineNumber ?? this.exceptionLineNumber,
      processStatus: processStatus ?? this.processStatus,
      processTime: processTime is DateTime? ? processTime : this.processTime,
      processUserId: processUserId is int? ? processUserId : this.processUserId,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class InfraApiErrorLogUpdateTable
    extends _is.UpdateTable<InfraApiErrorLogTable> {
  InfraApiErrorLogUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> traceId(String value) =>
      _is.ColumnValue(table.traceId, value);

  _is.ColumnValue<int, int> userId(int value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<int, int> userType(int value) =>
      _is.ColumnValue(table.userType, value);

  _is.ColumnValue<String, String> applicationName(String value) =>
      _is.ColumnValue(table.applicationName, value);

  _is.ColumnValue<String, String> requestMethod(String value) =>
      _is.ColumnValue(table.requestMethod, value);

  _is.ColumnValue<String, String> requestUrl(String value) =>
      _is.ColumnValue(table.requestUrl, value);

  _is.ColumnValue<String, String> requestParams(String value) =>
      _is.ColumnValue(table.requestParams, value);

  _is.ColumnValue<String, String> userIp(String value) =>
      _is.ColumnValue(table.userIp, value);

  _is.ColumnValue<String, String> userAgent(String value) =>
      _is.ColumnValue(table.userAgent, value);

  _is.ColumnValue<DateTime, DateTime> exceptionTime(DateTime value) =>
      _is.ColumnValue(table.exceptionTime, value);

  _is.ColumnValue<String, String> exceptionName(String value) =>
      _is.ColumnValue(table.exceptionName, value);

  _is.ColumnValue<String, String> exceptionMessage(String value) =>
      _is.ColumnValue(table.exceptionMessage, value);

  _is.ColumnValue<String, String> exceptionRootCauseMessage(String value) =>
      _is.ColumnValue(table.exceptionRootCauseMessage, value);

  _is.ColumnValue<String, String> exceptionStackTrace(String value) =>
      _is.ColumnValue(table.exceptionStackTrace, value);

  _is.ColumnValue<String, String> exceptionClassName(String value) =>
      _is.ColumnValue(table.exceptionClassName, value);

  _is.ColumnValue<String, String> exceptionFileName(String value) =>
      _is.ColumnValue(table.exceptionFileName, value);

  _is.ColumnValue<String, String> exceptionMethodName(String value) =>
      _is.ColumnValue(table.exceptionMethodName, value);

  _is.ColumnValue<int, int> exceptionLineNumber(int value) =>
      _is.ColumnValue(table.exceptionLineNumber, value);

  _is.ColumnValue<int, int> processStatus(int value) =>
      _is.ColumnValue(table.processStatus, value);

  _is.ColumnValue<DateTime, DateTime> processTime(DateTime? value) =>
      _is.ColumnValue(table.processTime, value);

  _is.ColumnValue<int, int> processUserId(int? value) =>
      _is.ColumnValue(table.processUserId, value);

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

class InfraApiErrorLogTable extends _is.Table<int?> {
  InfraApiErrorLogTable({super.tableRelation})
    : super(tableName: 'infra_api_error_log') {
    updateTable = InfraApiErrorLogUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    traceId = _is.ColumnString('traceId', this);
    userId = _is.ColumnInt('userId', this);
    userType = _is.ColumnInt('userType', this);
    applicationName = _is.ColumnString('applicationName', this);
    requestMethod = _is.ColumnString('requestMethod', this);
    requestUrl = _is.ColumnString('requestUrl', this);
    requestParams = _is.ColumnString('requestParams', this);
    userIp = _is.ColumnString('userIp', this);
    userAgent = _is.ColumnString('userAgent', this);
    exceptionTime = _is.ColumnDateTime('exceptionTime', this);
    exceptionName = _is.ColumnString('exceptionName', this);
    exceptionMessage = _is.ColumnString('exceptionMessage', this);
    exceptionRootCauseMessage = _is.ColumnString(
      'exceptionRootCauseMessage',
      this,
    );
    exceptionStackTrace = _is.ColumnString('exceptionStackTrace', this);
    exceptionClassName = _is.ColumnString('exceptionClassName', this);
    exceptionFileName = _is.ColumnString('exceptionFileName', this);
    exceptionMethodName = _is.ColumnString('exceptionMethodName', this);
    exceptionLineNumber = _is.ColumnInt('exceptionLineNumber', this);
    processStatus = _is.ColumnInt('processStatus', this);
    processTime = _is.ColumnDateTime('processTime', this);
    processUserId = _is.ColumnInt('processUserId', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final InfraApiErrorLogUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString traceId;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt userType;

  late final _is.ColumnString applicationName;

  late final _is.ColumnString requestMethod;

  late final _is.ColumnString requestUrl;

  late final _is.ColumnString requestParams;

  late final _is.ColumnString userIp;

  late final _is.ColumnString userAgent;

  late final _is.ColumnDateTime exceptionTime;

  late final _is.ColumnString exceptionName;

  late final _is.ColumnString exceptionMessage;

  late final _is.ColumnString exceptionRootCauseMessage;

  late final _is.ColumnString exceptionStackTrace;

  late final _is.ColumnString exceptionClassName;

  late final _is.ColumnString exceptionFileName;

  late final _is.ColumnString exceptionMethodName;

  late final _is.ColumnInt exceptionLineNumber;

  late final _is.ColumnInt processStatus;

  late final _is.ColumnDateTime processTime;

  late final _is.ColumnInt processUserId;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    traceId,
    userId,
    userType,
    applicationName,
    requestMethod,
    requestUrl,
    requestParams,
    userIp,
    userAgent,
    exceptionTime,
    exceptionName,
    exceptionMessage,
    exceptionRootCauseMessage,
    exceptionStackTrace,
    exceptionClassName,
    exceptionFileName,
    exceptionMethodName,
    exceptionLineNumber,
    processStatus,
    processTime,
    processUserId,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class InfraApiErrorLogInclude extends _is.IncludeObject {
  InfraApiErrorLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => InfraApiErrorLog.t;
}

class InfraApiErrorLogIncludeList extends _is.IncludeList {
  InfraApiErrorLogIncludeList._({
    _is.WhereExpressionBuilder<InfraApiErrorLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraApiErrorLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => InfraApiErrorLog.t;
}

class InfraApiErrorLogRepository {
  const InfraApiErrorLogRepository._();

  /// Returns a list of [InfraApiErrorLog]s matching the given query parameters.
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
  Future<List<InfraApiErrorLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraApiErrorLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraApiErrorLogTable>? orderBy,
    _is.OrderByListBuilder<InfraApiErrorLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InfraApiErrorLog>(
      where: where?.call(InfraApiErrorLog.t),
      orderBy: orderBy?.call(InfraApiErrorLog.t),
      orderByList: orderByList?.call(InfraApiErrorLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InfraApiErrorLog] matching the given query parameters.
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
  Future<InfraApiErrorLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraApiErrorLogTable>? where,
    int? offset,
    _is.OrderByBuilder<InfraApiErrorLogTable>? orderBy,
    _is.OrderByListBuilder<InfraApiErrorLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InfraApiErrorLog>(
      where: where?.call(InfraApiErrorLog.t),
      orderBy: orderBy?.call(InfraApiErrorLog.t),
      orderByList: orderByList?.call(InfraApiErrorLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InfraApiErrorLog] by its [id] or null if no such row exists.
  Future<InfraApiErrorLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InfraApiErrorLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InfraApiErrorLog]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraApiErrorLog]s will have their `id` fields set.
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
  Future<List<InfraApiErrorLog>> insert(
    _is.DatabaseSession session,
    List<InfraApiErrorLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<InfraApiErrorLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [InfraApiErrorLog] and returns the inserted row.
  ///
  /// The returned [InfraApiErrorLog] will have its `id` field set.
  Future<InfraApiErrorLog> insertRow(
    _is.DatabaseSession session,
    InfraApiErrorLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<InfraApiErrorLog>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [InfraApiErrorLog]s in the list and returns the resulting rows.
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
  /// The returned [InfraApiErrorLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraApiErrorLog>> upsert(
    _is.DatabaseSession session,
    List<InfraApiErrorLog> rows, {
    required _is.ColumnSelections<InfraApiErrorLogTable> conflictColumns,
    _is.ColumnSelections<InfraApiErrorLogTable>? updateColumns,
    _is.WhereExpressionBuilder<InfraApiErrorLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<InfraApiErrorLog>(
      rows,
      conflictColumns: conflictColumns(InfraApiErrorLog.t),
      updateColumns: updateColumns?.call(InfraApiErrorLog.t),
      updateWhere: updateWhere?.call(InfraApiErrorLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [InfraApiErrorLog] and returns the resulting row.
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
  /// The returned [InfraApiErrorLog] will have its `id` field set.
  Future<InfraApiErrorLog?> upsertRow(
    _is.DatabaseSession session,
    InfraApiErrorLog row, {
    required _is.ColumnSelections<InfraApiErrorLogTable> conflictColumns,
    _is.ColumnSelections<InfraApiErrorLogTable>? updateColumns,
    _is.WhereExpressionBuilder<InfraApiErrorLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<InfraApiErrorLog>(
      row,
      conflictColumns: conflictColumns(InfraApiErrorLog.t),
      updateColumns: updateColumns?.call(InfraApiErrorLog.t),
      updateWhere: updateWhere?.call(InfraApiErrorLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [InfraApiErrorLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraApiErrorLog>> update(
    _is.DatabaseSession session,
    List<InfraApiErrorLog> rows, {
    _is.ColumnSelections<InfraApiErrorLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<InfraApiErrorLog>(
      rows,
      columns: columns?.call(InfraApiErrorLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [InfraApiErrorLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraApiErrorLog> updateRow(
    _is.DatabaseSession session,
    InfraApiErrorLog row, {
    _is.ColumnSelections<InfraApiErrorLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraApiErrorLog>(
      row,
      columns: columns?.call(InfraApiErrorLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InfraApiErrorLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InfraApiErrorLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InfraApiErrorLogUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<InfraApiErrorLog>(
      id,
      columnValues: columnValues(InfraApiErrorLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InfraApiErrorLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraApiErrorLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InfraApiErrorLogUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<InfraApiErrorLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraApiErrorLogTable>? orderBy,
    _is.OrderByListBuilder<InfraApiErrorLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<InfraApiErrorLog>(
      columnValues: columnValues(InfraApiErrorLog.t.updateTable),
      where: where(InfraApiErrorLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraApiErrorLog.t),
      orderByList: orderByList?.call(InfraApiErrorLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [InfraApiErrorLog]s in the list and returns the deleted rows.
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
  Future<List<InfraApiErrorLog>> delete(
    _is.DatabaseSession session,
    List<InfraApiErrorLog> rows, {
    _is.OrderByBuilder<InfraApiErrorLogTable>? orderBy,
    _is.OrderByListBuilder<InfraApiErrorLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<InfraApiErrorLog>(
      rows,
      orderBy: orderBy?.call(InfraApiErrorLog.t),
      orderByList: orderByList?.call(InfraApiErrorLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [InfraApiErrorLog].
  Future<InfraApiErrorLog> deleteRow(
    _is.DatabaseSession session,
    InfraApiErrorLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InfraApiErrorLog>(
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
  Future<List<InfraApiErrorLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InfraApiErrorLogTable> where,
    _is.OrderByBuilder<InfraApiErrorLogTable>? orderBy,
    _is.OrderByListBuilder<InfraApiErrorLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<InfraApiErrorLog>(
      where: where(InfraApiErrorLog.t),
      orderBy: orderBy?.call(InfraApiErrorLog.t),
      orderByList: orderByList?.call(InfraApiErrorLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraApiErrorLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<InfraApiErrorLog>(
      where: where?.call(InfraApiErrorLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InfraApiErrorLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InfraApiErrorLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InfraApiErrorLog>(
      where: where(InfraApiErrorLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
