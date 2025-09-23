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
    required this.name,
    this.description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory BookCategory({
    int? id,
    required String name,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _BookCategoryImpl;

  factory BookCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = BookCategoryTable();

  static const db = BookCategoryRepository._();

  @override
  int? id;

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
    String? name,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
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
      if (id != null) 'id': id,
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
    required String name,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
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
    String? name,
    Object? description = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return BookCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class BookCategoryTable extends _i1.Table<int?> {
  BookCategoryTable({super.tableRelation}) : super(tableName: 'book_category') {
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookCategoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<BookCategory>(
      where: where?.call(BookCategory.t),
      orderBy: orderBy?.call(BookCategory.t),
      orderByList: orderByList?.call(BookCategory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookCategoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookCategoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<BookCategory>(
      where: where?.call(BookCategory.t),
      orderBy: orderBy?.call(BookCategory.t),
      orderByList: orderByList?.call(BookCategory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [BookCategory] by its [id] or null if no such row exists.
  Future<BookCategory?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<BookCategory>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [BookCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [BookCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<BookCategory>> insert(
    _i1.Session session,
    List<BookCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BookCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [BookCategory] and returns the inserted row.
  ///
  /// The returned [BookCategory] will have its `id` field set.
  Future<BookCategory> insertRow(
    _i1.Session session,
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
    _i1.Session session,
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
    _i1.Session session,
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

  /// Deletes all [BookCategory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BookCategory>> delete(
    _i1.Session session,
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
    _i1.Session session,
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
    _i1.Session session, {
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
    _i1.Session session, {
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
}
