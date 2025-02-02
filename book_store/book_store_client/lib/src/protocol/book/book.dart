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

/// 图书信息模型，用于存储图书的基本信息
abstract class Book implements _i1.SerializableModel {
  Book._({
    this.id,
    required this.name,
    this.isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    required this.originalPrice,
    this.purchasePrice,
    this.salePrice,
    this.promotionPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
    this.activityId,
    this.category,
    this.categoryId,
    this.status,
  })  : author = author ?? '',
        keyword = keyword ?? '',
        publisher = publisher ?? '',
        image = image ?? '',
        inventory = inventory ?? 0,
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory Book({
    int? id,
    required String name,
    String? isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    required double originalPrice,
    double? purchasePrice,
    double? salePrice,
    double? promotionPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
    int? activityId,
    String? category,
    int? categoryId,
    int? status,
  }) = _BookImpl;

  factory Book.fromJson(Map<String, dynamic> jsonSerialization) {
    return Book(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      isbn: jsonSerialization['isbn'] as String?,
      author: jsonSerialization['author'] as String,
      keyword: jsonSerialization['keyword'] as String,
      publisher: jsonSerialization['publisher'] as String,
      image: jsonSerialization['image'] as String,
      originalPrice: (jsonSerialization['originalPrice'] as num).toDouble(),
      purchasePrice: (jsonSerialization['purchasePrice'] as num?)?.toDouble(),
      salePrice: (jsonSerialization['salePrice'] as num?)?.toDouble(),
      promotionPrice: (jsonSerialization['promotionPrice'] as num?)?.toDouble(),
      inventory: jsonSerialization['inventory'] as int,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
      activityId: jsonSerialization['activityId'] as int?,
      category: jsonSerialization['category'] as String?,
      categoryId: jsonSerialization['categoryId'] as int?,
      status: jsonSerialization['status'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 图书的标题/书名（必填，唯一约束）
  String name;

  /// 图书的ISBN编号，用于唯一标识一本书（唯一约束）
  String? isbn;

  /// 图书的作者姓名
  String author;

  /// 关键字
  String keyword;

  /// 出版社名称
  String publisher;

  /// 图书封面的图片URL地址
  String image;

  /// 图书的原价/定价（必填）
  double originalPrice;

  /// 图书的进货价格
  double? purchasePrice;

  /// 图书的销售价格
  double? salePrice;

  /// 图书的促销价格
  double? promotionPrice;

  /// 图书当前库存数量（默认值：0）
  int inventory;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否已删除（默认值：false）
  bool isDeleted;

  /// 活动ID
  int? activityId;

  /// 图书所属的分类名称
  String? category;

  /// 图书分类的ID，用于关联分类表
  int? categoryId;

  /// 图书状态：0-下架，1-上架
  int? status;

  Book copyWith({
    int? id,
    String? name,
    String? isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    double? originalPrice,
    double? purchasePrice,
    double? salePrice,
    double? promotionPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
    int? activityId,
    String? category,
    int? categoryId,
    int? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (isbn != null) 'isbn': isbn,
      'author': author,
      'keyword': keyword,
      'publisher': publisher,
      'image': image,
      'originalPrice': originalPrice,
      if (purchasePrice != null) 'purchasePrice': purchasePrice,
      if (salePrice != null) 'salePrice': salePrice,
      if (promotionPrice != null) 'promotionPrice': promotionPrice,
      'inventory': inventory,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
      if (activityId != null) 'activityId': activityId,
      if (category != null) 'category': category,
      if (categoryId != null) 'categoryId': categoryId,
      if (status != null) 'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookImpl extends Book {
  _BookImpl({
    int? id,
    required String name,
    String? isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    required double originalPrice,
    double? purchasePrice,
    double? salePrice,
    double? promotionPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
    int? activityId,
    String? category,
    int? categoryId,
    int? status,
  }) : super._(
          id: id,
          name: name,
          isbn: isbn,
          author: author,
          keyword: keyword,
          publisher: publisher,
          image: image,
          originalPrice: originalPrice,
          purchasePrice: purchasePrice,
          salePrice: salePrice,
          promotionPrice: promotionPrice,
          inventory: inventory,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
          activityId: activityId,
          category: category,
          categoryId: categoryId,
          status: status,
        );

  @override
  Book copyWith({
    Object? id = _Undefined,
    String? name,
    Object? isbn = _Undefined,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    double? originalPrice,
    Object? purchasePrice = _Undefined,
    Object? salePrice = _Undefined,
    Object? promotionPrice = _Undefined,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
    Object? activityId = _Undefined,
    Object? category = _Undefined,
    Object? categoryId = _Undefined,
    Object? status = _Undefined,
  }) {
    return Book(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      isbn: isbn is String? ? isbn : this.isbn,
      author: author ?? this.author,
      keyword: keyword ?? this.keyword,
      publisher: publisher ?? this.publisher,
      image: image ?? this.image,
      originalPrice: originalPrice ?? this.originalPrice,
      purchasePrice:
          purchasePrice is double? ? purchasePrice : this.purchasePrice,
      salePrice: salePrice is double? ? salePrice : this.salePrice,
      promotionPrice:
          promotionPrice is double? ? promotionPrice : this.promotionPrice,
      inventory: inventory ?? this.inventory,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
      activityId: activityId is int? ? activityId : this.activityId,
      category: category is String? ? category : this.category,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      status: status is int? ? status : this.status,
    );
  }
}
