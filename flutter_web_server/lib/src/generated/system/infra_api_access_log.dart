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

/// API 访问日志表
abstract class InfraApiAccessLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  InfraApiAccessLog._({
    this.id,
    int? tenantId,
    required this.traceId,
    required this.userId,
    required this.userType,
    required this.applicationName,
    required this.requestMethod,
    required this.requestUrl,
    this.requestParams,
    this.responseBody,
    required this.userIp,
    required this.userAgent,
    this.operateModule,
    this.operateName,
    required this.operateType,
    required this.beginTime,
    required this.endTime,
    required this.duration,
    required this.resultCode,
    this.resultMsg,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now();

  factory InfraApiAccessLog({
    int? id,
    int? tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String applicationName,
    required String requestMethod,
    required String requestUrl,
    String? requestParams,
    String? responseBody,
    required String userIp,
    required String userAgent,
    String? operateModule,
    String? operateName,
    required int operateType,
    required DateTime beginTime,
    required DateTime endTime,
    required int duration,
    required int resultCode,
    String? resultMsg,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraApiAccessLogImpl;

  factory InfraApiAccessLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraApiAccessLog(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      traceId: jsonSerialization['traceId'] as String,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      applicationName: jsonSerialization['applicationName'] as String,
      requestMethod: jsonSerialization['requestMethod'] as String,
      requestUrl: jsonSerialization['requestUrl'] as String,
      requestParams: jsonSerialization['requestParams'] as String?,
      responseBody: jsonSerialization['responseBody'] as String?,
      userIp: jsonSerialization['userIp'] as String,
      userAgent: jsonSerialization['userAgent'] as String,
      operateModule: jsonSerialization['operateModule'] as String?,
      operateName: jsonSerialization['operateName'] as String?,
      operateType: jsonSerialization['operateType'] as int,
      beginTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['beginTime'],
      ),
      endTime: _is.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      duration: jsonSerialization['duration'] as int,
      resultCode: jsonSerialization['resultCode'] as int,
      resultMsg: jsonSerialization['resultMsg'] as String?,
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

  static final t = InfraApiAccessLogTable();

  static const db = InfraApiAccessLogRepository._();

  @override
  int? id;

  int tenantId;

  String traceId;

  int userId;

  int userType;

  String applicationName;

  String requestMethod;

  String requestUrl;

  String? requestParams;

  String? responseBody;

  String userIp;

  String userAgent;

  String? operateModule;

  String? operateName;

  int operateType;

  DateTime beginTime;

  DateTime endTime;

  int duration;

  int resultCode;

  String? resultMsg;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraApiAccessLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InfraApiAccessLog copyWith({
    int? id,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? applicationName,
    String? requestMethod,
    String? requestUrl,
    String? requestParams,
    String? responseBody,
    String? userIp,
    String? userAgent,
    String? operateModule,
    String? operateName,
    int? operateType,
    DateTime? beginTime,
    DateTime? endTime,
    int? duration,
    int? resultCode,
    String? resultMsg,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InfraApiAccessLog',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'traceId': traceId,
      'userId': userId,
      'userType': userType,
      'applicationName': applicationName,
      'requestMethod': requestMethod,
      'requestUrl': requestUrl,
      if (requestParams != null) 'requestParams': requestParams,
      if (responseBody != null) 'responseBody': responseBody,
      'userIp': userIp,
      'userAgent': userAgent,
      if (operateModule != null) 'operateModule': operateModule,
      if (operateName != null) 'operateName': operateName,
      'operateType': operateType,
      'beginTime': beginTime.toJson(),
      'endTime': endTime.toJson(),
      'duration': duration,
      'resultCode': resultCode,
      if (resultMsg != null) 'resultMsg': resultMsg,
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
      '__className__': 'InfraApiAccessLog',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'traceId': traceId,
      'userId': userId,
      'userType': userType,
      'applicationName': applicationName,
      'requestMethod': requestMethod,
      'requestUrl': requestUrl,
      if (requestParams != null) 'requestParams': requestParams,
      if (responseBody != null) 'responseBody': responseBody,
      'userIp': userIp,
      'userAgent': userAgent,
      if (operateModule != null) 'operateModule': operateModule,
      if (operateName != null) 'operateName': operateName,
      'operateType': operateType,
      'beginTime': beginTime.toJson(),
      'endTime': endTime.toJson(),
      'duration': duration,
      'resultCode': resultCode,
      if (resultMsg != null) 'resultMsg': resultMsg,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static InfraApiAccessLogInclude include() {
    return InfraApiAccessLogInclude._();
  }

  static InfraApiAccessLogIncludeList includeList({
    _is.WhereExpressionBuilder<InfraApiAccessLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraApiAccessLogTable>? orderBy,
    _is.OrderByListBuilder<InfraApiAccessLogTable>? orderByList,
    InfraApiAccessLogInclude? include,
  }) {
    return InfraApiAccessLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraApiAccessLog.t),
      orderByList: orderByList?.call(InfraApiAccessLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InfraApiAccessLogImpl extends InfraApiAccessLog {
  _InfraApiAccessLogImpl({
    int? id,
    int? tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String applicationName,
    required String requestMethod,
    required String requestUrl,
    String? requestParams,
    String? responseBody,
    required String userIp,
    required String userAgent,
    String? operateModule,
    String? operateName,
    required int operateType,
    required DateTime beginTime,
    required DateTime endTime,
    required int duration,
    required int resultCode,
    String? resultMsg,
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
         responseBody: responseBody,
         userIp: userIp,
         userAgent: userAgent,
         operateModule: operateModule,
         operateName: operateName,
         operateType: operateType,
         beginTime: beginTime,
         endTime: endTime,
         duration: duration,
         resultCode: resultCode,
         resultMsg: resultMsg,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [InfraApiAccessLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InfraApiAccessLog copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? applicationName,
    String? requestMethod,
    String? requestUrl,
    Object? requestParams = _Undefined,
    Object? responseBody = _Undefined,
    String? userIp,
    String? userAgent,
    Object? operateModule = _Undefined,
    Object? operateName = _Undefined,
    int? operateType,
    DateTime? beginTime,
    DateTime? endTime,
    int? duration,
    int? resultCode,
    Object? resultMsg = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraApiAccessLog(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      traceId: traceId ?? this.traceId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      applicationName: applicationName ?? this.applicationName,
      requestMethod: requestMethod ?? this.requestMethod,
      requestUrl: requestUrl ?? this.requestUrl,
      requestParams: requestParams is String?
          ? requestParams
          : this.requestParams,
      responseBody: responseBody is String? ? responseBody : this.responseBody,
      userIp: userIp ?? this.userIp,
      userAgent: userAgent ?? this.userAgent,
      operateModule: operateModule is String?
          ? operateModule
          : this.operateModule,
      operateName: operateName is String? ? operateName : this.operateName,
      operateType: operateType ?? this.operateType,
      beginTime: beginTime ?? this.beginTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      resultCode: resultCode ?? this.resultCode,
      resultMsg: resultMsg is String? ? resultMsg : this.resultMsg,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class InfraApiAccessLogUpdateTable
    extends _is.UpdateTable<InfraApiAccessLogTable> {
  InfraApiAccessLogUpdateTable(super.table);

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

  _is.ColumnValue<String, String> requestParams(String? value) =>
      _is.ColumnValue(table.requestParams, value);

  _is.ColumnValue<String, String> responseBody(String? value) =>
      _is.ColumnValue(table.responseBody, value);

  _is.ColumnValue<String, String> userIp(String value) =>
      _is.ColumnValue(table.userIp, value);

  _is.ColumnValue<String, String> userAgent(String value) =>
      _is.ColumnValue(table.userAgent, value);

  _is.ColumnValue<String, String> operateModule(String? value) =>
      _is.ColumnValue(table.operateModule, value);

  _is.ColumnValue<String, String> operateName(String? value) =>
      _is.ColumnValue(table.operateName, value);

  _is.ColumnValue<int, int> operateType(int value) =>
      _is.ColumnValue(table.operateType, value);

  _is.ColumnValue<DateTime, DateTime> beginTime(DateTime value) =>
      _is.ColumnValue(table.beginTime, value);

  _is.ColumnValue<DateTime, DateTime> endTime(DateTime value) =>
      _is.ColumnValue(table.endTime, value);

  _is.ColumnValue<int, int> duration(int value) =>
      _is.ColumnValue(table.duration, value);

  _is.ColumnValue<int, int> resultCode(int value) =>
      _is.ColumnValue(table.resultCode, value);

  _is.ColumnValue<String, String> resultMsg(String? value) =>
      _is.ColumnValue(table.resultMsg, value);

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

class InfraApiAccessLogTable extends _is.Table<int?> {
  InfraApiAccessLogTable({super.tableRelation})
    : super(tableName: 'infra_api_access_log') {
    updateTable = InfraApiAccessLogUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    traceId = _is.ColumnString('traceId', this);
    userId = _is.ColumnInt('userId', this);
    userType = _is.ColumnInt('userType', this);
    applicationName = _is.ColumnString('applicationName', this);
    requestMethod = _is.ColumnString('requestMethod', this);
    requestUrl = _is.ColumnString('requestUrl', this);
    requestParams = _is.ColumnString('requestParams', this);
    responseBody = _is.ColumnString('responseBody', this);
    userIp = _is.ColumnString('userIp', this);
    userAgent = _is.ColumnString('userAgent', this);
    operateModule = _is.ColumnString('operateModule', this);
    operateName = _is.ColumnString('operateName', this);
    operateType = _is.ColumnInt('operateType', this);
    beginTime = _is.ColumnDateTime('beginTime', this);
    endTime = _is.ColumnDateTime('endTime', this);
    duration = _is.ColumnInt('duration', this);
    resultCode = _is.ColumnInt('resultCode', this);
    resultMsg = _is.ColumnString('resultMsg', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final InfraApiAccessLogUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString traceId;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt userType;

  late final _is.ColumnString applicationName;

  late final _is.ColumnString requestMethod;

  late final _is.ColumnString requestUrl;

  late final _is.ColumnString requestParams;

  late final _is.ColumnString responseBody;

  late final _is.ColumnString userIp;

  late final _is.ColumnString userAgent;

  late final _is.ColumnString operateModule;

  late final _is.ColumnString operateName;

  late final _is.ColumnInt operateType;

  late final _is.ColumnDateTime beginTime;

  late final _is.ColumnDateTime endTime;

  late final _is.ColumnInt duration;

  late final _is.ColumnInt resultCode;

  late final _is.ColumnString resultMsg;

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
    responseBody,
    userIp,
    userAgent,
    operateModule,
    operateName,
    operateType,
    beginTime,
    endTime,
    duration,
    resultCode,
    resultMsg,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class InfraApiAccessLogInclude extends _is.IncludeObject {
  InfraApiAccessLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => InfraApiAccessLog.t;
}

class InfraApiAccessLogIncludeList extends _is.IncludeList {
  InfraApiAccessLogIncludeList._({
    _is.WhereExpressionBuilder<InfraApiAccessLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraApiAccessLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => InfraApiAccessLog.t;
}

class InfraApiAccessLogRepository {
  const InfraApiAccessLogRepository._();

  /// Returns a list of [InfraApiAccessLog]s matching the given query parameters.
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
  Future<List<InfraApiAccessLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraApiAccessLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraApiAccessLogTable>? orderBy,
    _is.OrderByListBuilder<InfraApiAccessLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InfraApiAccessLog>(
      where: where?.call(InfraApiAccessLog.t),
      orderBy: orderBy?.call(InfraApiAccessLog.t),
      orderByList: orderByList?.call(InfraApiAccessLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InfraApiAccessLog] matching the given query parameters.
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
  Future<InfraApiAccessLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraApiAccessLogTable>? where,
    int? offset,
    _is.OrderByBuilder<InfraApiAccessLogTable>? orderBy,
    _is.OrderByListBuilder<InfraApiAccessLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InfraApiAccessLog>(
      where: where?.call(InfraApiAccessLog.t),
      orderBy: orderBy?.call(InfraApiAccessLog.t),
      orderByList: orderByList?.call(InfraApiAccessLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InfraApiAccessLog] by its [id] or null if no such row exists.
  Future<InfraApiAccessLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InfraApiAccessLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InfraApiAccessLog]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraApiAccessLog]s will have their `id` fields set.
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
  Future<List<InfraApiAccessLog>> insert(
    _is.DatabaseSession session,
    List<InfraApiAccessLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<InfraApiAccessLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [InfraApiAccessLog] and returns the inserted row.
  ///
  /// The returned [InfraApiAccessLog] will have its `id` field set.
  Future<InfraApiAccessLog> insertRow(
    _is.DatabaseSession session,
    InfraApiAccessLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<InfraApiAccessLog>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [InfraApiAccessLog]s in the list and returns the resulting rows.
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
  /// The returned [InfraApiAccessLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraApiAccessLog>> upsert(
    _is.DatabaseSession session,
    List<InfraApiAccessLog> rows, {
    required _is.ColumnSelections<InfraApiAccessLogTable> conflictColumns,
    _is.ColumnSelections<InfraApiAccessLogTable>? updateColumns,
    _is.WhereExpressionBuilder<InfraApiAccessLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<InfraApiAccessLog>(
      rows,
      conflictColumns: conflictColumns(InfraApiAccessLog.t),
      updateColumns: updateColumns?.call(InfraApiAccessLog.t),
      updateWhere: updateWhere?.call(InfraApiAccessLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [InfraApiAccessLog] and returns the resulting row.
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
  /// The returned [InfraApiAccessLog] will have its `id` field set.
  Future<InfraApiAccessLog?> upsertRow(
    _is.DatabaseSession session,
    InfraApiAccessLog row, {
    required _is.ColumnSelections<InfraApiAccessLogTable> conflictColumns,
    _is.ColumnSelections<InfraApiAccessLogTable>? updateColumns,
    _is.WhereExpressionBuilder<InfraApiAccessLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<InfraApiAccessLog>(
      row,
      conflictColumns: conflictColumns(InfraApiAccessLog.t),
      updateColumns: updateColumns?.call(InfraApiAccessLog.t),
      updateWhere: updateWhere?.call(InfraApiAccessLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [InfraApiAccessLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraApiAccessLog>> update(
    _is.DatabaseSession session,
    List<InfraApiAccessLog> rows, {
    _is.ColumnSelections<InfraApiAccessLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<InfraApiAccessLog>(
      rows,
      columns: columns?.call(InfraApiAccessLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [InfraApiAccessLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraApiAccessLog> updateRow(
    _is.DatabaseSession session,
    InfraApiAccessLog row, {
    _is.ColumnSelections<InfraApiAccessLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraApiAccessLog>(
      row,
      columns: columns?.call(InfraApiAccessLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InfraApiAccessLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InfraApiAccessLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InfraApiAccessLogUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<InfraApiAccessLog>(
      id,
      columnValues: columnValues(InfraApiAccessLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InfraApiAccessLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraApiAccessLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InfraApiAccessLogUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<InfraApiAccessLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraApiAccessLogTable>? orderBy,
    _is.OrderByListBuilder<InfraApiAccessLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<InfraApiAccessLog>(
      columnValues: columnValues(InfraApiAccessLog.t.updateTable),
      where: where(InfraApiAccessLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraApiAccessLog.t),
      orderByList: orderByList?.call(InfraApiAccessLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [InfraApiAccessLog]s in the list and returns the deleted rows.
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
  Future<List<InfraApiAccessLog>> delete(
    _is.DatabaseSession session,
    List<InfraApiAccessLog> rows, {
    _is.OrderByBuilder<InfraApiAccessLogTable>? orderBy,
    _is.OrderByListBuilder<InfraApiAccessLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<InfraApiAccessLog>(
      rows,
      orderBy: orderBy?.call(InfraApiAccessLog.t),
      orderByList: orderByList?.call(InfraApiAccessLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [InfraApiAccessLog].
  Future<InfraApiAccessLog> deleteRow(
    _is.DatabaseSession session,
    InfraApiAccessLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InfraApiAccessLog>(
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
  Future<List<InfraApiAccessLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InfraApiAccessLogTable> where,
    _is.OrderByBuilder<InfraApiAccessLogTable>? orderBy,
    _is.OrderByListBuilder<InfraApiAccessLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<InfraApiAccessLog>(
      where: where(InfraApiAccessLog.t),
      orderBy: orderBy?.call(InfraApiAccessLog.t),
      orderByList: orderByList?.call(InfraApiAccessLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraApiAccessLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<InfraApiAccessLog>(
      where: where?.call(InfraApiAccessLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InfraApiAccessLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InfraApiAccessLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InfraApiAccessLog>(
      where: where(InfraApiAccessLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
