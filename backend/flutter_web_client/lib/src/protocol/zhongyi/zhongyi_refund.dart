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

/// 中医门诊收费退款申请及处理记录
abstract class ZhongyiRefund implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['requestedAt']),
      approvedAt: jsonSerialization['approvedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['approvedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['completedAt']),
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

  /// Returns a shallow copy of this [ZhongyiRefund]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
