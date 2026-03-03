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

/// 系统API表
abstract class SysApi implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysApi._({
    this.id,
    int? tenantId,
    required this.name,
    required this.path,
    required this.method,
    this.remark,
    int? status,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    this.updateTime,
  }) : tenantId = tenantId ?? 0,
       status = status ?? 1,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now();

  factory SysApi({
    int? id,
    int? tenantId,
    required String name,
    required String path,
    required String method,
    String? remark,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _SysApiImpl;

  factory SysApi.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysApi(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      path: jsonSerialization['path'] as String,
      method: jsonSerialization['method'] as String,
      remark: jsonSerialization['remark'] as String?,
      status: jsonSerialization['status'] as int?,
      deleted: jsonSerialization['deleted'] as bool?,
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  static final t = SysApiTable();

  static const db = SysApiRepository._();

  @override
  int? id;

  int tenantId;

  String name;

  String path;

  String method;

  String? remark;

  int? status;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime? updateTime;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysApi]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysApi copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? path,
    String? method,
    String? remark,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysApi',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'path': path,
      'method': method,
      if (remark != null) 'remark': remark,
      if (status != null) 'status': status,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SysApi',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'path': path,
      'method': method,
      if (remark != null) 'remark': remark,
      if (status != null) 'status': status,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
    };
  }

  static SysApiInclude include() {
    return SysApiInclude._();
  }

  static SysApiIncludeList includeList({
    _i1.WhereExpressionBuilder<SysApiTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysApiTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysApiTable>? orderByList,
    SysApiInclude? include,
  }) {
    return SysApiIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysApi.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysApi.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysApiImpl extends SysApi {
  _SysApiImpl({
    int? id,
    int? tenantId,
    required String name,
    required String path,
    required String method,
    String? remark,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         path: path,
         method: method,
         remark: remark,
         status: status,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysApi]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysApi copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    String? path,
    String? method,
    Object? remark = _Undefined,
    Object? status = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    Object? updateTime = _Undefined,
  }) {
    return SysApi(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      path: path ?? this.path,
      method: method ?? this.method,
      remark: remark is String? ? remark : this.remark,
      status: status is int? ? status : this.status,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime is DateTime? ? updateTime : this.updateTime,
    );
  }
}

class SysApiUpdateTable extends _i1.UpdateTable<SysApiTable> {
  SysApiUpdateTable(super.table);

  _i1.ColumnValue<int, int> tenantId(int value) => _i1.ColumnValue(
    table.tenantId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> path(String value) => _i1.ColumnValue(
    table.path,
    value,
  );

  _i1.ColumnValue<String, String> method(String value) => _i1.ColumnValue(
    table.method,
    value,
  );

  _i1.ColumnValue<String, String> remark(String? value) => _i1.ColumnValue(
    table.remark,
    value,
  );

  _i1.ColumnValue<int, int> status(int? value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<bool, bool> deleted(bool value) => _i1.ColumnValue(
    table.deleted,
    value,
  );

  _i1.ColumnValue<String, String> creator(String? value) => _i1.ColumnValue(
    table.creator,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _i1.ColumnValue(
        table.createTime,
        value,
      );

  _i1.ColumnValue<String, String> updater(String? value) => _i1.ColumnValue(
    table.updater,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updateTime(DateTime? value) =>
      _i1.ColumnValue(
        table.updateTime,
        value,
      );
}

class SysApiTable extends _i1.Table<int?> {
  SysApiTable({super.tableRelation}) : super(tableName: 'sys_api') {
    updateTable = SysApiUpdateTable(this);
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
      hasDefault: true,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    path = _i1.ColumnString(
      'path',
      this,
    );
    method = _i1.ColumnString(
      'method',
      this,
    );
    remark = _i1.ColumnString(
      'remark',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
      hasDefault: true,
    );
    deleted = _i1.ColumnBool(
      'deleted',
      this,
      hasDefault: true,
    );
    creator = _i1.ColumnString(
      'creator',
      this,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
      hasDefault: true,
    );
    updater = _i1.ColumnString(
      'updater',
      this,
    );
    updateTime = _i1.ColumnDateTime(
      'updateTime',
      this,
    );
  }

  late final SysApiUpdateTable updateTable;

  late final _i1.ColumnInt tenantId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString path;

  late final _i1.ColumnString method;

  late final _i1.ColumnString remark;

  late final _i1.ColumnInt status;

  late final _i1.ColumnBool deleted;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  @override
  List<_i1.Column> get columns => [
    id,
    tenantId,
    name,
    path,
    method,
    remark,
    status,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class SysApiInclude extends _i1.IncludeObject {
  SysApiInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysApi.t;
}

class SysApiIncludeList extends _i1.IncludeList {
  SysApiIncludeList._({
    _i1.WhereExpressionBuilder<SysApiTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysApi.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysApi.t;
}

class SysApiRepository {
  const SysApiRepository._();

  /// Returns a list of [SysApi]s matching the given query parameters.
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
  Future<List<SysApi>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysApiTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysApiTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysApiTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysApi>(
      where: where?.call(SysApi.t),
      orderBy: orderBy?.call(SysApi.t),
      orderByList: orderByList?.call(SysApi.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysApi] matching the given query parameters.
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
  Future<SysApi?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysApiTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysApiTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysApiTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysApi>(
      where: where?.call(SysApi.t),
      orderBy: orderBy?.call(SysApi.t),
      orderByList: orderByList?.call(SysApi.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysApi] by its [id] or null if no such row exists.
  Future<SysApi?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysApi>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysApi]s in the list and returns the inserted rows.
  ///
  /// The returned [SysApi]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysApi>> insert(
    _i1.Session session,
    List<SysApi> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysApi>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysApi] and returns the inserted row.
  ///
  /// The returned [SysApi] will have its `id` field set.
  Future<SysApi> insertRow(
    _i1.Session session,
    SysApi row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysApi>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysApi]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysApi>> update(
    _i1.Session session,
    List<SysApi> rows, {
    _i1.ColumnSelections<SysApiTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysApi>(
      rows,
      columns: columns?.call(SysApi.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysApi]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysApi> updateRow(
    _i1.Session session,
    SysApi row, {
    _i1.ColumnSelections<SysApiTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysApi>(
      row,
      columns: columns?.call(SysApi.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysApi] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysApi?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SysApiUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SysApi>(
      id,
      columnValues: columnValues(SysApi.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysApi]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SysApi>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SysApiUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SysApiTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysApiTable>? orderBy,
    _i1.OrderByListBuilder<SysApiTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SysApi>(
      columnValues: columnValues(SysApi.t.updateTable),
      where: where(SysApi.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysApi.t),
      orderByList: orderByList?.call(SysApi.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SysApi]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysApi>> delete(
    _i1.Session session,
    List<SysApi> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysApi>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysApi].
  Future<SysApi> deleteRow(
    _i1.Session session,
    SysApi row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysApi>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysApi>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysApiTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysApi>(
      where: where(SysApi.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysApiTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysApi>(
      where: where?.call(SysApi.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
