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

/// 用于存储每个书籍套装中包含的书籍信息
abstract class BookPackageItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isDeleted']),
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
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookPackageItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
  @_i1.useResult
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

class BookPackageItemUpdateTable extends _i1.UpdateTable<BookPackageItemTable> {
  BookPackageItemUpdateTable(super.table);

  _i1.ColumnValue<int, int> tenantId(int? value) => _i1.ColumnValue(
    table.tenantId,
    value,
  );

  _i1.ColumnValue<int, int> bookId(int value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<int, int> packageId(int value) => _i1.ColumnValue(
    table.packageId,
    value,
  );

  _i1.ColumnValue<int, int> quantity(int value) => _i1.ColumnValue(
    table.quantity,
    value,
  );

  _i1.ColumnValue<double, double> packagePrice(double value) => _i1.ColumnValue(
    table.packagePrice,
    value,
  );

  _i1.ColumnValue<double, double> originalPrice(double value) =>
      _i1.ColumnValue(
        table.originalPrice,
        value,
      );

  _i1.ColumnValue<double, double> discountRate(double value) => _i1.ColumnValue(
    table.discountRate,
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

class BookPackageItemTable extends _i1.Table<int?> {
  BookPackageItemTable({super.tableRelation})
    : super(tableName: 'book_package_item') {
    updateTable = BookPackageItemUpdateTable(this);
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
      hasDefault: true,
    );
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

  late final BookPackageItemUpdateTable updateTable;

  /// 租户ID（0 表示系统租户）
  late final _i1.ColumnInt tenantId;

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

class BookPackageItemInclude extends _i1.IncludeObject {
  BookPackageItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BookPackageItem.t;
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
  _i1.Table<int?> get table => BookPackageItem.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookPackageItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookPackageItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookPackageItemTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookPackageItem>(
      where: where?.call(BookPackageItem.t),
      orderBy: orderBy?.call(BookPackageItem.t),
      orderByList: orderByList?.call(BookPackageItem.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookPackageItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookPackageItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookPackageItemTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookPackageItem>(
      where: where?.call(BookPackageItem.t),
      orderBy: orderBy?.call(BookPackageItem.t),
      orderByList: orderByList?.call(BookPackageItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookPackageItem] by its [id] or null if no such row exists.
  Future<BookPackageItem?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<BookPackageItem>> insert(
    _i1.DatabaseSession session,
    List<BookPackageItem> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BookPackageItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BookPackageItem] and returns the inserted row.
  ///
  /// The returned [BookPackageItem] will have its `id` field set.
  Future<BookPackageItem> insertRow(
    _i1.DatabaseSession session,
    BookPackageItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookPackageItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BookPackageItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BookPackageItem>> update(
    _i1.DatabaseSession session,
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

  /// Updates a single [BookPackageItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookPackageItem> updateRow(
    _i1.DatabaseSession session,
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

  /// Updates a single [BookPackageItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookPackageItem?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BookPackageItemUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BookPackageItem>(
      id,
      columnValues: columnValues(BookPackageItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookPackageItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BookPackageItem>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BookPackageItemUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<BookPackageItemTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookPackageItemTable>? orderBy,
    _i1.OrderByListBuilder<BookPackageItemTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BookPackageItem>(
      columnValues: columnValues(BookPackageItem.t.updateTable),
      where: where(BookPackageItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookPackageItem.t),
      orderByList: orderByList?.call(BookPackageItem.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BookPackageItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BookPackageItem>> delete(
    _i1.DatabaseSession session,
    List<BookPackageItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BookPackageItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BookPackageItem].
  Future<BookPackageItem> deleteRow(
    _i1.DatabaseSession session,
    BookPackageItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookPackageItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BookPackageItem>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BookPackageItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BookPackageItem>(
      where: where(BookPackageItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
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

  /// Acquires row-level locks on [BookPackageItem] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BookPackageItemTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookPackageItem>(
      where: where(BookPackageItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
