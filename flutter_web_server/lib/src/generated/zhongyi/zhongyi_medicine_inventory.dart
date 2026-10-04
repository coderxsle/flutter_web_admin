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

/// 中药药品库存批次
abstract class ZhongyiMedicineInventory implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiMedicineInventory._({
    this.id,
    required this.medicineId,
    required this.batchNumber,
    this.supplierId,
    double? quantityG,
    String? unit,
    this.purchasePrice,
    this.productionDate,
    this.expiryDate,
    String? qualityStatus,
    this.storageLocation,
    bool? isExhausted,
    this.description,
    int? status,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : quantityG = quantityG ?? 0.0,
       unit = unit ?? 'g',
       qualityStatus = qualityStatus ?? 'qualified',
       isExhausted = isExhausted ?? false,
       status = status ?? 0,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiMedicineInventory({
    int? id,
    required int medicineId,
    required String batchNumber,
    int? supplierId,
    double? quantityG,
    String? unit,
    double? purchasePrice,
    DateTime? productionDate,
    DateTime? expiryDate,
    String? qualityStatus,
    String? storageLocation,
    bool? isExhausted,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiMedicineInventoryImpl;

  factory ZhongyiMedicineInventory.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiMedicineInventory(
      id: jsonSerialization['id'] as int?,
      medicineId: jsonSerialization['medicineId'] as int,
      batchNumber: jsonSerialization['batchNumber'] as String,
      supplierId: jsonSerialization['supplierId'] as int?,
      quantityG: (jsonSerialization['quantityG'] as num?)?.toDouble(),
      unit: jsonSerialization['unit'] as String?,
      purchasePrice: (jsonSerialization['purchasePrice'] as num?)?.toDouble(),
      productionDate: jsonSerialization['productionDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['productionDate']),
      expiryDate: jsonSerialization['expiryDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['expiryDate']),
      qualityStatus: jsonSerialization['qualityStatus'] as String?,
      storageLocation: jsonSerialization['storageLocation'] as String?,
      isExhausted: jsonSerialization['isExhausted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isExhausted']),
      description: jsonSerialization['description'] as String?,
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

  static final t = ZhongyiMedicineInventoryTable();

  static const db = ZhongyiMedicineInventoryRepository._();

  @override
  int? id;

  /// 药品ID
  int medicineId;

  /// 批号
  String batchNumber;

  /// 供应商ID
  int? supplierId;

  /// 库存量(g)
  double quantityG;

  /// 单位
  String unit;

  /// 采购价
  double? purchasePrice;

  /// 生产日期
  DateTime? productionDate;

  /// 有效期至
  DateTime? expiryDate;

  /// 质量状态
  String qualityStatus;

  /// 库位
  String? storageLocation;

  /// 是否已耗尽
  bool isExhausted;

  /// 备注
  String? description;

  /// 状态（0停用，1启用）
  int status;

  /// 是否删除
  bool deleted;

  /// 创建人
  String? creator;

  /// 创建时间
  DateTime createTime;

  /// 更新人
  String? updater;

  /// 更新时间
  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiMedicineInventory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiMedicineInventory copyWith({
    int? id,
    int? medicineId,
    String? batchNumber,
    int? supplierId,
    double? quantityG,
    String? unit,
    double? purchasePrice,
    DateTime? productionDate,
    DateTime? expiryDate,
    String? qualityStatus,
    String? storageLocation,
    bool? isExhausted,
    String? description,
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
      '__className__': 'ZhongyiMedicineInventory',
      if (id != null) 'id': id,
      'medicineId': medicineId,
      'batchNumber': batchNumber,
      if (supplierId != null) 'supplierId': supplierId,
      'quantityG': quantityG,
      'unit': unit,
      if (purchasePrice != null) 'purchasePrice': purchasePrice,
      if (productionDate != null) 'productionDate': productionDate?.toJson(),
      if (expiryDate != null) 'expiryDate': expiryDate?.toJson(),
      'qualityStatus': qualityStatus,
      if (storageLocation != null) 'storageLocation': storageLocation,
      'isExhausted': isExhausted,
      if (description != null) 'description': description,
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
      '__className__': 'ZhongyiMedicineInventory',
      if (id != null) 'id': id,
      'medicineId': medicineId,
      'batchNumber': batchNumber,
      if (supplierId != null) 'supplierId': supplierId,
      'quantityG': quantityG,
      'unit': unit,
      if (purchasePrice != null) 'purchasePrice': purchasePrice,
      if (productionDate != null) 'productionDate': productionDate?.toJson(),
      if (expiryDate != null) 'expiryDate': expiryDate?.toJson(),
      'qualityStatus': qualityStatus,
      if (storageLocation != null) 'storageLocation': storageLocation,
      'isExhausted': isExhausted,
      if (description != null) 'description': description,
      'status': status,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiMedicineInventoryInclude include() {
    return ZhongyiMedicineInventoryInclude._();
  }

  static ZhongyiMedicineInventoryIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiMedicineInventoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiMedicineInventoryTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicineInventoryTable>? orderByList,
    ZhongyiMedicineInventoryInclude? include,
  }) {
    return ZhongyiMedicineInventoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiMedicineInventory.t),
      orderByList: orderByList?.call(ZhongyiMedicineInventory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiMedicineInventoryImpl extends ZhongyiMedicineInventory {
  _ZhongyiMedicineInventoryImpl({
    int? id,
    required int medicineId,
    required String batchNumber,
    int? supplierId,
    double? quantityG,
    String? unit,
    double? purchasePrice,
    DateTime? productionDate,
    DateTime? expiryDate,
    String? qualityStatus,
    String? storageLocation,
    bool? isExhausted,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         medicineId: medicineId,
         batchNumber: batchNumber,
         supplierId: supplierId,
         quantityG: quantityG,
         unit: unit,
         purchasePrice: purchasePrice,
         productionDate: productionDate,
         expiryDate: expiryDate,
         qualityStatus: qualityStatus,
         storageLocation: storageLocation,
         isExhausted: isExhausted,
         description: description,
         status: status,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiMedicineInventory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiMedicineInventory copyWith({
    Object? id = _Undefined,
    int? medicineId,
    String? batchNumber,
    Object? supplierId = _Undefined,
    double? quantityG,
    String? unit,
    Object? purchasePrice = _Undefined,
    Object? productionDate = _Undefined,
    Object? expiryDate = _Undefined,
    String? qualityStatus,
    Object? storageLocation = _Undefined,
    bool? isExhausted,
    Object? description = _Undefined,
    int? status,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiMedicineInventory(
      id: id is int? ? id : this.id,
      medicineId: medicineId ?? this.medicineId,
      batchNumber: batchNumber ?? this.batchNumber,
      supplierId: supplierId is int? ? supplierId : this.supplierId,
      quantityG: quantityG ?? this.quantityG,
      unit: unit ?? this.unit,
      purchasePrice: purchasePrice is double? ? purchasePrice : this.purchasePrice,
      productionDate: productionDate is DateTime? ? productionDate : this.productionDate,
      expiryDate: expiryDate is DateTime? ? expiryDate : this.expiryDate,
      qualityStatus: qualityStatus ?? this.qualityStatus,
      storageLocation: storageLocation is String? ? storageLocation : this.storageLocation,
      isExhausted: isExhausted ?? this.isExhausted,
      description: description is String? ? description : this.description,
      status: status ?? this.status,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiMedicineInventoryUpdateTable extends _is.UpdateTable<ZhongyiMedicineInventoryTable> {
  ZhongyiMedicineInventoryUpdateTable(super.table);

  _is.ColumnValue<int, int> medicineId(int value) => _is.ColumnValue(table.medicineId, value);

  _is.ColumnValue<String, String> batchNumber(String value) => _is.ColumnValue(table.batchNumber, value);

  _is.ColumnValue<int, int> supplierId(int? value) => _is.ColumnValue(table.supplierId, value);

  _is.ColumnValue<double, double> quantityG(double value) => _is.ColumnValue(table.quantityG, value);

  _is.ColumnValue<String, String> unit(String value) => _is.ColumnValue(table.unit, value);

  _is.ColumnValue<double, double> purchasePrice(double? value) => _is.ColumnValue(table.purchasePrice, value);

  _is.ColumnValue<DateTime, DateTime> productionDate(DateTime? value) => _is.ColumnValue(table.productionDate, value);

  _is.ColumnValue<DateTime, DateTime> expiryDate(DateTime? value) => _is.ColumnValue(table.expiryDate, value);

  _is.ColumnValue<String, String> qualityStatus(String value) => _is.ColumnValue(table.qualityStatus, value);

  _is.ColumnValue<String, String> storageLocation(String? value) => _is.ColumnValue(table.storageLocation, value);

  _is.ColumnValue<bool, bool> isExhausted(bool value) => _is.ColumnValue(table.isExhausted, value);

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(table.description, value);

  _is.ColumnValue<int, int> status(int value) => _is.ColumnValue(table.status, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiMedicineInventoryTable extends _is.Table<int?> {
  ZhongyiMedicineInventoryTable({super.tableRelation}) : super(tableName: 'zhongyi_medicine_inventory') {
    updateTable = ZhongyiMedicineInventoryUpdateTable(this);
    medicineId = _is.ColumnInt('medicineId', this);
    batchNumber = _is.ColumnString('batchNumber', this);
    supplierId = _is.ColumnInt('supplierId', this);
    quantityG = _is.ColumnDouble('quantityG', this, hasDefault: true);
    unit = _is.ColumnString('unit', this, hasDefault: true);
    purchasePrice = _is.ColumnDouble('purchasePrice', this);
    productionDate = _is.ColumnDateTime('productionDate', this);
    expiryDate = _is.ColumnDateTime('expiryDate', this);
    qualityStatus = _is.ColumnString('qualityStatus', this, hasDefault: true);
    storageLocation = _is.ColumnString('storageLocation', this);
    isExhausted = _is.ColumnBool('isExhausted', this, hasDefault: true);
    description = _is.ColumnString('description', this);
    status = _is.ColumnInt('status', this, hasDefault: true);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiMedicineInventoryUpdateTable updateTable;

  /// 药品ID
  late final _is.ColumnInt medicineId;

  /// 批号
  late final _is.ColumnString batchNumber;

  /// 供应商ID
  late final _is.ColumnInt supplierId;

  /// 库存量(g)
  late final _is.ColumnDouble quantityG;

  /// 单位
  late final _is.ColumnString unit;

  /// 采购价
  late final _is.ColumnDouble purchasePrice;

  /// 生产日期
  late final _is.ColumnDateTime productionDate;

  /// 有效期至
  late final _is.ColumnDateTime expiryDate;

  /// 质量状态
  late final _is.ColumnString qualityStatus;

  /// 库位
  late final _is.ColumnString storageLocation;

  /// 是否已耗尽
  late final _is.ColumnBool isExhausted;

  /// 备注
  late final _is.ColumnString description;

  /// 状态（0停用，1启用）
  late final _is.ColumnInt status;

  /// 是否删除
  late final _is.ColumnBool deleted;

  /// 创建人
  late final _is.ColumnString creator;

  /// 创建时间
  late final _is.ColumnDateTime createTime;

  /// 更新人
  late final _is.ColumnString updater;

  /// 更新时间
  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    medicineId,
    batchNumber,
    supplierId,
    quantityG,
    unit,
    purchasePrice,
    productionDate,
    expiryDate,
    qualityStatus,
    storageLocation,
    isExhausted,
    description,
    status,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiMedicineInventoryInclude extends _is.IncludeObject {
  ZhongyiMedicineInventoryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiMedicineInventory.t;
}

class ZhongyiMedicineInventoryIncludeList extends _is.IncludeList {
  ZhongyiMedicineInventoryIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiMedicineInventoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiMedicineInventory.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiMedicineInventory.t;
}

class ZhongyiMedicineInventoryRepository {
  const ZhongyiMedicineInventoryRepository._();

  /// Returns a list of [ZhongyiMedicineInventory]s matching the given query parameters.
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
  Future<List<ZhongyiMedicineInventory>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiMedicineInventoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiMedicineInventoryTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicineInventoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiMedicineInventory>(
      where: where?.call(ZhongyiMedicineInventory.t),
      orderBy: orderBy?.call(ZhongyiMedicineInventory.t),
      orderByList: orderByList?.call(ZhongyiMedicineInventory.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiMedicineInventory] matching the given query parameters.
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
  Future<ZhongyiMedicineInventory?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiMedicineInventoryTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiMedicineInventoryTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicineInventoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiMedicineInventory>(
      where: where?.call(ZhongyiMedicineInventory.t),
      orderBy: orderBy?.call(ZhongyiMedicineInventory.t),
      orderByList: orderByList?.call(ZhongyiMedicineInventory.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiMedicineInventory] by its [id] or null if no such row exists.
  Future<ZhongyiMedicineInventory?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiMedicineInventory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiMedicineInventory]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiMedicineInventory]s will have their `id` fields set.
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
  Future<List<ZhongyiMedicineInventory>> insert(
    _is.DatabaseSession session,
    List<ZhongyiMedicineInventory> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiMedicineInventory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiMedicineInventory] and returns the inserted row.
  ///
  /// The returned [ZhongyiMedicineInventory] will have its `id` field set.
  Future<ZhongyiMedicineInventory> insertRow(
    _is.DatabaseSession session,
    ZhongyiMedicineInventory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiMedicineInventory>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiMedicineInventory]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiMedicineInventory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiMedicineInventory>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiMedicineInventory> rows, {
    required _is.ColumnSelections<ZhongyiMedicineInventoryTable> conflictColumns,
    _is.ColumnSelections<ZhongyiMedicineInventoryTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiMedicineInventoryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiMedicineInventory>(
      rows,
      conflictColumns: conflictColumns(ZhongyiMedicineInventory.t),
      updateColumns: updateColumns?.call(ZhongyiMedicineInventory.t),
      updateWhere: updateWhere?.call(ZhongyiMedicineInventory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiMedicineInventory] and returns the resulting row.
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
  /// The returned [ZhongyiMedicineInventory] will have its `id` field set.
  Future<ZhongyiMedicineInventory?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiMedicineInventory row, {
    required _is.ColumnSelections<ZhongyiMedicineInventoryTable> conflictColumns,
    _is.ColumnSelections<ZhongyiMedicineInventoryTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiMedicineInventoryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiMedicineInventory>(
      row,
      conflictColumns: conflictColumns(ZhongyiMedicineInventory.t),
      updateColumns: updateColumns?.call(ZhongyiMedicineInventory.t),
      updateWhere: updateWhere?.call(ZhongyiMedicineInventory.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiMedicineInventory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiMedicineInventory>> update(
    _is.DatabaseSession session,
    List<ZhongyiMedicineInventory> rows, {
    _is.ColumnSelections<ZhongyiMedicineInventoryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiMedicineInventory>(
      rows,
      columns: columns?.call(ZhongyiMedicineInventory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiMedicineInventory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiMedicineInventory> updateRow(
    _is.DatabaseSession session,
    ZhongyiMedicineInventory row, {
    _is.ColumnSelections<ZhongyiMedicineInventoryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiMedicineInventory>(
      row,
      columns: columns?.call(ZhongyiMedicineInventory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ZhongyiMedicineInventory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiMedicineInventory?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiMedicineInventoryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiMedicineInventory>(
      id,
      columnValues: columnValues(ZhongyiMedicineInventory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiMedicineInventory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiMedicineInventory>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiMedicineInventoryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiMedicineInventoryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiMedicineInventoryTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicineInventoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiMedicineInventory>(
      columnValues: columnValues(ZhongyiMedicineInventory.t.updateTable),
      where: where(ZhongyiMedicineInventory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiMedicineInventory.t),
      orderByList: orderByList?.call(ZhongyiMedicineInventory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiMedicineInventory]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiMedicineInventory>> delete(
    _is.DatabaseSession session,
    List<ZhongyiMedicineInventory> rows, {
    _is.OrderByBuilder<ZhongyiMedicineInventoryTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicineInventoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiMedicineInventory>(
      rows,
      orderBy: orderBy?.call(ZhongyiMedicineInventory.t),
      orderByList: orderByList?.call(ZhongyiMedicineInventory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiMedicineInventory].
  Future<ZhongyiMedicineInventory> deleteRow(
    _is.DatabaseSession session,
    ZhongyiMedicineInventory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiMedicineInventory>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiMedicineInventory>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiMedicineInventoryTable> where,
    _is.OrderByBuilder<ZhongyiMedicineInventoryTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicineInventoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiMedicineInventory>(
      where: where(ZhongyiMedicineInventory.t),
      orderBy: orderBy?.call(ZhongyiMedicineInventory.t),
      orderByList: orderByList?.call(ZhongyiMedicineInventory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiMedicineInventoryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiMedicineInventory>(
      where: where?.call(ZhongyiMedicineInventory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ZhongyiMedicineInventory] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiMedicineInventoryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiMedicineInventory>(
      where: where(ZhongyiMedicineInventory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
