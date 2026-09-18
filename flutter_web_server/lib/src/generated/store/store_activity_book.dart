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

abstract class StoreActivityBook
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StoreActivityBook._({
    this.id,
    required this.storeId,
    required this.activityId,
    required this.bookId,
    required this.discountPrice,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : createTime = createTime ?? DateTime.now(),
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
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreActivityBook]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
      '__className__': 'StoreActivityBook',
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
      '__className__': 'StoreActivityBook',
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
    _is.WhereExpressionBuilder<StoreActivityBookTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreActivityBookTable>? orderBy,
    _is.OrderByListBuilder<StoreActivityBookTable>? orderByList,
    StoreActivityBookInclude? include,
  }) {
    return StoreActivityBookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreActivityBook.t),
      orderByList: orderByList?.call(StoreActivityBook.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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

  /// Returns a shallow copy of this [StoreActivityBook]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

class StoreActivityBookUpdateTable
    extends _is.UpdateTable<StoreActivityBookTable> {
  StoreActivityBookUpdateTable(super.table);

  _is.ColumnValue<int, int> storeId(int value) =>
      _is.ColumnValue(table.storeId, value);

  _is.ColumnValue<int, int> activityId(int value) =>
      _is.ColumnValue(table.activityId, value);

  _is.ColumnValue<int, int> bookId(int value) =>
      _is.ColumnValue(table.bookId, value);

  _is.ColumnValue<double, double> discountPrice(double value) =>
      _is.ColumnValue(table.discountPrice, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> isDeleted(bool value) =>
      _is.ColumnValue(table.isDeleted, value);
}

class StoreActivityBookTable extends _is.Table<int?> {
  StoreActivityBookTable({super.tableRelation})
    : super(tableName: 'store_activity_book') {
    updateTable = StoreActivityBookUpdateTable(this);
    storeId = _is.ColumnInt('storeId', this);
    activityId = _is.ColumnInt('activityId', this);
    bookId = _is.ColumnInt('bookId', this);
    discountPrice = _is.ColumnDouble('discountPrice', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
    isDeleted = _is.ColumnBool('isDeleted', this, hasDefault: true);
  }

  late final StoreActivityBookUpdateTable updateTable;

  /// 店铺ID
  late final _is.ColumnInt storeId;

  /// 活动ID
  late final _is.ColumnInt activityId;

  /// 书籍ID
  late final _is.ColumnInt bookId;

  /// 活动促销价
  late final _is.ColumnDouble discountPrice;

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
    activityId,
    bookId,
    discountPrice,
    createTime,
    updateTime,
    isDeleted,
  ];
}

class StoreActivityBookInclude extends _is.IncludeObject {
  StoreActivityBookInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StoreActivityBook.t;
}

class StoreActivityBookIncludeList extends _is.IncludeList {
  StoreActivityBookIncludeList._({
    _is.WhereExpressionBuilder<StoreActivityBookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreActivityBook.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StoreActivityBook.t;
}

class StoreActivityBookRepository {
  const StoreActivityBookRepository._();

  /// Returns a list of [StoreActivityBook]s matching the given query parameters.
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
  Future<List<StoreActivityBook>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreActivityBookTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreActivityBookTable>? orderBy,
    _is.OrderByListBuilder<StoreActivityBookTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StoreActivityBook>(
      where: where?.call(StoreActivityBook.t),
      orderBy: orderBy?.call(StoreActivityBook.t),
      orderByList: orderByList?.call(StoreActivityBook.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StoreActivityBook] matching the given query parameters.
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
  Future<StoreActivityBook?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreActivityBookTable>? where,
    int? offset,
    _is.OrderByBuilder<StoreActivityBookTable>? orderBy,
    _is.OrderByListBuilder<StoreActivityBookTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StoreActivityBook>(
      where: where?.call(StoreActivityBook.t),
      orderBy: orderBy?.call(StoreActivityBook.t),
      orderByList: orderByList?.call(StoreActivityBook.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StoreActivityBook] by its [id] or null if no such row exists.
  Future<StoreActivityBook?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StoreActivityBook>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StoreActivityBook]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreActivityBook]s will have their `id` fields set.
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
  Future<List<StoreActivityBook>> insert(
    _is.DatabaseSession session,
    List<StoreActivityBook> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StoreActivityBook>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StoreActivityBook] and returns the inserted row.
  ///
  /// The returned [StoreActivityBook] will have its `id` field set.
  Future<StoreActivityBook> insertRow(
    _is.DatabaseSession session,
    StoreActivityBook row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreActivityBook>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StoreActivityBook]s in the list and returns the resulting rows.
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
  /// The returned [StoreActivityBook]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreActivityBook>> upsert(
    _is.DatabaseSession session,
    List<StoreActivityBook> rows, {
    required _is.ColumnSelections<StoreActivityBookTable> conflictColumns,
    _is.ColumnSelections<StoreActivityBookTable>? updateColumns,
    _is.WhereExpressionBuilder<StoreActivityBookTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StoreActivityBook>(
      rows,
      conflictColumns: conflictColumns(StoreActivityBook.t),
      updateColumns: updateColumns?.call(StoreActivityBook.t),
      updateWhere: updateWhere?.call(StoreActivityBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StoreActivityBook] and returns the resulting row.
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
  /// The returned [StoreActivityBook] will have its `id` field set.
  Future<StoreActivityBook?> upsertRow(
    _is.DatabaseSession session,
    StoreActivityBook row, {
    required _is.ColumnSelections<StoreActivityBookTable> conflictColumns,
    _is.ColumnSelections<StoreActivityBookTable>? updateColumns,
    _is.WhereExpressionBuilder<StoreActivityBookTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StoreActivityBook>(
      row,
      conflictColumns: conflictColumns(StoreActivityBook.t),
      updateColumns: updateColumns?.call(StoreActivityBook.t),
      updateWhere: updateWhere?.call(StoreActivityBook.t),
      transaction: transaction,
    );
  }

  /// Updates all [StoreActivityBook]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreActivityBook>> update(
    _is.DatabaseSession session,
    List<StoreActivityBook> rows, {
    _is.ColumnSelections<StoreActivityBookTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StoreActivityBook>(
      rows,
      columns: columns?.call(StoreActivityBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StoreActivityBook]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreActivityBook> updateRow(
    _is.DatabaseSession session,
    StoreActivityBook row, {
    _is.ColumnSelections<StoreActivityBookTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreActivityBook>(
      row,
      columns: columns?.call(StoreActivityBook.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreActivityBook] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreActivityBook?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StoreActivityBookUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreActivityBook>(
      id,
      columnValues: columnValues(StoreActivityBook.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreActivityBook]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StoreActivityBook>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StoreActivityBookUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<StoreActivityBookTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreActivityBookTable>? orderBy,
    _is.OrderByListBuilder<StoreActivityBookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StoreActivityBook>(
      columnValues: columnValues(StoreActivityBook.t.updateTable),
      where: where(StoreActivityBook.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreActivityBook.t),
      orderByList: orderByList?.call(StoreActivityBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StoreActivityBook]s in the list and returns the deleted rows.
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
  Future<List<StoreActivityBook>> delete(
    _is.DatabaseSession session,
    List<StoreActivityBook> rows, {
    _is.OrderByBuilder<StoreActivityBookTable>? orderBy,
    _is.OrderByListBuilder<StoreActivityBookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StoreActivityBook>(
      rows,
      orderBy: orderBy?.call(StoreActivityBook.t),
      orderByList: orderByList?.call(StoreActivityBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StoreActivityBook].
  Future<StoreActivityBook> deleteRow(
    _is.DatabaseSession session,
    StoreActivityBook row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreActivityBook>(
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
  Future<List<StoreActivityBook>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoreActivityBookTable> where,
    _is.OrderByBuilder<StoreActivityBookTable>? orderBy,
    _is.OrderByListBuilder<StoreActivityBookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StoreActivityBook>(
      where: where(StoreActivityBook.t),
      orderBy: orderBy?.call(StoreActivityBook.t),
      orderByList: orderByList?.call(StoreActivityBook.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreActivityBookTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StoreActivityBook>(
      where: where?.call(StoreActivityBook.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StoreActivityBook] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoreActivityBookTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StoreActivityBook>(
      where: where(StoreActivityBook.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
