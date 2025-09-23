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

/// 定时任务日志表
abstract class InfraJobLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  InfraJobLog._({
    this.id,
    required this.jobId,
    required this.handlerName,
    this.handlerParam,
    required this.executeIndex,
    required this.beginTime,
    this.endTime,
    this.duration,
    required this.status,
    this.result,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraJobLog({
    int? id,
    required int jobId,
    required String handlerName,
    String? handlerParam,
    required int executeIndex,
    required DateTime beginTime,
    DateTime? endTime,
    int? duration,
    required int status,
    String? result,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraJobLogImpl;

  factory InfraJobLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraJobLog(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      handlerName: jsonSerialization['handlerName'] as String,
      handlerParam: jsonSerialization['handlerParam'] as String?,
      executeIndex: jsonSerialization['executeIndex'] as int,
      beginTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['beginTime']),
      endTime: jsonSerialization['endTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      duration: jsonSerialization['duration'] as int?,
      status: jsonSerialization['status'] as int,
      result: jsonSerialization['result'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = InfraJobLogTable();

  static const db = InfraJobLogRepository._();

  @override
  int? id;

  int jobId;

  String handlerName;

  String? handlerParam;

  int executeIndex;

  DateTime beginTime;

  DateTime? endTime;

  int? duration;

  int status;

  String? result;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraJobLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InfraJobLog copyWith({
    int? id,
    int? jobId,
    String? handlerName,
    String? handlerParam,
    int? executeIndex,
    DateTime? beginTime,
    DateTime? endTime,
    int? duration,
    int? status,
    String? result,
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
      'jobId': jobId,
      'handlerName': handlerName,
      if (handlerParam != null) 'handlerParam': handlerParam,
      'executeIndex': executeIndex,
      'beginTime': beginTime.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
      if (duration != null) 'duration': duration,
      'status': status,
      if (result != null) 'result': result,
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
      'jobId': jobId,
      'handlerName': handlerName,
      if (handlerParam != null) 'handlerParam': handlerParam,
      'executeIndex': executeIndex,
      'beginTime': beginTime.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
      if (duration != null) 'duration': duration,
      'status': status,
      if (result != null) 'result': result,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static InfraJobLogInclude include() {
    return InfraJobLogInclude._();
  }

  static InfraJobLogIncludeList includeList({
    _i1.WhereExpressionBuilder<InfraJobLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraJobLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraJobLogTable>? orderByList,
    InfraJobLogInclude? include,
  }) {
    return InfraJobLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraJobLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InfraJobLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InfraJobLogImpl extends InfraJobLog {
  _InfraJobLogImpl({
    int? id,
    required int jobId,
    required String handlerName,
    String? handlerParam,
    required int executeIndex,
    required DateTime beginTime,
    DateTime? endTime,
    int? duration,
    required int status,
    String? result,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          jobId: jobId,
          handlerName: handlerName,
          handlerParam: handlerParam,
          executeIndex: executeIndex,
          beginTime: beginTime,
          endTime: endTime,
          duration: duration,
          status: status,
          result: result,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [InfraJobLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InfraJobLog copyWith({
    Object? id = _Undefined,
    int? jobId,
    String? handlerName,
    Object? handlerParam = _Undefined,
    int? executeIndex,
    DateTime? beginTime,
    Object? endTime = _Undefined,
    Object? duration = _Undefined,
    int? status,
    Object? result = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraJobLog(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      handlerName: handlerName ?? this.handlerName,
      handlerParam: handlerParam is String? ? handlerParam : this.handlerParam,
      executeIndex: executeIndex ?? this.executeIndex,
      beginTime: beginTime ?? this.beginTime,
      endTime: endTime is DateTime? ? endTime : this.endTime,
      duration: duration is int? ? duration : this.duration,
      status: status ?? this.status,
      result: result is String? ? result : this.result,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class InfraJobLogTable extends _i1.Table<int?> {
  InfraJobLogTable({super.tableRelation}) : super(tableName: 'infra_job_log') {
    jobId = _i1.ColumnInt(
      'jobId',
      this,
    );
    handlerName = _i1.ColumnString(
      'handlerName',
      this,
    );
    handlerParam = _i1.ColumnString(
      'handlerParam',
      this,
    );
    executeIndex = _i1.ColumnInt(
      'executeIndex',
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
    status = _i1.ColumnInt(
      'status',
      this,
    );
    result = _i1.ColumnString(
      'result',
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

  late final _i1.ColumnInt jobId;

  late final _i1.ColumnString handlerName;

  late final _i1.ColumnString handlerParam;

  late final _i1.ColumnInt executeIndex;

  late final _i1.ColumnDateTime beginTime;

  late final _i1.ColumnDateTime endTime;

  late final _i1.ColumnInt duration;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString result;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        jobId,
        handlerName,
        handlerParam,
        executeIndex,
        beginTime,
        endTime,
        duration,
        status,
        result,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class InfraJobLogInclude extends _i1.IncludeObject {
  InfraJobLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => InfraJobLog.t;
}

class InfraJobLogIncludeList extends _i1.IncludeList {
  InfraJobLogIncludeList._({
    _i1.WhereExpressionBuilder<InfraJobLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraJobLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => InfraJobLog.t;
}

class InfraJobLogRepository {
  const InfraJobLogRepository._();

  /// Returns a list of [InfraJobLog]s matching the given query parameters.
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
  Future<List<InfraJobLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraJobLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraJobLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraJobLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<InfraJobLog>(
      where: where?.call(InfraJobLog.t),
      orderBy: orderBy?.call(InfraJobLog.t),
      orderByList: orderByList?.call(InfraJobLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [InfraJobLog] matching the given query parameters.
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
  Future<InfraJobLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraJobLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<InfraJobLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraJobLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<InfraJobLog>(
      where: where?.call(InfraJobLog.t),
      orderBy: orderBy?.call(InfraJobLog.t),
      orderByList: orderByList?.call(InfraJobLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [InfraJobLog] by its [id] or null if no such row exists.
  Future<InfraJobLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<InfraJobLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [InfraJobLog]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraJobLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<InfraJobLog>> insert(
    _i1.Session session,
    List<InfraJobLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<InfraJobLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [InfraJobLog] and returns the inserted row.
  ///
  /// The returned [InfraJobLog] will have its `id` field set.
  Future<InfraJobLog> insertRow(
    _i1.Session session,
    InfraJobLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InfraJobLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [InfraJobLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<InfraJobLog>> update(
    _i1.Session session,
    List<InfraJobLog> rows, {
    _i1.ColumnSelections<InfraJobLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InfraJobLog>(
      rows,
      columns: columns?.call(InfraJobLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InfraJobLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraJobLog> updateRow(
    _i1.Session session,
    InfraJobLog row, {
    _i1.ColumnSelections<InfraJobLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraJobLog>(
      row,
      columns: columns?.call(InfraJobLog.t),
      transaction: transaction,
    );
  }

  /// Deletes all [InfraJobLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<InfraJobLog>> delete(
    _i1.Session session,
    List<InfraJobLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InfraJobLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [InfraJobLog].
  Future<InfraJobLog> deleteRow(
    _i1.Session session,
    InfraJobLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InfraJobLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<InfraJobLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InfraJobLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InfraJobLog>(
      where: where(InfraJobLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraJobLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InfraJobLog>(
      where: where?.call(InfraJobLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
