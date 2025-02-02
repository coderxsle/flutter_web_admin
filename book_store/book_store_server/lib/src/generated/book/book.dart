/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// 图书信息模型，用于存储图书的基本信息
abstract class Book implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = BookTable();

  static const db = BookRepository._();

  @override
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

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static BookInclude include() {
    return BookInclude._();
  }

  static BookIncludeList includeList({
    _i1.WhereExpressionBuilder<BookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookTable>? orderByList,
    BookInclude? include,
  }) {
    return BookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Book.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Book.t),
      include: include,
    );
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

class BookTable extends _i1.Table {
  BookTable({super.tableRelation}) : super(tableName: 'book') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    isbn = _i1.ColumnString(
      'isbn',
      this,
    );
    author = _i1.ColumnString(
      'author',
      this,
      hasDefault: true,
    );
    keyword = _i1.ColumnString(
      'keyword',
      this,
      hasDefault: true,
    );
    publisher = _i1.ColumnString(
      'publisher',
      this,
      hasDefault: true,
    );
    image = _i1.ColumnString(
      'image',
      this,
      hasDefault: true,
    );
    originalPrice = _i1.ColumnDouble(
      'originalPrice',
      this,
    );
    purchasePrice = _i1.ColumnDouble(
      'purchasePrice',
      this,
    );
    salePrice = _i1.ColumnDouble(
      'salePrice',
      this,
    );
    promotionPrice = _i1.ColumnDouble(
      'promotionPrice',
      this,
    );
    inventory = _i1.ColumnInt(
      'inventory',
      this,
      hasDefault: true,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
      hasDefault: true,
    );
    updateTime = _i1.ColumnDateTime(
      'updateTime',
      this,
      hasDefault: true,
    );
    isDeleted = _i1.ColumnBool(
      'isDeleted',
      this,
      hasDefault: true,
    );
    activityId = _i1.ColumnInt(
      'activityId',
      this,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
    );
  }

  /// 图书的标题/书名（必填，唯一约束）
  late final _i1.ColumnString name;

  /// 图书的ISBN编号，用于唯一标识一本书（唯一约束）
  late final _i1.ColumnString isbn;

  /// 图书的作者姓名
  late final _i1.ColumnString author;

  /// 关键字
  late final _i1.ColumnString keyword;

  /// 出版社名称
  late final _i1.ColumnString publisher;

  /// 图书封面的图片URL地址
  late final _i1.ColumnString image;

  /// 图书的原价/定价（必填）
  late final _i1.ColumnDouble originalPrice;

  /// 图书的进货价格
  late final _i1.ColumnDouble purchasePrice;

  /// 图书的销售价格
  late final _i1.ColumnDouble salePrice;

  /// 图书的促销价格
  late final _i1.ColumnDouble promotionPrice;

  /// 图书当前库存数量（默认值：0）
  late final _i1.ColumnInt inventory;

  /// 记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  /// 是否已删除（默认值：false）
  late final _i1.ColumnBool isDeleted;

  /// 活动ID
  late final _i1.ColumnInt activityId;

  /// 图书所属的分类名称
  late final _i1.ColumnString category;

  /// 图书分类的ID，用于关联分类表
  late final _i1.ColumnInt categoryId;

  /// 图书状态：0-下架，1-上架
  late final _i1.ColumnInt status;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        isbn,
        author,
        keyword,
        publisher,
        image,
        originalPrice,
        purchasePrice,
        salePrice,
        promotionPrice,
        inventory,
        createTime,
        updateTime,
        isDeleted,
        activityId,
        category,
        categoryId,
        status,
      ];
}

class BookInclude extends _i1.IncludeObject {
  BookInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Book.t;
}

class BookIncludeList extends _i1.IncludeList {
  BookIncludeList._({
    _i1.WhereExpressionBuilder<BookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Book.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Book.t;
}

class BookRepository {
  const BookRepository._();

  Future<List<Book>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Book>(
      where: where?.call(Book.t),
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Book?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Book>(
      where: where?.call(Book.t),
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Book?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Book>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Book>> insert(
    _i1.Session session,
    List<Book> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Book>(
      rows,
      transaction: transaction,
    );
  }

  Future<Book> insertRow(
    _i1.Session session,
    Book row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Book>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Book>> update(
    _i1.Session session,
    List<Book> rows, {
    _i1.ColumnSelections<BookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Book>(
      rows,
      columns: columns?.call(Book.t),
      transaction: transaction,
    );
  }

  Future<Book> updateRow(
    _i1.Session session,
    Book row, {
    _i1.ColumnSelections<BookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Book>(
      row,
      columns: columns?.call(Book.t),
      transaction: transaction,
    );
  }

  Future<List<Book>> delete(
    _i1.Session session,
    List<Book> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Book>(
      rows,
      transaction: transaction,
    );
  }

  Future<Book> deleteRow(
    _i1.Session session,
    Book row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Book>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Book>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BookTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Book>(
      where: where(Book.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Book>(
      where: where?.call(Book.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
