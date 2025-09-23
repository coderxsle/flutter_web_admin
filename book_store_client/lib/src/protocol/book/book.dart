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

/// 书籍基本信息表，用于存储书籍的基本信息
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
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
    this.categoryId,
  })  : author = author ?? '',
        keyword = keyword ?? '',
        publisher = publisher ?? '',
        image = image ?? '',
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
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
    int? categoryId,
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
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
      categoryId: jsonSerialization['categoryId'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 书籍的标题/书名（必填，唯一约束）
  String name;

  /// 书籍的ISBN编号，用于唯一标识一本书（唯一约束）
  String? isbn;

  /// 书籍的作者姓名
  String author;

  /// 关键字
  String keyword;

  /// 出版社名称
  String publisher;

  /// 书籍封面的图片URL地址
  String image;

  /// 书籍的原价/定价（必填）
  double originalPrice;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否已删除（默认值：false）
  bool isDeleted;

  /// 书籍分类的ID，用于关联分类表
  int? categoryId;

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Book copyWith({
    int? id,
    String? name,
    String? isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    double? originalPrice,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
    int? categoryId,
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
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
      if (categoryId != null) 'categoryId': categoryId,
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
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
    int? categoryId,
  }) : super._(
          id: id,
          name: name,
          isbn: isbn,
          author: author,
          keyword: keyword,
          publisher: publisher,
          image: image,
          originalPrice: originalPrice,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
          categoryId: categoryId,
        );

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
    Object? categoryId = _Undefined,
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
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
    );
  }
}
