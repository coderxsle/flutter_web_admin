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

/// 中药库存变动流水
abstract class ZhongyiInventoryTransaction implements _isc.SerializableModel, _isc.ProtocolSerialization {
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

  /// Returns a shallow copy of this [ZhongyiInventoryTransaction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
