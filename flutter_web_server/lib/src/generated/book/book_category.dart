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

/// 用于存储图书的分类信息
abstract class BookCategory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isDeleted']),
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
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    _i1.WhereExpressionBuilder<BookCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookCategoryTable>? orderByList,
    BookCategoryInclude? include,
  }) {
    return BookCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookCategory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BookCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
  @_i1.useResult
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

class BookCategoryUpdateTable extends _i1.UpdateTable<BookCategoryTable> {
  BookCategoryUpdateTable(super.table);

  _i1.ColumnValue<int, int> tenantId(int? value) => _i1.ColumnValue(
    table.tenantId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
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

class BookCategoryTable extends _i1.Table<int?> {
  BookCategoryTable({super.tableRelation}) : super(tableName: 'book_category') {
    updateTable = BookCategoryUpdateTable(this);
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
      hasDefault: true,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
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

  late final BookCategoryUpdateTable updateTable;

  /// 租户ID（0 表示系统租户）
  late final _i1.ColumnInt tenantId;

  /// 类别的名称（必填）
  late final _i1.ColumnString name;

  /// 类别的描述信息（可选）
  late final _i1.ColumnString description;

  /// 类别记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 类别记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  /// 是否删除
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
    id,
    tenantId,
    name,
    description,
    createTime,
    updateTime,
    isDeleted,
  ];
}

class BookCategoryInclude extends _i1.IncludeObject {
  BookCategoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BookCategory.t;
}

class BookCategoryIncludeList extends _i1.IncludeList {
  BookCategoryIncludeList._({
    _i1.WhereExpressionBuilder<BookCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookCategory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BookCategory.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookCategoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookCategory>(
      where: where?.call(BookCategory.t),
      orderBy: orderBy?.call(BookCategory.t),
      orderByList: orderByList?.call(BookCategory.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookCategoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookCategoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookCategory>(
      where: where?.call(BookCategory.t),
      orderBy: orderBy?.call(BookCategory.t),
      orderByList: orderByList?.call(BookCategory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookCategory] by its [id] or null if no such row exists.
  Future<BookCategory?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<BookCategory>> insert(
    _i1.DatabaseSession session,
    List<BookCategory> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BookCategory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BookCategory] and returns the inserted row.
  ///
  /// The returned [BookCategory] will have its `id` field set.
  Future<BookCategory> insertRow(
    _i1.DatabaseSession session,
    BookCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BookCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BookCategory>> update(
    _i1.DatabaseSession session,
    List<BookCategory> rows, {
    _i1.ColumnSelections<BookCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BookCategory>(
      rows,
      columns: columns?.call(BookCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookCategory> updateRow(
    _i1.DatabaseSession session,
    BookCategory row, {
    _i1.ColumnSelections<BookCategoryTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BookCategoryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BookCategory>(
      id,
      columnValues: columnValues(BookCategory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookCategory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BookCategory>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BookCategoryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BookCategoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookCategoryTable>? orderBy,
    _i1.OrderByListBuilder<BookCategoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BookCategory>(
      columnValues: columnValues(BookCategory.t.updateTable),
      where: where(BookCategory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookCategory.t),
      orderByList: orderByList?.call(BookCategory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BookCategory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BookCategory>> delete(
    _i1.DatabaseSession session,
    List<BookCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BookCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BookCategory].
  Future<BookCategory> deleteRow(
    _i1.DatabaseSession session,
    BookCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BookCategory>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BookCategoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BookCategory>(
      where: where(BookCategory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookCategoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BookCategory>(
      where: where?.call(BookCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookCategory] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BookCategoryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookCategory>(
      where: where(BookCategory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
