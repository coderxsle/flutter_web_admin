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

/// 书籍基本信息表，用于存储书籍的基本信息
abstract class Book implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Book._({
    this.id,
    int? tenantId,
    this.categoryId,
    required this.name,
    this.isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    required this.originalPrice,
    bool? isDeleted,
    DateTime? createTime,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       author = author ?? '',
       keyword = keyword ?? '',
       publisher = publisher ?? '',
       image = image ?? '',
       isDeleted = isDeleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory Book({
    int? id,
    int? tenantId,
    int? categoryId,
    required String name,
    String? isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    required double originalPrice,
    bool? isDeleted,
    DateTime? createTime,
    DateTime? updateTime,
  }) = _BookImpl;

  factory Book.fromJson(Map<String, dynamic> jsonSerialization) {
    return Book(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      categoryId: jsonSerialization['categoryId'] as int?,
      name: jsonSerialization['name'] as String,
      isbn: jsonSerialization['isbn'] as String?,
      author: jsonSerialization['author'] as String?,
      keyword: jsonSerialization['keyword'] as String?,
      publisher: jsonSerialization['publisher'] as String?,
      image: jsonSerialization['image'] as String?,
      originalPrice: (jsonSerialization['originalPrice'] as num).toDouble(),
      isDeleted: jsonSerialization['isDeleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isDeleted']),
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  static final t = BookTable();

  static const db = BookRepository._();

  @override
  int? id;

  /// 租户ID（0 表示系统租户）
  int? tenantId;

  /// 书籍分类的ID，用于关联分类表
  int? categoryId;

  /// 书籍的标题/书名（必填，唯一约束）
  String name;

  /// 书籍的ISBN编号，用于唯一标识一本书（唯一约束）
  String? isbn;

  /// 书籍的作者姓名
  String author;

  /// 关键字
  String keyword;

  /// 出版社名称
  String publisher;

  /// 书籍封面的图片URL地址
  String image;

  /// 书籍的原价/定价（必填）
  double originalPrice;

  bool isDeleted;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Book copyWith({
    int? id,
    int? tenantId,
    int? categoryId,
    String? name,
    String? isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    double? originalPrice,
    bool? isDeleted,
    DateTime? createTime,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Book',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      if (categoryId != null) 'categoryId': categoryId,
      'name': name,
      if (isbn != null) 'isbn': isbn,
      'author': author,
      'keyword': keyword,
      'publisher': publisher,
      'image': image,
      'originalPrice': originalPrice,
      'isDeleted': isDeleted,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Book',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      if (categoryId != null) 'categoryId': categoryId,
      'name': name,
      if (isbn != null) 'isbn': isbn,
      'author': author,
      'keyword': keyword,
      'publisher': publisher,
      'image': image,
      'originalPrice': originalPrice,
      'isDeleted': isDeleted,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
    };
  }

  static BookInclude include() {
    return BookInclude._();
  }

  static BookIncludeList includeList({
    _is.WhereExpressionBuilder<BookTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookTable>? orderBy,
    _is.OrderByListBuilder<BookTable>? orderByList,
    BookInclude? include,
  }) {
    return BookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookImpl extends Book {
  _BookImpl({
    int? id,
    int? tenantId,
    int? categoryId,
    required String name,
    String? isbn,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    required double originalPrice,
    bool? isDeleted,
    DateTime? createTime,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         categoryId: categoryId,
         name: name,
         isbn: isbn,
         author: author,
         keyword: keyword,
         publisher: publisher,
         image: image,
         originalPrice: originalPrice,
         isDeleted: isDeleted,
         createTime: createTime,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Book copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    Object? categoryId = _Undefined,
    String? name,
    Object? isbn = _Undefined,
    String? author,
    String? keyword,
    String? publisher,
    String? image,
    double? originalPrice,
    bool? isDeleted,
    DateTime? createTime,
    DateTime? updateTime,
  }) {
    return Book(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      name: name ?? this.name,
      isbn: isbn is String? ? isbn : this.isbn,
      author: author ?? this.author,
      keyword: keyword ?? this.keyword,
      publisher: publisher ?? this.publisher,
      image: image ?? this.image,
      originalPrice: originalPrice ?? this.originalPrice,
      isDeleted: isDeleted ?? this.isDeleted,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class BookUpdateTable extends _is.UpdateTable<BookTable> {
  BookUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int? value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> categoryId(int? value) =>
      _is.ColumnValue(table.categoryId, value);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> isbn(String? value) =>
      _is.ColumnValue(table.isbn, value);

  _is.ColumnValue<String, String> author(String value) =>
      _is.ColumnValue(table.author, value);

  _is.ColumnValue<String, String> keyword(String value) =>
      _is.ColumnValue(table.keyword, value);

  _is.ColumnValue<String, String> publisher(String value) =>
      _is.ColumnValue(table.publisher, value);

  _is.ColumnValue<String, String> image(String value) =>
      _is.ColumnValue(table.image, value);

  _is.ColumnValue<double, double> originalPrice(double value) =>
      _is.ColumnValue(table.originalPrice, value);

  _is.ColumnValue<bool, bool> isDeleted(bool value) =>
      _is.ColumnValue(table.isDeleted, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);
}

class BookTable extends _is.Table<int?> {
  BookTable({super.tableRelation}) : super(tableName: 'book') {
    updateTable = BookUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    categoryId = _is.ColumnInt('categoryId', this);
    name = _is.ColumnString('name', this);
    isbn = _is.ColumnString('isbn', this);
    author = _is.ColumnString('author', this, hasDefault: true);
    keyword = _is.ColumnString('keyword', this, hasDefault: true);
    publisher = _is.ColumnString('publisher', this, hasDefault: true);
    image = _is.ColumnString('image', this, hasDefault: true);
    originalPrice = _is.ColumnDouble('originalPrice', this);
    isDeleted = _is.ColumnBool('isDeleted', this, hasDefault: true);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final BookUpdateTable updateTable;

  /// 租户ID（0 表示系统租户）
  late final _is.ColumnInt tenantId;

  /// 书籍分类的ID，用于关联分类表
  late final _is.ColumnInt categoryId;

  /// 书籍的标题/书名（必填，唯一约束）
  late final _is.ColumnString name;

  /// 书籍的ISBN编号，用于唯一标识一本书（唯一约束）
  late final _is.ColumnString isbn;

  /// 书籍的作者姓名
  late final _is.ColumnString author;

  /// 关键字
  late final _is.ColumnString keyword;

  /// 出版社名称
  late final _is.ColumnString publisher;

  /// 书籍封面的图片URL地址
  late final _is.ColumnString image;

  /// 书籍的原价/定价（必填）
  late final _is.ColumnDouble originalPrice;

  late final _is.ColumnBool isDeleted;

  /// 记录创建时间
  late final _is.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    categoryId,
    name,
    isbn,
    author,
    keyword,
    publisher,
    image,
    originalPrice,
    isDeleted,
    createTime,
    updateTime,
  ];
}

class BookInclude extends _is.IncludeObject {
  BookInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Book.t;
}

class BookIncludeList extends _is.IncludeList {
  BookIncludeList._({
    _is.WhereExpressionBuilder<BookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Book.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Book.t;
}

class BookRepository {
  const BookRepository._();

  /// Returns a list of [Book]s matching the given query parameters.
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
  Future<List<Book>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookTable>? orderBy,
    _is.OrderByListBuilder<BookTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Book>(
      where: where?.call(Book.t),
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Book] matching the given query parameters.
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
  Future<Book?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookTable>? where,
    int? offset,
    _is.OrderByBuilder<BookTable>? orderBy,
    _is.OrderByListBuilder<BookTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Book>(
      where: where?.call(Book.t),
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Book] by its [id] or null if no such row exists.
  Future<Book?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Book>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Book]s in the list and returns the inserted rows.
  ///
  /// The returned [Book]s will have their `id` fields set.
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
  Future<List<Book>> insert(
    _is.DatabaseSession session,
    List<Book> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Book>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Book] and returns the inserted row.
  ///
  /// The returned [Book] will have its `id` field set.
  Future<Book> insertRow(
    _is.DatabaseSession session,
    Book row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Book>(row, transaction: transaction);
  }

  /// Upserts all [Book]s in the list and returns the resulting rows.
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
  /// The returned [Book]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Book>> upsert(
    _is.DatabaseSession session,
    List<Book> rows, {
    required _is.ColumnSelections<BookTable> conflictColumns,
    _is.ColumnSelections<BookTable>? updateColumns,
    _is.WhereExpressionBuilder<BookTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Book>(
      rows,
      conflictColumns: conflictColumns(Book.t),
      updateColumns: updateColumns?.call(Book.t),
      updateWhere: updateWhere?.call(Book.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Book] and returns the resulting row.
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
  /// The returned [Book] will have its `id` field set.
  Future<Book?> upsertRow(
    _is.DatabaseSession session,
    Book row, {
    required _is.ColumnSelections<BookTable> conflictColumns,
    _is.ColumnSelections<BookTable>? updateColumns,
    _is.WhereExpressionBuilder<BookTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Book>(
      row,
      conflictColumns: conflictColumns(Book.t),
      updateColumns: updateColumns?.call(Book.t),
      updateWhere: updateWhere?.call(Book.t),
      transaction: transaction,
    );
  }

  /// Updates all [Book]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Book>> update(
    _is.DatabaseSession session,
    List<Book> rows, {
    _is.ColumnSelections<BookTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Book>(
      rows,
      columns: columns?.call(Book.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Book]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Book> updateRow(
    _is.DatabaseSession session,
    Book row, {
    _is.ColumnSelections<BookTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Book>(
      row,
      columns: columns?.call(Book.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Book] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Book?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Book>(
      id,
      columnValues: columnValues(Book.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Book]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Book>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BookTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookTable>? orderBy,
    _is.OrderByListBuilder<BookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Book>(
      columnValues: columnValues(Book.t.updateTable),
      where: where(Book.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Book]s in the list and returns the deleted rows.
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
  Future<List<Book>> delete(
    _is.DatabaseSession session,
    List<Book> rows, {
    _is.OrderByBuilder<BookTable>? orderBy,
    _is.OrderByListBuilder<BookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Book>(
      rows,
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Book].
  Future<Book> deleteRow(
    _is.DatabaseSession session,
    Book row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Book>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Book>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookTable> where,
    _is.OrderByBuilder<BookTable>? orderBy,
    _is.OrderByListBuilder<BookTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Book>(
      where: where(Book.t),
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Book>(
      where: where?.call(Book.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Book] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Book>(
      where: where(Book.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
