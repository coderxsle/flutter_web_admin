/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// 用于记录每本书库存变动的详细信息，便于审计和管理
abstract class BookInventoryLog
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  BookInventoryLog._({
    this.id,
    required this.bookId,
    required this.quantity,
    required this.changeType,
    required this.changeTime,
    this.description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory BookInventoryLog({
    int? id,
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
      bookId: jsonSerialization['bookId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      changeType: jsonSerialization['changeType'] as int,
      changeTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['changeTime']),
      description: jsonSerialization['description'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = BookInventoryLogTable();

  static const db = BookInventoryLogRepository._();

  @override
  int? id;

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
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [BookInventoryLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookInventoryLog copyWith({
    int? id,
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
      if (id != null) 'id': id,
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
      if (id != null) 'id': id,
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
    _i1.WhereExpressionBuilder<BookInventoryLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookInventoryLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookInventoryLogTable>? orderByList,
    BookInventoryLogInclude? include,
  }) {
    return BookInventoryLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookInventoryLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BookInventoryLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookInventoryLogImpl extends BookInventoryLog {
  _BookInventoryLogImpl({
    int? id,
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
  @_i1.useResult
  @override
  BookInventoryLog copyWith({
    Object? id = _Undefined,
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

class BookInventoryLogTable extends _i1.Table<int> {
  BookInventoryLogTable({super.tableRelation})
      : super(tableName: 'book_inventory_log') {
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    changeType = _i1.ColumnInt(
      'changeType',
      this,
    );
    changeTime = _i1.ColumnDateTime(
      'changeTime',
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

  /// 图书ID，用于标识是哪本书
  late final _i1.ColumnInt bookId;

  /// 变动数量，可以为正（增加库存）或负（减少库存）
  late final _i1.ColumnInt quantity;

  /// 变动类型，0=进货，1=售出，2=退货，3=损耗，4=库存调整
  late final _i1.ColumnInt changeType;

  /// 变动发生的时间
  late final _i1.ColumnDateTime changeTime;

  /// 变动的原因或描述，提供额外的说明
  late final _i1.ColumnString description;

  /// 记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  /// 是否删除
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
        id,
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

class BookInventoryLogInclude extends _i1.IncludeObject {
  BookInventoryLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => BookInventoryLog.t;
}

class BookInventoryLogIncludeList extends _i1.IncludeList {
  BookInventoryLogIncludeList._({
    _i1.WhereExpressionBuilder<BookInventoryLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookInventoryLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => BookInventoryLog.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookInventoryLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookInventoryLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookInventoryLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<BookInventoryLog>(
      where: where?.call(BookInventoryLog.t),
      orderBy: orderBy?.call(BookInventoryLog.t),
      orderByList: orderByList?.call(BookInventoryLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookInventoryLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookInventoryLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookInventoryLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<BookInventoryLog>(
      where: where?.call(BookInventoryLog.t),
      orderBy: orderBy?.call(BookInventoryLog.t),
      orderByList: orderByList?.call(BookInventoryLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [BookInventoryLog] by its [id] or null if no such row exists.
  Future<BookInventoryLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<BookInventoryLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [BookInventoryLog]s in the list and returns the inserted rows.
  ///
  /// The returned [BookInventoryLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<BookInventoryLog>> insert(
    _i1.Session session,
    List<BookInventoryLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BookInventoryLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [BookInventoryLog] and returns the inserted row.
  ///
  /// The returned [BookInventoryLog] will have its `id` field set.
  Future<BookInventoryLog> insertRow(
    _i1.Session session,
    BookInventoryLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookInventoryLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BookInventoryLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BookInventoryLog>> update(
    _i1.Session session,
    List<BookInventoryLog> rows, {
    _i1.ColumnSelections<BookInventoryLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BookInventoryLog>(
      rows,
      columns: columns?.call(BookInventoryLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookInventoryLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookInventoryLog> updateRow(
    _i1.Session session,
    BookInventoryLog row, {
    _i1.ColumnSelections<BookInventoryLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookInventoryLog>(
      row,
      columns: columns?.call(BookInventoryLog.t),
      transaction: transaction,
    );
  }

  /// Deletes all [BookInventoryLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BookInventoryLog>> delete(
    _i1.Session session,
    List<BookInventoryLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BookInventoryLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BookInventoryLog].
  Future<BookInventoryLog> deleteRow(
    _i1.Session session,
    BookInventoryLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookInventoryLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BookInventoryLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BookInventoryLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BookInventoryLog>(
      where: where(BookInventoryLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookInventoryLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BookInventoryLog>(
      where: where?.call(BookInventoryLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
