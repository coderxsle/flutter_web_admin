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

/// 中医门诊收费支付记录
abstract class ZhongyiPayment implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      operatorId: jsonSerialization['operatorId'] as int?,
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

  /// Returns a shallow copy of this [ZhongyiPayment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
