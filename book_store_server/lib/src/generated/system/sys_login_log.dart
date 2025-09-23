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

/// 系统访问记录
abstract class SysLoginLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysLoginLog._({
    this.id,
    required this.tenantId,
    required this.logType,
    required this.traceId,
    required this.userId,
    required this.userType,
    required this.username,
    required this.result,
    required this.userIp,
    required this.userAgent,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysLoginLog({
    int? id,
    required int tenantId,
    required int logType,
    required String traceId,
    required int userId,
    required int userType,
    required String username,
    required int result,
    required String userIp,
    required String userAgent,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysLoginLogImpl;

  factory SysLoginLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysLoginLog(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      logType: jsonSerialization['logType'] as int,
      traceId: jsonSerialization['traceId'] as String,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      username: jsonSerialization['username'] as String,
      result: jsonSerialization['result'] as int,
      userIp: jsonSerialization['userIp'] as String,
      userAgent: jsonSerialization['userAgent'] as String,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysLoginLogTable();

  static const db = SysLoginLogRepository._();

  @override
  int? id;

  int tenantId;

  int logType;

  String traceId;

  int userId;

  int userType;

  String username;

  int result;

  String userIp;

  String userAgent;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysLoginLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysLoginLog copyWith({
    int? id,
    int? tenantId,
    int? logType,
    String? traceId,
    int? userId,
    int? userType,
    String? username,
    int? result,
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
      'logType': logType,
      'traceId': traceId,
      'userId': userId,
      'userType': userType,
      'username': username,
      'result': result,
      'userIp': userIp,
      'userAgent': userAgent,
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
      'logType': logType,
      'traceId': traceId,
      'userId': userId,
      'userType': userType,
      'username': username,
      'result': result,
      'userIp': userIp,
      'userAgent': userAgent,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysLoginLogInclude include() {
    return SysLoginLogInclude._();
  }

  static SysLoginLogIncludeList includeList({
    _i1.WhereExpressionBuilder<SysLoginLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysLoginLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysLoginLogTable>? orderByList,
    SysLoginLogInclude? include,
  }) {
    return SysLoginLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysLoginLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysLoginLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysLoginLogImpl extends SysLoginLog {
  _SysLoginLogImpl({
    int? id,
    required int tenantId,
    required int logType,
    required String traceId,
    required int userId,
    required int userType,
    required String username,
    required int result,
    required String userIp,
    required String userAgent,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          logType: logType,
          traceId: traceId,
          userId: userId,
          userType: userType,
          username: username,
          result: result,
          userIp: userIp,
          userAgent: userAgent,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysLoginLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysLoginLog copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? logType,
    String? traceId,
    int? userId,
    int? userType,
    String? username,
    int? result,
    String? userIp,
    String? userAgent,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysLoginLog(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      logType: logType ?? this.logType,
      traceId: traceId ?? this.traceId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      username: username ?? this.username,
      result: result ?? this.result,
      userIp: userIp ?? this.userIp,
      userAgent: userAgent ?? this.userAgent,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysLoginLogTable extends _i1.Table<int?> {
  SysLoginLogTable({super.tableRelation}) : super(tableName: 'sys_login_log') {
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
    );
    logType = _i1.ColumnInt(
      'logType',
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
    username = _i1.ColumnString(
      'username',
      this,
    );
    result = _i1.ColumnInt(
      'result',
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

  late final _i1.ColumnInt logType;

  late final _i1.ColumnString traceId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt userType;

  late final _i1.ColumnString username;

  late final _i1.ColumnInt result;

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
        logType,
        traceId,
        userId,
        userType,
        username,
        result,
        userIp,
        userAgent,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysLoginLogInclude extends _i1.IncludeObject {
  SysLoginLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysLoginLog.t;
}

class SysLoginLogIncludeList extends _i1.IncludeList {
  SysLoginLogIncludeList._({
    _i1.WhereExpressionBuilder<SysLoginLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysLoginLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysLoginLog.t;
}

class SysLoginLogRepository {
  const SysLoginLogRepository._();

  /// Returns a list of [SysLoginLog]s matching the given query parameters.
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
  Future<List<SysLoginLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysLoginLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysLoginLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysLoginLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysLoginLog>(
      where: where?.call(SysLoginLog.t),
      orderBy: orderBy?.call(SysLoginLog.t),
      orderByList: orderByList?.call(SysLoginLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysLoginLog] matching the given query parameters.
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
  Future<SysLoginLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysLoginLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysLoginLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysLoginLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysLoginLog>(
      where: where?.call(SysLoginLog.t),
      orderBy: orderBy?.call(SysLoginLog.t),
      orderByList: orderByList?.call(SysLoginLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysLoginLog] by its [id] or null if no such row exists.
  Future<SysLoginLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysLoginLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysLoginLog]s in the list and returns the inserted rows.
  ///
  /// The returned [SysLoginLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysLoginLog>> insert(
    _i1.Session session,
    List<SysLoginLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysLoginLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysLoginLog] and returns the inserted row.
  ///
  /// The returned [SysLoginLog] will have its `id` field set.
  Future<SysLoginLog> insertRow(
    _i1.Session session,
    SysLoginLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysLoginLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysLoginLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysLoginLog>> update(
    _i1.Session session,
    List<SysLoginLog> rows, {
    _i1.ColumnSelections<SysLoginLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysLoginLog>(
      rows,
      columns: columns?.call(SysLoginLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysLoginLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysLoginLog> updateRow(
    _i1.Session session,
    SysLoginLog row, {
    _i1.ColumnSelections<SysLoginLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysLoginLog>(
      row,
      columns: columns?.call(SysLoginLog.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysLoginLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysLoginLog>> delete(
    _i1.Session session,
    List<SysLoginLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysLoginLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysLoginLog].
  Future<SysLoginLog> deleteRow(
    _i1.Session session,
    SysLoginLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysLoginLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysLoginLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysLoginLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysLoginLog>(
      where: where(SysLoginLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysLoginLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysLoginLog>(
      where: where?.call(SysLoginLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
