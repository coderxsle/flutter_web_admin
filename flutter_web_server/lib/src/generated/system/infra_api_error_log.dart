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

/// 系统异常日志
abstract class InfraApiErrorLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
  })  : tenantId = tenantId ?? 0,
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
      tenantId: jsonSerialization['tenantId'] as int,
      traceId: jsonSerialization['traceId'] as String,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      applicationName: jsonSerialization['applicationName'] as String,
      requestMethod: jsonSerialization['requestMethod'] as String,
      requestUrl: jsonSerialization['requestUrl'] as String,
      requestParams: jsonSerialization['requestParams'] as String,
      userIp: jsonSerialization['userIp'] as String,
      userAgent: jsonSerialization['userAgent'] as String,
      exceptionTime: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['exceptionTime']),
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
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['processTime']),
      processUserId: jsonSerialization['processUserId'] as int?,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
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
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraApiErrorLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    _i1.WhereExpressionBuilder<InfraApiErrorLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraApiErrorLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraApiErrorLogTable>? orderByList,
    InfraApiErrorLogInclude? include,
  }) {
    return InfraApiErrorLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraApiErrorLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InfraApiErrorLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
  @_i1.useResult
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

class InfraApiErrorLogTable extends _i1.Table<int?> {
  InfraApiErrorLogTable({super.tableRelation})
      : super(tableName: 'infra_api_error_log') {
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
    userIp = _i1.ColumnString(
      'userIp',
      this,
    );
    userAgent = _i1.ColumnString(
      'userAgent',
      this,
    );
    exceptionTime = _i1.ColumnDateTime(
      'exceptionTime',
      this,
    );
    exceptionName = _i1.ColumnString(
      'exceptionName',
      this,
    );
    exceptionMessage = _i1.ColumnString(
      'exceptionMessage',
      this,
    );
    exceptionRootCauseMessage = _i1.ColumnString(
      'exceptionRootCauseMessage',
      this,
    );
    exceptionStackTrace = _i1.ColumnString(
      'exceptionStackTrace',
      this,
    );
    exceptionClassName = _i1.ColumnString(
      'exceptionClassName',
      this,
    );
    exceptionFileName = _i1.ColumnString(
      'exceptionFileName',
      this,
    );
    exceptionMethodName = _i1.ColumnString(
      'exceptionMethodName',
      this,
    );
    exceptionLineNumber = _i1.ColumnInt(
      'exceptionLineNumber',
      this,
    );
    processStatus = _i1.ColumnInt(
      'processStatus',
      this,
    );
    processTime = _i1.ColumnDateTime(
      'processTime',
      this,
    );
    processUserId = _i1.ColumnInt(
      'processUserId',
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

  late final _i1.ColumnString userIp;

  late final _i1.ColumnString userAgent;

  late final _i1.ColumnDateTime exceptionTime;

  late final _i1.ColumnString exceptionName;

  late final _i1.ColumnString exceptionMessage;

  late final _i1.ColumnString exceptionRootCauseMessage;

  late final _i1.ColumnString exceptionStackTrace;

  late final _i1.ColumnString exceptionClassName;

  late final _i1.ColumnString exceptionFileName;

  late final _i1.ColumnString exceptionMethodName;

  late final _i1.ColumnInt exceptionLineNumber;

  late final _i1.ColumnInt processStatus;

  late final _i1.ColumnDateTime processTime;

  late final _i1.ColumnInt processUserId;

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

class InfraApiErrorLogInclude extends _i1.IncludeObject {
  InfraApiErrorLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => InfraApiErrorLog.t;
}

class InfraApiErrorLogIncludeList extends _i1.IncludeList {
  InfraApiErrorLogIncludeList._({
    _i1.WhereExpressionBuilder<InfraApiErrorLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraApiErrorLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => InfraApiErrorLog.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraApiErrorLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraApiErrorLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraApiErrorLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<InfraApiErrorLog>(
      where: where?.call(InfraApiErrorLog.t),
      orderBy: orderBy?.call(InfraApiErrorLog.t),
      orderByList: orderByList?.call(InfraApiErrorLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraApiErrorLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<InfraApiErrorLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraApiErrorLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<InfraApiErrorLog>(
      where: where?.call(InfraApiErrorLog.t),
      orderBy: orderBy?.call(InfraApiErrorLog.t),
      orderByList: orderByList?.call(InfraApiErrorLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [InfraApiErrorLog] by its [id] or null if no such row exists.
  Future<InfraApiErrorLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<InfraApiErrorLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [InfraApiErrorLog]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraApiErrorLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<InfraApiErrorLog>> insert(
    _i1.Session session,
    List<InfraApiErrorLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<InfraApiErrorLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [InfraApiErrorLog] and returns the inserted row.
  ///
  /// The returned [InfraApiErrorLog] will have its `id` field set.
  Future<InfraApiErrorLog> insertRow(
    _i1.Session session,
    InfraApiErrorLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InfraApiErrorLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [InfraApiErrorLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<InfraApiErrorLog>> update(
    _i1.Session session,
    List<InfraApiErrorLog> rows, {
    _i1.ColumnSelections<InfraApiErrorLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InfraApiErrorLog>(
      rows,
      columns: columns?.call(InfraApiErrorLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InfraApiErrorLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraApiErrorLog> updateRow(
    _i1.Session session,
    InfraApiErrorLog row, {
    _i1.ColumnSelections<InfraApiErrorLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraApiErrorLog>(
      row,
      columns: columns?.call(InfraApiErrorLog.t),
      transaction: transaction,
    );
  }

  /// Deletes all [InfraApiErrorLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<InfraApiErrorLog>> delete(
    _i1.Session session,
    List<InfraApiErrorLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InfraApiErrorLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [InfraApiErrorLog].
  Future<InfraApiErrorLog> deleteRow(
    _i1.Session session,
    InfraApiErrorLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InfraApiErrorLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<InfraApiErrorLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InfraApiErrorLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InfraApiErrorLog>(
      where: where(InfraApiErrorLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraApiErrorLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InfraApiErrorLog>(
      where: where?.call(InfraApiErrorLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
