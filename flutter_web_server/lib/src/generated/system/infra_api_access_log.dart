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
import 'package:serverpod/serverpod.dart' as _i1;

/// API 访问日志表
abstract class InfraApiAccessLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
  })  : tenantId = tenantId ?? 0,
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
      tenantId: jsonSerialization['tenantId'] as int,
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
      beginTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['beginTime']),
      endTime: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      duration: jsonSerialization['duration'] as int,
      resultCode: jsonSerialization['resultCode'] as int,
      resultMsg: jsonSerialization['resultMsg'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
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
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraApiAccessLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    _i1.WhereExpressionBuilder<InfraApiAccessLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraApiAccessLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraApiAccessLogTable>? orderByList,
    InfraApiAccessLogInclude? include,
  }) {
    return InfraApiAccessLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraApiAccessLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InfraApiAccessLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
  @_i1.useResult
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
      requestParams:
          requestParams is String? ? requestParams : this.requestParams,
      responseBody: responseBody is String? ? responseBody : this.responseBody,
      userIp: userIp ?? this.userIp,
      userAgent: userAgent ?? this.userAgent,
      operateModule:
          operateModule is String? ? operateModule : this.operateModule,
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

class InfraApiAccessLogTable extends _i1.Table<int?> {
  InfraApiAccessLogTable({super.tableRelation})
      : super(tableName: 'infra_api_access_log') {
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
      hasDefault: true,
    );
    traceId = _i1.ColumnString(
      'traceId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    userType = _i1.ColumnInt(
      'userType',
      this,
    );
    applicationName = _i1.ColumnString(
      'applicationName',
      this,
    );
    requestMethod = _i1.ColumnString(
      'requestMethod',
      this,
    );
    requestUrl = _i1.ColumnString(
      'requestUrl',
      this,
    );
    requestParams = _i1.ColumnString(
      'requestParams',
      this,
    );
    responseBody = _i1.ColumnString(
      'responseBody',
      this,
    );
    userIp = _i1.ColumnString(
      'userIp',
      this,
    );
    userAgent = _i1.ColumnString(
      'userAgent',
      this,
    );
    operateModule = _i1.ColumnString(
      'operateModule',
      this,
    );
    operateName = _i1.ColumnString(
      'operateName',
      this,
    );
    operateType = _i1.ColumnInt(
      'operateType',
      this,
    );
    beginTime = _i1.ColumnDateTime(
      'beginTime',
      this,
    );
    endTime = _i1.ColumnDateTime(
      'endTime',
      this,
    );
    duration = _i1.ColumnInt(
      'duration',
      this,
    );
    resultCode = _i1.ColumnInt(
      'resultCode',
      this,
    );
    resultMsg = _i1.ColumnString(
      'resultMsg',
      this,
    );
    creator = _i1.ColumnString(
      'creator',
      this,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
      hasDefault: true,
    );
    updater = _i1.ColumnString(
      'updater',
      this,
    );
    updateTime = _i1.ColumnDateTime(
      'updateTime',
      this,
    );
    deleted = _i1.ColumnBool(
      'deleted',
      this,
    );
  }

  late final _i1.ColumnInt tenantId;

  late final _i1.ColumnString traceId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt userType;

  late final _i1.ColumnString applicationName;

  late final _i1.ColumnString requestMethod;

  late final _i1.ColumnString requestUrl;

  late final _i1.ColumnString requestParams;

  late final _i1.ColumnString responseBody;

  late final _i1.ColumnString userIp;

  late final _i1.ColumnString userAgent;

  late final _i1.ColumnString operateModule;

  late final _i1.ColumnString operateName;

  late final _i1.ColumnInt operateType;

  late final _i1.ColumnDateTime beginTime;

  late final _i1.ColumnDateTime endTime;

  late final _i1.ColumnInt duration;

  late final _i1.ColumnInt resultCode;

  late final _i1.ColumnString resultMsg;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
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

class InfraApiAccessLogInclude extends _i1.IncludeObject {
  InfraApiAccessLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => InfraApiAccessLog.t;
}

class InfraApiAccessLogIncludeList extends _i1.IncludeList {
  InfraApiAccessLogIncludeList._({
    _i1.WhereExpressionBuilder<InfraApiAccessLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraApiAccessLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => InfraApiAccessLog.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraApiAccessLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraApiAccessLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraApiAccessLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<InfraApiAccessLog>(
      where: where?.call(InfraApiAccessLog.t),
      orderBy: orderBy?.call(InfraApiAccessLog.t),
      orderByList: orderByList?.call(InfraApiAccessLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraApiAccessLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<InfraApiAccessLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraApiAccessLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<InfraApiAccessLog>(
      where: where?.call(InfraApiAccessLog.t),
      orderBy: orderBy?.call(InfraApiAccessLog.t),
      orderByList: orderByList?.call(InfraApiAccessLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [InfraApiAccessLog] by its [id] or null if no such row exists.
  Future<InfraApiAccessLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<InfraApiAccessLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [InfraApiAccessLog]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraApiAccessLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<InfraApiAccessLog>> insert(
    _i1.Session session,
    List<InfraApiAccessLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<InfraApiAccessLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [InfraApiAccessLog] and returns the inserted row.
  ///
  /// The returned [InfraApiAccessLog] will have its `id` field set.
  Future<InfraApiAccessLog> insertRow(
    _i1.Session session,
    InfraApiAccessLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InfraApiAccessLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [InfraApiAccessLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<InfraApiAccessLog>> update(
    _i1.Session session,
    List<InfraApiAccessLog> rows, {
    _i1.ColumnSelections<InfraApiAccessLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InfraApiAccessLog>(
      rows,
      columns: columns?.call(InfraApiAccessLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InfraApiAccessLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraApiAccessLog> updateRow(
    _i1.Session session,
    InfraApiAccessLog row, {
    _i1.ColumnSelections<InfraApiAccessLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraApiAccessLog>(
      row,
      columns: columns?.call(InfraApiAccessLog.t),
      transaction: transaction,
    );
  }

  /// Deletes all [InfraApiAccessLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<InfraApiAccessLog>> delete(
    _i1.Session session,
    List<InfraApiAccessLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InfraApiAccessLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [InfraApiAccessLog].
  Future<InfraApiAccessLog> deleteRow(
    _i1.Session session,
    InfraApiAccessLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InfraApiAccessLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<InfraApiAccessLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InfraApiAccessLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InfraApiAccessLog>(
      where: where(InfraApiAccessLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraApiAccessLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InfraApiAccessLog>(
      where: where?.call(InfraApiAccessLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
