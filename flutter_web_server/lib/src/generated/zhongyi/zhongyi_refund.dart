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

/// 中医门诊收费退款申请及处理记录
abstract class ZhongyiRefund implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiRefund._({
    this.id,
    int? tenantId,
    required this.billingId,
    required this.refundNo,
    required this.refundAmount,
    this.refundReason,
    required this.status,
    this.requestedBy,
    this.approvedBy,
    this.completedBy,
    DateTime? requestedAt,
    this.approvedAt,
    this.completedAt,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       requestedAt = requestedAt ?? DateTime.now(),
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiRefund({
    int? id,
    int? tenantId,
    required int billingId,
    required String refundNo,
    required double refundAmount,
    String? refundReason,
    required int status,
    int? requestedBy,
    int? approvedBy,
    int? completedBy,
    DateTime? requestedAt,
    DateTime? approvedAt,
    DateTime? completedAt,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiRefundImpl;

  factory ZhongyiRefund.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiRefund(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      billingId: jsonSerialization['billingId'] as int,
      refundNo: jsonSerialization['refundNo'] as String,
      refundAmount: (jsonSerialization['refundAmount'] as num).toDouble(),
      refundReason: jsonSerialization['refundReason'] as String?,
      status: jsonSerialization['status'] as int,
      requestedBy: jsonSerialization['requestedBy'] as int?,
      approvedBy: jsonSerialization['approvedBy'] as int?,
      completedBy: jsonSerialization['completedBy'] as int?,
      requestedAt: jsonSerialization['requestedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['requestedAt']),
      approvedAt: jsonSerialization['approvedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['approvedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['completedAt']),
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

  static final t = ZhongyiRefundTable();

  static const db = ZhongyiRefundRepository._();

  @override
  int? id;

  int tenantId;

  int billingId;

  String refundNo;

  double refundAmount;

  String? refundReason;

  int status;

  int? requestedBy;

  int? approvedBy;

  int? completedBy;

  DateTime requestedAt;

  DateTime? approvedAt;

  DateTime? completedAt;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiRefund]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiRefund copyWith({
    int? id,
    int? tenantId,
    int? billingId,
    String? refundNo,
    double? refundAmount,
    String? refundReason,
    int? status,
    int? requestedBy,
    int? approvedBy,
    int? completedBy,
    DateTime? requestedAt,
    DateTime? approvedAt,
    DateTime? completedAt,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiRefund',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'billingId': billingId,
      'refundNo': refundNo,
      'refundAmount': refundAmount,
      if (refundReason != null) 'refundReason': refundReason,
      'status': status,
      if (requestedBy != null) 'requestedBy': requestedBy,
      if (approvedBy != null) 'approvedBy': approvedBy,
      if (completedBy != null) 'completedBy': completedBy,
      'requestedAt': requestedAt.toJson(),
      if (approvedAt != null) 'approvedAt': approvedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
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
      '__className__': 'ZhongyiRefund',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'billingId': billingId,
      'refundNo': refundNo,
      'refundAmount': refundAmount,
      if (refundReason != null) 'refundReason': refundReason,
      'status': status,
      if (requestedBy != null) 'requestedBy': requestedBy,
      if (approvedBy != null) 'approvedBy': approvedBy,
      if (completedBy != null) 'completedBy': completedBy,
      'requestedAt': requestedAt.toJson(),
      if (approvedAt != null) 'approvedAt': approvedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiRefundInclude include() {
    return ZhongyiRefundInclude._();
  }

  static ZhongyiRefundIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiRefundTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiRefundTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiRefundTable>? orderByList,
    ZhongyiRefundInclude? include,
  }) {
    return ZhongyiRefundIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiRefund.t),
      orderByList: orderByList?.call(ZhongyiRefund.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiRefundImpl extends ZhongyiRefund {
  _ZhongyiRefundImpl({
    int? id,
    int? tenantId,
    required int billingId,
    required String refundNo,
    required double refundAmount,
    String? refundReason,
    required int status,
    int? requestedBy,
    int? approvedBy,
    int? completedBy,
    DateTime? requestedAt,
    DateTime? approvedAt,
    DateTime? completedAt,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         billingId: billingId,
         refundNo: refundNo,
         refundAmount: refundAmount,
         refundReason: refundReason,
         status: status,
         requestedBy: requestedBy,
         approvedBy: approvedBy,
         completedBy: completedBy,
         requestedAt: requestedAt,
         approvedAt: approvedAt,
         completedAt: completedAt,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiRefund]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiRefund copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? billingId,
    String? refundNo,
    double? refundAmount,
    Object? refundReason = _Undefined,
    int? status,
    Object? requestedBy = _Undefined,
    Object? approvedBy = _Undefined,
    Object? completedBy = _Undefined,
    DateTime? requestedAt,
    Object? approvedAt = _Undefined,
    Object? completedAt = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiRefund(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      billingId: billingId ?? this.billingId,
      refundNo: refundNo ?? this.refundNo,
      refundAmount: refundAmount ?? this.refundAmount,
      refundReason: refundReason is String? ? refundReason : this.refundReason,
      status: status ?? this.status,
      requestedBy: requestedBy is int? ? requestedBy : this.requestedBy,
      approvedBy: approvedBy is int? ? approvedBy : this.approvedBy,
      completedBy: completedBy is int? ? completedBy : this.completedBy,
      requestedAt: requestedAt ?? this.requestedAt,
      approvedAt: approvedAt is DateTime? ? approvedAt : this.approvedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiRefundUpdateTable extends _is.UpdateTable<ZhongyiRefundTable> {
  ZhongyiRefundUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> billingId(int value) => _is.ColumnValue(table.billingId, value);

  _is.ColumnValue<String, String> refundNo(String value) => _is.ColumnValue(table.refundNo, value);

  _is.ColumnValue<double, double> refundAmount(double value) => _is.ColumnValue(table.refundAmount, value);

  _is.ColumnValue<String, String> refundReason(String? value) => _is.ColumnValue(table.refundReason, value);

  _is.ColumnValue<int, int> status(int value) => _is.ColumnValue(table.status, value);

  _is.ColumnValue<int, int> requestedBy(int? value) => _is.ColumnValue(table.requestedBy, value);

  _is.ColumnValue<int, int> approvedBy(int? value) => _is.ColumnValue(table.approvedBy, value);

  _is.ColumnValue<int, int> completedBy(int? value) => _is.ColumnValue(table.completedBy, value);

  _is.ColumnValue<DateTime, DateTime> requestedAt(DateTime value) => _is.ColumnValue(table.requestedAt, value);

  _is.ColumnValue<DateTime, DateTime> approvedAt(DateTime? value) => _is.ColumnValue(table.approvedAt, value);

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) => _is.ColumnValue(table.completedAt, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiRefundTable extends _is.Table<int?> {
  ZhongyiRefundTable({super.tableRelation}) : super(tableName: 'zhongyi_refund') {
    updateTable = ZhongyiRefundUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    billingId = _is.ColumnInt('billingId', this);
    refundNo = _is.ColumnString('refundNo', this);
    refundAmount = _is.ColumnDouble('refundAmount', this);
    refundReason = _is.ColumnString('refundReason', this);
    status = _is.ColumnInt('status', this);
    requestedBy = _is.ColumnInt('requestedBy', this);
    approvedBy = _is.ColumnInt('approvedBy', this);
    completedBy = _is.ColumnInt('completedBy', this);
    requestedAt = _is.ColumnDateTime('requestedAt', this, hasDefault: true);
    approvedAt = _is.ColumnDateTime('approvedAt', this);
    completedAt = _is.ColumnDateTime('completedAt', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiRefundUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnInt billingId;

  late final _is.ColumnString refundNo;

  late final _is.ColumnDouble refundAmount;

  late final _is.ColumnString refundReason;

  late final _is.ColumnInt status;

  late final _is.ColumnInt requestedBy;

  late final _is.ColumnInt approvedBy;

  late final _is.ColumnInt completedBy;

  late final _is.ColumnDateTime requestedAt;

  late final _is.ColumnDateTime approvedAt;

  late final _is.ColumnDateTime completedAt;

  late final _is.ColumnBool deleted;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    billingId,
    refundNo,
    refundAmount,
    refundReason,
    status,
    requestedBy,
    approvedBy,
    completedBy,
    requestedAt,
    approvedAt,
    completedAt,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiRefundInclude extends _is.IncludeObject {
  ZhongyiRefundInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiRefund.t;
}

class ZhongyiRefundIncludeList extends _is.IncludeList {
  ZhongyiRefundIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiRefundTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiRefund.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiRefund.t;
}

class ZhongyiRefundRepository {
  const ZhongyiRefundRepository._();

  /// Returns a list of [ZhongyiRefund]s matching the given query parameters.
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
  Future<List<ZhongyiRefund>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiRefundTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiRefundTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiRefundTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiRefund>(
      where: where?.call(ZhongyiRefund.t),
      orderBy: orderBy?.call(ZhongyiRefund.t),
      orderByList: orderByList?.call(ZhongyiRefund.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiRefund] matching the given query parameters.
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
  Future<ZhongyiRefund?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiRefundTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiRefundTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiRefundTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiRefund>(
      where: where?.call(ZhongyiRefund.t),
      orderBy: orderBy?.call(ZhongyiRefund.t),
      orderByList: orderByList?.call(ZhongyiRefund.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiRefund] by its [id] or null if no such row exists.
  Future<ZhongyiRefund?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiRefund>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiRefund]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiRefund]s will have their `id` fields set.
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
  Future<List<ZhongyiRefund>> insert(
    _is.DatabaseSession session,
    List<ZhongyiRefund> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiRefund>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiRefund] and returns the inserted row.
  ///
  /// The returned [ZhongyiRefund] will have its `id` field set.
  Future<ZhongyiRefund> insertRow(
    _is.DatabaseSession session,
    ZhongyiRefund row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiRefund>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiRefund]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiRefund]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiRefund>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiRefund> rows, {
    required _is.ColumnSelections<ZhongyiRefundTable> conflictColumns,
    _is.ColumnSelections<ZhongyiRefundTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiRefundTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiRefund>(
      rows,
      conflictColumns: conflictColumns(ZhongyiRefund.t),
      updateColumns: updateColumns?.call(ZhongyiRefund.t),
      updateWhere: updateWhere?.call(ZhongyiRefund.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiRefund] and returns the resulting row.
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
  /// The returned [ZhongyiRefund] will have its `id` field set.
  Future<ZhongyiRefund?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiRefund row, {
    required _is.ColumnSelections<ZhongyiRefundTable> conflictColumns,
    _is.ColumnSelections<ZhongyiRefundTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiRefundTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiRefund>(
      row,
      conflictColumns: conflictColumns(ZhongyiRefund.t),
      updateColumns: updateColumns?.call(ZhongyiRefund.t),
      updateWhere: updateWhere?.call(ZhongyiRefund.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiRefund]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiRefund>> update(
    _is.DatabaseSession session,
    List<ZhongyiRefund> rows, {
    _is.ColumnSelections<ZhongyiRefundTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiRefund>(
      rows,
      columns: columns?.call(ZhongyiRefund.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiRefund]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiRefund> updateRow(
    _is.DatabaseSession session,
    ZhongyiRefund row, {
    _is.ColumnSelections<ZhongyiRefundTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiRefund>(row, columns: columns?.call(ZhongyiRefund.t), transaction: transaction);
  }

  /// Updates a single [ZhongyiRefund] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiRefund?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiRefundUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiRefund>(
      id,
      columnValues: columnValues(ZhongyiRefund.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiRefund]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiRefund>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiRefundUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiRefundTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiRefundTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiRefundTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiRefund>(
      columnValues: columnValues(ZhongyiRefund.t.updateTable),
      where: where(ZhongyiRefund.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiRefund.t),
      orderByList: orderByList?.call(ZhongyiRefund.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiRefund]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiRefund>> delete(
    _is.DatabaseSession session,
    List<ZhongyiRefund> rows, {
    _is.OrderByBuilder<ZhongyiRefundTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiRefundTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiRefund>(
      rows,
      orderBy: orderBy?.call(ZhongyiRefund.t),
      orderByList: orderByList?.call(ZhongyiRefund.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiRefund].
  Future<ZhongyiRefund> deleteRow(
    _is.DatabaseSession session,
    ZhongyiRefund row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiRefund>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiRefund>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiRefundTable> where,
    _is.OrderByBuilder<ZhongyiRefundTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiRefundTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiRefund>(
      where: where(ZhongyiRefund.t),
      orderBy: orderBy?.call(ZhongyiRefund.t),
      orderByList: orderByList?.call(ZhongyiRefund.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiRefundTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiRefund>(where: where?.call(ZhongyiRefund.t), limit: limit, transaction: transaction);
  }

  /// Acquires row-level locks on [ZhongyiRefund] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiRefundTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiRefund>(
      where: where(ZhongyiRefund.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
