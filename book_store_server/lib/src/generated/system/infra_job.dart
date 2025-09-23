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

/// 定时任务表
abstract class InfraJob
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  InfraJob._({
    this.id,
    required this.name,
    required this.status,
    required this.handlerName,
    this.handlerParam,
    required this.cronExpression,
    required this.retryCount,
    required this.retryInterval,
    required this.monitorTimeout,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraJob({
    int? id,
    required String name,
    required int status,
    required String handlerName,
    String? handlerParam,
    required String cronExpression,
    required int retryCount,
    required int retryInterval,
    required int monitorTimeout,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraJobImpl;

  factory InfraJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraJob(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] as int,
      handlerName: jsonSerialization['handlerName'] as String,
      handlerParam: jsonSerialization['handlerParam'] as String?,
      cronExpression: jsonSerialization['cronExpression'] as String,
      retryCount: jsonSerialization['retryCount'] as int,
      retryInterval: jsonSerialization['retryInterval'] as int,
      monitorTimeout: jsonSerialization['monitorTimeout'] as int,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = InfraJobTable();

  static const db = InfraJobRepository._();

  @override
  int? id;

  String name;

  int status;

  String handlerName;

  String? handlerParam;

  String cronExpression;

  int retryCount;

  int retryInterval;

  int monitorTimeout;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InfraJob copyWith({
    int? id,
    String? name,
    int? status,
    String? handlerName,
    String? handlerParam,
    String? cronExpression,
    int? retryCount,
    int? retryInterval,
    int? monitorTimeout,
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
      'name': name,
      'status': status,
      'handlerName': handlerName,
      if (handlerParam != null) 'handlerParam': handlerParam,
      'cronExpression': cronExpression,
      'retryCount': retryCount,
      'retryInterval': retryInterval,
      'monitorTimeout': monitorTimeout,
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
      'name': name,
      'status': status,
      'handlerName': handlerName,
      if (handlerParam != null) 'handlerParam': handlerParam,
      'cronExpression': cronExpression,
      'retryCount': retryCount,
      'retryInterval': retryInterval,
      'monitorTimeout': monitorTimeout,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static InfraJobInclude include() {
    return InfraJobInclude._();
  }

  static InfraJobIncludeList includeList({
    _i1.WhereExpressionBuilder<InfraJobTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraJobTable>? orderByList,
    InfraJobInclude? include,
  }) {
    return InfraJobIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraJob.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InfraJob.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InfraJobImpl extends InfraJob {
  _InfraJobImpl({
    int? id,
    required String name,
    required int status,
    required String handlerName,
    String? handlerParam,
    required String cronExpression,
    required int retryCount,
    required int retryInterval,
    required int monitorTimeout,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          name: name,
          status: status,
          handlerName: handlerName,
          handlerParam: handlerParam,
          cronExpression: cronExpression,
          retryCount: retryCount,
          retryInterval: retryInterval,
          monitorTimeout: monitorTimeout,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [InfraJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InfraJob copyWith({
    Object? id = _Undefined,
    String? name,
    int? status,
    String? handlerName,
    Object? handlerParam = _Undefined,
    String? cronExpression,
    int? retryCount,
    int? retryInterval,
    int? monitorTimeout,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraJob(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      handlerName: handlerName ?? this.handlerName,
      handlerParam: handlerParam is String? ? handlerParam : this.handlerParam,
      cronExpression: cronExpression ?? this.cronExpression,
      retryCount: retryCount ?? this.retryCount,
      retryInterval: retryInterval ?? this.retryInterval,
      monitorTimeout: monitorTimeout ?? this.monitorTimeout,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class InfraJobTable extends _i1.Table<int?> {
  InfraJobTable({super.tableRelation}) : super(tableName: 'infra_job') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    status = _i1.ColumnInt(
      'status',
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
    cronExpression = _i1.ColumnString(
      'cronExpression',
      this,
    );
    retryCount = _i1.ColumnInt(
      'retryCount',
      this,
    );
    retryInterval = _i1.ColumnInt(
      'retryInterval',
      this,
    );
    monitorTimeout = _i1.ColumnInt(
      'monitorTimeout',
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

  late final _i1.ColumnString name;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString handlerName;

  late final _i1.ColumnString handlerParam;

  late final _i1.ColumnString cronExpression;

  late final _i1.ColumnInt retryCount;

  late final _i1.ColumnInt retryInterval;

  late final _i1.ColumnInt monitorTimeout;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        status,
        handlerName,
        handlerParam,
        cronExpression,
        retryCount,
        retryInterval,
        monitorTimeout,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class InfraJobInclude extends _i1.IncludeObject {
  InfraJobInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => InfraJob.t;
}

class InfraJobIncludeList extends _i1.IncludeList {
  InfraJobIncludeList._({
    _i1.WhereExpressionBuilder<InfraJobTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraJob.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => InfraJob.t;
}

class InfraJobRepository {
  const InfraJobRepository._();

  /// Returns a list of [InfraJob]s matching the given query parameters.
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
  Future<List<InfraJob>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraJobTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraJobTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<InfraJob>(
      where: where?.call(InfraJob.t),
      orderBy: orderBy?.call(InfraJob.t),
      orderByList: orderByList?.call(InfraJob.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [InfraJob] matching the given query parameters.
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
  Future<InfraJob?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraJobTable>? where,
    int? offset,
    _i1.OrderByBuilder<InfraJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraJobTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<InfraJob>(
      where: where?.call(InfraJob.t),
      orderBy: orderBy?.call(InfraJob.t),
      orderByList: orderByList?.call(InfraJob.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [InfraJob] by its [id] or null if no such row exists.
  Future<InfraJob?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<InfraJob>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [InfraJob]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraJob]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<InfraJob>> insert(
    _i1.Session session,
    List<InfraJob> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<InfraJob>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [InfraJob] and returns the inserted row.
  ///
  /// The returned [InfraJob] will have its `id` field set.
  Future<InfraJob> insertRow(
    _i1.Session session,
    InfraJob row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InfraJob>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [InfraJob]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<InfraJob>> update(
    _i1.Session session,
    List<InfraJob> rows, {
    _i1.ColumnSelections<InfraJobTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InfraJob>(
      rows,
      columns: columns?.call(InfraJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InfraJob]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraJob> updateRow(
    _i1.Session session,
    InfraJob row, {
    _i1.ColumnSelections<InfraJobTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraJob>(
      row,
      columns: columns?.call(InfraJob.t),
      transaction: transaction,
    );
  }

  /// Deletes all [InfraJob]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<InfraJob>> delete(
    _i1.Session session,
    List<InfraJob> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InfraJob>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [InfraJob].
  Future<InfraJob> deleteRow(
    _i1.Session session,
    InfraJob row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InfraJob>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<InfraJob>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InfraJobTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InfraJob>(
      where: where(InfraJob.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraJobTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InfraJob>(
      where: where?.call(InfraJob.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
