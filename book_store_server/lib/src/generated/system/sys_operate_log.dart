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

/// 操作日志记录 V2 版本
abstract class SysOperateLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysOperateLog._({
    this.id,
    required this.tenantId,
    required this.traceId,
    required this.userId,
    required this.userType,
    required this.type,
    required this.subType,
    required this.bizId,
    required this.action,
    required this.success,
    required this.extra,
    this.requestMethod,
    this.requestUrl,
    this.userIp,
    this.userAgent,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysOperateLog({
    int? id,
    required int tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String type,
    required String subType,
    required int bizId,
    required String action,
    required bool success,
    required String extra,
    String? requestMethod,
    String? requestUrl,
    String? userIp,
    String? userAgent,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysOperateLogImpl;

  factory SysOperateLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysOperateLog(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      traceId: jsonSerialization['traceId'] as String,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      type: jsonSerialization['type'] as String,
      subType: jsonSerialization['subType'] as String,
      bizId: jsonSerialization['bizId'] as int,
      action: jsonSerialization['action'] as String,
      success: jsonSerialization['success'] as bool,
      extra: jsonSerialization['extra'] as String,
      requestMethod: jsonSerialization['requestMethod'] as String?,
      requestUrl: jsonSerialization['requestUrl'] as String?,
      userIp: jsonSerialization['userIp'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysOperateLogTable();

  static const db = SysOperateLogRepository._();

  @override
  int? id;

  int tenantId;

  String traceId;

  int userId;

  int userType;

  String type;

  String subType;

  int bizId;

  String action;

  bool success;

  String extra;

  String? requestMethod;

  String? requestUrl;

  String? userIp;

  String? userAgent;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysOperateLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysOperateLog copyWith({
    int? id,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? type,
    String? subType,
    int? bizId,
    String? action,
    bool? success,
    String? extra,
    String? requestMethod,
    String? requestUrl,
    String? userIp,
    String? userAgent,
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
      'type': type,
      'subType': subType,
      'bizId': bizId,
      'action': action,
      'success': success,
      'extra': extra,
      if (requestMethod != null) 'requestMethod': requestMethod,
      if (requestUrl != null) 'requestUrl': requestUrl,
      if (userIp != null) 'userIp': userIp,
      if (userAgent != null) 'userAgent': userAgent,
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
      'type': type,
      'subType': subType,
      'bizId': bizId,
      'action': action,
      'success': success,
      'extra': extra,
      if (requestMethod != null) 'requestMethod': requestMethod,
      if (requestUrl != null) 'requestUrl': requestUrl,
      if (userIp != null) 'userIp': userIp,
      if (userAgent != null) 'userAgent': userAgent,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysOperateLogInclude include() {
    return SysOperateLogInclude._();
  }

  static SysOperateLogIncludeList includeList({
    _i1.WhereExpressionBuilder<SysOperateLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysOperateLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysOperateLogTable>? orderByList,
    SysOperateLogInclude? include,
  }) {
    return SysOperateLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysOperateLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysOperateLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysOperateLogImpl extends SysOperateLog {
  _SysOperateLogImpl({
    int? id,
    required int tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String type,
    required String subType,
    required int bizId,
    required String action,
    required bool success,
    required String extra,
    String? requestMethod,
    String? requestUrl,
    String? userIp,
    String? userAgent,
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
          type: type,
          subType: subType,
          bizId: bizId,
          action: action,
          success: success,
          extra: extra,
          requestMethod: requestMethod,
          requestUrl: requestUrl,
          userIp: userIp,
          userAgent: userAgent,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysOperateLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysOperateLog copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? type,
    String? subType,
    int? bizId,
    String? action,
    bool? success,
    String? extra,
    Object? requestMethod = _Undefined,
    Object? requestUrl = _Undefined,
    Object? userIp = _Undefined,
    Object? userAgent = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysOperateLog(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      traceId: traceId ?? this.traceId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      bizId: bizId ?? this.bizId,
      action: action ?? this.action,
      success: success ?? this.success,
      extra: extra ?? this.extra,
      requestMethod:
          requestMethod is String? ? requestMethod : this.requestMethod,
      requestUrl: requestUrl is String? ? requestUrl : this.requestUrl,
      userIp: userIp is String? ? userIp : this.userIp,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysOperateLogTable extends _i1.Table<int?> {
  SysOperateLogTable({super.tableRelation})
      : super(tableName: 'sys_operate_log') {
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
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
    type = _i1.ColumnString(
      'type',
      this,
    );
    subType = _i1.ColumnString(
      'subType',
      this,
    );
    bizId = _i1.ColumnInt(
      'bizId',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    success = _i1.ColumnBool(
      'success',
      this,
    );
    extra = _i1.ColumnString(
      'extra',
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
    userIp = _i1.ColumnString(
      'userIp',
      this,
    );
    userAgent = _i1.ColumnString(
      'userAgent',
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

  late final _i1.ColumnString type;

  late final _i1.ColumnString subType;

  late final _i1.ColumnInt bizId;

  late final _i1.ColumnString action;

  late final _i1.ColumnBool success;

  late final _i1.ColumnString extra;

  late final _i1.ColumnString requestMethod;

  late final _i1.ColumnString requestUrl;

  late final _i1.ColumnString userIp;

  late final _i1.ColumnString userAgent;

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
        type,
        subType,
        bizId,
        action,
        success,
        extra,
        requestMethod,
        requestUrl,
        userIp,
        userAgent,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysOperateLogInclude extends _i1.IncludeObject {
  SysOperateLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysOperateLog.t;
}

class SysOperateLogIncludeList extends _i1.IncludeList {
  SysOperateLogIncludeList._({
    _i1.WhereExpressionBuilder<SysOperateLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysOperateLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysOperateLog.t;
}

class SysOperateLogRepository {
  const SysOperateLogRepository._();

  /// Returns a list of [SysOperateLog]s matching the given query parameters.
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
  Future<List<SysOperateLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysOperateLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysOperateLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysOperateLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysOperateLog>(
      where: where?.call(SysOperateLog.t),
      orderBy: orderBy?.call(SysOperateLog.t),
      orderByList: orderByList?.call(SysOperateLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysOperateLog] matching the given query parameters.
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
  Future<SysOperateLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysOperateLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysOperateLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysOperateLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysOperateLog>(
      where: where?.call(SysOperateLog.t),
      orderBy: orderBy?.call(SysOperateLog.t),
      orderByList: orderByList?.call(SysOperateLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysOperateLog] by its [id] or null if no such row exists.
  Future<SysOperateLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysOperateLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysOperateLog]s in the list and returns the inserted rows.
  ///
  /// The returned [SysOperateLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysOperateLog>> insert(
    _i1.Session session,
    List<SysOperateLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysOperateLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysOperateLog] and returns the inserted row.
  ///
  /// The returned [SysOperateLog] will have its `id` field set.
  Future<SysOperateLog> insertRow(
    _i1.Session session,
    SysOperateLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysOperateLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysOperateLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysOperateLog>> update(
    _i1.Session session,
    List<SysOperateLog> rows, {
    _i1.ColumnSelections<SysOperateLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysOperateLog>(
      rows,
      columns: columns?.call(SysOperateLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysOperateLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysOperateLog> updateRow(
    _i1.Session session,
    SysOperateLog row, {
    _i1.ColumnSelections<SysOperateLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysOperateLog>(
      row,
      columns: columns?.call(SysOperateLog.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysOperateLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysOperateLog>> delete(
    _i1.Session session,
    List<SysOperateLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysOperateLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysOperateLog].
  Future<SysOperateLog> deleteRow(
    _i1.Session session,
    SysOperateLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysOperateLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysOperateLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysOperateLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysOperateLog>(
      where: where(SysOperateLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysOperateLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysOperateLog>(
      where: where?.call(SysOperateLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
