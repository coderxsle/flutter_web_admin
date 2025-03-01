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

/// 店铺图书关联表，用于存储店铺和图书的关联关系
abstract class StoreBook implements _i1.TableRow, _i1.ProtocolSerialization {
  StoreBook._({
    this.id,
    required this.storeId,
    required this.bookId,
    required this.purchasePrice,
    required this.salePrice,
    required this.discountPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : inventory = inventory ?? 0,
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory StoreBook({
    int? id,
    required int storeId,
    required int bookId,
    required double purchasePrice,
    required double salePrice,
    required double discountPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _StoreBookImpl;

  factory StoreBook.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreBook(
      id: jsonSerialization['id'] as int?,
      storeId: jsonSerialization['storeId'] as int,
      bookId: jsonSerialization['bookId'] as int,
      purchasePrice: (jsonSerialization['purchasePrice'] as num).toDouble(),
      salePrice: (jsonSerialization['salePrice'] as num).toDouble(),
      discountPrice: (jsonSerialization['discountPrice'] as num).toDouble(),
      inventory: jsonSerialization['inventory'] as int,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = StoreBookTable();

  static const db = StoreBookRepository._();

  @override
  int? id;

  /// 店铺ID
  int storeId;

  /// 图书ID
  int bookId;

  /// 进价
  double purchasePrice;

  /// 售价
  double salePrice;

  /// 优惠价
  double discountPrice;

  /// 库存
  int inventory;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否已删除（默认值：false）
  bool isDeleted;

  @override
  _i1.Table get table => t;

  StoreBook copyWith({
    int? id,
    int? storeId,
    int? bookId,
    double? purchasePrice,
    double? salePrice,
    double? discountPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'storeId': storeId,
      'bookId': bookId,
      'purchasePrice': purchasePrice,
      'salePrice': salePrice,
      'discountPrice': discountPrice,
      'inventory': inventory,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'storeId': storeId,
      'bookId': bookId,
      'purchasePrice': purchasePrice,
      'salePrice': salePrice,
      'discountPrice': discountPrice,
      'inventory': inventory,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static StoreBookInclude include() {
    return StoreBookInclude._();
  }

  static StoreBookIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreBookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreBookTable>? orderByList,
    StoreBookInclude? include,
  }) {
    return StoreBookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreBook.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreBook.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreBookImpl extends StoreBook {
  _StoreBookImpl({
    int? id,
    required int storeId,
    required int bookId,
    required double purchasePrice,
    required double salePrice,
    required double discountPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          storeId: storeId,
          bookId: bookId,
          purchasePrice: purchasePrice,
          salePrice: salePrice,
          discountPrice: discountPrice,
          inventory: inventory,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  StoreBook copyWith({
    Object? id = _Undefined,
    int? storeId,
    int? bookId,
    double? purchasePrice,
    double? salePrice,
    double? discountPrice,
    int? inventory,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return StoreBook(
      id: id is int? ? id : this.id,
      storeId: storeId ?? this.storeId,
      bookId: bookId ?? this.bookId,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      salePrice: salePrice ?? this.salePrice,
      discountPrice: discountPrice ?? this.discountPrice,
      inventory: inventory ?? this.inventory,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class StoreBookTable extends _i1.Table {
  StoreBookTable({super.tableRelation}) : super(tableName: 'store_book') {
    storeId = _i1.ColumnInt(
      'storeId',
      this,
    );
    bookId = _i1.ColumnInt(
      'bookId',
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
    discountPrice = _i1.ColumnDouble(
      'discountPrice',
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
  }

  /// 店铺ID
  late final _i1.ColumnInt storeId;

  /// 图书ID
  late final _i1.ColumnInt bookId;

  /// 进价
  late final _i1.ColumnDouble purchasePrice;

  /// 售价
  late final _i1.ColumnDouble salePrice;

  /// 优惠价
  late final _i1.ColumnDouble discountPrice;

  /// 库存
  late final _i1.ColumnInt inventory;

  /// 记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  /// 是否已删除（默认值：false）
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
        id,
        storeId,
        bookId,
        purchasePrice,
        salePrice,
        discountPrice,
        inventory,
        createTime,
        updateTime,
        isDeleted,
      ];
}

class StoreBookInclude extends _i1.IncludeObject {
  StoreBookInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => StoreBook.t;
}

class StoreBookIncludeList extends _i1.IncludeList {
  StoreBookIncludeList._({
    _i1.WhereExpressionBuilder<StoreBookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreBook.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => StoreBook.t;
}

class StoreBookRepository {
  const StoreBookRepository._();

  Future<List<StoreBook>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreBookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreBookTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreBook>(
      where: where?.call(StoreBook.t),
      orderBy: orderBy?.call(StoreBook.t),
      orderByList: orderByList?.call(StoreBook.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<StoreBook?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreBookTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreBookTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreBook>(
      where: where?.call(StoreBook.t),
      orderBy: orderBy?.call(StoreBook.t),
      orderByList: orderByList?.call(StoreBook.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<StoreBook?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreBook>(
      id,
      transaction: transaction,
    );
  }

  Future<List<StoreBook>> insert(
    _i1.Session session,
    List<StoreBook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreBook>(
      rows,
      transaction: transaction,
    );
  }

  Future<StoreBook> insertRow(
    _i1.Session session,
    StoreBook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreBook>(
      row,
      transaction: transaction,
    );
  }

  Future<List<StoreBook>> update(
    _i1.Session session,
    List<StoreBook> rows, {
    _i1.ColumnSelections<StoreBookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreBook>(
      rows,
      columns: columns?.call(StoreBook.t),
      transaction: transaction,
    );
  }

  Future<StoreBook> updateRow(
    _i1.Session session,
    StoreBook row, {
    _i1.ColumnSelections<StoreBookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreBook>(
      row,
      columns: columns?.call(StoreBook.t),
      transaction: transaction,
    );
  }

  Future<List<StoreBook>> delete(
    _i1.Session session,
    List<StoreBook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreBook>(
      rows,
      transaction: transaction,
    );
  }

  Future<StoreBook> deleteRow(
    _i1.Session session,
    StoreBook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreBook>(
      row,
      transaction: transaction,
    );
  }

  Future<List<StoreBook>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreBookTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreBook>(
      where: where(StoreBook.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreBookTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreBook>(
      where: where?.call(StoreBook.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
