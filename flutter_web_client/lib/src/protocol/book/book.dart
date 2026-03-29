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
    int? tenantId,
    this.categoryId,
    required this.name,
    this.isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    required this.originalPrice,
    bool? isDeleted,
    DateTime? createTime,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       author = author ?? '',
       keyword = keyword ?? '',
       publisher = publisher ?? '',
       image = image ?? '',
       isDeleted = isDeleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory Book({
    int? id,
    int? tenantId,
    int? categoryId,
    required String name,
    String? isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    required double originalPrice,
    bool? isDeleted,
    DateTime? createTime,
    DateTime? updateTime,
  }) = _BookImpl;

  factory Book.fromJson(Map<String, dynamic> jsonSerialization) {
    return Book(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      categoryId: jsonSerialization['categoryId'] as int?,
      name: jsonSerialization['name'] as String,
      isbn: jsonSerialization['isbn'] as String?,
      author: jsonSerialization['author'] as String?,
      keyword: jsonSerialization['keyword'] as String?,
      publisher: jsonSerialization['publisher'] as String?,
      image: jsonSerialization['image'] as String?,
      originalPrice: (jsonSerialization['originalPrice'] as num).toDouble(),
      isDeleted: jsonSerialization['isDeleted'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isDeleted']),
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 租户ID（0 表示系统租户）
  int? tenantId;

  /// 书籍分类的ID，用于关联分类表
  int? categoryId;

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

  bool isDeleted;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Book copyWith({
    int? id,
    int? tenantId,
    int? categoryId,
    String? name,
    String? isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    double? originalPrice,
    bool? isDeleted,
    DateTime? createTime,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Book',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      if (categoryId != null) 'categoryId': categoryId,
      'name': name,
      if (isbn != null) 'isbn': isbn,
      'author': author,
      'keyword': keyword,
      'publisher': publisher,
      'image': image,
      'originalPrice': originalPrice,
      'isDeleted': isDeleted,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
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
    int? tenantId,
    int? categoryId,
    required String name,
    String? isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    required double originalPrice,
    bool? isDeleted,
    DateTime? createTime,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         categoryId: categoryId,
         name: name,
         isbn: isbn,
         author: author,
         keyword: keyword,
         publisher: publisher,
         image: image,
         originalPrice: originalPrice,
         isDeleted: isDeleted,
         createTime: createTime,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Book copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    Object? categoryId = _Undefined,
    String? name,
    Object? isbn = _Undefined,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    double? originalPrice,
    bool? isDeleted,
    DateTime? createTime,
    DateTime? updateTime,
  }) {
    return Book(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      name: name ?? this.name,
      isbn: isbn is String? ? isbn : this.isbn,
      author: author ?? this.author,
      keyword: keyword ?? this.keyword,
      publisher: publisher ?? this.publisher,
      image: image ?? this.image,
      originalPrice: originalPrice ?? this.originalPrice,
      isDeleted: isDeleted ?? this.isDeleted,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}
