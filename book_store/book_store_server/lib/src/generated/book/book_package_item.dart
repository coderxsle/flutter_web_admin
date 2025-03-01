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

/// 用于存储每个书籍套装中包含的书籍信息
abstract class BookPackageItem
    implements _i1.TableRow, _i1.ProtocolSerialization {
  BookPackageItem._({
    this.id,
    required this.bookId,
    required this.packageId,
    int? quantity,
    required this.packagePrice,
    required this.originalPrice,
    double? discountRate,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : quantity = quantity ?? 1,
        discountRate = discountRate ?? 1.0,
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory BookPackageItem({
    int? id,
    required int bookId,
    required int packageId,
    int? quantity,
    required double packagePrice,
    required double originalPrice,
    double? discountRate,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _BookPackageItemImpl;

  factory BookPackageItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookPackageItem(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      packageId: jsonSerialization['packageId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      packagePrice: (jsonSerialization['packagePrice'] as num).toDouble(),
      originalPrice: (jsonSerialization['originalPrice'] as num).toDouble(),
      discountRate: (jsonSerialization['discountRate'] as num).toDouble(),
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = BookPackageItemTable();

  static const db = BookPackageItemRepository._();

  @override
  int? id;

  /// 关联的书籍ID
  int bookId;

  /// 关联的套餐ID
  int packageId;

  /// 此书籍在套餐中的数量
  int quantity;

  /// 此书籍在套餐中的单价（可能与原价不同）
  double packagePrice;

  /// 此书籍的原价（冗余存储，便于历史查询）
  double originalPrice;

  /// 单品折扣率
  double discountRate;

  /// 套餐明细记录创建时间
  DateTime createTime;

  /// 套餐明细记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  @override
  _i1.Table get table => t;

  BookPackageItem copyWith({
    int? id,
    int? bookId,
    int? packageId,
    int? quantity,
    double? packagePrice,
    double? originalPrice,
    double? discountRate,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'bookId': bookId,
      'packageId': packageId,
      'quantity': quantity,
      'packagePrice': packagePrice,
      'originalPrice': originalPrice,
      'discountRate': discountRate,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'bookId': bookId,
      'packageId': packageId,
      'quantity': quantity,
      'packagePrice': packagePrice,
      'originalPrice': originalPrice,
      'discountRate': discountRate,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static BookPackageItemInclude include() {
    return BookPackageItemInclude._();
  }

  static BookPackageItemIncludeList includeList({
    _i1.WhereExpressionBuilder<BookPackageItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookPackageItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookPackageItemTable>? orderByList,
    BookPackageItemInclude? include,
  }) {
    return BookPackageItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookPackageItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BookPackageItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookPackageItemImpl extends BookPackageItem {
  _BookPackageItemImpl({
    int? id,
    required int bookId,
    required int packageId,
    int? quantity,
    required double packagePrice,
    required double originalPrice,
    double? discountRate,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          bookId: bookId,
          packageId: packageId,
          quantity: quantity,
          packagePrice: packagePrice,
          originalPrice: originalPrice,
          discountRate: discountRate,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  BookPackageItem copyWith({
    Object? id = _Undefined,
    int? bookId,
    int? packageId,
    int? quantity,
    double? packagePrice,
    double? originalPrice,
    double? discountRate,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return BookPackageItem(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      packageId: packageId ?? this.packageId,
      quantity: quantity ?? this.quantity,
      packagePrice: packagePrice ?? this.packagePrice,
      originalPrice: originalPrice ?? this.originalPrice,
      discountRate: discountRate ?? this.discountRate,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class BookPackageItemTable extends _i1.Table {
  BookPackageItemTable({super.tableRelation})
      : super(tableName: 'book_package_item') {
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    packageId = _i1.ColumnInt(
      'packageId',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
      hasDefault: true,
    );
    packagePrice = _i1.ColumnDouble(
      'packagePrice',
      this,
    );
    originalPrice = _i1.ColumnDouble(
      'originalPrice',
      this,
    );
    discountRate = _i1.ColumnDouble(
      'discountRate',
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
  }

  /// 关联的书籍ID
  late final _i1.ColumnInt bookId;

  /// 关联的套餐ID
  late final _i1.ColumnInt packageId;

  /// 此书籍在套餐中的数量
  late final _i1.ColumnInt quantity;

  /// 此书籍在套餐中的单价（可能与原价不同）
  late final _i1.ColumnDouble packagePrice;

  /// 此书籍的原价（冗余存储，便于历史查询）
  late final _i1.ColumnDouble originalPrice;

  /// 单品折扣率
  late final _i1.ColumnDouble discountRate;

  /// 套餐明细记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 套餐明细记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  /// 是否删除
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
        id,
        bookId,
        packageId,
        quantity,
        packagePrice,
        originalPrice,
        discountRate,
        createTime,
        updateTime,
        isDeleted,
      ];
}

class BookPackageItemInclude extends _i1.IncludeObject {
  BookPackageItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => BookPackageItem.t;
}

class BookPackageItemIncludeList extends _i1.IncludeList {
  BookPackageItemIncludeList._({
    _i1.WhereExpressionBuilder<BookPackageItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookPackageItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => BookPackageItem.t;
}

class BookPackageItemRepository {
  const BookPackageItemRepository._();

  Future<List<BookPackageItem>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookPackageItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookPackageItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookPackageItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<BookPackageItem>(
      where: where?.call(BookPackageItem.t),
      orderBy: orderBy?.call(BookPackageItem.t),
      orderByList: orderByList?.call(BookPackageItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<BookPackageItem?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookPackageItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookPackageItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookPackageItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<BookPackageItem>(
      where: where?.call(BookPackageItem.t),
      orderBy: orderBy?.call(BookPackageItem.t),
      orderByList: orderByList?.call(BookPackageItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<BookPackageItem?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<BookPackageItem>(
      id,
      transaction: transaction,
    );
  }

  Future<List<BookPackageItem>> insert(
    _i1.Session session,
    List<BookPackageItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BookPackageItem>(
      rows,
      transaction: transaction,
    );
  }

  Future<BookPackageItem> insertRow(
    _i1.Session session,
    BookPackageItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookPackageItem>(
      row,
      transaction: transaction,
    );
  }

  Future<List<BookPackageItem>> update(
    _i1.Session session,
    List<BookPackageItem> rows, {
    _i1.ColumnSelections<BookPackageItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BookPackageItem>(
      rows,
      columns: columns?.call(BookPackageItem.t),
      transaction: transaction,
    );
  }

  Future<BookPackageItem> updateRow(
    _i1.Session session,
    BookPackageItem row, {
    _i1.ColumnSelections<BookPackageItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookPackageItem>(
      row,
      columns: columns?.call(BookPackageItem.t),
      transaction: transaction,
    );
  }

  Future<List<BookPackageItem>> delete(
    _i1.Session session,
    List<BookPackageItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BookPackageItem>(
      rows,
      transaction: transaction,
    );
  }

  Future<BookPackageItem> deleteRow(
    _i1.Session session,
    BookPackageItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookPackageItem>(
      row,
      transaction: transaction,
    );
  }

  Future<List<BookPackageItem>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BookPackageItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BookPackageItem>(
      where: where(BookPackageItem.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookPackageItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BookPackageItem>(
      where: where?.call(BookPackageItem.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
