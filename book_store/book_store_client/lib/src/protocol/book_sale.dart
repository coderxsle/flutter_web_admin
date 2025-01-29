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

/// 用于存储图书或组合套餐的销售记录信息
abstract class BookSale implements _i1.SerializableModel {
  BookSale._({
    this.id,
    required this.saleType,
    required this.bookPackageId,
    required this.bookId,
    required this.categoryId,
    required this.quantity,
    required this.salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  })  : saleTime = saleTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory BookSale({
    int? id,
    required int saleType,
    required int bookPackageId,
    required int bookId,
    required int categoryId,
    required int quantity,
    required double salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  }) = _BookSaleImpl;

  factory BookSale.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookSale(
      id: jsonSerialization['id'] as int?,
      saleType: jsonSerialization['saleType'] as int,
      bookPackageId: jsonSerialization['bookPackageId'] as int,
      bookId: jsonSerialization['bookId'] as int,
      categoryId: jsonSerialization['categoryId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      salePrice: (jsonSerialization['salePrice'] as num).toDouble(),
      saleTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['saleTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 销售类型：0-单本图书，1-组合套餐，2-赠品，3-促销等（可以根据需要扩展）
  int saleType;

  /// 组合套餐的ID（如果是组合销售）
  int bookPackageId;

  /// 图书的ID（如果是单本销售）
  int bookId;

  /// 类别ID（关联图书类别）
  int categoryId;

  /// 出售数量
  int quantity;

  /// 单本图书价格（单本出售）或套装总价（组合出售）
  double salePrice;

  /// 销售时间
  DateTime saleTime;

  /// 是否删除
  bool isDeleted;

  BookSale copyWith({
    int? id,
    int? saleType,
    int? bookPackageId,
    int? bookId,
    int? categoryId,
    int? quantity,
    double? salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'saleType': saleType,
      'bookPackageId': bookPackageId,
      'bookId': bookId,
      'categoryId': categoryId,
      'quantity': quantity,
      'salePrice': salePrice,
      'saleTime': saleTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookSaleImpl extends BookSale {
  _BookSaleImpl({
    int? id,
    required int saleType,
    required int bookPackageId,
    required int bookId,
    required int categoryId,
    required int quantity,
    required double salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          saleType: saleType,
          bookPackageId: bookPackageId,
          bookId: bookId,
          categoryId: categoryId,
          quantity: quantity,
          salePrice: salePrice,
          saleTime: saleTime,
          isDeleted: isDeleted,
        );

  @override
  BookSale copyWith({
    Object? id = _Undefined,
    int? saleType,
    int? bookPackageId,
    int? bookId,
    int? categoryId,
    int? quantity,
    double? salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  }) {
    return BookSale(
      id: id is int? ? id : this.id,
      saleType: saleType ?? this.saleType,
      bookPackageId: bookPackageId ?? this.bookPackageId,
      bookId: bookId ?? this.bookId,
      categoryId: categoryId ?? this.categoryId,
      quantity: quantity ?? this.quantity,
      salePrice: salePrice ?? this.salePrice,
      saleTime: saleTime ?? this.saleTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
