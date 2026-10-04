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

/// 中药药品库存批次
abstract class ZhongyiMedicineInventory implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['productionDate']),
      expiryDate: jsonSerialization['expiryDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['expiryDate']),
      qualityStatus: jsonSerialization['qualityStatus'] as String?,
      storageLocation: jsonSerialization['storageLocation'] as String?,
      isExhausted: jsonSerialization['isExhausted'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isExhausted']),
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

  /// Returns a shallow copy of this [ZhongyiMedicineInventory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
