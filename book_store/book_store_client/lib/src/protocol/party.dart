/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// 用于存储活动场地的基本信息
abstract class Party implements _i1.SerializableModel {
  Party._({
    this.id,
    String? name,
    this.latitude,
    this.longitude,
    this.address,
    this.capacity,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : name = name ?? '',
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory Party({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    String? address,
    int? capacity,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _PartyImpl;

  factory Party.fromJson(Map<String, dynamic> jsonSerialization) {
    return Party(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
      address: jsonSerialization['address'] as String?,
      capacity: jsonSerialization['capacity'] as int?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 场地名称（默认空字符串）
  String name;

  /// 纬度
  double? latitude;

  /// 经度
  double? longitude;

  /// 详细地址
  String? address;

  /// 场地容量
  int? capacity;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  Party copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    String? address,
    int? capacity,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (address != null) 'address': address,
      if (capacity != null) 'capacity': capacity,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartyImpl extends Party {
  _PartyImpl({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    String? address,
    int? capacity,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          name: name,
          latitude: latitude,
          longitude: longitude,
          address: address,
          capacity: capacity,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  Party copyWith({
    Object? id = _Undefined,
    String? name,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    Object? address = _Undefined,
    Object? capacity = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return Party(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      address: address is String? ? address : this.address,
      capacity: capacity is int? ? capacity : this.capacity,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
