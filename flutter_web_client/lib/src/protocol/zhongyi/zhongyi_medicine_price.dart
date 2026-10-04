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

/// 中药价格历史
abstract class ZhongyiMedicinePrice implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      effectiveFrom: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['effectiveFrom']),
      effectiveTo: jsonSerialization['effectiveTo'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['effectiveTo']),
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

  /// Returns a shallow copy of this [ZhongyiMedicinePrice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
