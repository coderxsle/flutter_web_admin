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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// 中医门诊账单（兼容 FastapiAdmin zhongyi_bill）
abstract class ZhongyiBill implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      notes: jsonSerialization['notes'] as String?,
      description: jsonSerialization['description'] as String?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [ZhongyiBill]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
