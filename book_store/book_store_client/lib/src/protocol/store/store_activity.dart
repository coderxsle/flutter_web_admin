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

abstract class StoreActivity implements _i1.SerializableModel {
  StoreActivity._({
    this.id,
    required this.storeId,
    required this.name,
    required this.address,
    required this.description,
    required this.startTime,
    required this.endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory StoreActivity({
    int? id,
    required int storeId,
    required String name,
    required String address,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _StoreActivityImpl;

  factory StoreActivity.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreActivity(
      id: jsonSerialization['id'] as int?,
      storeId: jsonSerialization['storeId'] as int,
      name: jsonSerialization['name'] as String,
      address: jsonSerialization['address'] as String,
      description: jsonSerialization['description'] as String,
      startTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startTime']),
      endTime: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
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

  /// 店铺ID
  int storeId;

  /// 活动名称
  String name;

  /// 活动地点
  String address;

  /// 活动描述
  String description;

  /// 开始时间
  DateTime startTime;

  /// 结束时间
  DateTime endTime;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否已删除（默认值：false）
  bool isDeleted;

  StoreActivity copyWith({
    int? id,
    int? storeId,
    String? name,
    String? address,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'storeId': storeId,
      'name': name,
      'address': address,
      'description': description,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
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

class _StoreActivityImpl extends StoreActivity {
  _StoreActivityImpl({
    int? id,
    required int storeId,
    required String name,
    required String address,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          storeId: storeId,
          name: name,
          address: address,
          description: description,
          startTime: startTime,
          endTime: endTime,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  StoreActivity copyWith({
    Object? id = _Undefined,
    int? storeId,
    String? name,
    String? address,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return StoreActivity(
      id: id is int? ? id : this.id,
      storeId: storeId ?? this.storeId,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
