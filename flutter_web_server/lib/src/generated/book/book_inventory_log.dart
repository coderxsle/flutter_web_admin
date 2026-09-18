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

/// 用于记录每本书库存变动的详细信息，便于审计和管理
abstract class BookInventoryLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  BookInventoryLog._({
    this.id,
    int? tenantId,
    required this.bookId,
    required this.quantity,
    required this.changeType,
    required this.changeTime,
    this.description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now(),
       isDeleted = isDeleted ?? false;

  factory BookInventoryLog({
    int? id,
    int? tenantId,
    required int bookId,
    required int quantity,
    required int changeType,
    required DateTime changeTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _BookInventoryLogImpl;

  factory BookInventoryLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookInventoryLog(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      changeType: jsonSerialization['changeType'] as int,
      changeTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['changeTime'],
      ),
      description: jsonSerialization['description'] as String?,
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

  static final t = BookInventoryLogTable();

  static const db = BookInventoryLogRepository._();

  @override
  int? id;

  /// 租户ID（0 表示系统租户）
  int? tenantId;

  /// 图书ID，用于标识是哪本书
  int bookId;

  /// 变动数量，可以为正（增加库存）或负（减少库存）
  int quantity;

  /// 变动类型，0=进货，1=售出，2=退货，3=损耗，4=库存调整
  int changeType;

  /// 变动发生的时间
  DateTime changeTime;

  /// 变动的原因或描述，提供额外的说明
  String? description;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookInventoryLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookInventoryLog copyWith({
    int? id,
    int? tenantId,
    int? bookId,
    int? quantity,
    int? changeType,
    DateTime? changeTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookInventoryLog',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'bookId': bookId,
      'quantity': quantity,
      'changeType': changeType,
      'changeTime': changeTime.toJson(),
      if (description != null) 'description': description,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookInventoryLog',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'bookId': bookId,
      'quantity': quantity,
      'changeType': changeType,
      'changeTime': changeTime.toJson(),
      if (description != null) 'description': description,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static BookInventoryLogInclude include() {
    return BookInventoryLogInclude._();
  }

  static BookInventoryLogIncludeList includeList({
    _is.WhereExpressionBuilder<BookInventoryLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookInventoryLogTable>? orderBy,
    _is.OrderByListBuilder<BookInventoryLogTable>? orderByList,
    BookInventoryLogInclude? include,
  }) {
    return BookInventoryLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookInventoryLog.t),
      orderByList: orderByList?.call(BookInventoryLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookInventoryLogImpl extends BookInventoryLog {
  _BookInventoryLogImpl({
    int? id,
    int? tenantId,
    required int bookId,
    required int quantity,
    required int changeType,
    required DateTime changeTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         bookId: bookId,
         quantity: quantity,
         changeType: changeType,
         changeTime: changeTime,
         description: description,
         createTime: createTime,
         updateTime: updateTime,
         isDeleted: isDeleted,
       );

  /// Returns a shallow copy of this [BookInventoryLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookInventoryLog copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    int? bookId,
    int? quantity,
    int? changeType,
    DateTime? changeTime,
    Object? description = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return BookInventoryLog(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      bookId: bookId ?? this.bookId,
      quantity: quantity ?? this.quantity,
      changeType: changeType ?? this.changeType,
      changeTime: changeTime ?? this.changeTime,
      description: description is String? ? description : this.description,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class BookInventoryLogUpdateTable
    extends _is.UpdateTable<BookInventoryLogTable> {
  BookInventoryLogUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int? value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> bookId(int value) =>
      _is.ColumnValue(table.bookId, value);

  _is.ColumnValue<int, int> quantity(int value) =>
      _is.ColumnValue(table.quantity, value);

  _is.ColumnValue<int, int> changeType(int value) =>
      _is.ColumnValue(table.changeType, value);

  _is.ColumnValue<DateTime, DateTime> changeTime(DateTime value) =>
      _is.ColumnValue(table.changeTime, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> isDeleted(bool value) =>
      _is.ColumnValue(table.isDeleted, value);
}

class BookInventoryLogTable extends _is.Table<int?> {
  BookInventoryLogTable({super.tableRelation})
    : super(tableName: 'book_inventory_log') {
    updateTable = BookInventoryLogUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    bookId = _is.ColumnInt('bookId', this);
    quantity = _is.ColumnInt('quantity', this);
    changeType = _is.ColumnInt('changeType', this);
    changeTime = _is.ColumnDateTime('changeTime', this);
    description = _is.ColumnString('description', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
    isDeleted = _is.ColumnBool('isDeleted', this, hasDefault: true);
  }

  late final BookInventoryLogUpdateTable updateTable;

  /// 租户ID（0 表示系统租户）
  late final _is.ColumnInt tenantId;

  /// 图书ID，用于标识是哪本书
  late final _is.ColumnInt bookId;

  /// 变动数量，可以为正（增加库存）或负（减少库存）
  late final _is.ColumnInt quantity;

  /// 变动类型，0=进货，1=售出，2=退货，3=损耗，4=库存调整
  late final _is.ColumnInt changeType;

  /// 变动发生的时间
  late final _is.ColumnDateTime changeTime;

  /// 变动的原因或描述，提供额外的说明
  late final _is.ColumnString description;

  /// 记录创建时间
  late final _is.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _is.ColumnDateTime updateTime;

  /// 是否删除
  late final _is.ColumnBool isDeleted;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    bookId,
    quantity,
    changeType,
    changeTime,
    description,
    createTime,
    updateTime,
    isDeleted,
  ];
}

class BookInventoryLogInclude extends _is.IncludeObject {
  BookInventoryLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => BookInventoryLog.t;
}

class BookInventoryLogIncludeList extends _is.IncludeList {
  BookInventoryLogIncludeList._({
    _is.WhereExpressionBuilder<BookInventoryLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookInventoryLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BookInventoryLog.t;
}

class BookInventoryLogRepository {
  const BookInventoryLogRepository._();

  /// Returns a list of [BookInventoryLog]s matching the given query parameters.
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
  Future<List<BookInventoryLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookInventoryLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookInventoryLogTable>? orderBy,
    _is.OrderByListBuilder<BookInventoryLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookInventoryLog>(
      where: where?.call(BookInventoryLog.t),
      orderBy: orderBy?.call(BookInventoryLog.t),
      orderByList: orderByList?.call(BookInventoryLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BookInventoryLog] matching the given query parameters.
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
  Future<BookInventoryLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookInventoryLogTable>? where,
    int? offset,
    _is.OrderByBuilder<BookInventoryLogTable>? orderBy,
    _is.OrderByListBuilder<BookInventoryLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookInventoryLog>(
      where: where?.call(BookInventoryLog.t),
      orderBy: orderBy?.call(BookInventoryLog.t),
      orderByList: orderByList?.call(BookInventoryLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookInventoryLog] by its [id] or null if no such row exists.
  Future<BookInventoryLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BookInventoryLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BookInventoryLog]s in the list and returns the inserted rows.
  ///
  /// The returned [BookInventoryLog]s will have their `id` fields set.
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
  Future<List<BookInventoryLog>> insert(
    _is.DatabaseSession session,
    List<BookInventoryLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BookInventoryLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BookInventoryLog] and returns the inserted row.
  ///
  /// The returned [BookInventoryLog] will have its `id` field set.
  Future<BookInventoryLog> insertRow(
    _is.DatabaseSession session,
    BookInventoryLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookInventoryLog>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [BookInventoryLog]s in the list and returns the resulting rows.
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
  /// The returned [BookInventoryLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookInventoryLog>> upsert(
    _is.DatabaseSession session,
    List<BookInventoryLog> rows, {
    required _is.ColumnSelections<BookInventoryLogTable> conflictColumns,
    _is.ColumnSelections<BookInventoryLogTable>? updateColumns,
    _is.WhereExpressionBuilder<BookInventoryLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BookInventoryLog>(
      rows,
      conflictColumns: conflictColumns(BookInventoryLog.t),
      updateColumns: updateColumns?.call(BookInventoryLog.t),
      updateWhere: updateWhere?.call(BookInventoryLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BookInventoryLog] and returns the resulting row.
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
  /// The returned [BookInventoryLog] will have its `id` field set.
  Future<BookInventoryLog?> upsertRow(
    _is.DatabaseSession session,
    BookInventoryLog row, {
    required _is.ColumnSelections<BookInventoryLogTable> conflictColumns,
    _is.ColumnSelections<BookInventoryLogTable>? updateColumns,
    _is.WhereExpressionBuilder<BookInventoryLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BookInventoryLog>(
      row,
      conflictColumns: conflictColumns(BookInventoryLog.t),
      updateColumns: updateColumns?.call(BookInventoryLog.t),
      updateWhere: updateWhere?.call(BookInventoryLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [BookInventoryLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookInventoryLog>> update(
    _is.DatabaseSession session,
    List<BookInventoryLog> rows, {
    _is.ColumnSelections<BookInventoryLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BookInventoryLog>(
      rows,
      columns: columns?.call(BookInventoryLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BookInventoryLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookInventoryLog> updateRow(
    _is.DatabaseSession session,
    BookInventoryLog row, {
    _is.ColumnSelections<BookInventoryLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookInventoryLog>(
      row,
      columns: columns?.call(BookInventoryLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookInventoryLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookInventoryLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookInventoryLogUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BookInventoryLog>(
      id,
      columnValues: columnValues(BookInventoryLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookInventoryLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookInventoryLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookInventoryLogUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<BookInventoryLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookInventoryLogTable>? orderBy,
    _is.OrderByListBuilder<BookInventoryLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BookInventoryLog>(
      columnValues: columnValues(BookInventoryLog.t.updateTable),
      where: where(BookInventoryLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookInventoryLog.t),
      orderByList: orderByList?.call(BookInventoryLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BookInventoryLog]s in the list and returns the deleted rows.
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
  Future<List<BookInventoryLog>> delete(
    _is.DatabaseSession session,
    List<BookInventoryLog> rows, {
    _is.OrderByBuilder<BookInventoryLogTable>? orderBy,
    _is.OrderByListBuilder<BookInventoryLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BookInventoryLog>(
      rows,
      orderBy: orderBy?.call(BookInventoryLog.t),
      orderByList: orderByList?.call(BookInventoryLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BookInventoryLog].
  Future<BookInventoryLog> deleteRow(
    _is.DatabaseSession session,
    BookInventoryLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookInventoryLog>(
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
  Future<List<BookInventoryLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookInventoryLogTable> where,
    _is.OrderByBuilder<BookInventoryLogTable>? orderBy,
    _is.OrderByListBuilder<BookInventoryLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BookInventoryLog>(
      where: where(BookInventoryLog.t),
      orderBy: orderBy?.call(BookInventoryLog.t),
      orderByList: orderByList?.call(BookInventoryLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookInventoryLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BookInventoryLog>(
      where: where?.call(BookInventoryLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookInventoryLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookInventoryLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookInventoryLog>(
      where: where(BookInventoryLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
