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

/// 用于存储书籍的销售记录信息
abstract class BookSale
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
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

  static final t = BookSaleTable();

  static const db = BookSaleRepository._();

  @override
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

  @override
  _i1.Table<int> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'bookId': bookId,
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

class BookSaleTable extends _i1.Table<int> {
  BookSaleTable({super.tableRelation}) : super(tableName: 'book_sale') {
    bookId = _i1.ColumnInt(
      'bookId',
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

  /// 图书的ID（如果是单本销售）
  late final _i1.ColumnInt bookId;

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
        bookId,
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
  _i1.Table<int> get table => BookSale.t;
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
  _i1.Table<int> get table => BookSale.t;
}

class BookSaleRepository {
  const BookSaleRepository._();

  /// Returns a list of [BookSale]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
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

  /// Returns the first matching [BookSale] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
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

  /// Finds a single [BookSale] by its [id] or null if no such row exists.
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

  /// Inserts all [BookSale]s in the list and returns the inserted rows.
  ///
  /// The returned [BookSale]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
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

  /// Inserts a single [BookSale] and returns the inserted row.
  ///
  /// The returned [BookSale] will have its `id` field set.
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

  /// Updates all [BookSale]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
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

  /// Updates a single [BookSale]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
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

  /// Deletes all [BookSale]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
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

  /// Deletes a single [BookSale].
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

  /// Deletes all rows matching the [where] expression.
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

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
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
