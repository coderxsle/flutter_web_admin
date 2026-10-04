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

/// 中药库存变动流水
abstract class ZhongyiInventoryTransaction implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiInventoryTransaction._({
    this.id,
    int? tenantId,
    required this.medicineId,
    this.inventoryId,
    this.batchNumber,
    required this.transactionType,
    required this.quantityChangeG,
    required this.quantityBeforeG,
    required this.quantityAfterG,
    this.remark,
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

  factory ZhongyiInventoryTransaction({
    int? id,
    int? tenantId,
    required int medicineId,
    int? inventoryId,
    String? batchNumber,
    required String transactionType,
    required double quantityChangeG,
    required double quantityBeforeG,
    required double quantityAfterG,
    String? remark,
    int? operatorId,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiInventoryTransactionImpl;

  factory ZhongyiInventoryTransaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiInventoryTransaction(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      medicineId: jsonSerialization['medicineId'] as int,
      inventoryId: jsonSerialization['inventoryId'] as int?,
      batchNumber: jsonSerialization['batchNumber'] as String?,
      transactionType: jsonSerialization['transactionType'] as String,
      quantityChangeG: (jsonSerialization['quantityChangeG'] as num).toDouble(),
      quantityBeforeG: (jsonSerialization['quantityBeforeG'] as num).toDouble(),
      quantityAfterG: (jsonSerialization['quantityAfterG'] as num).toDouble(),
      remark: jsonSerialization['remark'] as String?,
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

  static final t = ZhongyiInventoryTransactionTable();

  static const db = ZhongyiInventoryTransactionRepository._();

  @override
  int? id;

  /// 租户ID
  int tenantId;

  /// 药品ID
  int medicineId;

  /// 库存批次ID
  int? inventoryId;

  /// 批号
  String? batchNumber;

  /// 交易类型
  String transactionType;

  /// 数量变化(g)
  double quantityChangeG;

  /// 交易前数量(g)
  double quantityBeforeG;

  /// 交易后数量(g)
  double quantityAfterG;

  String? remark;

  int? operatorId;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiInventoryTransaction]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiInventoryTransaction copyWith({
    int? id,
    int? tenantId,
    int? medicineId,
    int? inventoryId,
    String? batchNumber,
    String? transactionType,
    double? quantityChangeG,
    double? quantityBeforeG,
    double? quantityAfterG,
    String? remark,
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
      '__className__': 'ZhongyiInventoryTransaction',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'medicineId': medicineId,
      if (inventoryId != null) 'inventoryId': inventoryId,
      if (batchNumber != null) 'batchNumber': batchNumber,
      'transactionType': transactionType,
      'quantityChangeG': quantityChangeG,
      'quantityBeforeG': quantityBeforeG,
      'quantityAfterG': quantityAfterG,
      if (remark != null) 'remark': remark,
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
      '__className__': 'ZhongyiInventoryTransaction',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'medicineId': medicineId,
      if (inventoryId != null) 'inventoryId': inventoryId,
      if (batchNumber != null) 'batchNumber': batchNumber,
      'transactionType': transactionType,
      'quantityChangeG': quantityChangeG,
      'quantityBeforeG': quantityBeforeG,
      'quantityAfterG': quantityAfterG,
      if (remark != null) 'remark': remark,
      if (operatorId != null) 'operatorId': operatorId,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiInventoryTransactionInclude include() {
    return ZhongyiInventoryTransactionInclude._();
  }

  static ZhongyiInventoryTransactionIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiInventoryTransactionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiInventoryTransactionTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiInventoryTransactionTable>? orderByList,
    ZhongyiInventoryTransactionInclude? include,
  }) {
    return ZhongyiInventoryTransactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiInventoryTransaction.t),
      orderByList: orderByList?.call(ZhongyiInventoryTransaction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiInventoryTransactionImpl extends ZhongyiInventoryTransaction {
  _ZhongyiInventoryTransactionImpl({
    int? id,
    int? tenantId,
    required int medicineId,
    int? inventoryId,
    String? batchNumber,
    required String transactionType,
    required double quantityChangeG,
    required double quantityBeforeG,
    required double quantityAfterG,
    String? remark,
    int? operatorId,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         medicineId: medicineId,
         inventoryId: inventoryId,
         batchNumber: batchNumber,
         transactionType: transactionType,
         quantityChangeG: quantityChangeG,
         quantityBeforeG: quantityBeforeG,
         quantityAfterG: quantityAfterG,
         remark: remark,
         operatorId: operatorId,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiInventoryTransaction]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiInventoryTransaction copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? medicineId,
    Object? inventoryId = _Undefined,
    Object? batchNumber = _Undefined,
    String? transactionType,
    double? quantityChangeG,
    double? quantityBeforeG,
    double? quantityAfterG,
    Object? remark = _Undefined,
    Object? operatorId = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiInventoryTransaction(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      medicineId: medicineId ?? this.medicineId,
      inventoryId: inventoryId is int? ? inventoryId : this.inventoryId,
      batchNumber: batchNumber is String? ? batchNumber : this.batchNumber,
      transactionType: transactionType ?? this.transactionType,
      quantityChangeG: quantityChangeG ?? this.quantityChangeG,
      quantityBeforeG: quantityBeforeG ?? this.quantityBeforeG,
      quantityAfterG: quantityAfterG ?? this.quantityAfterG,
      remark: remark is String? ? remark : this.remark,
      operatorId: operatorId is int? ? operatorId : this.operatorId,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiInventoryTransactionUpdateTable extends _is.UpdateTable<ZhongyiInventoryTransactionTable> {
  ZhongyiInventoryTransactionUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> medicineId(int value) => _is.ColumnValue(table.medicineId, value);

  _is.ColumnValue<int, int> inventoryId(int? value) => _is.ColumnValue(table.inventoryId, value);

  _is.ColumnValue<String, String> batchNumber(String? value) => _is.ColumnValue(table.batchNumber, value);

  _is.ColumnValue<String, String> transactionType(String value) => _is.ColumnValue(table.transactionType, value);

  _is.ColumnValue<double, double> quantityChangeG(double value) => _is.ColumnValue(table.quantityChangeG, value);

  _is.ColumnValue<double, double> quantityBeforeG(double value) => _is.ColumnValue(table.quantityBeforeG, value);

  _is.ColumnValue<double, double> quantityAfterG(double value) => _is.ColumnValue(table.quantityAfterG, value);

  _is.ColumnValue<String, String> remark(String? value) => _is.ColumnValue(table.remark, value);

  _is.ColumnValue<int, int> operatorId(int? value) => _is.ColumnValue(table.operatorId, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiInventoryTransactionTable extends _is.Table<int?> {
  ZhongyiInventoryTransactionTable({super.tableRelation}) : super(tableName: 'zhongyi_inventory_transaction') {
    updateTable = ZhongyiInventoryTransactionUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    medicineId = _is.ColumnInt('medicineId', this);
    inventoryId = _is.ColumnInt('inventoryId', this);
    batchNumber = _is.ColumnString('batchNumber', this);
    transactionType = _is.ColumnString('transactionType', this);
    quantityChangeG = _is.ColumnDouble('quantityChangeG', this);
    quantityBeforeG = _is.ColumnDouble('quantityBeforeG', this);
    quantityAfterG = _is.ColumnDouble('quantityAfterG', this);
    remark = _is.ColumnString('remark', this);
    operatorId = _is.ColumnInt('operatorId', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiInventoryTransactionUpdateTable updateTable;

  /// 租户ID
  late final _is.ColumnInt tenantId;

  /// 药品ID
  late final _is.ColumnInt medicineId;

  /// 库存批次ID
  late final _is.ColumnInt inventoryId;

  /// 批号
  late final _is.ColumnString batchNumber;

  /// 交易类型
  late final _is.ColumnString transactionType;

  /// 数量变化(g)
  late final _is.ColumnDouble quantityChangeG;

  /// 交易前数量(g)
  late final _is.ColumnDouble quantityBeforeG;

  /// 交易后数量(g)
  late final _is.ColumnDouble quantityAfterG;

  late final _is.ColumnString remark;

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
    medicineId,
    inventoryId,
    batchNumber,
    transactionType,
    quantityChangeG,
    quantityBeforeG,
    quantityAfterG,
    remark,
    operatorId,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiInventoryTransactionInclude extends _is.IncludeObject {
  ZhongyiInventoryTransactionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiInventoryTransaction.t;
}

class ZhongyiInventoryTransactionIncludeList extends _is.IncludeList {
  ZhongyiInventoryTransactionIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiInventoryTransactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiInventoryTransaction.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiInventoryTransaction.t;
}

class ZhongyiInventoryTransactionRepository {
  const ZhongyiInventoryTransactionRepository._();

  /// Returns a list of [ZhongyiInventoryTransaction]s matching the given query parameters.
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
  Future<List<ZhongyiInventoryTransaction>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiInventoryTransactionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiInventoryTransactionTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiInventoryTransactionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiInventoryTransaction>(
      where: where?.call(ZhongyiInventoryTransaction.t),
      orderBy: orderBy?.call(ZhongyiInventoryTransaction.t),
      orderByList: orderByList?.call(ZhongyiInventoryTransaction.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiInventoryTransaction] matching the given query parameters.
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
  Future<ZhongyiInventoryTransaction?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiInventoryTransactionTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiInventoryTransactionTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiInventoryTransactionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiInventoryTransaction>(
      where: where?.call(ZhongyiInventoryTransaction.t),
      orderBy: orderBy?.call(ZhongyiInventoryTransaction.t),
      orderByList: orderByList?.call(ZhongyiInventoryTransaction.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiInventoryTransaction] by its [id] or null if no such row exists.
  Future<ZhongyiInventoryTransaction?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiInventoryTransaction>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiInventoryTransaction]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiInventoryTransaction]s will have their `id` fields set.
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
  Future<List<ZhongyiInventoryTransaction>> insert(
    _is.DatabaseSession session,
    List<ZhongyiInventoryTransaction> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiInventoryTransaction>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiInventoryTransaction] and returns the inserted row.
  ///
  /// The returned [ZhongyiInventoryTransaction] will have its `id` field set.
  Future<ZhongyiInventoryTransaction> insertRow(
    _is.DatabaseSession session,
    ZhongyiInventoryTransaction row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiInventoryTransaction>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiInventoryTransaction]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiInventoryTransaction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiInventoryTransaction>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiInventoryTransaction> rows, {
    required _is.ColumnSelections<ZhongyiInventoryTransactionTable> conflictColumns,
    _is.ColumnSelections<ZhongyiInventoryTransactionTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiInventoryTransactionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiInventoryTransaction>(
      rows,
      conflictColumns: conflictColumns(ZhongyiInventoryTransaction.t),
      updateColumns: updateColumns?.call(ZhongyiInventoryTransaction.t),
      updateWhere: updateWhere?.call(ZhongyiInventoryTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiInventoryTransaction] and returns the resulting row.
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
  /// The returned [ZhongyiInventoryTransaction] will have its `id` field set.
  Future<ZhongyiInventoryTransaction?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiInventoryTransaction row, {
    required _is.ColumnSelections<ZhongyiInventoryTransactionTable> conflictColumns,
    _is.ColumnSelections<ZhongyiInventoryTransactionTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiInventoryTransactionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiInventoryTransaction>(
      row,
      conflictColumns: conflictColumns(ZhongyiInventoryTransaction.t),
      updateColumns: updateColumns?.call(ZhongyiInventoryTransaction.t),
      updateWhere: updateWhere?.call(ZhongyiInventoryTransaction.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiInventoryTransaction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiInventoryTransaction>> update(
    _is.DatabaseSession session,
    List<ZhongyiInventoryTransaction> rows, {
    _is.ColumnSelections<ZhongyiInventoryTransactionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiInventoryTransaction>(
      rows,
      columns: columns?.call(ZhongyiInventoryTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiInventoryTransaction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiInventoryTransaction> updateRow(
    _is.DatabaseSession session,
    ZhongyiInventoryTransaction row, {
    _is.ColumnSelections<ZhongyiInventoryTransactionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiInventoryTransaction>(
      row,
      columns: columns?.call(ZhongyiInventoryTransaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ZhongyiInventoryTransaction] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiInventoryTransaction?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiInventoryTransactionUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiInventoryTransaction>(
      id,
      columnValues: columnValues(ZhongyiInventoryTransaction.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiInventoryTransaction]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiInventoryTransaction>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiInventoryTransactionUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiInventoryTransactionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiInventoryTransactionTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiInventoryTransactionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiInventoryTransaction>(
      columnValues: columnValues(ZhongyiInventoryTransaction.t.updateTable),
      where: where(ZhongyiInventoryTransaction.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiInventoryTransaction.t),
      orderByList: orderByList?.call(ZhongyiInventoryTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiInventoryTransaction]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiInventoryTransaction>> delete(
    _is.DatabaseSession session,
    List<ZhongyiInventoryTransaction> rows, {
    _is.OrderByBuilder<ZhongyiInventoryTransactionTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiInventoryTransactionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiInventoryTransaction>(
      rows,
      orderBy: orderBy?.call(ZhongyiInventoryTransaction.t),
      orderByList: orderByList?.call(ZhongyiInventoryTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiInventoryTransaction].
  Future<ZhongyiInventoryTransaction> deleteRow(
    _is.DatabaseSession session,
    ZhongyiInventoryTransaction row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiInventoryTransaction>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiInventoryTransaction>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiInventoryTransactionTable> where,
    _is.OrderByBuilder<ZhongyiInventoryTransactionTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiInventoryTransactionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiInventoryTransaction>(
      where: where(ZhongyiInventoryTransaction.t),
      orderBy: orderBy?.call(ZhongyiInventoryTransaction.t),
      orderByList: orderByList?.call(ZhongyiInventoryTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiInventoryTransactionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiInventoryTransaction>(
      where: where?.call(ZhongyiInventoryTransaction.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ZhongyiInventoryTransaction] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiInventoryTransactionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiInventoryTransaction>(
      where: where(ZhongyiInventoryTransaction.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
