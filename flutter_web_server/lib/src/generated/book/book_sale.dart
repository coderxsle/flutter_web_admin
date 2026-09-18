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

/// 用于存储书籍的销售记录信息
abstract class BookSale
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  BookSale._({
    this.id,
    int? tenantId,
    required this.bookId,
    required this.quantity,
    required this.salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  }) : tenantId = tenantId ?? 0,
       saleTime = saleTime ?? DateTime.now(),
       isDeleted = isDeleted ?? false;

  factory BookSale({
    int? id,
    int? tenantId,
    required int bookId,
    required int quantity,
    required double salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  }) = _BookSaleImpl;

  factory BookSale.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookSale(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      salePrice: (jsonSerialization['salePrice'] as num).toDouble(),
      saleTime: jsonSerialization['saleTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['saleTime']),
      isDeleted: jsonSerialization['isDeleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isDeleted']),
    );
  }

  static final t = BookSaleTable();

  static const db = BookSaleRepository._();

  @override
  int? id;

  /// 租户ID（0 表示系统租户）
  int? tenantId;

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
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookSale]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookSale copyWith({
    int? id,
    int? tenantId,
    int? bookId,
    int? quantity,
    double? salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookSale',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
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
      '__className__': 'BookSale',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
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
    _is.WhereExpressionBuilder<BookSaleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookSaleTable>? orderBy,
    _is.OrderByListBuilder<BookSaleTable>? orderByList,
    BookSaleInclude? include,
  }) {
    return BookSaleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookSale.t),
      orderByList: orderByList?.call(BookSale.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookSaleImpl extends BookSale {
  _BookSaleImpl({
    int? id,
    int? tenantId,
    required int bookId,
    required int quantity,
    required double salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         bookId: bookId,
         quantity: quantity,
         salePrice: salePrice,
         saleTime: saleTime,
         isDeleted: isDeleted,
       );

  /// Returns a shallow copy of this [BookSale]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookSale copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    int? bookId,
    int? quantity,
    double? salePrice,
    DateTime? saleTime,
    bool? isDeleted,
  }) {
    return BookSale(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      bookId: bookId ?? this.bookId,
      quantity: quantity ?? this.quantity,
      salePrice: salePrice ?? this.salePrice,
      saleTime: saleTime ?? this.saleTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class BookSaleUpdateTable extends _is.UpdateTable<BookSaleTable> {
  BookSaleUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int? value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> bookId(int value) =>
      _is.ColumnValue(table.bookId, value);

  _is.ColumnValue<int, int> quantity(int value) =>
      _is.ColumnValue(table.quantity, value);

  _is.ColumnValue<double, double> salePrice(double value) =>
      _is.ColumnValue(table.salePrice, value);

  _is.ColumnValue<DateTime, DateTime> saleTime(DateTime value) =>
      _is.ColumnValue(table.saleTime, value);

  _is.ColumnValue<bool, bool> isDeleted(bool value) =>
      _is.ColumnValue(table.isDeleted, value);
}

class BookSaleTable extends _is.Table<int?> {
  BookSaleTable({super.tableRelation}) : super(tableName: 'book_sale') {
    updateTable = BookSaleUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    bookId = _is.ColumnInt('bookId', this);
    quantity = _is.ColumnInt('quantity', this);
    salePrice = _is.ColumnDouble('salePrice', this);
    saleTime = _is.ColumnDateTime('saleTime', this, hasDefault: true);
    isDeleted = _is.ColumnBool('isDeleted', this, hasDefault: true);
  }

  late final BookSaleUpdateTable updateTable;

  /// 租户ID（0 表示系统租户）
  late final _is.ColumnInt tenantId;

  /// 图书的ID（如果是单本销售）
  late final _is.ColumnInt bookId;

  /// 出售数量
  late final _is.ColumnInt quantity;

  /// 单本图书价格（单本出售）或套装总价（组合出售）
  late final _is.ColumnDouble salePrice;

  /// 销售时间
  late final _is.ColumnDateTime saleTime;

  /// 是否删除
  late final _is.ColumnBool isDeleted;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    bookId,
    quantity,
    salePrice,
    saleTime,
    isDeleted,
  ];
}

class BookSaleInclude extends _is.IncludeObject {
  BookSaleInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => BookSale.t;
}

class BookSaleIncludeList extends _is.IncludeList {
  BookSaleIncludeList._({
    _is.WhereExpressionBuilder<BookSaleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookSale.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BookSale.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookSaleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookSaleTable>? orderBy,
    _is.OrderByListBuilder<BookSaleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookSale>(
      where: where?.call(BookSale.t),
      orderBy: orderBy?.call(BookSale.t),
      orderByList: orderByList?.call(BookSale.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookSaleTable>? where,
    int? offset,
    _is.OrderByBuilder<BookSaleTable>? orderBy,
    _is.OrderByListBuilder<BookSaleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookSale>(
      where: where?.call(BookSale.t),
      orderBy: orderBy?.call(BookSale.t),
      orderByList: orderByList?.call(BookSale.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookSale] by its [id] or null if no such row exists.
  Future<BookSale?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BookSale>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BookSale]s in the list and returns the inserted rows.
  ///
  /// The returned [BookSale]s will have their `id` fields set.
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
  Future<List<BookSale>> insert(
    _is.DatabaseSession session,
    List<BookSale> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BookSale>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BookSale] and returns the inserted row.
  ///
  /// The returned [BookSale] will have its `id` field set.
  Future<BookSale> insertRow(
    _is.DatabaseSession session,
    BookSale row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookSale>(row, transaction: transaction);
  }

  /// Upserts all [BookSale]s in the list and returns the resulting rows.
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
  /// The returned [BookSale]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookSale>> upsert(
    _is.DatabaseSession session,
    List<BookSale> rows, {
    required _is.ColumnSelections<BookSaleTable> conflictColumns,
    _is.ColumnSelections<BookSaleTable>? updateColumns,
    _is.WhereExpressionBuilder<BookSaleTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BookSale>(
      rows,
      conflictColumns: conflictColumns(BookSale.t),
      updateColumns: updateColumns?.call(BookSale.t),
      updateWhere: updateWhere?.call(BookSale.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BookSale] and returns the resulting row.
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
  /// The returned [BookSale] will have its `id` field set.
  Future<BookSale?> upsertRow(
    _is.DatabaseSession session,
    BookSale row, {
    required _is.ColumnSelections<BookSaleTable> conflictColumns,
    _is.ColumnSelections<BookSaleTable>? updateColumns,
    _is.WhereExpressionBuilder<BookSaleTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BookSale>(
      row,
      conflictColumns: conflictColumns(BookSale.t),
      updateColumns: updateColumns?.call(BookSale.t),
      updateWhere: updateWhere?.call(BookSale.t),
      transaction: transaction,
    );
  }

  /// Updates all [BookSale]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookSale>> update(
    _is.DatabaseSession session,
    List<BookSale> rows, {
    _is.ColumnSelections<BookSaleTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BookSale>(
      rows,
      columns: columns?.call(BookSale.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BookSale]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookSale> updateRow(
    _is.DatabaseSession session,
    BookSale row, {
    _is.ColumnSelections<BookSaleTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookSale>(
      row,
      columns: columns?.call(BookSale.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookSale] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookSale?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookSaleUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BookSale>(
      id,
      columnValues: columnValues(BookSale.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookSale]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookSale>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookSaleUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BookSaleTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookSaleTable>? orderBy,
    _is.OrderByListBuilder<BookSaleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BookSale>(
      columnValues: columnValues(BookSale.t.updateTable),
      where: where(BookSale.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookSale.t),
      orderByList: orderByList?.call(BookSale.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BookSale]s in the list and returns the deleted rows.
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
  Future<List<BookSale>> delete(
    _is.DatabaseSession session,
    List<BookSale> rows, {
    _is.OrderByBuilder<BookSaleTable>? orderBy,
    _is.OrderByListBuilder<BookSaleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BookSale>(
      rows,
      orderBy: orderBy?.call(BookSale.t),
      orderByList: orderByList?.call(BookSale.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BookSale].
  Future<BookSale> deleteRow(
    _is.DatabaseSession session,
    BookSale row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookSale>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookSale>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookSaleTable> where,
    _is.OrderByBuilder<BookSaleTable>? orderBy,
    _is.OrderByListBuilder<BookSaleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BookSale>(
      where: where(BookSale.t),
      orderBy: orderBy?.call(BookSale.t),
      orderByList: orderByList?.call(BookSale.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookSaleTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BookSale>(
      where: where?.call(BookSale.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookSale] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookSaleTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookSale>(
      where: where(BookSale.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
