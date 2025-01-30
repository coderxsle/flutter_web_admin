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

/// 用于存储书籍组合套餐的基本信息。
abstract class BookPackage implements _i1.SerializableModel {
  BookPackage._({
    this.id,
    String? name,
    required this.bundlePrice,
    required this.originalPrice,
    double? discountRate,
    String? contentDescription,
    int? status,
    this.startTime,
    this.endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : name = name ?? '',
        discountRate = discountRate ?? 1.0,
        contentDescription = contentDescription ?? '',
        status = status ?? 0,
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory BookPackage({
    int? id,
    String? name,
    required double bundlePrice,
    required double originalPrice,
    double? discountRate,
    String? contentDescription,
    int? status,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _BookPackageImpl;

  factory BookPackage.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookPackage(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      bundlePrice: (jsonSerialization['bundlePrice'] as num).toDouble(),
      originalPrice: (jsonSerialization['originalPrice'] as num).toDouble(),
      discountRate: (jsonSerialization['discountRate'] as num).toDouble(),
      contentDescription: jsonSerialization['contentDescription'] as String,
      status: jsonSerialization['status'] as int,
      startTime: jsonSerialization['startTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startTime']),
      endTime: jsonSerialization['endTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
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

  /// 套餐名称（必填）
  String name;

  /// 套餐的组合价格（实际售价）
  double bundlePrice;

  /// 套餐的原价（各书原价总和）
  double originalPrice;

  /// 折扣率（例：0.8 表示八折）
  double discountRate;

  /// 套餐的描述内容
  String contentDescription;

  /// 套餐状态：0-下架，1-上架，2-预售
  int status;

  /// 生效时间
  DateTime? startTime;

  /// 失效时间
  DateTime? endTime;

  /// 套餐记录创建时间
  DateTime createTime;

  /// 套餐记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  BookPackage copyWith({
    int? id,
    String? name,
    double? bundlePrice,
    double? originalPrice,
    double? discountRate,
    String? contentDescription,
    int? status,
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
      'name': name,
      'bundlePrice': bundlePrice,
      'originalPrice': originalPrice,
      'discountRate': discountRate,
      'contentDescription': contentDescription,
      'status': status,
      if (startTime != null) 'startTime': startTime?.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
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

class _BookPackageImpl extends BookPackage {
  _BookPackageImpl({
    int? id,
    String? name,
    required double bundlePrice,
    required double originalPrice,
    double? discountRate,
    String? contentDescription,
    int? status,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          name: name,
          bundlePrice: bundlePrice,
          originalPrice: originalPrice,
          discountRate: discountRate,
          contentDescription: contentDescription,
          status: status,
          startTime: startTime,
          endTime: endTime,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  BookPackage copyWith({
    Object? id = _Undefined,
    String? name,
    double? bundlePrice,
    double? originalPrice,
    double? discountRate,
    String? contentDescription,
    int? status,
    Object? startTime = _Undefined,
    Object? endTime = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return BookPackage(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      bundlePrice: bundlePrice ?? this.bundlePrice,
      originalPrice: originalPrice ?? this.originalPrice,
      discountRate: discountRate ?? this.discountRate,
      contentDescription: contentDescription ?? this.contentDescription,
      status: status ?? this.status,
      startTime: startTime is DateTime? ? startTime : this.startTime,
      endTime: endTime is DateTime? ? endTime : this.endTime,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
