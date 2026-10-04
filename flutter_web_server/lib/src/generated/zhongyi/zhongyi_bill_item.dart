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

/// 中医门诊账单明细（兼容 FastapiAdmin zhongyi_bill_item）
abstract class ZhongyiBillItem implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiBillItem._({
    this.id,
    required this.billId,
    required this.itemType,
    this.referenceType,
    this.referenceId,
    required this.itemName,
    this.specification,
    String? unit,
    int? quantity,
    required this.unitPrice,
    required this.totalPrice,
    bool? isRefunded,
    int? refundedQuantity,
    this.description,
    int? status,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : unit = unit ?? '次',
       quantity = quantity ?? 1,
       isRefunded = isRefunded ?? false,
       refundedQuantity = refundedQuantity ?? 0,
       status = status ?? 0,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiBillItem({
    int? id,
    required int billId,
    required String itemType,
    String? referenceType,
    int? referenceId,
    required String itemName,
    String? specification,
    String? unit,
    int? quantity,
    required double unitPrice,
    required double totalPrice,
    bool? isRefunded,
    int? refundedQuantity,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiBillItemImpl;

  factory ZhongyiBillItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiBillItem(
      id: jsonSerialization['id'] as int?,
      billId: jsonSerialization['billId'] as int,
      itemType: jsonSerialization['itemType'] as String,
      referenceType: jsonSerialization['referenceType'] as String?,
      referenceId: jsonSerialization['referenceId'] as int?,
      itemName: jsonSerialization['itemName'] as String,
      specification: jsonSerialization['specification'] as String?,
      unit: jsonSerialization['unit'] as String?,
      quantity: jsonSerialization['quantity'] as int?,
      unitPrice: (jsonSerialization['unitPrice'] as num).toDouble(),
      totalPrice: (jsonSerialization['totalPrice'] as num).toDouble(),
      isRefunded: jsonSerialization['isRefunded'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isRefunded']),
      refundedQuantity: jsonSerialization['refundedQuantity'] as int?,
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

  static final t = ZhongyiBillItemTable();

  static const db = ZhongyiBillItemRepository._();

  @override
  int? id;

  /// 账单ID
  int billId;

  /// 项目类型
  String itemType;

  /// 关联类型
  String? referenceType;

  /// 关联记录ID
  int? referenceId;

  /// 项目名称
  String itemName;

  /// 规格
  String? specification;

  /// 单位
  String unit;

  /// 数量
  int quantity;

  /// 单价
  double unitPrice;

  /// 小计
  double totalPrice;

  /// 是否已退款
  bool isRefunded;

  /// 已退数量
  int refundedQuantity;

  /// 描述
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

  /// Returns a shallow copy of this [ZhongyiBillItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiBillItem copyWith({
    int? id,
    int? billId,
    String? itemType,
    String? referenceType,
    int? referenceId,
    String? itemName,
    String? specification,
    String? unit,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    bool? isRefunded,
    int? refundedQuantity,
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
      '__className__': 'ZhongyiBillItem',
      if (id != null) 'id': id,
      'billId': billId,
      'itemType': itemType,
      if (referenceType != null) 'referenceType': referenceType,
      if (referenceId != null) 'referenceId': referenceId,
      'itemName': itemName,
      if (specification != null) 'specification': specification,
      'unit': unit,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'isRefunded': isRefunded,
      'refundedQuantity': refundedQuantity,
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
      '__className__': 'ZhongyiBillItem',
      if (id != null) 'id': id,
      'billId': billId,
      'itemType': itemType,
      if (referenceType != null) 'referenceType': referenceType,
      if (referenceId != null) 'referenceId': referenceId,
      'itemName': itemName,
      if (specification != null) 'specification': specification,
      'unit': unit,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'isRefunded': isRefunded,
      'refundedQuantity': refundedQuantity,
      if (description != null) 'description': description,
      'status': status,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiBillItemInclude include() {
    return ZhongyiBillItemInclude._();
  }

  static ZhongyiBillItemIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiBillItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiBillItemTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiBillItemTable>? orderByList,
    ZhongyiBillItemInclude? include,
  }) {
    return ZhongyiBillItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiBillItem.t),
      orderByList: orderByList?.call(ZhongyiBillItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiBillItemImpl extends ZhongyiBillItem {
  _ZhongyiBillItemImpl({
    int? id,
    required int billId,
    required String itemType,
    String? referenceType,
    int? referenceId,
    required String itemName,
    String? specification,
    String? unit,
    int? quantity,
    required double unitPrice,
    required double totalPrice,
    bool? isRefunded,
    int? refundedQuantity,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         billId: billId,
         itemType: itemType,
         referenceType: referenceType,
         referenceId: referenceId,
         itemName: itemName,
         specification: specification,
         unit: unit,
         quantity: quantity,
         unitPrice: unitPrice,
         totalPrice: totalPrice,
         isRefunded: isRefunded,
         refundedQuantity: refundedQuantity,
         description: description,
         status: status,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiBillItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiBillItem copyWith({
    Object? id = _Undefined,
    int? billId,
    String? itemType,
    Object? referenceType = _Undefined,
    Object? referenceId = _Undefined,
    String? itemName,
    Object? specification = _Undefined,
    String? unit,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    bool? isRefunded,
    int? refundedQuantity,
    Object? description = _Undefined,
    int? status,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiBillItem(
      id: id is int? ? id : this.id,
      billId: billId ?? this.billId,
      itemType: itemType ?? this.itemType,
      referenceType: referenceType is String? ? referenceType : this.referenceType,
      referenceId: referenceId is int? ? referenceId : this.referenceId,
      itemName: itemName ?? this.itemName,
      specification: specification is String? ? specification : this.specification,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      isRefunded: isRefunded ?? this.isRefunded,
      refundedQuantity: refundedQuantity ?? this.refundedQuantity,
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

class ZhongyiBillItemUpdateTable extends _is.UpdateTable<ZhongyiBillItemTable> {
  ZhongyiBillItemUpdateTable(super.table);

  _is.ColumnValue<int, int> billId(int value) => _is.ColumnValue(table.billId, value);

  _is.ColumnValue<String, String> itemType(String value) => _is.ColumnValue(table.itemType, value);

  _is.ColumnValue<String, String> referenceType(String? value) => _is.ColumnValue(table.referenceType, value);

  _is.ColumnValue<int, int> referenceId(int? value) => _is.ColumnValue(table.referenceId, value);

  _is.ColumnValue<String, String> itemName(String value) => _is.ColumnValue(table.itemName, value);

  _is.ColumnValue<String, String> specification(String? value) => _is.ColumnValue(table.specification, value);

  _is.ColumnValue<String, String> unit(String value) => _is.ColumnValue(table.unit, value);

  _is.ColumnValue<int, int> quantity(int value) => _is.ColumnValue(table.quantity, value);

  _is.ColumnValue<double, double> unitPrice(double value) => _is.ColumnValue(table.unitPrice, value);

  _is.ColumnValue<double, double> totalPrice(double value) => _is.ColumnValue(table.totalPrice, value);

  _is.ColumnValue<bool, bool> isRefunded(bool value) => _is.ColumnValue(table.isRefunded, value);

  _is.ColumnValue<int, int> refundedQuantity(int value) => _is.ColumnValue(table.refundedQuantity, value);

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(table.description, value);

  _is.ColumnValue<int, int> status(int value) => _is.ColumnValue(table.status, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiBillItemTable extends _is.Table<int?> {
  ZhongyiBillItemTable({super.tableRelation}) : super(tableName: 'zhongyi_bill_item') {
    updateTable = ZhongyiBillItemUpdateTable(this);
    billId = _is.ColumnInt('billId', this);
    itemType = _is.ColumnString('itemType', this);
    referenceType = _is.ColumnString('referenceType', this);
    referenceId = _is.ColumnInt('referenceId', this);
    itemName = _is.ColumnString('itemName', this);
    specification = _is.ColumnString('specification', this);
    unit = _is.ColumnString('unit', this, hasDefault: true);
    quantity = _is.ColumnInt('quantity', this, hasDefault: true);
    unitPrice = _is.ColumnDouble('unitPrice', this);
    totalPrice = _is.ColumnDouble('totalPrice', this);
    isRefunded = _is.ColumnBool('isRefunded', this, hasDefault: true);
    refundedQuantity = _is.ColumnInt('refundedQuantity', this, hasDefault: true);
    description = _is.ColumnString('description', this);
    status = _is.ColumnInt('status', this, hasDefault: true);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiBillItemUpdateTable updateTable;

  /// 账单ID
  late final _is.ColumnInt billId;

  /// 项目类型
  late final _is.ColumnString itemType;

  /// 关联类型
  late final _is.ColumnString referenceType;

  /// 关联记录ID
  late final _is.ColumnInt referenceId;

  /// 项目名称
  late final _is.ColumnString itemName;

  /// 规格
  late final _is.ColumnString specification;

  /// 单位
  late final _is.ColumnString unit;

  /// 数量
  late final _is.ColumnInt quantity;

  /// 单价
  late final _is.ColumnDouble unitPrice;

  /// 小计
  late final _is.ColumnDouble totalPrice;

  /// 是否已退款
  late final _is.ColumnBool isRefunded;

  /// 已退数量
  late final _is.ColumnInt refundedQuantity;

  /// 描述
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
    billId,
    itemType,
    referenceType,
    referenceId,
    itemName,
    specification,
    unit,
    quantity,
    unitPrice,
    totalPrice,
    isRefunded,
    refundedQuantity,
    description,
    status,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiBillItemInclude extends _is.IncludeObject {
  ZhongyiBillItemInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiBillItem.t;
}

class ZhongyiBillItemIncludeList extends _is.IncludeList {
  ZhongyiBillItemIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiBillItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiBillItem.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiBillItem.t;
}

class ZhongyiBillItemRepository {
  const ZhongyiBillItemRepository._();

  /// Returns a list of [ZhongyiBillItem]s matching the given query parameters.
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
  Future<List<ZhongyiBillItem>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiBillItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiBillItemTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiBillItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiBillItem>(
      where: where?.call(ZhongyiBillItem.t),
      orderBy: orderBy?.call(ZhongyiBillItem.t),
      orderByList: orderByList?.call(ZhongyiBillItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiBillItem] matching the given query parameters.
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
  Future<ZhongyiBillItem?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiBillItemTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiBillItemTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiBillItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiBillItem>(
      where: where?.call(ZhongyiBillItem.t),
      orderBy: orderBy?.call(ZhongyiBillItem.t),
      orderByList: orderByList?.call(ZhongyiBillItem.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiBillItem] by its [id] or null if no such row exists.
  Future<ZhongyiBillItem?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiBillItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiBillItem]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiBillItem]s will have their `id` fields set.
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
  Future<List<ZhongyiBillItem>> insert(
    _is.DatabaseSession session,
    List<ZhongyiBillItem> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiBillItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiBillItem] and returns the inserted row.
  ///
  /// The returned [ZhongyiBillItem] will have its `id` field set.
  Future<ZhongyiBillItem> insertRow(
    _is.DatabaseSession session,
    ZhongyiBillItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiBillItem>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiBillItem]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiBillItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiBillItem>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiBillItem> rows, {
    required _is.ColumnSelections<ZhongyiBillItemTable> conflictColumns,
    _is.ColumnSelections<ZhongyiBillItemTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiBillItemTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiBillItem>(
      rows,
      conflictColumns: conflictColumns(ZhongyiBillItem.t),
      updateColumns: updateColumns?.call(ZhongyiBillItem.t),
      updateWhere: updateWhere?.call(ZhongyiBillItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiBillItem] and returns the resulting row.
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
  /// The returned [ZhongyiBillItem] will have its `id` field set.
  Future<ZhongyiBillItem?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiBillItem row, {
    required _is.ColumnSelections<ZhongyiBillItemTable> conflictColumns,
    _is.ColumnSelections<ZhongyiBillItemTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiBillItemTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiBillItem>(
      row,
      conflictColumns: conflictColumns(ZhongyiBillItem.t),
      updateColumns: updateColumns?.call(ZhongyiBillItem.t),
      updateWhere: updateWhere?.call(ZhongyiBillItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiBillItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiBillItem>> update(
    _is.DatabaseSession session,
    List<ZhongyiBillItem> rows, {
    _is.ColumnSelections<ZhongyiBillItemTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiBillItem>(
      rows,
      columns: columns?.call(ZhongyiBillItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiBillItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiBillItem> updateRow(
    _is.DatabaseSession session,
    ZhongyiBillItem row, {
    _is.ColumnSelections<ZhongyiBillItemTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiBillItem>(
      row,
      columns: columns?.call(ZhongyiBillItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ZhongyiBillItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiBillItem?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiBillItemUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiBillItem>(
      id,
      columnValues: columnValues(ZhongyiBillItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiBillItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiBillItem>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiBillItemUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiBillItemTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiBillItemTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiBillItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiBillItem>(
      columnValues: columnValues(ZhongyiBillItem.t.updateTable),
      where: where(ZhongyiBillItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiBillItem.t),
      orderByList: orderByList?.call(ZhongyiBillItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiBillItem]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiBillItem>> delete(
    _is.DatabaseSession session,
    List<ZhongyiBillItem> rows, {
    _is.OrderByBuilder<ZhongyiBillItemTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiBillItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiBillItem>(
      rows,
      orderBy: orderBy?.call(ZhongyiBillItem.t),
      orderByList: orderByList?.call(ZhongyiBillItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiBillItem].
  Future<ZhongyiBillItem> deleteRow(
    _is.DatabaseSession session,
    ZhongyiBillItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiBillItem>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiBillItem>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiBillItemTable> where,
    _is.OrderByBuilder<ZhongyiBillItemTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiBillItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiBillItem>(
      where: where(ZhongyiBillItem.t),
      orderBy: orderBy?.call(ZhongyiBillItem.t),
      orderByList: orderByList?.call(ZhongyiBillItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiBillItemTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiBillItem>(
      where: where?.call(ZhongyiBillItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ZhongyiBillItem] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiBillItemTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiBillItem>(
      where: where(ZhongyiBillItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
