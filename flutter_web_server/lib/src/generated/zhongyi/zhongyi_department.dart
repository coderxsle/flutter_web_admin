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

/// 中医门诊科室
abstract class ZhongyiDepartment implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiDepartment._({
    this.id,
    int? tenantId,
    required this.name,
    required this.code,
    int? parentId,
    int? sortOrder,
    bool? isActive,
    this.phone,
    this.description,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       parentId = parentId ?? 0,
       sortOrder = sortOrder ?? 0,
       isActive = isActive ?? true,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiDepartment({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    int? parentId,
    int? sortOrder,
    bool? isActive,
    String? phone,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiDepartmentImpl;

  factory ZhongyiDepartment.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiDepartment(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      parentId: jsonSerialization['parentId'] as int?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      phone: jsonSerialization['phone'] as String?,
      description: jsonSerialization['description'] as String?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  static final t = ZhongyiDepartmentTable();

  static const db = ZhongyiDepartmentRepository._();

  @override
  int? id;

  /// 租户ID
  int tenantId;

  /// 科室名称
  String name;

  /// 科室编码
  String code;

  /// 上级科室ID
  int? parentId;

  /// 排序
  int sortOrder;

  /// 是否启用
  bool isActive;

  String? phone;

  String? description;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiDepartment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiDepartment copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? code,
    int? parentId,
    int? sortOrder,
    bool? isActive,
    String? phone,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiDepartment',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'code': code,
      if (parentId != null) 'parentId': parentId,
      'sortOrder': sortOrder,
      'isActive': isActive,
      if (phone != null) 'phone': phone,
      if (description != null) 'description': description,
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
      '__className__': 'ZhongyiDepartment',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'code': code,
      if (parentId != null) 'parentId': parentId,
      'sortOrder': sortOrder,
      'isActive': isActive,
      if (phone != null) 'phone': phone,
      if (description != null) 'description': description,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiDepartmentInclude include() {
    return ZhongyiDepartmentInclude._();
  }

  static ZhongyiDepartmentIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiDepartmentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiDepartmentTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiDepartmentTable>? orderByList,
    ZhongyiDepartmentInclude? include,
  }) {
    return ZhongyiDepartmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiDepartment.t),
      orderByList: orderByList?.call(ZhongyiDepartment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiDepartmentImpl extends ZhongyiDepartment {
  _ZhongyiDepartmentImpl({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    int? parentId,
    int? sortOrder,
    bool? isActive,
    String? phone,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         code: code,
         parentId: parentId,
         sortOrder: sortOrder,
         isActive: isActive,
         phone: phone,
         description: description,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiDepartment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiDepartment copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    String? code,
    Object? parentId = _Undefined,
    int? sortOrder,
    bool? isActive,
    Object? phone = _Undefined,
    Object? description = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiDepartment(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      code: code ?? this.code,
      parentId: parentId is int? ? parentId : this.parentId,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      phone: phone is String? ? phone : this.phone,
      description: description is String? ? description : this.description,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiDepartmentUpdateTable extends _is.UpdateTable<ZhongyiDepartmentTable> {
  ZhongyiDepartmentUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> code(String value) => _is.ColumnValue(table.code, value);

  _is.ColumnValue<int, int> parentId(int? value) => _is.ColumnValue(table.parentId, value);

  _is.ColumnValue<int, int> sortOrder(int value) => _is.ColumnValue(table.sortOrder, value);

  _is.ColumnValue<bool, bool> isActive(bool value) => _is.ColumnValue(table.isActive, value);

  _is.ColumnValue<String, String> phone(String? value) => _is.ColumnValue(table.phone, value);

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(table.description, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiDepartmentTable extends _is.Table<int?> {
  ZhongyiDepartmentTable({super.tableRelation}) : super(tableName: 'zhongyi_department') {
    updateTable = ZhongyiDepartmentUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    name = _is.ColumnString('name', this);
    code = _is.ColumnString('code', this);
    parentId = _is.ColumnInt('parentId', this, hasDefault: true);
    sortOrder = _is.ColumnInt('sortOrder', this, hasDefault: true);
    isActive = _is.ColumnBool('isActive', this, hasDefault: true);
    phone = _is.ColumnString('phone', this);
    description = _is.ColumnString('description', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiDepartmentUpdateTable updateTable;

  /// 租户ID
  late final _is.ColumnInt tenantId;

  /// 科室名称
  late final _is.ColumnString name;

  /// 科室编码
  late final _is.ColumnString code;

  /// 上级科室ID
  late final _is.ColumnInt parentId;

  /// 排序
  late final _is.ColumnInt sortOrder;

  /// 是否启用
  late final _is.ColumnBool isActive;

  late final _is.ColumnString phone;

  late final _is.ColumnString description;

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
    parentId,
    sortOrder,
    isActive,
    phone,
    description,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiDepartmentInclude extends _is.IncludeObject {
  ZhongyiDepartmentInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiDepartment.t;
}

class ZhongyiDepartmentIncludeList extends _is.IncludeList {
  ZhongyiDepartmentIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiDepartmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiDepartment.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiDepartment.t;
}

class ZhongyiDepartmentRepository {
  const ZhongyiDepartmentRepository._();

  /// Returns a list of [ZhongyiDepartment]s matching the given query parameters.
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
  Future<List<ZhongyiDepartment>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiDepartmentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiDepartmentTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiDepartmentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiDepartment>(
      where: where?.call(ZhongyiDepartment.t),
      orderBy: orderBy?.call(ZhongyiDepartment.t),
      orderByList: orderByList?.call(ZhongyiDepartment.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiDepartment] matching the given query parameters.
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
  Future<ZhongyiDepartment?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiDepartmentTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiDepartmentTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiDepartmentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiDepartment>(
      where: where?.call(ZhongyiDepartment.t),
      orderBy: orderBy?.call(ZhongyiDepartment.t),
      orderByList: orderByList?.call(ZhongyiDepartment.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiDepartment] by its [id] or null if no such row exists.
  Future<ZhongyiDepartment?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiDepartment>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiDepartment]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiDepartment]s will have their `id` fields set.
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
  Future<List<ZhongyiDepartment>> insert(
    _is.DatabaseSession session,
    List<ZhongyiDepartment> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiDepartment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiDepartment] and returns the inserted row.
  ///
  /// The returned [ZhongyiDepartment] will have its `id` field set.
  Future<ZhongyiDepartment> insertRow(
    _is.DatabaseSession session,
    ZhongyiDepartment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiDepartment>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiDepartment]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiDepartment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiDepartment>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiDepartment> rows, {
    required _is.ColumnSelections<ZhongyiDepartmentTable> conflictColumns,
    _is.ColumnSelections<ZhongyiDepartmentTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiDepartmentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiDepartment>(
      rows,
      conflictColumns: conflictColumns(ZhongyiDepartment.t),
      updateColumns: updateColumns?.call(ZhongyiDepartment.t),
      updateWhere: updateWhere?.call(ZhongyiDepartment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiDepartment] and returns the resulting row.
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
  /// The returned [ZhongyiDepartment] will have its `id` field set.
  Future<ZhongyiDepartment?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiDepartment row, {
    required _is.ColumnSelections<ZhongyiDepartmentTable> conflictColumns,
    _is.ColumnSelections<ZhongyiDepartmentTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiDepartmentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiDepartment>(
      row,
      conflictColumns: conflictColumns(ZhongyiDepartment.t),
      updateColumns: updateColumns?.call(ZhongyiDepartment.t),
      updateWhere: updateWhere?.call(ZhongyiDepartment.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiDepartment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiDepartment>> update(
    _is.DatabaseSession session,
    List<ZhongyiDepartment> rows, {
    _is.ColumnSelections<ZhongyiDepartmentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiDepartment>(
      rows,
      columns: columns?.call(ZhongyiDepartment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiDepartment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiDepartment> updateRow(
    _is.DatabaseSession session,
    ZhongyiDepartment row, {
    _is.ColumnSelections<ZhongyiDepartmentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiDepartment>(
      row,
      columns: columns?.call(ZhongyiDepartment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ZhongyiDepartment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiDepartment?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiDepartmentUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiDepartment>(
      id,
      columnValues: columnValues(ZhongyiDepartment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiDepartment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiDepartment>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiDepartmentUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiDepartmentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiDepartmentTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiDepartmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiDepartment>(
      columnValues: columnValues(ZhongyiDepartment.t.updateTable),
      where: where(ZhongyiDepartment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiDepartment.t),
      orderByList: orderByList?.call(ZhongyiDepartment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiDepartment]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiDepartment>> delete(
    _is.DatabaseSession session,
    List<ZhongyiDepartment> rows, {
    _is.OrderByBuilder<ZhongyiDepartmentTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiDepartmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiDepartment>(
      rows,
      orderBy: orderBy?.call(ZhongyiDepartment.t),
      orderByList: orderByList?.call(ZhongyiDepartment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiDepartment].
  Future<ZhongyiDepartment> deleteRow(
    _is.DatabaseSession session,
    ZhongyiDepartment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiDepartment>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiDepartment>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiDepartmentTable> where,
    _is.OrderByBuilder<ZhongyiDepartmentTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiDepartmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiDepartment>(
      where: where(ZhongyiDepartment.t),
      orderBy: orderBy?.call(ZhongyiDepartment.t),
      orderByList: orderByList?.call(ZhongyiDepartment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiDepartmentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiDepartment>(
      where: where?.call(ZhongyiDepartment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ZhongyiDepartment] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiDepartmentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiDepartment>(
      where: where(ZhongyiDepartment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
