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

/// 店铺基本信息表，用于存储店铺的基本信息
abstract class Store implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Store._({
    this.id,
    required this.name,
    this.logo,
    this.address,
    this.contact,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now(),
       isDeleted = isDeleted ?? false;

  factory Store({
    int? id,
    required String name,
    String? logo,
    String? address,
    String? contact,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _StoreImpl;

  factory Store.fromJson(Map<String, dynamic> jsonSerialization) {
    return Store(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      logo: jsonSerialization['logo'] as String?,
      address: jsonSerialization['address'] as String?,
      contact: jsonSerialization['contact'] as String?,
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

  static final t = StoreTable();

  static const db = StoreRepository._();

  @override
  int? id;

  /// 店铺的名称（必填）
  String name;

  /// 店铺的logo
  String? logo;

  /// 店铺的地址
  String? address;

  /// 店铺的联系方式
  String? contact;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否已删除（默认值：false）
  bool isDeleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Store]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Store copyWith({
    int? id,
    String? name,
    String? logo,
    String? address,
    String? contact,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Store',
      if (id != null) 'id': id,
      'name': name,
      if (logo != null) 'logo': logo,
      if (address != null) 'address': address,
      if (contact != null) 'contact': contact,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Store',
      if (id != null) 'id': id,
      'name': name,
      if (logo != null) 'logo': logo,
      if (address != null) 'address': address,
      if (contact != null) 'contact': contact,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static StoreInclude include() {
    return StoreInclude._();
  }

  static StoreIncludeList includeList({
    _is.WhereExpressionBuilder<StoreTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreTable>? orderBy,
    _is.OrderByListBuilder<StoreTable>? orderByList,
    StoreInclude? include,
  }) {
    return StoreIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Store.t),
      orderByList: orderByList?.call(Store.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreImpl extends Store {
  _StoreImpl({
    int? id,
    required String name,
    String? logo,
    String? address,
    String? contact,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
         id: id,
         name: name,
         logo: logo,
         address: address,
         contact: contact,
         createTime: createTime,
         updateTime: updateTime,
         isDeleted: isDeleted,
       );

  /// Returns a shallow copy of this [Store]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Store copyWith({
    Object? id = _Undefined,
    String? name,
    Object? logo = _Undefined,
    Object? address = _Undefined,
    Object? contact = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return Store(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      logo: logo is String? ? logo : this.logo,
      address: address is String? ? address : this.address,
      contact: contact is String? ? contact : this.contact,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class StoreUpdateTable extends _is.UpdateTable<StoreTable> {
  StoreUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> logo(String? value) =>
      _is.ColumnValue(table.logo, value);

  _is.ColumnValue<String, String> address(String? value) =>
      _is.ColumnValue(table.address, value);

  _is.ColumnValue<String, String> contact(String? value) =>
      _is.ColumnValue(table.contact, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> isDeleted(bool value) =>
      _is.ColumnValue(table.isDeleted, value);
}

class StoreTable extends _is.Table<int?> {
  StoreTable({super.tableRelation}) : super(tableName: 'store') {
    updateTable = StoreUpdateTable(this);
    name = _is.ColumnString('name', this);
    logo = _is.ColumnString('logo', this);
    address = _is.ColumnString('address', this);
    contact = _is.ColumnString('contact', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
    isDeleted = _is.ColumnBool('isDeleted', this, hasDefault: true);
  }

  late final StoreUpdateTable updateTable;

  /// 店铺的名称（必填）
  late final _is.ColumnString name;

  /// 店铺的logo
  late final _is.ColumnString logo;

  /// 店铺的地址
  late final _is.ColumnString address;

  /// 店铺的联系方式
  late final _is.ColumnString contact;

  /// 记录创建时间
  late final _is.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _is.ColumnDateTime updateTime;

  /// 是否已删除（默认值：false）
  late final _is.ColumnBool isDeleted;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    logo,
    address,
    contact,
    createTime,
    updateTime,
    isDeleted,
  ];
}

class StoreInclude extends _is.IncludeObject {
  StoreInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Store.t;
}

class StoreIncludeList extends _is.IncludeList {
  StoreIncludeList._({
    _is.WhereExpressionBuilder<StoreTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Store.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Store.t;
}

class StoreRepository {
  const StoreRepository._();

  /// Returns a list of [Store]s matching the given query parameters.
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
  Future<List<Store>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreTable>? orderBy,
    _is.OrderByListBuilder<StoreTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Store>(
      where: where?.call(Store.t),
      orderBy: orderBy?.call(Store.t),
      orderByList: orderByList?.call(Store.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Store] matching the given query parameters.
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
  Future<Store?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreTable>? where,
    int? offset,
    _is.OrderByBuilder<StoreTable>? orderBy,
    _is.OrderByListBuilder<StoreTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Store>(
      where: where?.call(Store.t),
      orderBy: orderBy?.call(Store.t),
      orderByList: orderByList?.call(Store.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Store] by its [id] or null if no such row exists.
  Future<Store?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Store>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Store]s in the list and returns the inserted rows.
  ///
  /// The returned [Store]s will have their `id` fields set.
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
  Future<List<Store>> insert(
    _is.DatabaseSession session,
    List<Store> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Store>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Store] and returns the inserted row.
  ///
  /// The returned [Store] will have its `id` field set.
  Future<Store> insertRow(
    _is.DatabaseSession session,
    Store row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Store>(row, transaction: transaction);
  }

  /// Upserts all [Store]s in the list and returns the resulting rows.
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
  /// The returned [Store]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Store>> upsert(
    _is.DatabaseSession session,
    List<Store> rows, {
    required _is.ColumnSelections<StoreTable> conflictColumns,
    _is.ColumnSelections<StoreTable>? updateColumns,
    _is.WhereExpressionBuilder<StoreTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Store>(
      rows,
      conflictColumns: conflictColumns(Store.t),
      updateColumns: updateColumns?.call(Store.t),
      updateWhere: updateWhere?.call(Store.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Store] and returns the resulting row.
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
  /// The returned [Store] will have its `id` field set.
  Future<Store?> upsertRow(
    _is.DatabaseSession session,
    Store row, {
    required _is.ColumnSelections<StoreTable> conflictColumns,
    _is.ColumnSelections<StoreTable>? updateColumns,
    _is.WhereExpressionBuilder<StoreTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Store>(
      row,
      conflictColumns: conflictColumns(Store.t),
      updateColumns: updateColumns?.call(Store.t),
      updateWhere: updateWhere?.call(Store.t),
      transaction: transaction,
    );
  }

  /// Updates all [Store]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Store>> update(
    _is.DatabaseSession session,
    List<Store> rows, {
    _is.ColumnSelections<StoreTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Store>(
      rows,
      columns: columns?.call(Store.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Store]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Store> updateRow(
    _is.DatabaseSession session,
    Store row, {
    _is.ColumnSelections<StoreTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Store>(
      row,
      columns: columns?.call(Store.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Store] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Store?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StoreUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Store>(
      id,
      columnValues: columnValues(Store.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Store]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Store>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StoreUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StoreTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StoreTable>? orderBy,
    _is.OrderByListBuilder<StoreTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Store>(
      columnValues: columnValues(Store.t.updateTable),
      where: where(Store.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Store.t),
      orderByList: orderByList?.call(Store.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Store]s in the list and returns the deleted rows.
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
  Future<List<Store>> delete(
    _is.DatabaseSession session,
    List<Store> rows, {
    _is.OrderByBuilder<StoreTable>? orderBy,
    _is.OrderByListBuilder<StoreTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Store>(
      rows,
      orderBy: orderBy?.call(Store.t),
      orderByList: orderByList?.call(Store.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Store].
  Future<Store> deleteRow(
    _is.DatabaseSession session,
    Store row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Store>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Store>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoreTable> where,
    _is.OrderByBuilder<StoreTable>? orderBy,
    _is.OrderByListBuilder<StoreTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Store>(
      where: where(Store.t),
      orderBy: orderBy?.call(Store.t),
      orderByList: orderByList?.call(Store.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StoreTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Store>(
      where: where?.call(Store.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Store] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StoreTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Store>(
      where: where(Store.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
