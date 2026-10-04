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

/// 中医门诊账单（兼容 FastapiAdmin zhongyi_bill）
abstract class ZhongyiBill implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiBill._({
    this.id,
    int? tenantId,
    required this.billNo,
    required this.patientId,
    this.registrationId,
    this.medicalRecordId,
    required this.billingStage,
    double? totalAmount,
    double? paidAmount,
    double? refundedAmount,
    this.discountAmount,
    this.discountReason,
    String? paymentStatus,
    int? status,
    this.cashierId,
    this.paidAt,
    this.notes,
    this.description,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       totalAmount = totalAmount ?? 0.0,
       paidAmount = paidAmount ?? 0.0,
       refundedAmount = refundedAmount ?? 0.0,
       paymentStatus = paymentStatus ?? 'unpaid',
       status = status ?? 1,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiBill({
    int? id,
    int? tenantId,
    required String billNo,
    required int patientId,
    int? registrationId,
    int? medicalRecordId,
    required String billingStage,
    double? totalAmount,
    double? paidAmount,
    double? refundedAmount,
    double? discountAmount,
    String? discountReason,
    String? paymentStatus,
    int? status,
    int? cashierId,
    DateTime? paidAt,
    String? notes,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiBillImpl;

  factory ZhongyiBill.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiBill(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      billNo: jsonSerialization['billNo'] as String,
      patientId: jsonSerialization['patientId'] as int,
      registrationId: jsonSerialization['registrationId'] as int?,
      medicalRecordId: jsonSerialization['medicalRecordId'] as int?,
      billingStage: jsonSerialization['billingStage'] as String,
      totalAmount: (jsonSerialization['totalAmount'] as num?)?.toDouble(),
      paidAmount: (jsonSerialization['paidAmount'] as num?)?.toDouble(),
      refundedAmount: (jsonSerialization['refundedAmount'] as num?)?.toDouble(),
      discountAmount: (jsonSerialization['discountAmount'] as num?)?.toDouble(),
      discountReason: jsonSerialization['discountReason'] as String?,
      paymentStatus: jsonSerialization['paymentStatus'] as String?,
      status: jsonSerialization['status'] as int?,
      cashierId: jsonSerialization['cashierId'] as int?,
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      notes: jsonSerialization['notes'] as String?,
      description: jsonSerialization['description'] as String?,
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

  static final t = ZhongyiBillTable();

  static const db = ZhongyiBillRepository._();

  @override
  int? id;

  /// 租户ID
  int tenantId;

  /// 账单编号
  String billNo;

  /// 患者ID
  int patientId;

  /// 挂号ID
  int? registrationId;

  /// 病历ID
  int? medicalRecordId;

  /// 收费阶段
  String billingStage;

  /// 总金额
  double totalAmount;

  /// 已付金额
  double paidAmount;

  /// 已退金额
  double refundedAmount;

  /// 优惠金额
  double? discountAmount;

  /// 优惠原因
  String? discountReason;

  /// 支付状态
  String paymentStatus;

  /// 账单状态（0取消，1正常）
  int status;

  /// 收银员ID
  int? cashierId;

  /// 支付完成时间
  DateTime? paidAt;

  /// 备注
  String? notes;

  /// 描述
  String? description;

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

  /// Returns a shallow copy of this [ZhongyiBill]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiBill copyWith({
    int? id,
    int? tenantId,
    String? billNo,
    int? patientId,
    int? registrationId,
    int? medicalRecordId,
    String? billingStage,
    double? totalAmount,
    double? paidAmount,
    double? refundedAmount,
    double? discountAmount,
    String? discountReason,
    String? paymentStatus,
    int? status,
    int? cashierId,
    DateTime? paidAt,
    String? notes,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiBill',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'billNo': billNo,
      'patientId': patientId,
      if (registrationId != null) 'registrationId': registrationId,
      if (medicalRecordId != null) 'medicalRecordId': medicalRecordId,
      'billingStage': billingStage,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'refundedAmount': refundedAmount,
      if (discountAmount != null) 'discountAmount': discountAmount,
      if (discountReason != null) 'discountReason': discountReason,
      'paymentStatus': paymentStatus,
      'status': status,
      if (cashierId != null) 'cashierId': cashierId,
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (notes != null) 'notes': notes,
      if (description != null) 'description': description,
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
      '__className__': 'ZhongyiBill',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'billNo': billNo,
      'patientId': patientId,
      if (registrationId != null) 'registrationId': registrationId,
      if (medicalRecordId != null) 'medicalRecordId': medicalRecordId,
      'billingStage': billingStage,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'refundedAmount': refundedAmount,
      if (discountAmount != null) 'discountAmount': discountAmount,
      if (discountReason != null) 'discountReason': discountReason,
      'paymentStatus': paymentStatus,
      'status': status,
      if (cashierId != null) 'cashierId': cashierId,
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (notes != null) 'notes': notes,
      if (description != null) 'description': description,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiBillInclude include() {
    return ZhongyiBillInclude._();
  }

  static ZhongyiBillIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiBillTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiBillTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiBillTable>? orderByList,
    ZhongyiBillInclude? include,
  }) {
    return ZhongyiBillIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiBill.t),
      orderByList: orderByList?.call(ZhongyiBill.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiBillImpl extends ZhongyiBill {
  _ZhongyiBillImpl({
    int? id,
    int? tenantId,
    required String billNo,
    required int patientId,
    int? registrationId,
    int? medicalRecordId,
    required String billingStage,
    double? totalAmount,
    double? paidAmount,
    double? refundedAmount,
    double? discountAmount,
    String? discountReason,
    String? paymentStatus,
    int? status,
    int? cashierId,
    DateTime? paidAt,
    String? notes,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         billNo: billNo,
         patientId: patientId,
         registrationId: registrationId,
         medicalRecordId: medicalRecordId,
         billingStage: billingStage,
         totalAmount: totalAmount,
         paidAmount: paidAmount,
         refundedAmount: refundedAmount,
         discountAmount: discountAmount,
         discountReason: discountReason,
         paymentStatus: paymentStatus,
         status: status,
         cashierId: cashierId,
         paidAt: paidAt,
         notes: notes,
         description: description,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiBill]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiBill copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? billNo,
    int? patientId,
    Object? registrationId = _Undefined,
    Object? medicalRecordId = _Undefined,
    String? billingStage,
    double? totalAmount,
    double? paidAmount,
    double? refundedAmount,
    Object? discountAmount = _Undefined,
    Object? discountReason = _Undefined,
    String? paymentStatus,
    int? status,
    Object? cashierId = _Undefined,
    Object? paidAt = _Undefined,
    Object? notes = _Undefined,
    Object? description = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiBill(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      billNo: billNo ?? this.billNo,
      patientId: patientId ?? this.patientId,
      registrationId: registrationId is int? ? registrationId : this.registrationId,
      medicalRecordId: medicalRecordId is int? ? medicalRecordId : this.medicalRecordId,
      billingStage: billingStage ?? this.billingStage,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      refundedAmount: refundedAmount ?? this.refundedAmount,
      discountAmount: discountAmount is double? ? discountAmount : this.discountAmount,
      discountReason: discountReason is String? ? discountReason : this.discountReason,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      status: status ?? this.status,
      cashierId: cashierId is int? ? cashierId : this.cashierId,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      notes: notes is String? ? notes : this.notes,
      description: description is String? ? description : this.description,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiBillUpdateTable extends _is.UpdateTable<ZhongyiBillTable> {
  ZhongyiBillUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> billNo(String value) => _is.ColumnValue(table.billNo, value);

  _is.ColumnValue<int, int> patientId(int value) => _is.ColumnValue(table.patientId, value);

  _is.ColumnValue<int, int> registrationId(int? value) => _is.ColumnValue(table.registrationId, value);

  _is.ColumnValue<int, int> medicalRecordId(int? value) => _is.ColumnValue(table.medicalRecordId, value);

  _is.ColumnValue<String, String> billingStage(String value) => _is.ColumnValue(table.billingStage, value);

  _is.ColumnValue<double, double> totalAmount(double value) => _is.ColumnValue(table.totalAmount, value);

  _is.ColumnValue<double, double> paidAmount(double value) => _is.ColumnValue(table.paidAmount, value);

  _is.ColumnValue<double, double> refundedAmount(double value) => _is.ColumnValue(table.refundedAmount, value);

  _is.ColumnValue<double, double> discountAmount(double? value) => _is.ColumnValue(table.discountAmount, value);

  _is.ColumnValue<String, String> discountReason(String? value) => _is.ColumnValue(table.discountReason, value);

  _is.ColumnValue<String, String> paymentStatus(String value) => _is.ColumnValue(table.paymentStatus, value);

  _is.ColumnValue<int, int> status(int value) => _is.ColumnValue(table.status, value);

  _is.ColumnValue<int, int> cashierId(int? value) => _is.ColumnValue(table.cashierId, value);

  _is.ColumnValue<DateTime, DateTime> paidAt(DateTime? value) => _is.ColumnValue(table.paidAt, value);

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(table.notes, value);

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(table.description, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiBillTable extends _is.Table<int?> {
  ZhongyiBillTable({super.tableRelation}) : super(tableName: 'zhongyi_bill') {
    updateTable = ZhongyiBillUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    billNo = _is.ColumnString('billNo', this);
    patientId = _is.ColumnInt('patientId', this);
    registrationId = _is.ColumnInt('registrationId', this);
    medicalRecordId = _is.ColumnInt('medicalRecordId', this);
    billingStage = _is.ColumnString('billingStage', this);
    totalAmount = _is.ColumnDouble('totalAmount', this, hasDefault: true);
    paidAmount = _is.ColumnDouble('paidAmount', this, hasDefault: true);
    refundedAmount = _is.ColumnDouble('refundedAmount', this, hasDefault: true);
    discountAmount = _is.ColumnDouble('discountAmount', this);
    discountReason = _is.ColumnString('discountReason', this);
    paymentStatus = _is.ColumnString('paymentStatus', this, hasDefault: true);
    status = _is.ColumnInt('status', this, hasDefault: true);
    cashierId = _is.ColumnInt('cashierId', this);
    paidAt = _is.ColumnDateTime('paidAt', this);
    notes = _is.ColumnString('notes', this);
    description = _is.ColumnString('description', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiBillUpdateTable updateTable;

  /// 租户ID
  late final _is.ColumnInt tenantId;

  /// 账单编号
  late final _is.ColumnString billNo;

  /// 患者ID
  late final _is.ColumnInt patientId;

  /// 挂号ID
  late final _is.ColumnInt registrationId;

  /// 病历ID
  late final _is.ColumnInt medicalRecordId;

  /// 收费阶段
  late final _is.ColumnString billingStage;

  /// 总金额
  late final _is.ColumnDouble totalAmount;

  /// 已付金额
  late final _is.ColumnDouble paidAmount;

  /// 已退金额
  late final _is.ColumnDouble refundedAmount;

  /// 优惠金额
  late final _is.ColumnDouble discountAmount;

  /// 优惠原因
  late final _is.ColumnString discountReason;

  /// 支付状态
  late final _is.ColumnString paymentStatus;

  /// 账单状态（0取消，1正常）
  late final _is.ColumnInt status;

  /// 收银员ID
  late final _is.ColumnInt cashierId;

  /// 支付完成时间
  late final _is.ColumnDateTime paidAt;

  /// 备注
  late final _is.ColumnString notes;

  /// 描述
  late final _is.ColumnString description;

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
    tenantId,
    billNo,
    patientId,
    registrationId,
    medicalRecordId,
    billingStage,
    totalAmount,
    paidAmount,
    refundedAmount,
    discountAmount,
    discountReason,
    paymentStatus,
    status,
    cashierId,
    paidAt,
    notes,
    description,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiBillInclude extends _is.IncludeObject {
  ZhongyiBillInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiBill.t;
}

class ZhongyiBillIncludeList extends _is.IncludeList {
  ZhongyiBillIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiBillTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiBill.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiBill.t;
}

class ZhongyiBillRepository {
  const ZhongyiBillRepository._();

  /// Returns a list of [ZhongyiBill]s matching the given query parameters.
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
  Future<List<ZhongyiBill>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiBillTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiBillTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiBillTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiBill>(
      where: where?.call(ZhongyiBill.t),
      orderBy: orderBy?.call(ZhongyiBill.t),
      orderByList: orderByList?.call(ZhongyiBill.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiBill] matching the given query parameters.
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
  Future<ZhongyiBill?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiBillTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiBillTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiBillTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiBill>(
      where: where?.call(ZhongyiBill.t),
      orderBy: orderBy?.call(ZhongyiBill.t),
      orderByList: orderByList?.call(ZhongyiBill.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiBill] by its [id] or null if no such row exists.
  Future<ZhongyiBill?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiBill>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiBill]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiBill]s will have their `id` fields set.
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
  Future<List<ZhongyiBill>> insert(
    _is.DatabaseSession session,
    List<ZhongyiBill> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiBill>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiBill] and returns the inserted row.
  ///
  /// The returned [ZhongyiBill] will have its `id` field set.
  Future<ZhongyiBill> insertRow(_is.DatabaseSession session, ZhongyiBill row, {_is.Transaction? transaction}) async {
    return session.db.insertRow<ZhongyiBill>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiBill]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiBill]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiBill>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiBill> rows, {
    required _is.ColumnSelections<ZhongyiBillTable> conflictColumns,
    _is.ColumnSelections<ZhongyiBillTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiBillTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiBill>(
      rows,
      conflictColumns: conflictColumns(ZhongyiBill.t),
      updateColumns: updateColumns?.call(ZhongyiBill.t),
      updateWhere: updateWhere?.call(ZhongyiBill.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiBill] and returns the resulting row.
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
  /// The returned [ZhongyiBill] will have its `id` field set.
  Future<ZhongyiBill?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiBill row, {
    required _is.ColumnSelections<ZhongyiBillTable> conflictColumns,
    _is.ColumnSelections<ZhongyiBillTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiBillTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiBill>(
      row,
      conflictColumns: conflictColumns(ZhongyiBill.t),
      updateColumns: updateColumns?.call(ZhongyiBill.t),
      updateWhere: updateWhere?.call(ZhongyiBill.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiBill]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiBill>> update(
    _is.DatabaseSession session,
    List<ZhongyiBill> rows, {
    _is.ColumnSelections<ZhongyiBillTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiBill>(
      rows,
      columns: columns?.call(ZhongyiBill.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiBill]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiBill> updateRow(
    _is.DatabaseSession session,
    ZhongyiBill row, {
    _is.ColumnSelections<ZhongyiBillTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiBill>(row, columns: columns?.call(ZhongyiBill.t), transaction: transaction);
  }

  /// Updates a single [ZhongyiBill] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiBill?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiBillUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiBill>(
      id,
      columnValues: columnValues(ZhongyiBill.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiBill]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiBill>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiBillUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiBillTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiBillTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiBillTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiBill>(
      columnValues: columnValues(ZhongyiBill.t.updateTable),
      where: where(ZhongyiBill.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiBill.t),
      orderByList: orderByList?.call(ZhongyiBill.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiBill]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiBill>> delete(
    _is.DatabaseSession session,
    List<ZhongyiBill> rows, {
    _is.OrderByBuilder<ZhongyiBillTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiBillTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiBill>(
      rows,
      orderBy: orderBy?.call(ZhongyiBill.t),
      orderByList: orderByList?.call(ZhongyiBill.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiBill].
  Future<ZhongyiBill> deleteRow(_is.DatabaseSession session, ZhongyiBill row, {_is.Transaction? transaction}) async {
    return session.db.deleteRow<ZhongyiBill>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiBill>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiBillTable> where,
    _is.OrderByBuilder<ZhongyiBillTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiBillTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiBill>(
      where: where(ZhongyiBill.t),
      orderBy: orderBy?.call(ZhongyiBill.t),
      orderByList: orderByList?.call(ZhongyiBill.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiBillTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiBill>(where: where?.call(ZhongyiBill.t), limit: limit, transaction: transaction);
  }

  /// Acquires row-level locks on [ZhongyiBill] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiBillTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiBill>(
      where: where(ZhongyiBill.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
