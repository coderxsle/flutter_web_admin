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
import 'package:serverpod/serverpod.dart' as _is;

/// 店铺销售记录表，用于存储店铺的销售记录
abstract class StoreSalesRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['saleTime']),
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isDeleted']),
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
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreSalesRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    _is.WhereExpressionBuilder<StoreSalesRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreSalesRecordTable>? orderBy,
    _is.OrderByListBuilder<StoreSalesRecordTable>? orderByList,
    StoreSalesRecordInclude? include,
  }) {
    return StoreSalesRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreSalesRecord.t),
      orderByList: orderByList?.call(StoreSalesRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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
    extends _is.UpdateTable<StoreSalesRecordTable> {
  StoreSalesRecordUpdateTable(super.table);

  _is.ColumnValue<int, int> storeId(int value) =>
      _is.ColumnValue(table.storeId, value);

  _is.ColumnValue<int, int> saleType(int value) =>
      _is.ColumnValue(table.saleType, value);

  _is.ColumnValue<int, int> bookId(int value) =>
      _is.ColumnValue(table.bookId, value);

  _is.ColumnValue<int, int> bookPackageId(int value) =>
      _is.ColumnValue(table.bookPackageId, value);

  _is.ColumnValue<int, int> salesCount(int value) =>
      _is.ColumnValue(table.salesCount, value);

  _is.ColumnValue<double, double> salePrice(double value) =>
      _is.ColumnValue(table.salePrice, value);

  _is.ColumnValue<double, double> totalPrice(double value) =>
      _is.ColumnValue(table.totalPrice, value);

  _is.ColumnValue<double, double> discountPrice(double value) =>
      _is.ColumnValue(table.discountPrice, value);

  _is.ColumnValue<double, double> paymentPrice(double value) =>
      _is.ColumnValue(table.paymentPrice, value);

  _is.ColumnValue<int, int> activityId(int value) =>
      _is.ColumnValue(table.activityId, value);

  _is.ColumnValue<DateTime, DateTime> saleTime(DateTime value) =>
      _is.ColumnValue(table.saleTime, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> isDeleted(bool value) =>
      _is.ColumnValue(table.isDeleted, value);
}

class StoreSalesRecordTable extends _is.Table<int?> {
  StoreSalesRecordTable({super.tableRelation})
    : super(tableName: 'store_sales_record') {
    updateTable = StoreSalesRecordUpdateTable(this);
    storeId = _is.ColumnInt('storeId', this);
    saleType = _is.ColumnInt('saleType', this);
    bookId = _is.ColumnInt('bookId', this);
    bookPackageId = _is.ColumnInt('bookPackageId', this);
    salesCount = _is.ColumnInt('salesCount', this);
    salePrice = _is.ColumnDouble('salePrice', this);
    totalPrice = _is.ColumnDouble('totalPrice', this);
    discountPrice = _is.ColumnDouble('discountPrice', this);
    paymentPrice = _is.ColumnDouble('paymentPrice', this);
    activityId = _is.ColumnInt('activityId', this);
    saleTime = _is.ColumnDateTime('saleTime', this, hasDefault: true);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
    isDeleted = _is.ColumnBool('isDeleted', this, hasDefault: true);
  }

  late final StoreSalesRecordUpdateTable updateTable;

  /// 店铺ID（必填）
  late final _is.ColumnInt storeId;

  /// 销售类型：0-单本图书，1-组合套餐，2-赠品，3-促销等（可以根据需要扩展）
  late final _is.ColumnInt saleType;

  /// 书籍ID（如果是单本销售）
  late final _is.ColumnInt bookId;

  /// 组合套餐的ID（如果是组合销售）
  late final _is.ColumnInt bookPackageId;

  /// 销售数量
  late final _is.ColumnInt salesCount;

  /// 销售
  late final _is.ColumnDouble salePrice;

  /// 单本图书价格（单本出售）或套装总价（组合出售）
  late final _is.ColumnDouble totalPrice;

  /// 优惠金额
  late final _is.ColumnDouble discountPrice;

  ///# 实付金额
  late final _is.ColumnDouble paymentPrice;

  /// 参与的活动ID（如果没有活动，`NULL`）
  late final _is.ColumnInt activityId;

  /// 销售时间
  late final _is.ColumnDateTime saleTime;

  /// 记录创建时间
  late final _is.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _is.ColumnDateTime updateTime;

  /// 是否已删除（默认值：false）
  late final _is.ColumnBool isDeleted;

  @override
  List<_is.Column> get columns => [
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

class StoreSalesRecordInclude extends _is.IncludeObject {
  StoreSalesRecordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StoreSalesRecord.t;
}

class StoreSalesRecordIncludeList extends _is.IncludeList {
  StoreSalesRecordIncludeList._({
    _is.WhereExpressionBuilder<StoreSalesRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreSalesRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StoreSalesRecord.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreSalesRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreSalesRecordTable>? orderBy,
    _is.OrderByListBuilder<StoreSalesRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StoreSalesRecord>(
      where: where?.call(StoreSalesRecord.t),
      orderBy: orderBy?.call(StoreSalesRecord.t),
      orderByList: orderByList?.call(StoreSalesRecord.t),
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreSalesRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<StoreSalesRecordTable>? orderBy,
    _is.OrderByListBuilder<StoreSalesRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StoreSalesRecord>(
      where: where?.call(StoreSalesRecord.t),
      orderBy: orderBy?.call(StoreSalesRecord.t),
      orderByList: orderByList?.call(StoreSalesRecord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StoreSalesRecord] by its [id] or null if no such row exists.
  Future<StoreSalesRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreSalesRecord>> insert(
    _is.DatabaseSession session,
    List<StoreSalesRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StoreSalesRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StoreSalesRecord] and returns the inserted row.
  ///
  /// The returned [StoreSalesRecord] will have its `id` field set.
  Future<StoreSalesRecord> insertRow(
    _is.DatabaseSession session,
    StoreSalesRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreSalesRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StoreSalesRecord]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [StoreSalesRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreSalesRecord>> upsert(
    _is.DatabaseSession session,
    List<StoreSalesRecord> rows, {
    required _is.ColumnSelections<StoreSalesRecordTable> conflictColumns,
    _is.ColumnSelections<StoreSalesRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<StoreSalesRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StoreSalesRecord>(
      rows,
      conflictColumns: conflictColumns(StoreSalesRecord.t),
      updateColumns: updateColumns?.call(StoreSalesRecord.t),
      updateWhere: updateWhere?.call(StoreSalesRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StoreSalesRecord] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [StoreSalesRecord] will have its `id` field set.
  Future<StoreSalesRecord?> upsertRow(
    _is.DatabaseSession session,
    StoreSalesRecord row, {
    required _is.ColumnSelections<StoreSalesRecordTable> conflictColumns,
    _is.ColumnSelections<StoreSalesRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<StoreSalesRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StoreSalesRecord>(
      row,
      conflictColumns: conflictColumns(StoreSalesRecord.t),
      updateColumns: updateColumns?.call(StoreSalesRecord.t),
      updateWhere: updateWhere?.call(StoreSalesRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [StoreSalesRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreSalesRecord>> update(
    _is.DatabaseSession session,
    List<StoreSalesRecord> rows, {
    _is.ColumnSelections<StoreSalesRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StoreSalesRecord>(
      rows,
      columns: columns?.call(StoreSalesRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StoreSalesRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreSalesRecord> updateRow(
    _is.DatabaseSession session,
    StoreSalesRecord row, {
    _is.ColumnSelections<StoreSalesRecordTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StoreSalesRecordUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreSalesRecord>(
      id,
      columnValues: columnValues(StoreSalesRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreSalesRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreSalesRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StoreSalesRecordUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<StoreSalesRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreSalesRecordTable>? orderBy,
    _is.OrderByListBuilder<StoreSalesRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StoreSalesRecord>(
      columnValues: columnValues(StoreSalesRecord.t.updateTable),
      where: where(StoreSalesRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreSalesRecord.t),
      orderByList: orderByList?.call(StoreSalesRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StoreSalesRecord]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreSalesRecord>> delete(
    _is.DatabaseSession session,
    List<StoreSalesRecord> rows, {
    _is.OrderByBuilder<StoreSalesRecordTable>? orderBy,
    _is.OrderByListBuilder<StoreSalesRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StoreSalesRecord>(
      rows,
      orderBy: orderBy?.call(StoreSalesRecord.t),
      orderByList: orderByList?.call(StoreSalesRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StoreSalesRecord].
  Future<StoreSalesRecord> deleteRow(
    _is.DatabaseSession session,
    StoreSalesRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreSalesRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreSalesRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoreSalesRecordTable> where,
    _is.OrderByBuilder<StoreSalesRecordTable>? orderBy,
    _is.OrderByListBuilder<StoreSalesRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StoreSalesRecord>(
      where: where(StoreSalesRecord.t),
      orderBy: orderBy?.call(StoreSalesRecord.t),
      orderByList: orderByList?.call(StoreSalesRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreSalesRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StoreSalesRecord>(
      where: where?.call(StoreSalesRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StoreSalesRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoreSalesRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StoreSalesRecord>(
      where: where(StoreSalesRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
