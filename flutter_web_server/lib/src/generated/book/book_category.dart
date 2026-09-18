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

/// 用于存储图书的分类信息
abstract class BookCategory
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  BookCategory._({
    this.id,
    int? tenantId,
    required this.name,
    this.description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now(),
       isDeleted = isDeleted ?? false;

  factory BookCategory({
    int? id,
    int? tenantId,
    required String name,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _BookCategoryImpl;

  factory BookCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookCategory(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
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

  static final t = BookCategoryTable();

  static const db = BookCategoryRepository._();

  @override
  int? id;

  /// 租户ID（0 表示系统租户）
  int? tenantId;

  /// 类别的名称（必填）
  String name;

  /// 类别的描述信息（可选）
  String? description;

  /// 类别记录创建时间
  DateTime createTime;

  /// 类别记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookCategory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookCategory copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookCategory',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'name': name,
      if (description != null) 'description': description,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookCategory',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'name': name,
      if (description != null) 'description': description,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static BookCategoryInclude include() {
    return BookCategoryInclude._();
  }

  static BookCategoryIncludeList includeList({
    _is.WhereExpressionBuilder<BookCategoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookCategoryTable>? orderBy,
    _is.OrderByListBuilder<BookCategoryTable>? orderByList,
    BookCategoryInclude? include,
  }) {
    return BookCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookCategory.t),
      orderByList: orderByList?.call(BookCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookCategoryImpl extends BookCategory {
  _BookCategoryImpl({
    int? id,
    int? tenantId,
    required String name,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         description: description,
         createTime: createTime,
         updateTime: updateTime,
         isDeleted: isDeleted,
       );

  /// Returns a shallow copy of this [BookCategory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookCategory copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    String? name,
    Object? description = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return BookCategory(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class BookCategoryUpdateTable extends _is.UpdateTable<BookCategoryTable> {
  BookCategoryUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int? value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> isDeleted(bool value) =>
      _is.ColumnValue(table.isDeleted, value);
}

class BookCategoryTable extends _is.Table<int?> {
  BookCategoryTable({super.tableRelation}) : super(tableName: 'book_category') {
    updateTable = BookCategoryUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
    isDeleted = _is.ColumnBool('isDeleted', this, hasDefault: true);
  }

  late final BookCategoryUpdateTable updateTable;

  /// 租户ID（0 表示系统租户）
  late final _is.ColumnInt tenantId;

  /// 类别的名称（必填）
  late final _is.ColumnString name;

  /// 类别的描述信息（可选）
  late final _is.ColumnString description;

  /// 类别记录创建时间
  late final _is.ColumnDateTime createTime;

  /// 类别记录最后更新时间
  late final _is.ColumnDateTime updateTime;

  /// 是否删除
  late final _is.ColumnBool isDeleted;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    name,
    description,
    createTime,
    updateTime,
    isDeleted,
  ];
}

class BookCategoryInclude extends _is.IncludeObject {
  BookCategoryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => BookCategory.t;
}

class BookCategoryIncludeList extends _is.IncludeList {
  BookCategoryIncludeList._({
    _is.WhereExpressionBuilder<BookCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookCategory.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BookCategory.t;
}

class BookCategoryRepository {
  const BookCategoryRepository._();

  /// Returns a list of [BookCategory]s matching the given query parameters.
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
  Future<List<BookCategory>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookCategoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookCategoryTable>? orderBy,
    _is.OrderByListBuilder<BookCategoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookCategory>(
      where: where?.call(BookCategory.t),
      orderBy: orderBy?.call(BookCategory.t),
      orderByList: orderByList?.call(BookCategory.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BookCategory] matching the given query parameters.
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
  Future<BookCategory?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookCategoryTable>? where,
    int? offset,
    _is.OrderByBuilder<BookCategoryTable>? orderBy,
    _is.OrderByListBuilder<BookCategoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookCategory>(
      where: where?.call(BookCategory.t),
      orderBy: orderBy?.call(BookCategory.t),
      orderByList: orderByList?.call(BookCategory.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookCategory] by its [id] or null if no such row exists.
  Future<BookCategory?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BookCategory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BookCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [BookCategory]s will have their `id` fields set.
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
  Future<List<BookCategory>> insert(
    _is.DatabaseSession session,
    List<BookCategory> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BookCategory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BookCategory] and returns the inserted row.
  ///
  /// The returned [BookCategory] will have its `id` field set.
  Future<BookCategory> insertRow(
    _is.DatabaseSession session,
    BookCategory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookCategory>(row, transaction: transaction);
  }

  /// Upserts all [BookCategory]s in the list and returns the resulting rows.
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
  /// The returned [BookCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookCategory>> upsert(
    _is.DatabaseSession session,
    List<BookCategory> rows, {
    required _is.ColumnSelections<BookCategoryTable> conflictColumns,
    _is.ColumnSelections<BookCategoryTable>? updateColumns,
    _is.WhereExpressionBuilder<BookCategoryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BookCategory>(
      rows,
      conflictColumns: conflictColumns(BookCategory.t),
      updateColumns: updateColumns?.call(BookCategory.t),
      updateWhere: updateWhere?.call(BookCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BookCategory] and returns the resulting row.
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
  /// The returned [BookCategory] will have its `id` field set.
  Future<BookCategory?> upsertRow(
    _is.DatabaseSession session,
    BookCategory row, {
    required _is.ColumnSelections<BookCategoryTable> conflictColumns,
    _is.ColumnSelections<BookCategoryTable>? updateColumns,
    _is.WhereExpressionBuilder<BookCategoryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BookCategory>(
      row,
      conflictColumns: conflictColumns(BookCategory.t),
      updateColumns: updateColumns?.call(BookCategory.t),
      updateWhere: updateWhere?.call(BookCategory.t),
      transaction: transaction,
    );
  }

  /// Updates all [BookCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookCategory>> update(
    _is.DatabaseSession session,
    List<BookCategory> rows, {
    _is.ColumnSelections<BookCategoryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BookCategory>(
      rows,
      columns: columns?.call(BookCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BookCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookCategory> updateRow(
    _is.DatabaseSession session,
    BookCategory row, {
    _is.ColumnSelections<BookCategoryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookCategory>(
      row,
      columns: columns?.call(BookCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookCategory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookCategory?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookCategoryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BookCategory>(
      id,
      columnValues: columnValues(BookCategory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookCategory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookCategory>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookCategoryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BookCategoryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookCategoryTable>? orderBy,
    _is.OrderByListBuilder<BookCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BookCategory>(
      columnValues: columnValues(BookCategory.t.updateTable),
      where: where(BookCategory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookCategory.t),
      orderByList: orderByList?.call(BookCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BookCategory]s in the list and returns the deleted rows.
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
  Future<List<BookCategory>> delete(
    _is.DatabaseSession session,
    List<BookCategory> rows, {
    _is.OrderByBuilder<BookCategoryTable>? orderBy,
    _is.OrderByListBuilder<BookCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BookCategory>(
      rows,
      orderBy: orderBy?.call(BookCategory.t),
      orderByList: orderByList?.call(BookCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BookCategory].
  Future<BookCategory> deleteRow(
    _is.DatabaseSession session,
    BookCategory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookCategory>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BookCategory>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookCategoryTable> where,
    _is.OrderByBuilder<BookCategoryTable>? orderBy,
    _is.OrderByListBuilder<BookCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BookCategory>(
      where: where(BookCategory.t),
      orderBy: orderBy?.call(BookCategory.t),
      orderByList: orderByList?.call(BookCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookCategoryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BookCategory>(
      where: where?.call(BookCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookCategory] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookCategoryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookCategory>(
      where: where(BookCategory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
