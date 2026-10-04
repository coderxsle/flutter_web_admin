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

/// 中医门诊收费支付记录
abstract class ZhongyiPayment implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiPayment._({
    this.id,
    int? tenantId,
    required this.billingId,
    required this.channel,
    required this.amount,
    this.transactionNo,
    required this.status,
    this.paidAt,
    this.operatorId,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiPayment({
    int? id,
    int? tenantId,
    required int billingId,
    required String channel,
    required double amount,
    String? transactionNo,
    required int status,
    DateTime? paidAt,
    int? operatorId,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiPaymentImpl;

  factory ZhongyiPayment.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiPayment(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      billingId: jsonSerialization['billingId'] as int,
      channel: jsonSerialization['channel'] as String,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      transactionNo: jsonSerialization['transactionNo'] as String?,
      status: jsonSerialization['status'] as int,
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      operatorId: jsonSerialization['operatorId'] as int?,
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

  static final t = ZhongyiPaymentTable();

  static const db = ZhongyiPaymentRepository._();

  @override
  int? id;

  int tenantId;

  int billingId;

  String channel;

  double amount;

  String? transactionNo;

  int status;

  DateTime? paidAt;

  int? operatorId;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiPayment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiPayment copyWith({
    int? id,
    int? tenantId,
    int? billingId,
    String? channel,
    double? amount,
    String? transactionNo,
    int? status,
    DateTime? paidAt,
    int? operatorId,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiPayment',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'billingId': billingId,
      'channel': channel,
      'amount': amount,
      if (transactionNo != null) 'transactionNo': transactionNo,
      'status': status,
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (operatorId != null) 'operatorId': operatorId,
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
      '__className__': 'ZhongyiPayment',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'billingId': billingId,
      'channel': channel,
      'amount': amount,
      if (transactionNo != null) 'transactionNo': transactionNo,
      'status': status,
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (operatorId != null) 'operatorId': operatorId,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiPaymentInclude include() {
    return ZhongyiPaymentInclude._();
  }

  static ZhongyiPaymentIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiPaymentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPaymentTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPaymentTable>? orderByList,
    ZhongyiPaymentInclude? include,
  }) {
    return ZhongyiPaymentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiPayment.t),
      orderByList: orderByList?.call(ZhongyiPayment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiPaymentImpl extends ZhongyiPayment {
  _ZhongyiPaymentImpl({
    int? id,
    int? tenantId,
    required int billingId,
    required String channel,
    required double amount,
    String? transactionNo,
    required int status,
    DateTime? paidAt,
    int? operatorId,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         billingId: billingId,
         channel: channel,
         amount: amount,
         transactionNo: transactionNo,
         status: status,
         paidAt: paidAt,
         operatorId: operatorId,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiPayment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiPayment copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? billingId,
    String? channel,
    double? amount,
    Object? transactionNo = _Undefined,
    int? status,
    Object? paidAt = _Undefined,
    Object? operatorId = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiPayment(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      billingId: billingId ?? this.billingId,
      channel: channel ?? this.channel,
      amount: amount ?? this.amount,
      transactionNo: transactionNo is String? ? transactionNo : this.transactionNo,
      status: status ?? this.status,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      operatorId: operatorId is int? ? operatorId : this.operatorId,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiPaymentUpdateTable extends _is.UpdateTable<ZhongyiPaymentTable> {
  ZhongyiPaymentUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> billingId(int value) => _is.ColumnValue(table.billingId, value);

  _is.ColumnValue<String, String> channel(String value) => _is.ColumnValue(table.channel, value);

  _is.ColumnValue<double, double> amount(double value) => _is.ColumnValue(table.amount, value);

  _is.ColumnValue<String, String> transactionNo(String? value) => _is.ColumnValue(table.transactionNo, value);

  _is.ColumnValue<int, int> status(int value) => _is.ColumnValue(table.status, value);

  _is.ColumnValue<DateTime, DateTime> paidAt(DateTime? value) => _is.ColumnValue(table.paidAt, value);

  _is.ColumnValue<int, int> operatorId(int? value) => _is.ColumnValue(table.operatorId, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiPaymentTable extends _is.Table<int?> {
  ZhongyiPaymentTable({super.tableRelation}) : super(tableName: 'zhongyi_payment') {
    updateTable = ZhongyiPaymentUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    billingId = _is.ColumnInt('billingId', this);
    channel = _is.ColumnString('channel', this);
    amount = _is.ColumnDouble('amount', this);
    transactionNo = _is.ColumnString('transactionNo', this);
    status = _is.ColumnInt('status', this);
    paidAt = _is.ColumnDateTime('paidAt', this);
    operatorId = _is.ColumnInt('operatorId', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiPaymentUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnInt billingId;

  late final _is.ColumnString channel;

  late final _is.ColumnDouble amount;

  late final _is.ColumnString transactionNo;

  late final _is.ColumnInt status;

  late final _is.ColumnDateTime paidAt;

  late final _is.ColumnInt operatorId;

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
    channel,
    amount,
    transactionNo,
    status,
    paidAt,
    operatorId,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiPaymentInclude extends _is.IncludeObject {
  ZhongyiPaymentInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiPayment.t;
}

class ZhongyiPaymentIncludeList extends _is.IncludeList {
  ZhongyiPaymentIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiPaymentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiPayment.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiPayment.t;
}

class ZhongyiPaymentRepository {
  const ZhongyiPaymentRepository._();

  /// Returns a list of [ZhongyiPayment]s matching the given query parameters.
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
  Future<List<ZhongyiPayment>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPaymentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPaymentTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPaymentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiPayment>(
      where: where?.call(ZhongyiPayment.t),
      orderBy: orderBy?.call(ZhongyiPayment.t),
      orderByList: orderByList?.call(ZhongyiPayment.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiPayment] matching the given query parameters.
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
  Future<ZhongyiPayment?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPaymentTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiPaymentTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPaymentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiPayment>(
      where: where?.call(ZhongyiPayment.t),
      orderBy: orderBy?.call(ZhongyiPayment.t),
      orderByList: orderByList?.call(ZhongyiPayment.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiPayment] by its [id] or null if no such row exists.
  Future<ZhongyiPayment?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiPayment>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiPayment]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiPayment]s will have their `id` fields set.
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
  Future<List<ZhongyiPayment>> insert(
    _is.DatabaseSession session,
    List<ZhongyiPayment> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiPayment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiPayment] and returns the inserted row.
  ///
  /// The returned [ZhongyiPayment] will have its `id` field set.
  Future<ZhongyiPayment> insertRow(
    _is.DatabaseSession session,
    ZhongyiPayment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiPayment>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiPayment]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiPayment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPayment>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiPayment> rows, {
    required _is.ColumnSelections<ZhongyiPaymentTable> conflictColumns,
    _is.ColumnSelections<ZhongyiPaymentTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiPaymentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiPayment>(
      rows,
      conflictColumns: conflictColumns(ZhongyiPayment.t),
      updateColumns: updateColumns?.call(ZhongyiPayment.t),
      updateWhere: updateWhere?.call(ZhongyiPayment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiPayment] and returns the resulting row.
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
  /// The returned [ZhongyiPayment] will have its `id` field set.
  Future<ZhongyiPayment?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiPayment row, {
    required _is.ColumnSelections<ZhongyiPaymentTable> conflictColumns,
    _is.ColumnSelections<ZhongyiPaymentTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiPaymentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiPayment>(
      row,
      conflictColumns: conflictColumns(ZhongyiPayment.t),
      updateColumns: updateColumns?.call(ZhongyiPayment.t),
      updateWhere: updateWhere?.call(ZhongyiPayment.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiPayment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPayment>> update(
    _is.DatabaseSession session,
    List<ZhongyiPayment> rows, {
    _is.ColumnSelections<ZhongyiPaymentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiPayment>(
      rows,
      columns: columns?.call(ZhongyiPayment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiPayment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiPayment> updateRow(
    _is.DatabaseSession session,
    ZhongyiPayment row, {
    _is.ColumnSelections<ZhongyiPaymentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiPayment>(
      row,
      columns: columns?.call(ZhongyiPayment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ZhongyiPayment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiPayment?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiPaymentUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiPayment>(
      id,
      columnValues: columnValues(ZhongyiPayment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiPayment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPayment>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiPaymentUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiPaymentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPaymentTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPaymentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiPayment>(
      columnValues: columnValues(ZhongyiPayment.t.updateTable),
      where: where(ZhongyiPayment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiPayment.t),
      orderByList: orderByList?.call(ZhongyiPayment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiPayment]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiPayment>> delete(
    _is.DatabaseSession session,
    List<ZhongyiPayment> rows, {
    _is.OrderByBuilder<ZhongyiPaymentTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPaymentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiPayment>(
      rows,
      orderBy: orderBy?.call(ZhongyiPayment.t),
      orderByList: orderByList?.call(ZhongyiPayment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiPayment].
  Future<ZhongyiPayment> deleteRow(
    _is.DatabaseSession session,
    ZhongyiPayment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiPayment>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPayment>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiPaymentTable> where,
    _is.OrderByBuilder<ZhongyiPaymentTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPaymentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiPayment>(
      where: where(ZhongyiPayment.t),
      orderBy: orderBy?.call(ZhongyiPayment.t),
      orderByList: orderByList?.call(ZhongyiPayment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPaymentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiPayment>(
      where: where?.call(ZhongyiPayment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ZhongyiPayment] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiPaymentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiPayment>(
      where: where(ZhongyiPayment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
