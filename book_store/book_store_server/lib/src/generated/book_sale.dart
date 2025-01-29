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

/// 用于存储图书或组合套餐的销售记录信息
abstract class BookSale implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = BookSaleTable();

  static const db = BookSaleRepository._();

  @override
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

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static BookSaleInclude include() {
    return BookSaleInclude._();
  }

  static BookSaleIncludeList includeList({
    _i1.WhereExpressionBuilder<BookSaleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookSaleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookSaleTable>? orderByList,
    BookSaleInclude? include,
  }) {
    return BookSaleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookSale.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BookSale.t),
      include: include,
    );
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

class BookSaleTable extends _i1.Table {
  BookSaleTable({super.tableRelation}) : super(tableName: 'book_sale') {
    saleType = _i1.ColumnInt(
      'saleType',
      this,
    );
    bookPackageId = _i1.ColumnInt(
      'bookPackageId',
      this,
    );
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    salePrice = _i1.ColumnDouble(
      'salePrice',
      this,
    );
    saleTime = _i1.ColumnDateTime(
      'saleTime',
      this,
      hasDefault: true,
    );
    isDeleted = _i1.ColumnBool(
      'isDeleted',
      this,
      hasDefault: true,
    );
  }

  /// 销售类型：0-单本图书，1-组合套餐，2-赠品，3-促销等（可以根据需要扩展）
  late final _i1.ColumnInt saleType;

  /// 组合套餐的ID（如果是组合销售）
  late final _i1.ColumnInt bookPackageId;

  /// 图书的ID（如果是单本销售）
  late final _i1.ColumnInt bookId;

  /// 类别ID（关联图书类别）
  late final _i1.ColumnInt categoryId;

  /// 出售数量
  late final _i1.ColumnInt quantity;

  /// 单本图书价格（单本出售）或套装总价（组合出售）
  late final _i1.ColumnDouble salePrice;

  /// 销售时间
  late final _i1.ColumnDateTime saleTime;

  /// 是否删除
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
        id,
        saleType,
        bookPackageId,
        bookId,
        categoryId,
        quantity,
        salePrice,
        saleTime,
        isDeleted,
      ];
}

class BookSaleInclude extends _i1.IncludeObject {
  BookSaleInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => BookSale.t;
}

class BookSaleIncludeList extends _i1.IncludeList {
  BookSaleIncludeList._({
    _i1.WhereExpressionBuilder<BookSaleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookSale.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => BookSale.t;
}

class BookSaleRepository {
  const BookSaleRepository._();

  Future<List<BookSale>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookSaleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookSaleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookSaleTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<BookSale>(
      where: where?.call(BookSale.t),
      orderBy: orderBy?.call(BookSale.t),
      orderByList: orderByList?.call(BookSale.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<BookSale?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookSaleTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookSaleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookSaleTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<BookSale>(
      where: where?.call(BookSale.t),
      orderBy: orderBy?.call(BookSale.t),
      orderByList: orderByList?.call(BookSale.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<BookSale?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<BookSale>(
      id,
      transaction: transaction,
    );
  }

  Future<List<BookSale>> insert(
    _i1.Session session,
    List<BookSale> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BookSale>(
      rows,
      transaction: transaction,
    );
  }

  Future<BookSale> insertRow(
    _i1.Session session,
    BookSale row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookSale>(
      row,
      transaction: transaction,
    );
  }

  Future<List<BookSale>> update(
    _i1.Session session,
    List<BookSale> rows, {
    _i1.ColumnSelections<BookSaleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BookSale>(
      rows,
      columns: columns?.call(BookSale.t),
      transaction: transaction,
    );
  }

  Future<BookSale> updateRow(
    _i1.Session session,
    BookSale row, {
    _i1.ColumnSelections<BookSaleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookSale>(
      row,
      columns: columns?.call(BookSale.t),
      transaction: transaction,
    );
  }

  Future<List<BookSale>> delete(
    _i1.Session session,
    List<BookSale> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BookSale>(
      rows,
      transaction: transaction,
    );
  }

  Future<BookSale> deleteRow(
    _i1.Session session,
    BookSale row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookSale>(
      row,
      transaction: transaction,
    );
  }

  Future<List<BookSale>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BookSaleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BookSale>(
      where: where(BookSale.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookSaleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BookSale>(
      where: where?.call(BookSale.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
