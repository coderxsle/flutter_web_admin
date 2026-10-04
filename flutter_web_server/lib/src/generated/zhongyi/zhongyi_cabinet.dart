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

/// 药斗/药柜
abstract class ZhongyiCabinet implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiCabinet._({
    this.id,
    required this.cabinetNo,
    this.name,
    this.location,
    String? cabinetType,
    this.medicineId,
    this.capacityG,
    bool? isLocked,
    this.description,
    int? status,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : cabinetType = cabinetType ?? 'drawer',
       isLocked = isLocked ?? false,
       status = status ?? 0,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiCabinet({
    int? id,
    required String cabinetNo,
    String? name,
    String? location,
    String? cabinetType,
    int? medicineId,
    int? capacityG,
    bool? isLocked,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiCabinetImpl;

  factory ZhongyiCabinet.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiCabinet(
      id: jsonSerialization['id'] as int?,
      cabinetNo: jsonSerialization['cabinetNo'] as String,
      name: jsonSerialization['name'] as String?,
      location: jsonSerialization['location'] as String?,
      cabinetType: jsonSerialization['cabinetType'] as String?,
      medicineId: jsonSerialization['medicineId'] as int?,
      capacityG: jsonSerialization['capacityG'] as int?,
      isLocked: jsonSerialization['isLocked'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isLocked']),
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as int?,
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

  static final t = ZhongyiCabinetTable();

  static const db = ZhongyiCabinetRepository._();

  @override
  int? id;

  /// 药斗编号
  String cabinetNo;

  /// 药斗名称
  String? name;

  /// 位置
  String? location;

  /// 类型
  String cabinetType;

  /// 存放药品ID
  int? medicineId;

  /// 容量(g)
  int? capacityG;

  /// 是否锁定
  bool isLocked;

  /// 备注
  String? description;

  /// 状态（0停用，1启用）
  int status;

  /// 是否删除
  bool deleted;

  /// 创建人
  String? creator;

  /// 创建时间
  DateTime createTime;

  /// 更新人
  String? updater;

  /// 更新时间
  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiCabinet]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiCabinet copyWith({
    int? id,
    String? cabinetNo,
    String? name,
    String? location,
    String? cabinetType,
    int? medicineId,
    int? capacityG,
    bool? isLocked,
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
      '__className__': 'ZhongyiCabinet',
      if (id != null) 'id': id,
      'cabinetNo': cabinetNo,
      if (name != null) 'name': name,
      if (location != null) 'location': location,
      'cabinetType': cabinetType,
      if (medicineId != null) 'medicineId': medicineId,
      if (capacityG != null) 'capacityG': capacityG,
      'isLocked': isLocked,
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
      '__className__': 'ZhongyiCabinet',
      if (id != null) 'id': id,
      'cabinetNo': cabinetNo,
      if (name != null) 'name': name,
      if (location != null) 'location': location,
      'cabinetType': cabinetType,
      if (medicineId != null) 'medicineId': medicineId,
      if (capacityG != null) 'capacityG': capacityG,
      'isLocked': isLocked,
      if (description != null) 'description': description,
      'status': status,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiCabinetInclude include() {
    return ZhongyiCabinetInclude._();
  }

  static ZhongyiCabinetIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiCabinetTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiCabinetTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiCabinetTable>? orderByList,
    ZhongyiCabinetInclude? include,
  }) {
    return ZhongyiCabinetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiCabinet.t),
      orderByList: orderByList?.call(ZhongyiCabinet.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiCabinetImpl extends ZhongyiCabinet {
  _ZhongyiCabinetImpl({
    int? id,
    required String cabinetNo,
    String? name,
    String? location,
    String? cabinetType,
    int? medicineId,
    int? capacityG,
    bool? isLocked,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         cabinetNo: cabinetNo,
         name: name,
         location: location,
         cabinetType: cabinetType,
         medicineId: medicineId,
         capacityG: capacityG,
         isLocked: isLocked,
         description: description,
         status: status,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiCabinet]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiCabinet copyWith({
    Object? id = _Undefined,
    String? cabinetNo,
    Object? name = _Undefined,
    Object? location = _Undefined,
    String? cabinetType,
    Object? medicineId = _Undefined,
    Object? capacityG = _Undefined,
    bool? isLocked,
    Object? description = _Undefined,
    int? status,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiCabinet(
      id: id is int? ? id : this.id,
      cabinetNo: cabinetNo ?? this.cabinetNo,
      name: name is String? ? name : this.name,
      location: location is String? ? location : this.location,
      cabinetType: cabinetType ?? this.cabinetType,
      medicineId: medicineId is int? ? medicineId : this.medicineId,
      capacityG: capacityG is int? ? capacityG : this.capacityG,
      isLocked: isLocked ?? this.isLocked,
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

class ZhongyiCabinetUpdateTable extends _is.UpdateTable<ZhongyiCabinetTable> {
  ZhongyiCabinetUpdateTable(super.table);

  _is.ColumnValue<String, String> cabinetNo(String value) => _is.ColumnValue(table.cabinetNo, value);

  _is.ColumnValue<String, String> name(String? value) => _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> location(String? value) => _is.ColumnValue(table.location, value);

  _is.ColumnValue<String, String> cabinetType(String value) => _is.ColumnValue(table.cabinetType, value);

  _is.ColumnValue<int, int> medicineId(int? value) => _is.ColumnValue(table.medicineId, value);

  _is.ColumnValue<int, int> capacityG(int? value) => _is.ColumnValue(table.capacityG, value);

  _is.ColumnValue<bool, bool> isLocked(bool value) => _is.ColumnValue(table.isLocked, value);

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(table.description, value);

  _is.ColumnValue<int, int> status(int value) => _is.ColumnValue(table.status, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiCabinetTable extends _is.Table<int?> {
  ZhongyiCabinetTable({super.tableRelation}) : super(tableName: 'zhongyi_cabinet') {
    updateTable = ZhongyiCabinetUpdateTable(this);
    cabinetNo = _is.ColumnString('cabinetNo', this);
    name = _is.ColumnString('name', this);
    location = _is.ColumnString('location', this);
    cabinetType = _is.ColumnString('cabinetType', this, hasDefault: true);
    medicineId = _is.ColumnInt('medicineId', this);
    capacityG = _is.ColumnInt('capacityG', this);
    isLocked = _is.ColumnBool('isLocked', this, hasDefault: true);
    description = _is.ColumnString('description', this);
    status = _is.ColumnInt('status', this, hasDefault: true);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiCabinetUpdateTable updateTable;

  /// 药斗编号
  late final _is.ColumnString cabinetNo;

  /// 药斗名称
  late final _is.ColumnString name;

  /// 位置
  late final _is.ColumnString location;

  /// 类型
  late final _is.ColumnString cabinetType;

  /// 存放药品ID
  late final _is.ColumnInt medicineId;

  /// 容量(g)
  late final _is.ColumnInt capacityG;

  /// 是否锁定
  late final _is.ColumnBool isLocked;

  /// 备注
  late final _is.ColumnString description;

  /// 状态（0停用，1启用）
  late final _is.ColumnInt status;

  /// 是否删除
  late final _is.ColumnBool deleted;

  /// 创建人
  late final _is.ColumnString creator;

  /// 创建时间
  late final _is.ColumnDateTime createTime;

  /// 更新人
  late final _is.ColumnString updater;

  /// 更新时间
  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    cabinetNo,
    name,
    location,
    cabinetType,
    medicineId,
    capacityG,
    isLocked,
    description,
    status,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiCabinetInclude extends _is.IncludeObject {
  ZhongyiCabinetInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiCabinet.t;
}

class ZhongyiCabinetIncludeList extends _is.IncludeList {
  ZhongyiCabinetIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiCabinetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiCabinet.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiCabinet.t;
}

class ZhongyiCabinetRepository {
  const ZhongyiCabinetRepository._();

  /// Returns a list of [ZhongyiCabinet]s matching the given query parameters.
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
  Future<List<ZhongyiCabinet>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiCabinetTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiCabinetTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiCabinetTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiCabinet>(
      where: where?.call(ZhongyiCabinet.t),
      orderBy: orderBy?.call(ZhongyiCabinet.t),
      orderByList: orderByList?.call(ZhongyiCabinet.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiCabinet] matching the given query parameters.
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
  Future<ZhongyiCabinet?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiCabinetTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiCabinetTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiCabinetTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiCabinet>(
      where: where?.call(ZhongyiCabinet.t),
      orderBy: orderBy?.call(ZhongyiCabinet.t),
      orderByList: orderByList?.call(ZhongyiCabinet.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiCabinet] by its [id] or null if no such row exists.
  Future<ZhongyiCabinet?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiCabinet>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiCabinet]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiCabinet]s will have their `id` fields set.
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
  Future<List<ZhongyiCabinet>> insert(
    _is.DatabaseSession session,
    List<ZhongyiCabinet> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiCabinet>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiCabinet] and returns the inserted row.
  ///
  /// The returned [ZhongyiCabinet] will have its `id` field set.
  Future<ZhongyiCabinet> insertRow(
    _is.DatabaseSession session,
    ZhongyiCabinet row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiCabinet>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiCabinet]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiCabinet]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiCabinet>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiCabinet> rows, {
    required _is.ColumnSelections<ZhongyiCabinetTable> conflictColumns,
    _is.ColumnSelections<ZhongyiCabinetTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiCabinetTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiCabinet>(
      rows,
      conflictColumns: conflictColumns(ZhongyiCabinet.t),
      updateColumns: updateColumns?.call(ZhongyiCabinet.t),
      updateWhere: updateWhere?.call(ZhongyiCabinet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiCabinet] and returns the resulting row.
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
  /// The returned [ZhongyiCabinet] will have its `id` field set.
  Future<ZhongyiCabinet?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiCabinet row, {
    required _is.ColumnSelections<ZhongyiCabinetTable> conflictColumns,
    _is.ColumnSelections<ZhongyiCabinetTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiCabinetTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiCabinet>(
      row,
      conflictColumns: conflictColumns(ZhongyiCabinet.t),
      updateColumns: updateColumns?.call(ZhongyiCabinet.t),
      updateWhere: updateWhere?.call(ZhongyiCabinet.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiCabinet]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiCabinet>> update(
    _is.DatabaseSession session,
    List<ZhongyiCabinet> rows, {
    _is.ColumnSelections<ZhongyiCabinetTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiCabinet>(
      rows,
      columns: columns?.call(ZhongyiCabinet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiCabinet]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiCabinet> updateRow(
    _is.DatabaseSession session,
    ZhongyiCabinet row, {
    _is.ColumnSelections<ZhongyiCabinetTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiCabinet>(
      row,
      columns: columns?.call(ZhongyiCabinet.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ZhongyiCabinet] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiCabinet?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiCabinetUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiCabinet>(
      id,
      columnValues: columnValues(ZhongyiCabinet.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiCabinet]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiCabinet>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiCabinetUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiCabinetTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiCabinetTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiCabinetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiCabinet>(
      columnValues: columnValues(ZhongyiCabinet.t.updateTable),
      where: where(ZhongyiCabinet.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiCabinet.t),
      orderByList: orderByList?.call(ZhongyiCabinet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiCabinet]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiCabinet>> delete(
    _is.DatabaseSession session,
    List<ZhongyiCabinet> rows, {
    _is.OrderByBuilder<ZhongyiCabinetTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiCabinetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiCabinet>(
      rows,
      orderBy: orderBy?.call(ZhongyiCabinet.t),
      orderByList: orderByList?.call(ZhongyiCabinet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiCabinet].
  Future<ZhongyiCabinet> deleteRow(
    _is.DatabaseSession session,
    ZhongyiCabinet row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiCabinet>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiCabinet>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiCabinetTable> where,
    _is.OrderByBuilder<ZhongyiCabinetTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiCabinetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiCabinet>(
      where: where(ZhongyiCabinet.t),
      orderBy: orderBy?.call(ZhongyiCabinet.t),
      orderByList: orderByList?.call(ZhongyiCabinet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiCabinetTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiCabinet>(
      where: where?.call(ZhongyiCabinet.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ZhongyiCabinet] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiCabinetTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiCabinet>(
      where: where(ZhongyiCabinet.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
