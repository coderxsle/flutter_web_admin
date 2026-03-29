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
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// 用于存储每个书籍套装中包含的书籍信息
abstract class BookPackageItem implements _i1.SerializableModel {
  BookPackageItem._({
    this.id,
    int? tenantId,
    required this.bookId,
    required this.packageId,
    int? quantity,
    required this.packagePrice,
    required this.originalPrice,
    double? discountRate,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : tenantId = tenantId ?? 0,
       quantity = quantity ?? 1,
       discountRate = discountRate ?? 1.0,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now(),
       isDeleted = isDeleted ?? false;

  factory BookPackageItem({
    int? id,
    int? tenantId,
    required int bookId,
    required int packageId,
    int? quantity,
    required double packagePrice,
    required double originalPrice,
    double? discountRate,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _BookPackageItemImpl;

  factory BookPackageItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookPackageItem(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      packageId: jsonSerialization['packageId'] as int,
      quantity: jsonSerialization['quantity'] as int?,
      packagePrice: (jsonSerialization['packagePrice'] as num).toDouble(),
      originalPrice: (jsonSerialization['originalPrice'] as num).toDouble(),
      discountRate: (jsonSerialization['discountRate'] as num?)?.toDouble(),
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isDeleted']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 租户ID（0 表示系统租户）
  int? tenantId;

  /// 关联的书籍ID
  int bookId;

  /// 关联的套餐ID
  int packageId;

  /// 此书籍在套餐中的数量
  int quantity;

  /// 此书籍在套餐中的单价（可能与原价不同）
  double packagePrice;

  /// 此书籍的原价（冗余存储，便于历史查询）
  double originalPrice;

  /// 单品折扣率
  double discountRate;

  /// 套餐明细记录创建时间
  DateTime createTime;

  /// 套餐明细记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  /// Returns a shallow copy of this [BookPackageItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookPackageItem copyWith({
    int? id,
    int? tenantId,
    int? bookId,
    int? packageId,
    int? quantity,
    double? packagePrice,
    double? originalPrice,
    double? discountRate,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookPackageItem',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'bookId': bookId,
      'packageId': packageId,
      'quantity': quantity,
      'packagePrice': packagePrice,
      'originalPrice': originalPrice,
      'discountRate': discountRate,
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

class _BookPackageItemImpl extends BookPackageItem {
  _BookPackageItemImpl({
    int? id,
    int? tenantId,
    required int bookId,
    required int packageId,
    int? quantity,
    required double packagePrice,
    required double originalPrice,
    double? discountRate,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         bookId: bookId,
         packageId: packageId,
         quantity: quantity,
         packagePrice: packagePrice,
         originalPrice: originalPrice,
         discountRate: discountRate,
         createTime: createTime,
         updateTime: updateTime,
         isDeleted: isDeleted,
       );

  /// Returns a shallow copy of this [BookPackageItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookPackageItem copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    int? bookId,
    int? packageId,
    int? quantity,
    double? packagePrice,
    double? originalPrice,
    double? discountRate,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return BookPackageItem(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      bookId: bookId ?? this.bookId,
      packageId: packageId ?? this.packageId,
      quantity: quantity ?? this.quantity,
      packagePrice: packagePrice ?? this.packagePrice,
      originalPrice: originalPrice ?? this.originalPrice,
      discountRate: discountRate ?? this.discountRate,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
