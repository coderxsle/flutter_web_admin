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
import 'package:flutter_web_server/src/generated/protocol.dart' as _ii4hkddg;
import 'package:serverpod/serverpod.dart' as _is;

/// 术数排盘记录表
abstract class ArtsRecord implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ArtsRecord._({
    this.id,
    int? tenantId,
    required this.userId,
    required this.artsType,
    required this.clientKey,
    String? title,
    String? question,
    required this.chartTime,
    String? queryParams,
    String? chartSnapshot,
    String? interpretation,
    String? feedback,
    this.tags,
    int? status,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       title = title ?? '',
       question = question ?? '',
       queryParams = queryParams ?? '',
       chartSnapshot = chartSnapshot ?? '',
       interpretation = interpretation ?? '',
       feedback = feedback ?? '',
       status = status ?? 1,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ArtsRecord({
    int? id,
    int? tenantId,
    required int userId,
    required String artsType,
    required String clientKey,
    String? title,
    String? question,
    required DateTime chartTime,
    String? queryParams,
    String? chartSnapshot,
    String? interpretation,
    String? feedback,
    List<String>? tags,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ArtsRecordImpl;

  factory ArtsRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArtsRecord(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      userId: jsonSerialization['userId'] as int,
      artsType: jsonSerialization['artsType'] as String,
      clientKey: jsonSerialization['clientKey'] as String,
      title: jsonSerialization['title'] as String?,
      question: jsonSerialization['question'] as String?,
      chartTime: _is.DateTimeJsonExtension.fromJson(jsonSerialization['chartTime']),
      queryParams: jsonSerialization['queryParams'] as String?,
      chartSnapshot: jsonSerialization['chartSnapshot'] as String?,
      interpretation: jsonSerialization['interpretation'] as String?,
      feedback: jsonSerialization['feedback'] as String?,
      tags: jsonSerialization['tags'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<List<String>>(jsonSerialization['tags']),
      status: jsonSerialization['status'] as int?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  static final t = ArtsRecordTable();

  static const db = ArtsRecordRepository._();

  @override
  int? id;

  /// 租户ID（0 表示系统租户）
  int tenantId;

  /// 用户ID（sys_user.id）
  int userId;

  /// 术数类型：qimen（奇门）/ bazi（八字）
  String artsType;

  /// 客户端记录键：同一条排盘重复上报时据此幂等（本地记录 id）
  String clientKey;

  /// 标题：奇门取占事，八字取命主姓名
  String title;

  /// 占事
  String question;

  /// 排盘时间（八字为真太阳时校正后的时刻）
  DateTime chartTime;

  /// 起盘参数（JSON 文本）
  String queryParams;

  /// 排盘快照（JSON 文本）
  String chartSnapshot;

  /// 卦解/断语
  String interpretation;

  /// 反馈/应验
  String feedback;

  /// 标签
  List<String>? tags;

  /// 状态（1=正常，0=禁用）
  int status;

  /// 是否删除
  bool deleted;

  /// 创建者
  String? creator;

  /// 创建时间
  DateTime createTime;

  /// 更新者
  String? updater;

  /// 更新时间
  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ArtsRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ArtsRecord copyWith({
    int? id,
    int? tenantId,
    int? userId,
    String? artsType,
    String? clientKey,
    String? title,
    String? question,
    DateTime? chartTime,
    String? queryParams,
    String? chartSnapshot,
    String? interpretation,
    String? feedback,
    List<String>? tags,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArtsRecord',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'artsType': artsType,
      'clientKey': clientKey,
      'title': title,
      'question': question,
      'chartTime': chartTime.toJson(),
      'queryParams': queryParams,
      'chartSnapshot': chartSnapshot,
      'interpretation': interpretation,
      'feedback': feedback,
      if (tags != null) 'tags': tags?.toJson(),
      'status': status,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArtsRecord',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'artsType': artsType,
      'clientKey': clientKey,
      'title': title,
      'question': question,
      'chartTime': chartTime.toJson(),
      'queryParams': queryParams,
      'chartSnapshot': chartSnapshot,
      'interpretation': interpretation,
      'feedback': feedback,
      if (tags != null) 'tags': tags?.toJson(),
      'status': status,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ArtsRecordInclude include() {
    return ArtsRecordInclude._();
  }

  static ArtsRecordIncludeList includeList({
    _is.WhereExpressionBuilder<ArtsRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ArtsRecordTable>? orderBy,
    _is.OrderByListBuilder<ArtsRecordTable>? orderByList,
    ArtsRecordInclude? include,
  }) {
    return ArtsRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ArtsRecord.t),
      orderByList: orderByList?.call(ArtsRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArtsRecordImpl extends ArtsRecord {
  _ArtsRecordImpl({
    int? id,
    int? tenantId,
    required int userId,
    required String artsType,
    required String clientKey,
    String? title,
    String? question,
    required DateTime chartTime,
    String? queryParams,
    String? chartSnapshot,
    String? interpretation,
    String? feedback,
    List<String>? tags,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         userId: userId,
         artsType: artsType,
         clientKey: clientKey,
         title: title,
         question: question,
         chartTime: chartTime,
         queryParams: queryParams,
         chartSnapshot: chartSnapshot,
         interpretation: interpretation,
         feedback: feedback,
         tags: tags,
         status: status,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ArtsRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ArtsRecord copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    String? artsType,
    String? clientKey,
    String? title,
    String? question,
    DateTime? chartTime,
    String? queryParams,
    String? chartSnapshot,
    String? interpretation,
    String? feedback,
    Object? tags = _Undefined,
    int? status,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ArtsRecord(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      artsType: artsType ?? this.artsType,
      clientKey: clientKey ?? this.clientKey,
      title: title ?? this.title,
      question: question ?? this.question,
      chartTime: chartTime ?? this.chartTime,
      queryParams: queryParams ?? this.queryParams,
      chartSnapshot: chartSnapshot ?? this.chartSnapshot,
      interpretation: interpretation ?? this.interpretation,
      feedback: feedback ?? this.feedback,
      tags: tags is List<String>? ? tags : this.tags?.map((e0) => e0).toList(),
      status: status ?? this.status,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ArtsRecordUpdateTable extends _is.UpdateTable<ArtsRecordTable> {
  ArtsRecordUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(table.userId, value);

  _is.ColumnValue<String, String> artsType(String value) => _is.ColumnValue(table.artsType, value);

  _is.ColumnValue<String, String> clientKey(String value) => _is.ColumnValue(table.clientKey, value);

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(table.title, value);

  _is.ColumnValue<String, String> question(String value) => _is.ColumnValue(table.question, value);

  _is.ColumnValue<DateTime, DateTime> chartTime(DateTime value) => _is.ColumnValue(table.chartTime, value);

  _is.ColumnValue<String, String> queryParams(String value) => _is.ColumnValue(table.queryParams, value);

  _is.ColumnValue<String, String> chartSnapshot(String value) => _is.ColumnValue(table.chartSnapshot, value);

  _is.ColumnValue<String, String> interpretation(String value) => _is.ColumnValue(table.interpretation, value);

  _is.ColumnValue<String, String> feedback(String value) => _is.ColumnValue(table.feedback, value);

  _is.ColumnValue<List<String>, List<String>> tags(List<String>? value) => _is.ColumnValue(table.tags, value);

  _is.ColumnValue<int, int> status(int value) => _is.ColumnValue(table.status, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ArtsRecordTable extends _is.Table<int?> {
  ArtsRecordTable({super.tableRelation}) : super(tableName: 'arts_record') {
    updateTable = ArtsRecordUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    userId = _is.ColumnInt('userId', this);
    artsType = _is.ColumnString('artsType', this);
    clientKey = _is.ColumnString('clientKey', this);
    title = _is.ColumnString('title', this, hasDefault: true);
    question = _is.ColumnString('question', this, hasDefault: true);
    chartTime = _is.ColumnDateTime('chartTime', this);
    queryParams = _is.ColumnString('queryParams', this, hasDefault: true);
    chartSnapshot = _is.ColumnString('chartSnapshot', this, hasDefault: true);
    interpretation = _is.ColumnString('interpretation', this, hasDefault: true);
    feedback = _is.ColumnString('feedback', this, hasDefault: true);
    tags = _is.ColumnSerializable<List<String>>('tags', this);
    status = _is.ColumnInt('status', this, hasDefault: true);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ArtsRecordUpdateTable updateTable;

  /// 租户ID（0 表示系统租户）
  late final _is.ColumnInt tenantId;

  /// 用户ID（sys_user.id）
  late final _is.ColumnInt userId;

  /// 术数类型：qimen（奇门）/ bazi（八字）
  late final _is.ColumnString artsType;

  /// 客户端记录键：同一条排盘重复上报时据此幂等（本地记录 id）
  late final _is.ColumnString clientKey;

  /// 标题：奇门取占事，八字取命主姓名
  late final _is.ColumnString title;

  /// 占事
  late final _is.ColumnString question;

  /// 排盘时间（八字为真太阳时校正后的时刻）
  late final _is.ColumnDateTime chartTime;

  /// 起盘参数（JSON 文本）
  late final _is.ColumnString queryParams;

  /// 排盘快照（JSON 文本）
  late final _is.ColumnString chartSnapshot;

  /// 卦解/断语
  late final _is.ColumnString interpretation;

  /// 反馈/应验
  late final _is.ColumnString feedback;

  /// 标签
  late final _is.ColumnSerializable<List<String>> tags;

  /// 状态（1=正常，0=禁用）
  late final _is.ColumnInt status;

  /// 是否删除
  late final _is.ColumnBool deleted;

  /// 创建者
  late final _is.ColumnString creator;

  /// 创建时间
  late final _is.ColumnDateTime createTime;

  /// 更新者
  late final _is.ColumnString updater;

  /// 更新时间
  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    userId,
    artsType,
    clientKey,
    title,
    question,
    chartTime,
    queryParams,
    chartSnapshot,
    interpretation,
    feedback,
    tags,
    status,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ArtsRecordInclude extends _is.IncludeObject {
  ArtsRecordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ArtsRecord.t;
}

class ArtsRecordIncludeList extends _is.IncludeList {
  ArtsRecordIncludeList._({
    _is.WhereExpressionBuilder<ArtsRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ArtsRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ArtsRecord.t;
}

class ArtsRecordRepository {
  const ArtsRecordRepository._();

  /// Returns a list of [ArtsRecord]s matching the given query parameters.
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
  Future<List<ArtsRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ArtsRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ArtsRecordTable>? orderBy,
    _is.OrderByListBuilder<ArtsRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ArtsRecord>(
      where: where?.call(ArtsRecord.t),
      orderBy: orderBy?.call(ArtsRecord.t),
      orderByList: orderByList?.call(ArtsRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ArtsRecord] matching the given query parameters.
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
  Future<ArtsRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ArtsRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<ArtsRecordTable>? orderBy,
    _is.OrderByListBuilder<ArtsRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ArtsRecord>(
      where: where?.call(ArtsRecord.t),
      orderBy: orderBy?.call(ArtsRecord.t),
      orderByList: orderByList?.call(ArtsRecord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ArtsRecord] by its [id] or null if no such row exists.
  Future<ArtsRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ArtsRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ArtsRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [ArtsRecord]s will have their `id` fields set.
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
  Future<List<ArtsRecord>> insert(
    _is.DatabaseSession session,
    List<ArtsRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ArtsRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ArtsRecord] and returns the inserted row.
  ///
  /// The returned [ArtsRecord] will have its `id` field set.
  Future<ArtsRecord> insertRow(_is.DatabaseSession session, ArtsRecord row, {_is.Transaction? transaction}) async {
    return session.db.insertRow<ArtsRecord>(row, transaction: transaction);
  }

  /// Upserts all [ArtsRecord]s in the list and returns the resulting rows.
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
  /// The returned [ArtsRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArtsRecord>> upsert(
    _is.DatabaseSession session,
    List<ArtsRecord> rows, {
    required _is.ColumnSelections<ArtsRecordTable> conflictColumns,
    _is.ColumnSelections<ArtsRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<ArtsRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ArtsRecord>(
      rows,
      conflictColumns: conflictColumns(ArtsRecord.t),
      updateColumns: updateColumns?.call(ArtsRecord.t),
      updateWhere: updateWhere?.call(ArtsRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ArtsRecord] and returns the resulting row.
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
  /// The returned [ArtsRecord] will have its `id` field set.
  Future<ArtsRecord?> upsertRow(
    _is.DatabaseSession session,
    ArtsRecord row, {
    required _is.ColumnSelections<ArtsRecordTable> conflictColumns,
    _is.ColumnSelections<ArtsRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<ArtsRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ArtsRecord>(
      row,
      conflictColumns: conflictColumns(ArtsRecord.t),
      updateColumns: updateColumns?.call(ArtsRecord.t),
      updateWhere: updateWhere?.call(ArtsRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [ArtsRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArtsRecord>> update(
    _is.DatabaseSession session,
    List<ArtsRecord> rows, {
    _is.ColumnSelections<ArtsRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ArtsRecord>(
      rows,
      columns: columns?.call(ArtsRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ArtsRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ArtsRecord> updateRow(
    _is.DatabaseSession session,
    ArtsRecord row, {
    _is.ColumnSelections<ArtsRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ArtsRecord>(row, columns: columns?.call(ArtsRecord.t), transaction: transaction);
  }

  /// Updates a single [ArtsRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ArtsRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ArtsRecordUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ArtsRecord>(
      id,
      columnValues: columnValues(ArtsRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ArtsRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArtsRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ArtsRecordUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ArtsRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ArtsRecordTable>? orderBy,
    _is.OrderByListBuilder<ArtsRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ArtsRecord>(
      columnValues: columnValues(ArtsRecord.t.updateTable),
      where: where(ArtsRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ArtsRecord.t),
      orderByList: orderByList?.call(ArtsRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ArtsRecord]s in the list and returns the deleted rows.
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
  Future<List<ArtsRecord>> delete(
    _is.DatabaseSession session,
    List<ArtsRecord> rows, {
    _is.OrderByBuilder<ArtsRecordTable>? orderBy,
    _is.OrderByListBuilder<ArtsRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ArtsRecord>(
      rows,
      orderBy: orderBy?.call(ArtsRecord.t),
      orderByList: orderByList?.call(ArtsRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ArtsRecord].
  Future<ArtsRecord> deleteRow(_is.DatabaseSession session, ArtsRecord row, {_is.Transaction? transaction}) async {
    return session.db.deleteRow<ArtsRecord>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArtsRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ArtsRecordTable> where,
    _is.OrderByBuilder<ArtsRecordTable>? orderBy,
    _is.OrderByListBuilder<ArtsRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ArtsRecord>(
      where: where(ArtsRecord.t),
      orderBy: orderBy?.call(ArtsRecord.t),
      orderByList: orderByList?.call(ArtsRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ArtsRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ArtsRecord>(where: where?.call(ArtsRecord.t), limit: limit, transaction: transaction);
  }

  /// Acquires row-level locks on [ArtsRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ArtsRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ArtsRecord>(
      where: where(ArtsRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
