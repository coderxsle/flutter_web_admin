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

/// 店铺图书关联表，用于存储店铺和图书的关联关系
abstract class StoreBook
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
  }) : inventory = inventory ?? 0,
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
      inventory: jsonSerialization['inventory'] as int?,
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
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreBook]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
      '__className__': 'StoreBook',
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
      '__className__': 'StoreBook',
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
    _is.WhereExpressionBuilder<StoreBookTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreBookTable>? orderBy,
    _is.OrderByListBuilder<StoreBookTable>? orderByList,
    StoreBookInclude? include,
  }) {
    return StoreBookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreBook.t),
      orderByList: orderByList?.call(StoreBook.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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

  /// Returns a shallow copy of this [StoreBook]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

class StoreBookUpdateTable extends _is.UpdateTable<StoreBookTable> {
  StoreBookUpdateTable(super.table);

  _is.ColumnValue<int, int> storeId(int value) =>
      _is.ColumnValue(table.storeId, value);

  _is.ColumnValue<int, int> bookId(int value) =>
      _is.ColumnValue(table.bookId, value);

  _is.ColumnValue<double, double> purchasePrice(double value) =>
      _is.ColumnValue(table.purchasePrice, value);

  _is.ColumnValue<double, double> salePrice(double value) =>
      _is.ColumnValue(table.salePrice, value);

  _is.ColumnValue<double, double> discountPrice(double value) =>
      _is.ColumnValue(table.discountPrice, value);

  _is.ColumnValue<int, int> inventory(int value) =>
      _is.ColumnValue(table.inventory, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> isDeleted(bool value) =>
      _is.ColumnValue(table.isDeleted, value);
}

class StoreBookTable extends _is.Table<int?> {
  StoreBookTable({super.tableRelation}) : super(tableName: 'store_book') {
    updateTable = StoreBookUpdateTable(this);
    storeId = _is.ColumnInt('storeId', this);
    bookId = _is.ColumnInt('bookId', this);
    purchasePrice = _is.ColumnDouble('purchasePrice', this);
    salePrice = _is.ColumnDouble('salePrice', this);
    discountPrice = _is.ColumnDouble('discountPrice', this);
    inventory = _is.ColumnInt('inventory', this, hasDefault: true);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
    isDeleted = _is.ColumnBool('isDeleted', this, hasDefault: true);
  }

  late final StoreBookUpdateTable updateTable;

  /// 店铺ID
  late final _is.ColumnInt storeId;

  /// 图书ID
  late final _is.ColumnInt bookId;

  /// 进价
  late final _is.ColumnDouble purchasePrice;

  /// 售价
  late final _is.ColumnDouble salePrice;

  /// 优惠价
  late final _is.ColumnDouble discountPrice;

  /// 库存
  late final _is.ColumnInt inventory;

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

class StoreBookInclude extends _is.IncludeObject {
  StoreBookInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StoreBook.t;
}

class StoreBookIncludeList extends _is.IncludeList {
  StoreBookIncludeList._({
    _is.WhereExpressionBuilder<StoreBookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreBook.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StoreBook.t;
}

class StoreBookRepository {
  const StoreBookRepository._();

  /// Returns a list of [StoreBook]s matching the given query parameters.
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
  Future<List<StoreBook>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreBookTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreBookTable>? orderBy,
    _is.OrderByListBuilder<StoreBookTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StoreBook>(
      where: where?.call(StoreBook.t),
      orderBy: orderBy?.call(StoreBook.t),
      orderByList: orderByList?.call(StoreBook.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StoreBook] matching the given query parameters.
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
  Future<StoreBook?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreBookTable>? where,
    int? offset,
    _is.OrderByBuilder<StoreBookTable>? orderBy,
    _is.OrderByListBuilder<StoreBookTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StoreBook>(
      where: where?.call(StoreBook.t),
      orderBy: orderBy?.call(StoreBook.t),
      orderByList: orderByList?.call(StoreBook.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StoreBook] by its [id] or null if no such row exists.
  Future<StoreBook?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StoreBook>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StoreBook]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreBook]s will have their `id` fields set.
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
  Future<List<StoreBook>> insert(
    _is.DatabaseSession session,
    List<StoreBook> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StoreBook>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StoreBook] and returns the inserted row.
  ///
  /// The returned [StoreBook] will have its `id` field set.
  Future<StoreBook> insertRow(
    _is.DatabaseSession session,
    StoreBook row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreBook>(row, transaction: transaction);
  }

  /// Upserts all [StoreBook]s in the list and returns the resulting rows.
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
  /// The returned [StoreBook]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreBook>> upsert(
    _is.DatabaseSession session,
    List<StoreBook> rows, {
    required _is.ColumnSelections<StoreBookTable> conflictColumns,
    _is.ColumnSelections<StoreBookTable>? updateColumns,
    _is.WhereExpressionBuilder<StoreBookTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StoreBook>(
      rows,
      conflictColumns: conflictColumns(StoreBook.t),
      updateColumns: updateColumns?.call(StoreBook.t),
      updateWhere: updateWhere?.call(StoreBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StoreBook] and returns the resulting row.
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
  /// The returned [StoreBook] will have its `id` field set.
  Future<StoreBook?> upsertRow(
    _is.DatabaseSession session,
    StoreBook row, {
    required _is.ColumnSelections<StoreBookTable> conflictColumns,
    _is.ColumnSelections<StoreBookTable>? updateColumns,
    _is.WhereExpressionBuilder<StoreBookTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StoreBook>(
      row,
      conflictColumns: conflictColumns(StoreBook.t),
      updateColumns: updateColumns?.call(StoreBook.t),
      updateWhere: updateWhere?.call(StoreBook.t),
      transaction: transaction,
    );
  }

  /// Updates all [StoreBook]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreBook>> update(
    _is.DatabaseSession session,
    List<StoreBook> rows, {
    _is.ColumnSelections<StoreBookTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StoreBook>(
      rows,
      columns: columns?.call(StoreBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StoreBook]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreBook> updateRow(
    _is.DatabaseSession session,
    StoreBook row, {
    _is.ColumnSelections<StoreBookTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreBook>(
      row,
      columns: columns?.call(StoreBook.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreBook] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreBook?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StoreBookUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreBook>(
      id,
      columnValues: columnValues(StoreBook.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreBook]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreBook>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StoreBookUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StoreBookTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreBookTable>? orderBy,
    _is.OrderByListBuilder<StoreBookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StoreBook>(
      columnValues: columnValues(StoreBook.t.updateTable),
      where: where(StoreBook.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreBook.t),
      orderByList: orderByList?.call(StoreBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StoreBook]s in the list and returns the deleted rows.
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
  Future<List<StoreBook>> delete(
    _is.DatabaseSession session,
    List<StoreBook> rows, {
    _is.OrderByBuilder<StoreBookTable>? orderBy,
    _is.OrderByListBuilder<StoreBookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StoreBook>(
      rows,
      orderBy: orderBy?.call(StoreBook.t),
      orderByList: orderByList?.call(StoreBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StoreBook].
  Future<StoreBook> deleteRow(
    _is.DatabaseSession session,
    StoreBook row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreBook>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreBook>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoreBookTable> where,
    _is.OrderByBuilder<StoreBookTable>? orderBy,
    _is.OrderByListBuilder<StoreBookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StoreBook>(
      where: where(StoreBook.t),
      orderBy: orderBy?.call(StoreBook.t),
      orderByList: orderByList?.call(StoreBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreBookTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StoreBook>(
      where: where?.call(StoreBook.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StoreBook] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoreBookTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StoreBook>(
      where: where(StoreBook.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
