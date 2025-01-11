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
    this.isbn,
    required this.title,
    this.image,
    this.author,
    this.category,
    this.categoryId,
    this.status,
    this.publisher,
    this.purchasePrice,
    this.salePrice,
    this.stock,
    this.createTime,
    this.updatedTime,
  });

  factory Book({
    int? id,
    String? isbn,
    required String title,
    String? image,
    String? author,
    String? category,
    int? categoryId,
    int? status,
    String? publisher,
    double? purchasePrice,
    double? salePrice,
    int? stock,
    DateTime? createTime,
    DateTime? updatedTime,
  }) = _BookImpl;

  factory Book.fromJson(Map<String, dynamic> jsonSerialization) {
    return Book(
      id: jsonSerialization['id'] as int?,
      isbn: jsonSerialization['isbn'] as String?,
      title: jsonSerialization['title'] as String,
      image: jsonSerialization['image'] as String?,
      author: jsonSerialization['author'] as String?,
      category: jsonSerialization['category'] as String?,
      categoryId: jsonSerialization['categoryId'] as int?,
      status: jsonSerialization['status'] as int?,
      publisher: jsonSerialization['publisher'] as String?,
      purchasePrice: (jsonSerialization['purchasePrice'] as num?)?.toDouble(),
      salePrice: (jsonSerialization['salePrice'] as num?)?.toDouble(),
      stock: jsonSerialization['stock'] as int?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updatedTime: jsonSerialization['updatedTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['updatedTime']),
    );
  }

  static final t = BookTable();

  static const db = BookRepository._();

  @override
  int? id;

  /// 图书的ISBN编号，用于唯一标识一本书
  String? isbn;

  /// 图书的标题/书名（必填）
  String title;

  /// 图书封面的图片URL地址
  String? image;

  /// 图书的作者姓名
  String? author;

  /// 图书所属的分类名称
  String? category;

  /// 图书分类的ID，用于关联分类表
  int? categoryId;

  /// 图书状态：0-下架，1-上架
  int? status;

  /// 出版社名称
  String? publisher;

  /// 图书的进货价格
  double? purchasePrice;

  /// 图书的销售价格
  double? salePrice;

  /// 图书当前库存数量
  int? stock;

  /// 记录创建时间
  DateTime? createTime;

  /// 记录最后更新时间
  DateTime? updatedTime;

  @override
  _i1.Table get table => t;

  Book copyWith({
    int? id,
    String? isbn,
    String? title,
    String? image,
    String? author,
    String? category,
    int? categoryId,
    int? status,
    String? publisher,
    double? purchasePrice,
    double? salePrice,
    int? stock,
    DateTime? createTime,
    DateTime? updatedTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (isbn != null) 'isbn': isbn,
      'title': title,
      if (image != null) 'image': image,
      if (author != null) 'author': author,
      if (category != null) 'category': category,
      if (categoryId != null) 'categoryId': categoryId,
      if (status != null) 'status': status,
      if (publisher != null) 'publisher': publisher,
      if (purchasePrice != null) 'purchasePrice': purchasePrice,
      if (salePrice != null) 'salePrice': salePrice,
      if (stock != null) 'stock': stock,
      if (createTime != null) 'createTime': createTime?.toJson(),
      if (updatedTime != null) 'updatedTime': updatedTime?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (isbn != null) 'isbn': isbn,
      'title': title,
      if (image != null) 'image': image,
      if (author != null) 'author': author,
      if (category != null) 'category': category,
      if (categoryId != null) 'categoryId': categoryId,
      if (status != null) 'status': status,
      if (publisher != null) 'publisher': publisher,
      if (purchasePrice != null) 'purchasePrice': purchasePrice,
      if (salePrice != null) 'salePrice': salePrice,
      if (stock != null) 'stock': stock,
      if (createTime != null) 'createTime': createTime?.toJson(),
      if (updatedTime != null) 'updatedTime': updatedTime?.toJson(),
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
    String? isbn,
    required String title,
    String? image,
    String? author,
    String? category,
    int? categoryId,
    int? status,
    String? publisher,
    double? purchasePrice,
    double? salePrice,
    int? stock,
    DateTime? createTime,
    DateTime? updatedTime,
  }) : super._(
          id: id,
          isbn: isbn,
          title: title,
          image: image,
          author: author,
          category: category,
          categoryId: categoryId,
          status: status,
          publisher: publisher,
          purchasePrice: purchasePrice,
          salePrice: salePrice,
          stock: stock,
          createTime: createTime,
          updatedTime: updatedTime,
        );

  @override
  Book copyWith({
    Object? id = _Undefined,
    Object? isbn = _Undefined,
    String? title,
    Object? image = _Undefined,
    Object? author = _Undefined,
    Object? category = _Undefined,
    Object? categoryId = _Undefined,
    Object? status = _Undefined,
    Object? publisher = _Undefined,
    Object? purchasePrice = _Undefined,
    Object? salePrice = _Undefined,
    Object? stock = _Undefined,
    Object? createTime = _Undefined,
    Object? updatedTime = _Undefined,
  }) {
    return Book(
      id: id is int? ? id : this.id,
      isbn: isbn is String? ? isbn : this.isbn,
      title: title ?? this.title,
      image: image is String? ? image : this.image,
      author: author is String? ? author : this.author,
      category: category is String? ? category : this.category,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      status: status is int? ? status : this.status,
      publisher: publisher is String? ? publisher : this.publisher,
      purchasePrice:
          purchasePrice is double? ? purchasePrice : this.purchasePrice,
      salePrice: salePrice is double? ? salePrice : this.salePrice,
      stock: stock is int? ? stock : this.stock,
      createTime: createTime is DateTime? ? createTime : this.createTime,
      updatedTime: updatedTime is DateTime? ? updatedTime : this.updatedTime,
    );
  }
}

class BookTable extends _i1.Table {
  BookTable({super.tableRelation}) : super(tableName: 'book') {
    isbn = _i1.ColumnString(
      'isbn',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    image = _i1.ColumnString(
      'image',
      this,
    );
    author = _i1.ColumnString(
      'author',
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
    publisher = _i1.ColumnString(
      'publisher',
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
    stock = _i1.ColumnInt(
      'stock',
      this,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
    );
    updatedTime = _i1.ColumnDateTime(
      'updatedTime',
      this,
    );
  }

  /// 图书的ISBN编号，用于唯一标识一本书
  late final _i1.ColumnString isbn;

  /// 图书的标题/书名（必填）
  late final _i1.ColumnString title;

  /// 图书封面的图片URL地址
  late final _i1.ColumnString image;

  /// 图书的作者姓名
  late final _i1.ColumnString author;

  /// 图书所属的分类名称
  late final _i1.ColumnString category;

  /// 图书分类的ID，用于关联分类表
  late final _i1.ColumnInt categoryId;

  /// 图书状态：0-下架，1-上架
  late final _i1.ColumnInt status;

  /// 出版社名称
  late final _i1.ColumnString publisher;

  /// 图书的进货价格
  late final _i1.ColumnDouble purchasePrice;

  /// 图书的销售价格
  late final _i1.ColumnDouble salePrice;

  /// 图书当前库存数量
  late final _i1.ColumnInt stock;

  /// 记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _i1.ColumnDateTime updatedTime;

  @override
  List<_i1.Column> get columns => [
        id,
        isbn,
        title,
        image,
        author,
        category,
        categoryId,
        status,
        publisher,
        purchasePrice,
        salePrice,
        stock,
        createTime,
        updatedTime,
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
