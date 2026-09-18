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

/// 用于存储每个书籍套装中包含的书籍信息
abstract class BookPackageItem
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  BookPackageItem._({
    this.id,
    int? tenantId,
    required this.bookId,
    required this.packageId,
    int? quantity,
    required this.packagePrice,
    required this.originalPrice,
    double? discountRate,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : tenantId = tenantId ?? 0,
       quantity = quantity ?? 1,
       discountRate = discountRate ?? 1.0,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now(),
       isDeleted = isDeleted ?? false;

  factory BookPackageItem({
    int? id,
    int? tenantId,
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
      tenantId: jsonSerialization['tenantId'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      packageId: jsonSerialization['packageId'] as int,
      quantity: jsonSerialization['quantity'] as int?,
      packagePrice: (jsonSerialization['packagePrice'] as num).toDouble(),
      originalPrice: (jsonSerialization['originalPrice'] as num).toDouble(),
      discountRate: (jsonSerialization['discountRate'] as num?)?.toDouble(),
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

  static final t = BookPackageItemTable();

  static const db = BookPackageItemRepository._();

  @override
  int? id;

  /// 租户ID（0 表示系统租户）
  int? tenantId;

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
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookPackageItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookPackageItem copyWith({
    int? id,
    int? tenantId,
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
      '__className__': 'BookPackageItem',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
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
      '__className__': 'BookPackageItem',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
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
    _is.WhereExpressionBuilder<BookPackageItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookPackageItemTable>? orderBy,
    _is.OrderByListBuilder<BookPackageItemTable>? orderByList,
    BookPackageItemInclude? include,
  }) {
    return BookPackageItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookPackageItem.t),
      orderByList: orderByList?.call(BookPackageItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookPackageItemImpl extends BookPackageItem {
  _BookPackageItemImpl({
    int? id,
    int? tenantId,
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
         tenantId: tenantId,
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

  /// Returns a shallow copy of this [BookPackageItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookPackageItem copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
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
      tenantId: tenantId is int? ? tenantId : this.tenantId,
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

class BookPackageItemUpdateTable extends _is.UpdateTable<BookPackageItemTable> {
  BookPackageItemUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int? value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> bookId(int value) =>
      _is.ColumnValue(table.bookId, value);

  _is.ColumnValue<int, int> packageId(int value) =>
      _is.ColumnValue(table.packageId, value);

  _is.ColumnValue<int, int> quantity(int value) =>
      _is.ColumnValue(table.quantity, value);

  _is.ColumnValue<double, double> packagePrice(double value) =>
      _is.ColumnValue(table.packagePrice, value);

  _is.ColumnValue<double, double> originalPrice(double value) =>
      _is.ColumnValue(table.originalPrice, value);

  _is.ColumnValue<double, double> discountRate(double value) =>
      _is.ColumnValue(table.discountRate, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> isDeleted(bool value) =>
      _is.ColumnValue(table.isDeleted, value);
}

class BookPackageItemTable extends _is.Table<int?> {
  BookPackageItemTable({super.tableRelation})
    : super(tableName: 'book_package_item') {
    updateTable = BookPackageItemUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    bookId = _is.ColumnInt('bookId', this);
    packageId = _is.ColumnInt('packageId', this);
    quantity = _is.ColumnInt('quantity', this, hasDefault: true);
    packagePrice = _is.ColumnDouble('packagePrice', this);
    originalPrice = _is.ColumnDouble('originalPrice', this);
    discountRate = _is.ColumnDouble('discountRate', this, hasDefault: true);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
    isDeleted = _is.ColumnBool('isDeleted', this, hasDefault: true);
  }

  late final BookPackageItemUpdateTable updateTable;

  /// 租户ID（0 表示系统租户）
  late final _is.ColumnInt tenantId;

  /// 关联的书籍ID
  late final _is.ColumnInt bookId;

  /// 关联的套餐ID
  late final _is.ColumnInt packageId;

  /// 此书籍在套餐中的数量
  late final _is.ColumnInt quantity;

  /// 此书籍在套餐中的单价（可能与原价不同）
  late final _is.ColumnDouble packagePrice;

  /// 此书籍的原价（冗余存储，便于历史查询）
  late final _is.ColumnDouble originalPrice;

  /// 单品折扣率
  late final _is.ColumnDouble discountRate;

  /// 套餐明细记录创建时间
  late final _is.ColumnDateTime createTime;

  /// 套餐明细记录最后更新时间
  late final _is.ColumnDateTime updateTime;

  /// 是否删除
  late final _is.ColumnBool isDeleted;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
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

class BookPackageItemInclude extends _is.IncludeObject {
  BookPackageItemInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => BookPackageItem.t;
}

class BookPackageItemIncludeList extends _is.IncludeList {
  BookPackageItemIncludeList._({
    _is.WhereExpressionBuilder<BookPackageItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookPackageItem.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BookPackageItem.t;
}

class BookPackageItemRepository {
  const BookPackageItemRepository._();

  /// Returns a list of [BookPackageItem]s matching the given query parameters.
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
  Future<List<BookPackageItem>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookPackageItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookPackageItemTable>? orderBy,
    _is.OrderByListBuilder<BookPackageItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookPackageItem>(
      where: where?.call(BookPackageItem.t),
      orderBy: orderBy?.call(BookPackageItem.t),
      orderByList: orderByList?.call(BookPackageItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BookPackageItem] matching the given query parameters.
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
  Future<BookPackageItem?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookPackageItemTable>? where,
    int? offset,
    _is.OrderByBuilder<BookPackageItemTable>? orderBy,
    _is.OrderByListBuilder<BookPackageItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookPackageItem>(
      where: where?.call(BookPackageItem.t),
      orderBy: orderBy?.call(BookPackageItem.t),
      orderByList: orderByList?.call(BookPackageItem.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookPackageItem] by its [id] or null if no such row exists.
  Future<BookPackageItem?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BookPackageItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BookPackageItem]s in the list and returns the inserted rows.
  ///
  /// The returned [BookPackageItem]s will have their `id` fields set.
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
  Future<List<BookPackageItem>> insert(
    _is.DatabaseSession session,
    List<BookPackageItem> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BookPackageItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BookPackageItem] and returns the inserted row.
  ///
  /// The returned [BookPackageItem] will have its `id` field set.
  Future<BookPackageItem> insertRow(
    _is.DatabaseSession session,
    BookPackageItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookPackageItem>(row, transaction: transaction);
  }

  /// Upserts all [BookPackageItem]s in the list and returns the resulting rows.
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
  /// The returned [BookPackageItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookPackageItem>> upsert(
    _is.DatabaseSession session,
    List<BookPackageItem> rows, {
    required _is.ColumnSelections<BookPackageItemTable> conflictColumns,
    _is.ColumnSelections<BookPackageItemTable>? updateColumns,
    _is.WhereExpressionBuilder<BookPackageItemTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BookPackageItem>(
      rows,
      conflictColumns: conflictColumns(BookPackageItem.t),
      updateColumns: updateColumns?.call(BookPackageItem.t),
      updateWhere: updateWhere?.call(BookPackageItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BookPackageItem] and returns the resulting row.
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
  /// The returned [BookPackageItem] will have its `id` field set.
  Future<BookPackageItem?> upsertRow(
    _is.DatabaseSession session,
    BookPackageItem row, {
    required _is.ColumnSelections<BookPackageItemTable> conflictColumns,
    _is.ColumnSelections<BookPackageItemTable>? updateColumns,
    _is.WhereExpressionBuilder<BookPackageItemTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BookPackageItem>(
      row,
      conflictColumns: conflictColumns(BookPackageItem.t),
      updateColumns: updateColumns?.call(BookPackageItem.t),
      updateWhere: updateWhere?.call(BookPackageItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [BookPackageItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookPackageItem>> update(
    _is.DatabaseSession session,
    List<BookPackageItem> rows, {
    _is.ColumnSelections<BookPackageItemTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BookPackageItem>(
      rows,
      columns: columns?.call(BookPackageItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BookPackageItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookPackageItem> updateRow(
    _is.DatabaseSession session,
    BookPackageItem row, {
    _is.ColumnSelections<BookPackageItemTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookPackageItem>(
      row,
      columns: columns?.call(BookPackageItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookPackageItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookPackageItem?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookPackageItemUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BookPackageItem>(
      id,
      columnValues: columnValues(BookPackageItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookPackageItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookPackageItem>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookPackageItemUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<BookPackageItemTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookPackageItemTable>? orderBy,
    _is.OrderByListBuilder<BookPackageItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BookPackageItem>(
      columnValues: columnValues(BookPackageItem.t.updateTable),
      where: where(BookPackageItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookPackageItem.t),
      orderByList: orderByList?.call(BookPackageItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BookPackageItem]s in the list and returns the deleted rows.
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
  Future<List<BookPackageItem>> delete(
    _is.DatabaseSession session,
    List<BookPackageItem> rows, {
    _is.OrderByBuilder<BookPackageItemTable>? orderBy,
    _is.OrderByListBuilder<BookPackageItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BookPackageItem>(
      rows,
      orderBy: orderBy?.call(BookPackageItem.t),
      orderByList: orderByList?.call(BookPackageItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BookPackageItem].
  Future<BookPackageItem> deleteRow(
    _is.DatabaseSession session,
    BookPackageItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookPackageItem>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookPackageItem>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookPackageItemTable> where,
    _is.OrderByBuilder<BookPackageItemTable>? orderBy,
    _is.OrderByListBuilder<BookPackageItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BookPackageItem>(
      where: where(BookPackageItem.t),
      orderBy: orderBy?.call(BookPackageItem.t),
      orderByList: orderByList?.call(BookPackageItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookPackageItemTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BookPackageItem>(
      where: where?.call(BookPackageItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookPackageItem] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookPackageItemTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookPackageItem>(
      where: where(BookPackageItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
