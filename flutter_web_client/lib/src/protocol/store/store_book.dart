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

/// 店铺图书关联表，用于存储店铺和图书的关联关系
abstract class StoreBook implements _i1.SerializableModel {
  StoreBook._({
    this.id,
    required this.storeId,
    required this.bookId,
    required this.purchasePrice,
    required this.salePrice,
    required this.discountPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : inventory = inventory ?? 0,
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory StoreBook({
    int? id,
    required int storeId,
    required int bookId,
    required double purchasePrice,
    required double salePrice,
    required double discountPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _StoreBookImpl;

  factory StoreBook.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreBook(
      id: jsonSerialization['id'] as int?,
      storeId: jsonSerialization['storeId'] as int,
      bookId: jsonSerialization['bookId'] as int,
      purchasePrice: (jsonSerialization['purchasePrice'] as num).toDouble(),
      salePrice: (jsonSerialization['salePrice'] as num).toDouble(),
      discountPrice: (jsonSerialization['discountPrice'] as num).toDouble(),
      inventory: jsonSerialization['inventory'] as int,
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

  /// 图书ID
  int bookId;

  /// 进价
  double purchasePrice;

  /// 售价
  double salePrice;

  /// 优惠价
  double discountPrice;

  /// 库存
  int inventory;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否已删除（默认值：false）
  bool isDeleted;

  /// Returns a shallow copy of this [StoreBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreBook copyWith({
    int? id,
    int? storeId,
    int? bookId,
    double? purchasePrice,
    double? salePrice,
    double? discountPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'storeId': storeId,
      'bookId': bookId,
      'purchasePrice': purchasePrice,
      'salePrice': salePrice,
      'discountPrice': discountPrice,
      'inventory': inventory,
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

class _StoreBookImpl extends StoreBook {
  _StoreBookImpl({
    int? id,
    required int storeId,
    required int bookId,
    required double purchasePrice,
    required double salePrice,
    required double discountPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          storeId: storeId,
          bookId: bookId,
          purchasePrice: purchasePrice,
          salePrice: salePrice,
          discountPrice: discountPrice,
          inventory: inventory,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  /// Returns a shallow copy of this [StoreBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreBook copyWith({
    Object? id = _Undefined,
    int? storeId,
    int? bookId,
    double? purchasePrice,
    double? salePrice,
    double? discountPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return StoreBook(
      id: id is int? ? id : this.id,
      storeId: storeId ?? this.storeId,
      bookId: bookId ?? this.bookId,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      salePrice: salePrice ?? this.salePrice,
      discountPrice: discountPrice ?? this.discountPrice,
      inventory: inventory ?? this.inventory,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
