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

/// 用于存储书籍的销售记录信息
abstract class BookSale implements _i1.SerializableModel {
  BookSale._({
    this.id,
    required this.bookId,
    required this.quantity,
    required this.salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  })  : saleTime = saleTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory BookSale({
    int? id,
    required int bookId,
    required int quantity,
    required double salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  }) = _BookSaleImpl;

  factory BookSale.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookSale(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
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

  /// 图书的ID（如果是单本销售）
  int bookId;

  /// 出售数量
  int quantity;

  /// 单本图书价格（单本出售）或套装总价（组合出售）
  double salePrice;

  /// 销售时间
  DateTime saleTime;

  /// 是否删除
  bool isDeleted;

  /// Returns a shallow copy of this [BookSale]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookSale copyWith({
    int? id,
    int? bookId,
    int? quantity,
    double? salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'bookId': bookId,
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
    required int bookId,
    required int quantity,
    required double salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          bookId: bookId,
          quantity: quantity,
          salePrice: salePrice,
          saleTime: saleTime,
          isDeleted: isDeleted,
        );

  /// Returns a shallow copy of this [BookSale]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookSale copyWith({
    Object? id = _Undefined,
    int? bookId,
    int? quantity,
    double? salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  }) {
    return BookSale(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      quantity: quantity ?? this.quantity,
      salePrice: salePrice ?? this.salePrice,
      saleTime: saleTime ?? this.saleTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
