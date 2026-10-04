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

/// 药斗/药柜
abstract class ZhongyiCabinet implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ZhongyiCabinet._({
    this.id,
    required this.cabinetNo,
    this.name,
    this.location,
    String? cabinetType,
    this.medicineId,
    this.capacityG,
    bool? isLocked,
    this.description,
    int? status,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : cabinetType = cabinetType ?? 'drawer',
       isLocked = isLocked ?? false,
       status = status ?? 0,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiCabinet({
    int? id,
    required String cabinetNo,
    String? name,
    String? location,
    String? cabinetType,
    int? medicineId,
    int? capacityG,
    bool? isLocked,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiCabinetImpl;

  factory ZhongyiCabinet.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiCabinet(
      id: jsonSerialization['id'] as int?,
      cabinetNo: jsonSerialization['cabinetNo'] as String,
      name: jsonSerialization['name'] as String?,
      location: jsonSerialization['location'] as String?,
      cabinetType: jsonSerialization['cabinetType'] as String?,
      medicineId: jsonSerialization['medicineId'] as int?,
      capacityG: jsonSerialization['capacityG'] as int?,
      isLocked: jsonSerialization['isLocked'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isLocked']),
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

  /// 药斗编号
  String cabinetNo;

  /// 药斗名称
  String? name;

  /// 位置
  String? location;

  /// 类型
  String cabinetType;

  /// 存放药品ID
  int? medicineId;

  /// 容量(g)
  int? capacityG;

  /// 是否锁定
  bool isLocked;

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

  /// Returns a shallow copy of this [ZhongyiCabinet]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ZhongyiCabinet copyWith({
    int? id,
    String? cabinetNo,
    String? name,
    String? location,
    String? cabinetType,
    int? medicineId,
    int? capacityG,
    bool? isLocked,
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
      '__className__': 'ZhongyiCabinet',
      if (id != null) 'id': id,
      'cabinetNo': cabinetNo,
      if (name != null) 'name': name,
      if (location != null) 'location': location,
      'cabinetType': cabinetType,
      if (medicineId != null) 'medicineId': medicineId,
      if (capacityG != null) 'capacityG': capacityG,
      'isLocked': isLocked,
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
      '__className__': 'ZhongyiCabinet',
      if (id != null) 'id': id,
      'cabinetNo': cabinetNo,
      if (name != null) 'name': name,
      if (location != null) 'location': location,
      'cabinetType': cabinetType,
      if (medicineId != null) 'medicineId': medicineId,
      if (capacityG != null) 'capacityG': capacityG,
      'isLocked': isLocked,
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

class _ZhongyiCabinetImpl extends ZhongyiCabinet {
  _ZhongyiCabinetImpl({
    int? id,
    required String cabinetNo,
    String? name,
    String? location,
    String? cabinetType,
    int? medicineId,
    int? capacityG,
    bool? isLocked,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         cabinetNo: cabinetNo,
         name: name,
         location: location,
         cabinetType: cabinetType,
         medicineId: medicineId,
         capacityG: capacityG,
         isLocked: isLocked,
         description: description,
         status: status,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiCabinet]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ZhongyiCabinet copyWith({
    Object? id = _Undefined,
    String? cabinetNo,
    Object? name = _Undefined,
    Object? location = _Undefined,
    String? cabinetType,
    Object? medicineId = _Undefined,
    Object? capacityG = _Undefined,
    bool? isLocked,
    Object? description = _Undefined,
    int? status,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiCabinet(
      id: id is int? ? id : this.id,
      cabinetNo: cabinetNo ?? this.cabinetNo,
      name: name is String? ? name : this.name,
      location: location is String? ? location : this.location,
      cabinetType: cabinetType ?? this.cabinetType,
      medicineId: medicineId is int? ? medicineId : this.medicineId,
      capacityG: capacityG is int? ? capacityG : this.capacityG,
      isLocked: isLocked ?? this.isLocked,
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
