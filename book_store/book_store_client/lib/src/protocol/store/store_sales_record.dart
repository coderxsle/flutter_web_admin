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

/// 店铺销售记录表，用于存储店铺的销售记录
abstract class StoreSalesRecord implements _i1.SerializableModel {
  StoreSalesRecord._({
    this.id,
    required this.storeId,
    required this.saleType,
    required this.bookId,
    required this.bookPackageId,
    required this.salesCount,
    required this.salePrice,
    required this.totalPrice,
    required this.discountPrice,
    required this.paymentPrice,
    required this.activityId,
    DateTime? saleTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : saleTime = saleTime ?? DateTime.now(),
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory StoreSalesRecord({
    int? id,
    required int storeId,
    required int saleType,
    required int bookId,
    required int bookPackageId,
    required int salesCount,
    required double salePrice,
    required double totalPrice,
    required double discountPrice,
    required double paymentPrice,
    required int activityId,
    DateTime? saleTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _StoreSalesRecordImpl;

  factory StoreSalesRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreSalesRecord(
      id: jsonSerialization['id'] as int?,
      storeId: jsonSerialization['storeId'] as int,
      saleType: jsonSerialization['saleType'] as int,
      bookId: jsonSerialization['bookId'] as int,
      bookPackageId: jsonSerialization['bookPackageId'] as int,
      salesCount: jsonSerialization['salesCount'] as int,
      salePrice: (jsonSerialization['salePrice'] as num).toDouble(),
      totalPrice: (jsonSerialization['totalPrice'] as num).toDouble(),
      discountPrice: (jsonSerialization['discountPrice'] as num).toDouble(),
      paymentPrice: (jsonSerialization['paymentPrice'] as num).toDouble(),
      activityId: jsonSerialization['activityId'] as int,
      saleTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['saleTime']),
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

  /// 店铺ID（必填）
  int storeId;

  /// 销售类型：0-单本图书，1-组合套餐，2-赠品，3-促销等（可以根据需要扩展）
  int saleType;

  /// 书籍ID（如果是单本销售）
  int bookId;

  /// 组合套餐的ID（如果是组合销售）
  int bookPackageId;

  /// 销售数量
  int salesCount;

  /// 销售
  double salePrice;

  /// 单本图书价格（单本出售）或套装总价（组合出售）
  double totalPrice;

  /// 优惠金额
  double discountPrice;

  ///# 实付金额
  double paymentPrice;

  /// 参与的活动ID（如果没有活动，`NULL`）
  int activityId;

  /// 销售时间
  DateTime saleTime;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否已删除（默认值：false）
  bool isDeleted;

  StoreSalesRecord copyWith({
    int? id,
    int? storeId,
    int? saleType,
    int? bookId,
    int? bookPackageId,
    int? salesCount,
    double? salePrice,
    double? totalPrice,
    double? discountPrice,
    double? paymentPrice,
    int? activityId,
    DateTime? saleTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'storeId': storeId,
      'saleType': saleType,
      'bookId': bookId,
      'bookPackageId': bookPackageId,
      'salesCount': salesCount,
      'salePrice': salePrice,
      'totalPrice': totalPrice,
      'discountPrice': discountPrice,
      'paymentPrice': paymentPrice,
      'activityId': activityId,
      'saleTime': saleTime.toJson(),
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

class _StoreSalesRecordImpl extends StoreSalesRecord {
  _StoreSalesRecordImpl({
    int? id,
    required int storeId,
    required int saleType,
    required int bookId,
    required int bookPackageId,
    required int salesCount,
    required double salePrice,
    required double totalPrice,
    required double discountPrice,
    required double paymentPrice,
    required int activityId,
    DateTime? saleTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          storeId: storeId,
          saleType: saleType,
          bookId: bookId,
          bookPackageId: bookPackageId,
          salesCount: salesCount,
          salePrice: salePrice,
          totalPrice: totalPrice,
          discountPrice: discountPrice,
          paymentPrice: paymentPrice,
          activityId: activityId,
          saleTime: saleTime,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  StoreSalesRecord copyWith({
    Object? id = _Undefined,
    int? storeId,
    int? saleType,
    int? bookId,
    int? bookPackageId,
    int? salesCount,
    double? salePrice,
    double? totalPrice,
    double? discountPrice,
    double? paymentPrice,
    int? activityId,
    DateTime? saleTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return StoreSalesRecord(
      id: id is int? ? id : this.id,
      storeId: storeId ?? this.storeId,
      saleType: saleType ?? this.saleType,
      bookId: bookId ?? this.bookId,
      bookPackageId: bookPackageId ?? this.bookPackageId,
      salesCount: salesCount ?? this.salesCount,
      salePrice: salePrice ?? this.salePrice,
      totalPrice: totalPrice ?? this.totalPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      paymentPrice: paymentPrice ?? this.paymentPrice,
      activityId: activityId ?? this.activityId,
      saleTime: saleTime ?? this.saleTime,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
