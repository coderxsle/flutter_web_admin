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
import 'package:flutter_web_server/src/generated/protocol.dart' as _ii4hkddg;
import 'package:serverpod/serverpod.dart' as _is;
import '../system/sys_api.dart' as _i7sy8eed;
import '../system/sys_menu.dart' as _i7cd37b3;

/// 系统角色表 - 支持多租户、数据权限范围控制
abstract class SysRole
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysRole._({
    this.id,
    int? tenantId,
    required this.name,
    required this.code,
    required this.sort,
    required this.type,
    int? dataScope,
    this.dataScopeDeptIds,
    this.menus,
    this.apis,
    this.description,
    required this.status,
    required this.deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
  }) : tenantId = tenantId ?? 0,
       dataScope = dataScope ?? 5,
       createTime = createTime ?? DateTime.now();

  factory SysRole({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    required int sort,
    required int type,
    int? dataScope,
    List<int>? dataScopeDeptIds,
    List<_i7cd37b3.SysMenu>? menus,
    List<_i7sy8eed.SysApi>? apis,
    String? description,
    required int status,
    required bool deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) = _SysRoleImpl;

  factory SysRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysRole(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      sort: jsonSerialization['sort'] as int,
      type: jsonSerialization['type'] as int,
      dataScope: jsonSerialization['dataScope'] as int?,
      dataScopeDeptIds: jsonSerialization['dataScopeDeptIds'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<List<int>>(
              jsonSerialization['dataScopeDeptIds'],
            ),
      menus: jsonSerialization['menus'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<List<_i7cd37b3.SysMenu>>(
              jsonSerialization['menus'],
            ),
      apis: jsonSerialization['apis'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<List<_i7sy8eed.SysApi>>(
              jsonSerialization['apis'],
            ),
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as int,
      deleted: _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
    );
  }

  static final t = SysRoleTable();

  static const db = SysRoleRepository._();

  @override
  int? id;

  int tenantId;

  String name;

  String code;

  int sort;

  int type;

  int dataScope;

  List<int>? dataScopeDeptIds;

  List<_i7cd37b3.SysMenu>? menus;

  List<_i7sy8eed.SysApi>? apis;

  String? description;

  int status;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysRole]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysRole copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? code,
    int? sort,
    int? type,
    int? dataScope,
    List<int>? dataScopeDeptIds,
    List<_i7cd37b3.SysMenu>? menus,
    List<_i7sy8eed.SysApi>? apis,
    String? description,
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
      '__className__': 'SysRole',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'code': code,
      'sort': sort,
      'type': type,
      'dataScope': dataScope,
      if (dataScopeDeptIds != null)
        'dataScopeDeptIds': dataScopeDeptIds?.toJson(),
      if (menus != null) 'menus': menus?.toJson(valueToJson: (v) => v.toJson()),
      if (apis != null) 'apis': apis?.toJson(valueToJson: (v) => v.toJson()),
      if (description != null) 'description': description,
      'status': status,
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
      '__className__': 'SysRole',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'code': code,
      'sort': sort,
      'type': type,
      'dataScope': dataScope,
      if (dataScopeDeptIds != null)
        'dataScopeDeptIds': dataScopeDeptIds?.toJson(),
      if (menus != null)
        'menus': menus?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (apis != null)
        'apis': apis?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (description != null) 'description': description,
      'status': status,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static SysRoleInclude include() {
    return SysRoleInclude._();
  }

  static SysRoleIncludeList includeList({
    _is.WhereExpressionBuilder<SysRoleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysRoleTable>? orderBy,
    _is.OrderByListBuilder<SysRoleTable>? orderByList,
    SysRoleInclude? include,
  }) {
    return SysRoleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysRole.t),
      orderByList: orderByList?.call(SysRole.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysRoleImpl extends SysRole {
  _SysRoleImpl({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    required int sort,
    required int type,
    int? dataScope,
    List<int>? dataScopeDeptIds,
    List<_i7cd37b3.SysMenu>? menus,
    List<_i7sy8eed.SysApi>? apis,
    String? description,
    required int status,
    required bool deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         code: code,
         sort: sort,
         type: type,
         dataScope: dataScope,
         dataScopeDeptIds: dataScopeDeptIds,
         menus: menus,
         apis: apis,
         description: description,
         status: status,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysRole]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysRole copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    String? code,
    int? sort,
    int? type,
    int? dataScope,
    Object? dataScopeDeptIds = _Undefined,
    Object? menus = _Undefined,
    Object? apis = _Undefined,
    Object? description = _Undefined,
    int? status,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return SysRole(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      code: code ?? this.code,
      sort: sort ?? this.sort,
      type: type ?? this.type,
      dataScope: dataScope ?? this.dataScope,
      dataScopeDeptIds: dataScopeDeptIds is List<int>?
          ? dataScopeDeptIds
          : this.dataScopeDeptIds?.map((e0) => e0).toList(),
      menus: menus is List<_i7cd37b3.SysMenu>?
          ? menus
          : this.menus?.map((e0) => e0.copyWith()).toList(),
      apis: apis is List<_i7sy8eed.SysApi>?
          ? apis
          : this.apis?.map((e0) => e0.copyWith()).toList(),
      description: description is String? ? description : this.description,
      status: status ?? this.status,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class SysRoleUpdateTable extends _is.UpdateTable<SysRoleTable> {
  SysRoleUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> code(String value) =>
      _is.ColumnValue(table.code, value);

  _is.ColumnValue<int, int> sort(int value) =>
      _is.ColumnValue(table.sort, value);

  _is.ColumnValue<int, int> type(int value) =>
      _is.ColumnValue(table.type, value);

  _is.ColumnValue<int, int> dataScope(int value) =>
      _is.ColumnValue(table.dataScope, value);

  _is.ColumnValue<List<int>, List<int>> dataScopeDeptIds(List<int>? value) =>
      _is.ColumnValue(table.dataScopeDeptIds, value);

  _is.ColumnValue<List<_i7cd37b3.SysMenu>, List<_i7cd37b3.SysMenu>> menus(
    List<_i7cd37b3.SysMenu>? value,
  ) => _is.ColumnValue(table.menus, value);

  _is.ColumnValue<List<_i7sy8eed.SysApi>, List<_i7sy8eed.SysApi>> apis(
    List<_i7sy8eed.SysApi>? value,
  ) => _is.ColumnValue(table.apis, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<int, int> status(int value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<bool, bool> deleted(bool value) =>
      _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) =>
      _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) =>
      _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);
}

class SysRoleTable extends _is.Table<int?> {
  SysRoleTable({super.tableRelation}) : super(tableName: 'sys_role') {
    updateTable = SysRoleUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    name = _is.ColumnString('name', this);
    code = _is.ColumnString('code', this);
    sort = _is.ColumnInt('sort', this);
    type = _is.ColumnInt('type', this);
    dataScope = _is.ColumnInt('dataScope', this, hasDefault: true);
    dataScopeDeptIds = _is.ColumnSerializable<List<int>>(
      'dataScopeDeptIds',
      this,
    );
    menus = _is.ColumnSerializable<List<_i7cd37b3.SysMenu>>('menus', this);
    apis = _is.ColumnSerializable<List<_i7sy8eed.SysApi>>('apis', this);
    description = _is.ColumnString('description', this);
    status = _is.ColumnInt('status', this);
    deleted = _is.ColumnBool('deleted', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
  }

  late final SysRoleUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString name;

  late final _is.ColumnString code;

  late final _is.ColumnInt sort;

  late final _is.ColumnInt type;

  late final _is.ColumnInt dataScope;

  late final _is.ColumnSerializable<List<int>> dataScopeDeptIds;

  late final _is.ColumnSerializable<List<_i7cd37b3.SysMenu>> menus;

  late final _is.ColumnSerializable<List<_i7sy8eed.SysApi>> apis;

  late final _is.ColumnString description;

  late final _is.ColumnInt status;

  late final _is.ColumnBool deleted;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    name,
    code,
    sort,
    type,
    dataScope,
    dataScopeDeptIds,
    menus,
    apis,
    description,
    status,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class SysRoleInclude extends _is.IncludeObject {
  SysRoleInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysRole.t;
}

class SysRoleIncludeList extends _is.IncludeList {
  SysRoleIncludeList._({
    _is.WhereExpressionBuilder<SysRoleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysRole.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysRole.t;
}

class SysRoleRepository {
  const SysRoleRepository._();

  /// Returns a list of [SysRole]s matching the given query parameters.
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
  Future<List<SysRole>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysRoleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysRoleTable>? orderBy,
    _is.OrderByListBuilder<SysRoleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysRole>(
      where: where?.call(SysRole.t),
      orderBy: orderBy?.call(SysRole.t),
      orderByList: orderByList?.call(SysRole.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysRole] matching the given query parameters.
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
  Future<SysRole?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysRoleTable>? where,
    int? offset,
    _is.OrderByBuilder<SysRoleTable>? orderBy,
    _is.OrderByListBuilder<SysRoleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysRole>(
      where: where?.call(SysRole.t),
      orderBy: orderBy?.call(SysRole.t),
      orderByList: orderByList?.call(SysRole.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysRole] by its [id] or null if no such row exists.
  Future<SysRole?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysRole>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysRole]s in the list and returns the inserted rows.
  ///
  /// The returned [SysRole]s will have their `id` fields set.
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
  Future<List<SysRole>> insert(
    _is.DatabaseSession session,
    List<SysRole> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysRole>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysRole] and returns the inserted row.
  ///
  /// The returned [SysRole] will have its `id` field set.
  Future<SysRole> insertRow(
    _is.DatabaseSession session,
    SysRole row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysRole>(row, transaction: transaction);
  }

  /// Upserts all [SysRole]s in the list and returns the resulting rows.
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
  /// The returned [SysRole]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysRole>> upsert(
    _is.DatabaseSession session,
    List<SysRole> rows, {
    required _is.ColumnSelections<SysRoleTable> conflictColumns,
    _is.ColumnSelections<SysRoleTable>? updateColumns,
    _is.WhereExpressionBuilder<SysRoleTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysRole>(
      rows,
      conflictColumns: conflictColumns(SysRole.t),
      updateColumns: updateColumns?.call(SysRole.t),
      updateWhere: updateWhere?.call(SysRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysRole] and returns the resulting row.
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
  /// The returned [SysRole] will have its `id` field set.
  Future<SysRole?> upsertRow(
    _is.DatabaseSession session,
    SysRole row, {
    required _is.ColumnSelections<SysRoleTable> conflictColumns,
    _is.ColumnSelections<SysRoleTable>? updateColumns,
    _is.WhereExpressionBuilder<SysRoleTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysRole>(
      row,
      conflictColumns: conflictColumns(SysRole.t),
      updateColumns: updateColumns?.call(SysRole.t),
      updateWhere: updateWhere?.call(SysRole.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysRole]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysRole>> update(
    _is.DatabaseSession session,
    List<SysRole> rows, {
    _is.ColumnSelections<SysRoleTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysRole>(
      rows,
      columns: columns?.call(SysRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysRole]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysRole> updateRow(
    _is.DatabaseSession session,
    SysRole row, {
    _is.ColumnSelections<SysRoleTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysRole>(
      row,
      columns: columns?.call(SysRole.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysRole] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysRole?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysRoleUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysRole>(
      id,
      columnValues: columnValues(SysRole.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysRole]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysRole>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysRoleUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysRoleTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysRoleTable>? orderBy,
    _is.OrderByListBuilder<SysRoleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysRole>(
      columnValues: columnValues(SysRole.t.updateTable),
      where: where(SysRole.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysRole.t),
      orderByList: orderByList?.call(SysRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysRole]s in the list and returns the deleted rows.
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
  Future<List<SysRole>> delete(
    _is.DatabaseSession session,
    List<SysRole> rows, {
    _is.OrderByBuilder<SysRoleTable>? orderBy,
    _is.OrderByListBuilder<SysRoleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysRole>(
      rows,
      orderBy: orderBy?.call(SysRole.t),
      orderByList: orderByList?.call(SysRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysRole].
  Future<SysRole> deleteRow(
    _is.DatabaseSession session,
    SysRole row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysRole>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysRole>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysRoleTable> where,
    _is.OrderByBuilder<SysRoleTable>? orderBy,
    _is.OrderByListBuilder<SysRoleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysRole>(
      where: where(SysRole.t),
      orderBy: orderBy?.call(SysRole.t),
      orderByList: orderByList?.call(SysRole.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysRoleTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysRole>(
      where: where?.call(SysRole.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysRole] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysRoleTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysRole>(
      where: where(SysRole.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
