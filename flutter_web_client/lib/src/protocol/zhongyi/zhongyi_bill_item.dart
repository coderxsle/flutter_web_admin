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

/// 中医门诊账单明细（兼容 FastapiAdmin zhongyi_bill_item）
abstract class ZhongyiBillItem implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isRefunded']),
      refundedQuantity: jsonSerialization['refundedQuantity'] as int?,
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as int?,
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

  /// Returns a shallow copy of this [ZhongyiBillItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
