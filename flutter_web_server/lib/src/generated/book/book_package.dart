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

/// 用于存储书籍组合套装的基本信息。
abstract class BookPackage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  BookPackage._({
    this.id,
    int? tenantId,
    String? name,
    String? contentDescription,
    required this.originalPrice,
    double? discountRate,
    required this.salePrice,
    int? status,
    this.startTime,
    this.endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : tenantId = tenantId ?? 0,
       name = name ?? '',
       contentDescription = contentDescription ?? '',
       discountRate = discountRate ?? 1.0,
       status = status ?? 0,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now(),
       isDeleted = isDeleted ?? false;

  factory BookPackage({
    int? id,
    int? tenantId,
    String? name,
    String? contentDescription,
    required double originalPrice,
    double? discountRate,
    required double salePrice,
    int? status,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _BookPackageImpl;

  factory BookPackage.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookPackage(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String?,
      contentDescription: jsonSerialization['contentDescription'] as String?,
      originalPrice: (jsonSerialization['originalPrice'] as num).toDouble(),
      discountRate: (jsonSerialization['discountRate'] as num?)?.toDouble(),
      salePrice: (jsonSerialization['salePrice'] as num).toDouble(),
      status: jsonSerialization['status'] as int?,
      startTime: jsonSerialization['startTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startTime']),
      endTime: jsonSerialization['endTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
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

  static final t = BookPackageTable();

  static const db = BookPackageRepository._();

  @override
  int? id;

  /// 租户ID（0 表示系统租户）
  int? tenantId;

  /// 套装名称（必填）
  String name;

  /// 套装的描述内容
  String contentDescription;

  /// 套装的原价（各书原价总和）
  double originalPrice;

  /// 折扣率（例：0.8 表示八折）
  double discountRate;

  /// 套装的组合价格（实际售价）
  double salePrice;

  /// 套装状态：0-下架，1-上架，2-预售
  int status;

  /// 生效时间
  DateTime? startTime;

  /// 失效时间
  DateTime? endTime;

  /// 套装记录创建时间
  DateTime createTime;

  /// 套装记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookPackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookPackage copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? contentDescription,
    double? originalPrice,
    double? discountRate,
    double? salePrice,
    int? status,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookPackage',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'name': name,
      'contentDescription': contentDescription,
      'originalPrice': originalPrice,
      'discountRate': discountRate,
      'salePrice': salePrice,
      'status': status,
      if (startTime != null) 'startTime': startTime?.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookPackage',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'name': name,
      'contentDescription': contentDescription,
      'originalPrice': originalPrice,
      'discountRate': discountRate,
      'salePrice': salePrice,
      'status': status,
      if (startTime != null) 'startTime': startTime?.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static BookPackageInclude include() {
    return BookPackageInclude._();
  }

  static BookPackageIncludeList includeList({
    _i1.WhereExpressionBuilder<BookPackageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookPackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookPackageTable>? orderByList,
    BookPackageInclude? include,
  }) {
    return BookPackageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookPackage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BookPackage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookPackageImpl extends BookPackage {
  _BookPackageImpl({
    int? id,
    int? tenantId,
    String? name,
    String? contentDescription,
    required double originalPrice,
    double? discountRate,
    required double salePrice,
    int? status,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         contentDescription: contentDescription,
         originalPrice: originalPrice,
         discountRate: discountRate,
         salePrice: salePrice,
         status: status,
         startTime: startTime,
         endTime: endTime,
         createTime: createTime,
         updateTime: updateTime,
         isDeleted: isDeleted,
       );

  /// Returns a shallow copy of this [BookPackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookPackage copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    String? name,
    String? contentDescription,
    double? originalPrice,
    double? discountRate,
    double? salePrice,
    int? status,
    Object? startTime = _Undefined,
    Object? endTime = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return BookPackage(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      name: name ?? this.name,
      contentDescription: contentDescription ?? this.contentDescription,
      originalPrice: originalPrice ?? this.originalPrice,
      discountRate: discountRate ?? this.discountRate,
      salePrice: salePrice ?? this.salePrice,
      status: status ?? this.status,
      startTime: startTime is DateTime? ? startTime : this.startTime,
      endTime: endTime is DateTime? ? endTime : this.endTime,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class BookPackageUpdateTable extends _i1.UpdateTable<BookPackageTable> {
  BookPackageUpdateTable(super.table);

  _i1.ColumnValue<int, int> tenantId(int? value) => _i1.ColumnValue(
    table.tenantId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> contentDescription(String value) =>
      _i1.ColumnValue(
        table.contentDescription,
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

  _i1.ColumnValue<double, double> salePrice(double value) => _i1.ColumnValue(
    table.salePrice,
    value,
  );

  _i1.ColumnValue<int, int> status(int value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startTime(DateTime? value) =>
      _i1.ColumnValue(
        table.startTime,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endTime(DateTime? value) =>
      _i1.ColumnValue(
        table.endTime,
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

class BookPackageTable extends _i1.Table<int?> {
  BookPackageTable({super.tableRelation}) : super(tableName: 'book_package') {
    updateTable = BookPackageUpdateTable(this);
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
      hasDefault: true,
    );
    name = _i1.ColumnString(
      'name',
      this,
      hasDefault: true,
    );
    contentDescription = _i1.ColumnString(
      'contentDescription',
      this,
      hasDefault: true,
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
    salePrice = _i1.ColumnDouble(
      'salePrice',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
      hasDefault: true,
    );
    startTime = _i1.ColumnDateTime(
      'startTime',
      this,
    );
    endTime = _i1.ColumnDateTime(
      'endTime',
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

  late final BookPackageUpdateTable updateTable;

  /// 租户ID（0 表示系统租户）
  late final _i1.ColumnInt tenantId;

  /// 套装名称（必填）
  late final _i1.ColumnString name;

  /// 套装的描述内容
  late final _i1.ColumnString contentDescription;

  /// 套装的原价（各书原价总和）
  late final _i1.ColumnDouble originalPrice;

  /// 折扣率（例：0.8 表示八折）
  late final _i1.ColumnDouble discountRate;

  /// 套装的组合价格（实际售价）
  late final _i1.ColumnDouble salePrice;

  /// 套装状态：0-下架，1-上架，2-预售
  late final _i1.ColumnInt status;

  /// 生效时间
  late final _i1.ColumnDateTime startTime;

  /// 失效时间
  late final _i1.ColumnDateTime endTime;

  /// 套装记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 套装记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  /// 是否删除
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
    id,
    tenantId,
    name,
    contentDescription,
    originalPrice,
    discountRate,
    salePrice,
    status,
    startTime,
    endTime,
    createTime,
    updateTime,
    isDeleted,
  ];
}

class BookPackageInclude extends _i1.IncludeObject {
  BookPackageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BookPackage.t;
}

class BookPackageIncludeList extends _i1.IncludeList {
  BookPackageIncludeList._({
    _i1.WhereExpressionBuilder<BookPackageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookPackage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BookPackage.t;
}

class BookPackageRepository {
  const BookPackageRepository._();

  /// Returns a list of [BookPackage]s matching the given query parameters.
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
  Future<List<BookPackage>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookPackageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookPackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookPackageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookPackage>(
      where: where?.call(BookPackage.t),
      orderBy: orderBy?.call(BookPackage.t),
      orderByList: orderByList?.call(BookPackage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BookPackage] matching the given query parameters.
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
  Future<BookPackage?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookPackageTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookPackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookPackageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookPackage>(
      where: where?.call(BookPackage.t),
      orderBy: orderBy?.call(BookPackage.t),
      orderByList: orderByList?.call(BookPackage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookPackage] by its [id] or null if no such row exists.
  Future<BookPackage?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BookPackage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BookPackage]s in the list and returns the inserted rows.
  ///
  /// The returned [BookPackage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<BookPackage>> insert(
    _i1.DatabaseSession session,
    List<BookPackage> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BookPackage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BookPackage] and returns the inserted row.
  ///
  /// The returned [BookPackage] will have its `id` field set.
  Future<BookPackage> insertRow(
    _i1.DatabaseSession session,
    BookPackage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookPackage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BookPackage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BookPackage>> update(
    _i1.DatabaseSession session,
    List<BookPackage> rows, {
    _i1.ColumnSelections<BookPackageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BookPackage>(
      rows,
      columns: columns?.call(BookPackage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookPackage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookPackage> updateRow(
    _i1.DatabaseSession session,
    BookPackage row, {
    _i1.ColumnSelections<BookPackageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookPackage>(
      row,
      columns: columns?.call(BookPackage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookPackage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookPackage?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BookPackageUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BookPackage>(
      id,
      columnValues: columnValues(BookPackage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookPackage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BookPackage>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BookPackageUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BookPackageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookPackageTable>? orderBy,
    _i1.OrderByListBuilder<BookPackageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BookPackage>(
      columnValues: columnValues(BookPackage.t.updateTable),
      where: where(BookPackage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookPackage.t),
      orderByList: orderByList?.call(BookPackage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BookPackage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BookPackage>> delete(
    _i1.DatabaseSession session,
    List<BookPackage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BookPackage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BookPackage].
  Future<BookPackage> deleteRow(
    _i1.DatabaseSession session,
    BookPackage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookPackage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BookPackage>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BookPackageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BookPackage>(
      where: where(BookPackage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookPackageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BookPackage>(
      where: where?.call(BookPackage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookPackage] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BookPackageTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookPackage>(
      where: where(BookPackage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
