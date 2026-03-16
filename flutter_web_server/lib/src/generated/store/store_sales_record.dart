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
import 'package:serverpod/serverpod.dart' as _i1;

/// 店铺销售记录表，用于存储店铺的销售记录
abstract class StoreSalesRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StoreSalesRecord._({
    this.id,
    required this.storeId,
    required this.saleType,
    required this.bookId,
    required this.bookPackageId,
    required this.salesCount,
    required this.salePrice,
    required this.totalPrice,
    required this.discountPrice,
    required this.paymentPrice,
    required this.activityId,
    DateTime? saleTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : saleTime = saleTime ?? DateTime.now(),
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now(),
       isDeleted = isDeleted ?? false;

  factory StoreSalesRecord({
    int? id,
    required int storeId,
    required int saleType,
    required int bookId,
    required int bookPackageId,
    required int salesCount,
    required double salePrice,
    required double totalPrice,
    required double discountPrice,
    required double paymentPrice,
    required int activityId,
    DateTime? saleTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _StoreSalesRecordImpl;

  factory StoreSalesRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreSalesRecord(
      id: jsonSerialization['id'] as int?,
      storeId: jsonSerialization['storeId'] as int,
      saleType: jsonSerialization['saleType'] as int,
      bookId: jsonSerialization['bookId'] as int,
      bookPackageId: jsonSerialization['bookPackageId'] as int,
      salesCount: jsonSerialization['salesCount'] as int,
      salePrice: (jsonSerialization['salePrice'] as num).toDouble(),
      totalPrice: (jsonSerialization['totalPrice'] as num).toDouble(),
      discountPrice: (jsonSerialization['discountPrice'] as num).toDouble(),
      paymentPrice: (jsonSerialization['paymentPrice'] as num).toDouble(),
      activityId: jsonSerialization['activityId'] as int,
      saleTime: jsonSerialization['saleTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['saleTime']),
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isDeleted']),
    );
  }

  static final t = StoreSalesRecordTable();

  static const db = StoreSalesRecordRepository._();

  @override
  int? id;

  /// 店铺ID（必填）
  int storeId;

  /// 销售类型：0-单本图书，1-组合套餐，2-赠品，3-促销等（可以根据需要扩展）
  int saleType;

  /// 书籍ID（如果是单本销售）
  int bookId;

  /// 组合套餐的ID（如果是组合销售）
  int bookPackageId;

  /// 销售数量
  int salesCount;

  /// 销售
  double salePrice;

  /// 单本图书价格（单本出售）或套装总价（组合出售）
  double totalPrice;

  /// 优惠金额
  double discountPrice;

  ///# 实付金额
  double paymentPrice;

  /// 参与的活动ID（如果没有活动，`NULL`）
  int activityId;

  /// 销售时间
  DateTime saleTime;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否已删除（默认值：false）
  bool isDeleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreSalesRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreSalesRecord copyWith({
    int? id,
    int? storeId,
    int? saleType,
    int? bookId,
    int? bookPackageId,
    int? salesCount,
    double? salePrice,
    double? totalPrice,
    double? discountPrice,
    double? paymentPrice,
    int? activityId,
    DateTime? saleTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreSalesRecord',
      if (id != null) 'id': id,
      'storeId': storeId,
      'saleType': saleType,
      'bookId': bookId,
      'bookPackageId': bookPackageId,
      'salesCount': salesCount,
      'salePrice': salePrice,
      'totalPrice': totalPrice,
      'discountPrice': discountPrice,
      'paymentPrice': paymentPrice,
      'activityId': activityId,
      'saleTime': saleTime.toJson(),
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StoreSalesRecord',
      if (id != null) 'id': id,
      'storeId': storeId,
      'saleType': saleType,
      'bookId': bookId,
      'bookPackageId': bookPackageId,
      'salesCount': salesCount,
      'salePrice': salePrice,
      'totalPrice': totalPrice,
      'discountPrice': discountPrice,
      'paymentPrice': paymentPrice,
      'activityId': activityId,
      'saleTime': saleTime.toJson(),
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static StoreSalesRecordInclude include() {
    return StoreSalesRecordInclude._();
  }

  static StoreSalesRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreSalesRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreSalesRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreSalesRecordTable>? orderByList,
    StoreSalesRecordInclude? include,
  }) {
    return StoreSalesRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreSalesRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreSalesRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreSalesRecordImpl extends StoreSalesRecord {
  _StoreSalesRecordImpl({
    int? id,
    required int storeId,
    required int saleType,
    required int bookId,
    required int bookPackageId,
    required int salesCount,
    required double salePrice,
    required double totalPrice,
    required double discountPrice,
    required double paymentPrice,
    required int activityId,
    DateTime? saleTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
         id: id,
         storeId: storeId,
         saleType: saleType,
         bookId: bookId,
         bookPackageId: bookPackageId,
         salesCount: salesCount,
         salePrice: salePrice,
         totalPrice: totalPrice,
         discountPrice: discountPrice,
         paymentPrice: paymentPrice,
         activityId: activityId,
         saleTime: saleTime,
         createTime: createTime,
         updateTime: updateTime,
         isDeleted: isDeleted,
       );

  /// Returns a shallow copy of this [StoreSalesRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreSalesRecord copyWith({
    Object? id = _Undefined,
    int? storeId,
    int? saleType,
    int? bookId,
    int? bookPackageId,
    int? salesCount,
    double? salePrice,
    double? totalPrice,
    double? discountPrice,
    double? paymentPrice,
    int? activityId,
    DateTime? saleTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return StoreSalesRecord(
      id: id is int? ? id : this.id,
      storeId: storeId ?? this.storeId,
      saleType: saleType ?? this.saleType,
      bookId: bookId ?? this.bookId,
      bookPackageId: bookPackageId ?? this.bookPackageId,
      salesCount: salesCount ?? this.salesCount,
      salePrice: salePrice ?? this.salePrice,
      totalPrice: totalPrice ?? this.totalPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      paymentPrice: paymentPrice ?? this.paymentPrice,
      activityId: activityId ?? this.activityId,
      saleTime: saleTime ?? this.saleTime,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class StoreSalesRecordUpdateTable
    extends _i1.UpdateTable<StoreSalesRecordTable> {
  StoreSalesRecordUpdateTable(super.table);

  _i1.ColumnValue<int, int> storeId(int value) => _i1.ColumnValue(
    table.storeId,
    value,
  );

  _i1.ColumnValue<int, int> saleType(int value) => _i1.ColumnValue(
    table.saleType,
    value,
  );

  _i1.ColumnValue<int, int> bookId(int value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<int, int> bookPackageId(int value) => _i1.ColumnValue(
    table.bookPackageId,
    value,
  );

  _i1.ColumnValue<int, int> salesCount(int value) => _i1.ColumnValue(
    table.salesCount,
    value,
  );

  _i1.ColumnValue<double, double> salePrice(double value) => _i1.ColumnValue(
    table.salePrice,
    value,
  );

  _i1.ColumnValue<double, double> totalPrice(double value) => _i1.ColumnValue(
    table.totalPrice,
    value,
  );

  _i1.ColumnValue<double, double> discountPrice(double value) =>
      _i1.ColumnValue(
        table.discountPrice,
        value,
      );

  _i1.ColumnValue<double, double> paymentPrice(double value) => _i1.ColumnValue(
    table.paymentPrice,
    value,
  );

  _i1.ColumnValue<int, int> activityId(int value) => _i1.ColumnValue(
    table.activityId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> saleTime(DateTime value) =>
      _i1.ColumnValue(
        table.saleTime,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _i1.ColumnValue(
        table.createTime,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _i1.ColumnValue(
        table.updateTime,
        value,
      );

  _i1.ColumnValue<bool, bool> isDeleted(bool value) => _i1.ColumnValue(
    table.isDeleted,
    value,
  );
}

class StoreSalesRecordTable extends _i1.Table<int?> {
  StoreSalesRecordTable({super.tableRelation})
    : super(tableName: 'store_sales_record') {
    updateTable = StoreSalesRecordUpdateTable(this);
    storeId = _i1.ColumnInt(
      'storeId',
      this,
    );
    saleType = _i1.ColumnInt(
      'saleType',
      this,
    );
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    bookPackageId = _i1.ColumnInt(
      'bookPackageId',
      this,
    );
    salesCount = _i1.ColumnInt(
      'salesCount',
      this,
    );
    salePrice = _i1.ColumnDouble(
      'salePrice',
      this,
    );
    totalPrice = _i1.ColumnDouble(
      'totalPrice',
      this,
    );
    discountPrice = _i1.ColumnDouble(
      'discountPrice',
      this,
    );
    paymentPrice = _i1.ColumnDouble(
      'paymentPrice',
      this,
    );
    activityId = _i1.ColumnInt(
      'activityId',
      this,
    );
    saleTime = _i1.ColumnDateTime(
      'saleTime',
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

  late final StoreSalesRecordUpdateTable updateTable;

  /// 店铺ID（必填）
  late final _i1.ColumnInt storeId;

  /// 销售类型：0-单本图书，1-组合套餐，2-赠品，3-促销等（可以根据需要扩展）
  late final _i1.ColumnInt saleType;

  /// 书籍ID（如果是单本销售）
  late final _i1.ColumnInt bookId;

  /// 组合套餐的ID（如果是组合销售）
  late final _i1.ColumnInt bookPackageId;

  /// 销售数量
  late final _i1.ColumnInt salesCount;

  /// 销售
  late final _i1.ColumnDouble salePrice;

  /// 单本图书价格（单本出售）或套装总价（组合出售）
  late final _i1.ColumnDouble totalPrice;

  /// 优惠金额
  late final _i1.ColumnDouble discountPrice;

  ///# 实付金额
  late final _i1.ColumnDouble paymentPrice;

  /// 参与的活动ID（如果没有活动，`NULL`）
  late final _i1.ColumnInt activityId;

  /// 销售时间
  late final _i1.ColumnDateTime saleTime;

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
    saleType,
    bookId,
    bookPackageId,
    salesCount,
    salePrice,
    totalPrice,
    discountPrice,
    paymentPrice,
    activityId,
    saleTime,
    createTime,
    updateTime,
    isDeleted,
  ];
}

class StoreSalesRecordInclude extends _i1.IncludeObject {
  StoreSalesRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StoreSalesRecord.t;
}

class StoreSalesRecordIncludeList extends _i1.IncludeList {
  StoreSalesRecordIncludeList._({
    _i1.WhereExpressionBuilder<StoreSalesRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreSalesRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StoreSalesRecord.t;
}

class StoreSalesRecordRepository {
  const StoreSalesRecordRepository._();

  /// Returns a list of [StoreSalesRecord]s matching the given query parameters.
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
  Future<List<StoreSalesRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StoreSalesRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreSalesRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreSalesRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StoreSalesRecord>(
      where: where?.call(StoreSalesRecord.t),
      orderBy: orderBy?.call(StoreSalesRecord.t),
      orderByList: orderByList?.call(StoreSalesRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StoreSalesRecord] matching the given query parameters.
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
  Future<StoreSalesRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StoreSalesRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreSalesRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreSalesRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StoreSalesRecord>(
      where: where?.call(StoreSalesRecord.t),
      orderBy: orderBy?.call(StoreSalesRecord.t),
      orderByList: orderByList?.call(StoreSalesRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StoreSalesRecord] by its [id] or null if no such row exists.
  Future<StoreSalesRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StoreSalesRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StoreSalesRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreSalesRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<StoreSalesRecord>> insert(
    _i1.DatabaseSession session,
    List<StoreSalesRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<StoreSalesRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [StoreSalesRecord] and returns the inserted row.
  ///
  /// The returned [StoreSalesRecord] will have its `id` field set.
  Future<StoreSalesRecord> insertRow(
    _i1.DatabaseSession session,
    StoreSalesRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreSalesRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StoreSalesRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StoreSalesRecord>> update(
    _i1.DatabaseSession session,
    List<StoreSalesRecord> rows, {
    _i1.ColumnSelections<StoreSalesRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreSalesRecord>(
      rows,
      columns: columns?.call(StoreSalesRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreSalesRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreSalesRecord> updateRow(
    _i1.DatabaseSession session,
    StoreSalesRecord row, {
    _i1.ColumnSelections<StoreSalesRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreSalesRecord>(
      row,
      columns: columns?.call(StoreSalesRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreSalesRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreSalesRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<StoreSalesRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreSalesRecord>(
      id,
      columnValues: columnValues(StoreSalesRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreSalesRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StoreSalesRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<StoreSalesRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<StoreSalesRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreSalesRecordTable>? orderBy,
    _i1.OrderByListBuilder<StoreSalesRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StoreSalesRecord>(
      columnValues: columnValues(StoreSalesRecord.t.updateTable),
      where: where(StoreSalesRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreSalesRecord.t),
      orderByList: orderByList?.call(StoreSalesRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StoreSalesRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StoreSalesRecord>> delete(
    _i1.DatabaseSession session,
    List<StoreSalesRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreSalesRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StoreSalesRecord].
  Future<StoreSalesRecord> deleteRow(
    _i1.DatabaseSession session,
    StoreSalesRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreSalesRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StoreSalesRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StoreSalesRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreSalesRecord>(
      where: where(StoreSalesRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StoreSalesRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreSalesRecord>(
      where: where?.call(StoreSalesRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StoreSalesRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StoreSalesRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StoreSalesRecord>(
      where: where(StoreSalesRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
