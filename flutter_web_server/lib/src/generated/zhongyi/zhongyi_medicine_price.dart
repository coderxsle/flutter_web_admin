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

/// 中药价格历史
abstract class ZhongyiMedicinePrice implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiMedicinePrice._({
    this.id,
    int? tenantId,
    required this.medicineId,
    required this.priceType,
    required this.unit,
    required this.salePrice,
    required this.effectiveFrom,
    this.effectiveTo,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiMedicinePrice({
    int? id,
    int? tenantId,
    required int medicineId,
    required String priceType,
    required String unit,
    required double salePrice,
    required DateTime effectiveFrom,
    DateTime? effectiveTo,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiMedicinePriceImpl;

  factory ZhongyiMedicinePrice.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiMedicinePrice(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      medicineId: jsonSerialization['medicineId'] as int,
      priceType: jsonSerialization['priceType'] as String,
      unit: jsonSerialization['unit'] as String,
      salePrice: (jsonSerialization['salePrice'] as num).toDouble(),
      effectiveFrom: _is.DateTimeJsonExtension.fromJson(jsonSerialization['effectiveFrom']),
      effectiveTo: jsonSerialization['effectiveTo'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['effectiveTo']),
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

  static final t = ZhongyiMedicinePriceTable();

  static const db = ZhongyiMedicinePriceRepository._();

  @override
  int? id;

  /// 租户ID
  int tenantId;

  /// 药品ID
  int medicineId;

  /// 价格类型
  String priceType;

  /// 计价单位
  String unit;

  /// 销售价
  double salePrice;

  /// 生效时间
  DateTime effectiveFrom;

  /// 失效时间
  DateTime? effectiveTo;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiMedicinePrice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiMedicinePrice copyWith({
    int? id,
    int? tenantId,
    int? medicineId,
    String? priceType,
    String? unit,
    double? salePrice,
    DateTime? effectiveFrom,
    DateTime? effectiveTo,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiMedicinePrice',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'medicineId': medicineId,
      'priceType': priceType,
      'unit': unit,
      'salePrice': salePrice,
      'effectiveFrom': effectiveFrom.toJson(),
      if (effectiveTo != null) 'effectiveTo': effectiveTo?.toJson(),
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
      '__className__': 'ZhongyiMedicinePrice',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'medicineId': medicineId,
      'priceType': priceType,
      'unit': unit,
      'salePrice': salePrice,
      'effectiveFrom': effectiveFrom.toJson(),
      if (effectiveTo != null) 'effectiveTo': effectiveTo?.toJson(),
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiMedicinePriceInclude include() {
    return ZhongyiMedicinePriceInclude._();
  }

  static ZhongyiMedicinePriceIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiMedicinePriceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiMedicinePriceTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicinePriceTable>? orderByList,
    ZhongyiMedicinePriceInclude? include,
  }) {
    return ZhongyiMedicinePriceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiMedicinePrice.t),
      orderByList: orderByList?.call(ZhongyiMedicinePrice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiMedicinePriceImpl extends ZhongyiMedicinePrice {
  _ZhongyiMedicinePriceImpl({
    int? id,
    int? tenantId,
    required int medicineId,
    required String priceType,
    required String unit,
    required double salePrice,
    required DateTime effectiveFrom,
    DateTime? effectiveTo,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         medicineId: medicineId,
         priceType: priceType,
         unit: unit,
         salePrice: salePrice,
         effectiveFrom: effectiveFrom,
         effectiveTo: effectiveTo,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiMedicinePrice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiMedicinePrice copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? medicineId,
    String? priceType,
    String? unit,
    double? salePrice,
    DateTime? effectiveFrom,
    Object? effectiveTo = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiMedicinePrice(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      medicineId: medicineId ?? this.medicineId,
      priceType: priceType ?? this.priceType,
      unit: unit ?? this.unit,
      salePrice: salePrice ?? this.salePrice,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      effectiveTo: effectiveTo is DateTime? ? effectiveTo : this.effectiveTo,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiMedicinePriceUpdateTable extends _is.UpdateTable<ZhongyiMedicinePriceTable> {
  ZhongyiMedicinePriceUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> medicineId(int value) => _is.ColumnValue(table.medicineId, value);

  _is.ColumnValue<String, String> priceType(String value) => _is.ColumnValue(table.priceType, value);

  _is.ColumnValue<String, String> unit(String value) => _is.ColumnValue(table.unit, value);

  _is.ColumnValue<double, double> salePrice(double value) => _is.ColumnValue(table.salePrice, value);

  _is.ColumnValue<DateTime, DateTime> effectiveFrom(DateTime value) => _is.ColumnValue(table.effectiveFrom, value);

  _is.ColumnValue<DateTime, DateTime> effectiveTo(DateTime? value) => _is.ColumnValue(table.effectiveTo, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiMedicinePriceTable extends _is.Table<int?> {
  ZhongyiMedicinePriceTable({super.tableRelation}) : super(tableName: 'zhongyi_medicine_price') {
    updateTable = ZhongyiMedicinePriceUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    medicineId = _is.ColumnInt('medicineId', this);
    priceType = _is.ColumnString('priceType', this);
    unit = _is.ColumnString('unit', this);
    salePrice = _is.ColumnDouble('salePrice', this);
    effectiveFrom = _is.ColumnDateTime('effectiveFrom', this);
    effectiveTo = _is.ColumnDateTime('effectiveTo', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiMedicinePriceUpdateTable updateTable;

  /// 租户ID
  late final _is.ColumnInt tenantId;

  /// 药品ID
  late final _is.ColumnInt medicineId;

  /// 价格类型
  late final _is.ColumnString priceType;

  /// 计价单位
  late final _is.ColumnString unit;

  /// 销售价
  late final _is.ColumnDouble salePrice;

  /// 生效时间
  late final _is.ColumnDateTime effectiveFrom;

  /// 失效时间
  late final _is.ColumnDateTime effectiveTo;

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
    priceType,
    unit,
    salePrice,
    effectiveFrom,
    effectiveTo,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiMedicinePriceInclude extends _is.IncludeObject {
  ZhongyiMedicinePriceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiMedicinePrice.t;
}

class ZhongyiMedicinePriceIncludeList extends _is.IncludeList {
  ZhongyiMedicinePriceIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiMedicinePriceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiMedicinePrice.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiMedicinePrice.t;
}

class ZhongyiMedicinePriceRepository {
  const ZhongyiMedicinePriceRepository._();

  /// Returns a list of [ZhongyiMedicinePrice]s matching the given query parameters.
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
  Future<List<ZhongyiMedicinePrice>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiMedicinePriceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiMedicinePriceTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicinePriceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiMedicinePrice>(
      where: where?.call(ZhongyiMedicinePrice.t),
      orderBy: orderBy?.call(ZhongyiMedicinePrice.t),
      orderByList: orderByList?.call(ZhongyiMedicinePrice.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiMedicinePrice] matching the given query parameters.
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
  Future<ZhongyiMedicinePrice?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiMedicinePriceTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiMedicinePriceTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicinePriceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiMedicinePrice>(
      where: where?.call(ZhongyiMedicinePrice.t),
      orderBy: orderBy?.call(ZhongyiMedicinePrice.t),
      orderByList: orderByList?.call(ZhongyiMedicinePrice.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiMedicinePrice] by its [id] or null if no such row exists.
  Future<ZhongyiMedicinePrice?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiMedicinePrice>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiMedicinePrice]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiMedicinePrice]s will have their `id` fields set.
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
  Future<List<ZhongyiMedicinePrice>> insert(
    _is.DatabaseSession session,
    List<ZhongyiMedicinePrice> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiMedicinePrice>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiMedicinePrice] and returns the inserted row.
  ///
  /// The returned [ZhongyiMedicinePrice] will have its `id` field set.
  Future<ZhongyiMedicinePrice> insertRow(
    _is.DatabaseSession session,
    ZhongyiMedicinePrice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiMedicinePrice>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiMedicinePrice]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiMedicinePrice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiMedicinePrice>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiMedicinePrice> rows, {
    required _is.ColumnSelections<ZhongyiMedicinePriceTable> conflictColumns,
    _is.ColumnSelections<ZhongyiMedicinePriceTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiMedicinePriceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiMedicinePrice>(
      rows,
      conflictColumns: conflictColumns(ZhongyiMedicinePrice.t),
      updateColumns: updateColumns?.call(ZhongyiMedicinePrice.t),
      updateWhere: updateWhere?.call(ZhongyiMedicinePrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiMedicinePrice] and returns the resulting row.
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
  /// The returned [ZhongyiMedicinePrice] will have its `id` field set.
  Future<ZhongyiMedicinePrice?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiMedicinePrice row, {
    required _is.ColumnSelections<ZhongyiMedicinePriceTable> conflictColumns,
    _is.ColumnSelections<ZhongyiMedicinePriceTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiMedicinePriceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiMedicinePrice>(
      row,
      conflictColumns: conflictColumns(ZhongyiMedicinePrice.t),
      updateColumns: updateColumns?.call(ZhongyiMedicinePrice.t),
      updateWhere: updateWhere?.call(ZhongyiMedicinePrice.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiMedicinePrice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiMedicinePrice>> update(
    _is.DatabaseSession session,
    List<ZhongyiMedicinePrice> rows, {
    _is.ColumnSelections<ZhongyiMedicinePriceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiMedicinePrice>(
      rows,
      columns: columns?.call(ZhongyiMedicinePrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiMedicinePrice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiMedicinePrice> updateRow(
    _is.DatabaseSession session,
    ZhongyiMedicinePrice row, {
    _is.ColumnSelections<ZhongyiMedicinePriceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiMedicinePrice>(
      row,
      columns: columns?.call(ZhongyiMedicinePrice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ZhongyiMedicinePrice] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiMedicinePrice?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiMedicinePriceUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiMedicinePrice>(
      id,
      columnValues: columnValues(ZhongyiMedicinePrice.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiMedicinePrice]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiMedicinePrice>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiMedicinePriceUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiMedicinePriceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiMedicinePriceTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicinePriceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiMedicinePrice>(
      columnValues: columnValues(ZhongyiMedicinePrice.t.updateTable),
      where: where(ZhongyiMedicinePrice.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiMedicinePrice.t),
      orderByList: orderByList?.call(ZhongyiMedicinePrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiMedicinePrice]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiMedicinePrice>> delete(
    _is.DatabaseSession session,
    List<ZhongyiMedicinePrice> rows, {
    _is.OrderByBuilder<ZhongyiMedicinePriceTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicinePriceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiMedicinePrice>(
      rows,
      orderBy: orderBy?.call(ZhongyiMedicinePrice.t),
      orderByList: orderByList?.call(ZhongyiMedicinePrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiMedicinePrice].
  Future<ZhongyiMedicinePrice> deleteRow(
    _is.DatabaseSession session,
    ZhongyiMedicinePrice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiMedicinePrice>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiMedicinePrice>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiMedicinePriceTable> where,
    _is.OrderByBuilder<ZhongyiMedicinePriceTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicinePriceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiMedicinePrice>(
      where: where(ZhongyiMedicinePrice.t),
      orderBy: orderBy?.call(ZhongyiMedicinePrice.t),
      orderByList: orderByList?.call(ZhongyiMedicinePrice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiMedicinePriceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiMedicinePrice>(
      where: where?.call(ZhongyiMedicinePrice.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ZhongyiMedicinePrice] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiMedicinePriceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiMedicinePrice>(
      where: where(ZhongyiMedicinePrice.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
