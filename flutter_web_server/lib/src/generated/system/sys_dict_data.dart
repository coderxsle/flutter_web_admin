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

/// 字典数据表
abstract class SysDictData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysDictData._({
    this.id,
    this.tenantId,
    required this.code,
    required this.name,
    required this.value,
    this.color,
    required this.sort,
    required this.status,
    this.remark,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
  }) : deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now();

  factory SysDictData({
    int? id,
    int? tenantId,
    required String code,
    required String name,
    required String value,
    String? color,
    required int sort,
    required int status,
    String? remark,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) = _SysDictDataImpl;

  factory SysDictData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDictData(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      value: jsonSerialization['value'] as String,
      color: jsonSerialization['color'] as String?,
      sort: jsonSerialization['sort'] as int,
      status: jsonSerialization['status'] as int,
      remark: jsonSerialization['remark'] as String?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
    );
  }

  static final t = SysDictDataTable();

  static const db = SysDictDataRepository._();

  @override
  int? id;

  int? tenantId;

  String code;

  String name;

  String value;

  String? color;

  int sort;

  int status;

  String? remark;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysDictData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysDictData copyWith({
    int? id,
    int? tenantId,
    String? code,
    String? name,
    String? value,
    String? color,
    int? sort,
    int? status,
    String? remark,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysDictData',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'code': code,
      'name': name,
      'value': value,
      if (color != null) 'color': color,
      'sort': sort,
      'status': status,
      if (remark != null) 'remark': remark,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SysDictData',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'code': code,
      'name': name,
      'value': value,
      if (color != null) 'color': color,
      'sort': sort,
      'status': status,
      if (remark != null) 'remark': remark,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static SysDictDataInclude include() {
    return SysDictDataInclude._();
  }

  static SysDictDataIncludeList includeList({
    _i1.WhereExpressionBuilder<SysDictDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDictDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDictDataTable>? orderByList,
    SysDictDataInclude? include,
  }) {
    return SysDictDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDictData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysDictData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysDictDataImpl extends SysDictData {
  _SysDictDataImpl({
    int? id,
    int? tenantId,
    required String code,
    required String name,
    required String value,
    String? color,
    required int sort,
    required int status,
    String? remark,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         code: code,
         name: name,
         value: value,
         color: color,
         sort: sort,
         status: status,
         remark: remark,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysDictData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysDictData copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    String? code,
    String? name,
    String? value,
    Object? color = _Undefined,
    int? sort,
    int? status,
    Object? remark = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return SysDictData(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      code: code ?? this.code,
      name: name ?? this.name,
      value: value ?? this.value,
      color: color is String? ? color : this.color,
      sort: sort ?? this.sort,
      status: status ?? this.status,
      remark: remark is String? ? remark : this.remark,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class SysDictDataUpdateTable extends _i1.UpdateTable<SysDictDataTable> {
  SysDictDataUpdateTable(super.table);

  _i1.ColumnValue<int, int> tenantId(int? value) => _i1.ColumnValue(
    table.tenantId,
    value,
  );

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> value(String value) => _i1.ColumnValue(
    table.value,
    value,
  );

  _i1.ColumnValue<String, String> color(String? value) => _i1.ColumnValue(
    table.color,
    value,
  );

  _i1.ColumnValue<int, int> sort(int value) => _i1.ColumnValue(
    table.sort,
    value,
  );

  _i1.ColumnValue<int, int> status(int value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> remark(String? value) => _i1.ColumnValue(
    table.remark,
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

  _i1.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _i1.ColumnValue(
        table.updateTime,
        value,
      );
}

class SysDictDataTable extends _i1.Table<int?> {
  SysDictDataTable({super.tableRelation}) : super(tableName: 'sys_dict_data') {
    updateTable = SysDictDataUpdateTable(this);
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    value = _i1.ColumnString(
      'value',
      this,
    );
    color = _i1.ColumnString(
      'color',
      this,
    );
    sort = _i1.ColumnInt(
      'sort',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
    );
    remark = _i1.ColumnString(
      'remark',
      this,
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

  late final SysDictDataUpdateTable updateTable;

  late final _i1.ColumnInt tenantId;

  late final _i1.ColumnString code;

  late final _i1.ColumnString name;

  late final _i1.ColumnString value;

  late final _i1.ColumnString color;

  late final _i1.ColumnInt sort;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString remark;

  late final _i1.ColumnBool deleted;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  @override
  List<_i1.Column> get columns => [
    id,
    tenantId,
    code,
    name,
    value,
    color,
    sort,
    status,
    remark,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class SysDictDataInclude extends _i1.IncludeObject {
  SysDictDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysDictData.t;
}

class SysDictDataIncludeList extends _i1.IncludeList {
  SysDictDataIncludeList._({
    _i1.WhereExpressionBuilder<SysDictDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysDictData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysDictData.t;
}

class SysDictDataRepository {
  const SysDictDataRepository._();

  /// Returns a list of [SysDictData]s matching the given query parameters.
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
  Future<List<SysDictData>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SysDictDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDictDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDictDataTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysDictData>(
      where: where?.call(SysDictData.t),
      orderBy: orderBy?.call(SysDictData.t),
      orderByList: orderByList?.call(SysDictData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysDictData] matching the given query parameters.
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
  Future<SysDictData?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SysDictDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysDictDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDictDataTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysDictData>(
      where: where?.call(SysDictData.t),
      orderBy: orderBy?.call(SysDictData.t),
      orderByList: orderByList?.call(SysDictData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysDictData] by its [id] or null if no such row exists.
  Future<SysDictData?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysDictData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysDictData]s in the list and returns the inserted rows.
  ///
  /// The returned [SysDictData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SysDictData>> insert(
    _i1.DatabaseSession session,
    List<SysDictData> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SysDictData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SysDictData] and returns the inserted row.
  ///
  /// The returned [SysDictData] will have its `id` field set.
  Future<SysDictData> insertRow(
    _i1.DatabaseSession session,
    SysDictData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysDictData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysDictData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysDictData>> update(
    _i1.DatabaseSession session,
    List<SysDictData> rows, {
    _i1.ColumnSelections<SysDictDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysDictData>(
      rows,
      columns: columns?.call(SysDictData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysDictData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysDictData> updateRow(
    _i1.DatabaseSession session,
    SysDictData row, {
    _i1.ColumnSelections<SysDictDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysDictData>(
      row,
      columns: columns?.call(SysDictData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysDictData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysDictData?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SysDictDataUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SysDictData>(
      id,
      columnValues: columnValues(SysDictData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysDictData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SysDictData>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SysDictDataUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SysDictDataTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDictDataTable>? orderBy,
    _i1.OrderByListBuilder<SysDictDataTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SysDictData>(
      columnValues: columnValues(SysDictData.t.updateTable),
      where: where(SysDictData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDictData.t),
      orderByList: orderByList?.call(SysDictData.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SysDictData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysDictData>> delete(
    _i1.DatabaseSession session,
    List<SysDictData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysDictData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysDictData].
  Future<SysDictData> deleteRow(
    _i1.DatabaseSession session,
    SysDictData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysDictData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysDictData>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SysDictDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysDictData>(
      where: where(SysDictData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SysDictDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysDictData>(
      where: where?.call(SysDictData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysDictData] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SysDictDataTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysDictData>(
      where: where(SysDictData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
