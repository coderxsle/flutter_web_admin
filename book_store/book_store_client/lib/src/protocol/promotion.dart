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

/// 用于记录促销活动的基本信息，支持管理折扣和活动规则
abstract class Promotion implements _i1.SerializableModel {
  Promotion._({
    this.id,
    required this.name,
    required this.type,
    this.discountRate,
    DateTime? startTime,
    DateTime? endTime,
    this.description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : startTime = startTime ?? DateTime.now(),
        endTime = endTime ?? DateTime.now(),
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory Promotion({
    int? id,
    required String name,
    required int type,
    double? discountRate,
    DateTime? startTime,
    DateTime? endTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _PromotionImpl;

  factory Promotion.fromJson(Map<String, dynamic> jsonSerialization) {
    return Promotion(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as int,
      discountRate: (jsonSerialization['discountRate'] as num?)?.toDouble(),
      startTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startTime']),
      endTime: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      description: jsonSerialization['description'] as String?,
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

  /// 活动名称
  String name;

  /// 活动类型，0=单本折扣，1=组合优惠
  int type;

  /// 折扣率，范围 0.0 - 1.0，用于定义折扣力度
  double? discountRate;

  /// 活动开始时间
  DateTime startTime;

  /// 活动结束时间
  DateTime endTime;

  /// 活动描述或规则说明
  String? description;

  /// 活动创建时间
  DateTime createTime;

  /// 活动最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  Promotion copyWith({
    int? id,
    String? name,
    int? type,
    double? discountRate,
    DateTime? startTime,
    DateTime? endTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'type': type,
      if (discountRate != null) 'discountRate': discountRate,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      if (description != null) 'description': description,
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

class _PromotionImpl extends Promotion {
  _PromotionImpl({
    int? id,
    required String name,
    required int type,
    double? discountRate,
    DateTime? startTime,
    DateTime? endTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          name: name,
          type: type,
          discountRate: discountRate,
          startTime: startTime,
          endTime: endTime,
          description: description,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  Promotion copyWith({
    Object? id = _Undefined,
    String? name,
    int? type,
    Object? discountRate = _Undefined,
    DateTime? startTime,
    DateTime? endTime,
    Object? description = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return Promotion(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      discountRate: discountRate is double? ? discountRate : this.discountRate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description is String? ? description : this.description,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
