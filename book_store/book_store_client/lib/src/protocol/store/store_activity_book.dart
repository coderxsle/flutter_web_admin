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

abstract class StoreActivityBook implements _i1.SerializableModel {
  StoreActivityBook._({
    this.id,
    required this.storeId,
    required this.activityId,
    required this.bookId,
    required this.discountPrice,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory StoreActivityBook({
    int? id,
    required int storeId,
    required int activityId,
    required int bookId,
    required double discountPrice,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _StoreActivityBookImpl;

  factory StoreActivityBook.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreActivityBook(
      id: jsonSerialization['id'] as int?,
      storeId: jsonSerialization['storeId'] as int,
      activityId: jsonSerialization['activityId'] as int,
      bookId: jsonSerialization['bookId'] as int,
      discountPrice: (jsonSerialization['discountPrice'] as num).toDouble(),
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

  /// 活动ID
  int activityId;

  /// 书籍ID
  int bookId;

  /// 活动促销价
  double discountPrice;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否已删除（默认值：false）
  bool isDeleted;

  /// Returns a shallow copy of this [StoreActivityBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreActivityBook copyWith({
    int? id,
    int? storeId,
    int? activityId,
    int? bookId,
    double? discountPrice,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'storeId': storeId,
      'activityId': activityId,
      'bookId': bookId,
      'discountPrice': discountPrice,
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

class _StoreActivityBookImpl extends StoreActivityBook {
  _StoreActivityBookImpl({
    int? id,
    required int storeId,
    required int activityId,
    required int bookId,
    required double discountPrice,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          storeId: storeId,
          activityId: activityId,
          bookId: bookId,
          discountPrice: discountPrice,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  /// Returns a shallow copy of this [StoreActivityBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreActivityBook copyWith({
    Object? id = _Undefined,
    int? storeId,
    int? activityId,
    int? bookId,
    double? discountPrice,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return StoreActivityBook(
      id: id is int? ? id : this.id,
      storeId: storeId ?? this.storeId,
      activityId: activityId ?? this.activityId,
      bookId: bookId ?? this.bookId,
      discountPrice: discountPrice ?? this.discountPrice,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
