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

abstract class StoreActivityBook
    implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = StoreActivityBookTable();

  static const db = StoreActivityBookRepository._();

  @override
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

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static StoreActivityBookInclude include() {
    return StoreActivityBookInclude._();
  }

  static StoreActivityBookIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreActivityBookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreActivityBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreActivityBookTable>? orderByList,
    StoreActivityBookInclude? include,
  }) {
    return StoreActivityBookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreActivityBook.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreActivityBook.t),
      include: include,
    );
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

class StoreActivityBookTable extends _i1.Table {
  StoreActivityBookTable({super.tableRelation})
      : super(tableName: 'store_activity_book') {
    storeId = _i1.ColumnInt(
      'storeId',
      this,
    );
    activityId = _i1.ColumnInt(
      'activityId',
      this,
    );
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    discountPrice = _i1.ColumnDouble(
      'discountPrice',
      this,
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

  /// 活动ID
  late final _i1.ColumnInt activityId;

  /// 书籍ID
  late final _i1.ColumnInt bookId;

  /// 活动促销价
  late final _i1.ColumnDouble discountPrice;

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
        activityId,
        bookId,
        discountPrice,
        createTime,
        updateTime,
        isDeleted,
      ];
}

class StoreActivityBookInclude extends _i1.IncludeObject {
  StoreActivityBookInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => StoreActivityBook.t;
}

class StoreActivityBookIncludeList extends _i1.IncludeList {
  StoreActivityBookIncludeList._({
    _i1.WhereExpressionBuilder<StoreActivityBookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreActivityBook.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => StoreActivityBook.t;
}

class StoreActivityBookRepository {
  const StoreActivityBookRepository._();

  Future<List<StoreActivityBook>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreActivityBookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreActivityBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreActivityBookTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreActivityBook>(
      where: where?.call(StoreActivityBook.t),
      orderBy: orderBy?.call(StoreActivityBook.t),
      orderByList: orderByList?.call(StoreActivityBook.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<StoreActivityBook?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreActivityBookTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreActivityBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreActivityBookTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreActivityBook>(
      where: where?.call(StoreActivityBook.t),
      orderBy: orderBy?.call(StoreActivityBook.t),
      orderByList: orderByList?.call(StoreActivityBook.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<StoreActivityBook?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreActivityBook>(
      id,
      transaction: transaction,
    );
  }

  Future<List<StoreActivityBook>> insert(
    _i1.Session session,
    List<StoreActivityBook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreActivityBook>(
      rows,
      transaction: transaction,
    );
  }

  Future<StoreActivityBook> insertRow(
    _i1.Session session,
    StoreActivityBook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreActivityBook>(
      row,
      transaction: transaction,
    );
  }

  Future<List<StoreActivityBook>> update(
    _i1.Session session,
    List<StoreActivityBook> rows, {
    _i1.ColumnSelections<StoreActivityBookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreActivityBook>(
      rows,
      columns: columns?.call(StoreActivityBook.t),
      transaction: transaction,
    );
  }

  Future<StoreActivityBook> updateRow(
    _i1.Session session,
    StoreActivityBook row, {
    _i1.ColumnSelections<StoreActivityBookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreActivityBook>(
      row,
      columns: columns?.call(StoreActivityBook.t),
      transaction: transaction,
    );
  }

  Future<List<StoreActivityBook>> delete(
    _i1.Session session,
    List<StoreActivityBook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreActivityBook>(
      rows,
      transaction: transaction,
    );
  }

  Future<StoreActivityBook> deleteRow(
    _i1.Session session,
    StoreActivityBook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreActivityBook>(
      row,
      transaction: transaction,
    );
  }

  Future<List<StoreActivityBook>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreActivityBookTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreActivityBook>(
      where: where(StoreActivityBook.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreActivityBookTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreActivityBook>(
      where: where?.call(StoreActivityBook.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
