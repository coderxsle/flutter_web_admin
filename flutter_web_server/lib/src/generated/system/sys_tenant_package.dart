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

/// 租户套餐表
abstract class SysTenantPackage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysTenantPackage._({
    this.id,
    required this.name,
    required this.status,
    this.remark,
    required this.menuIds,
    required this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysTenantPackage({
    int? id,
    required String name,
    required int status,
    String? remark,
    required String menuIds,
    required String creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysTenantPackageImpl;

  factory SysTenantPackage.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysTenantPackage(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] as int,
      remark: jsonSerialization['remark'] as String?,
      menuIds: jsonSerialization['menuIds'] as String,
      creator: jsonSerialization['creator'] as String,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysTenantPackageTable();

  static const db = SysTenantPackageRepository._();

  @override
  int? id;

  String name;

  int status;

  String? remark;

  String menuIds;

  String creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysTenantPackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysTenantPackage copyWith({
    int? id,
    String? name,
    int? status,
    String? remark,
    String? menuIds,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'status': status,
      if (remark != null) 'remark': remark,
      'menuIds': menuIds,
      'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'status': status,
      if (remark != null) 'remark': remark,
      'menuIds': menuIds,
      'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysTenantPackageInclude include() {
    return SysTenantPackageInclude._();
  }

  static SysTenantPackageIncludeList includeList({
    _i1.WhereExpressionBuilder<SysTenantPackageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysTenantPackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysTenantPackageTable>? orderByList,
    SysTenantPackageInclude? include,
  }) {
    return SysTenantPackageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysTenantPackage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysTenantPackage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysTenantPackageImpl extends SysTenantPackage {
  _SysTenantPackageImpl({
    int? id,
    required String name,
    required int status,
    String? remark,
    required String menuIds,
    required String creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          name: name,
          status: status,
          remark: remark,
          menuIds: menuIds,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysTenantPackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysTenantPackage copyWith({
    Object? id = _Undefined,
    String? name,
    int? status,
    Object? remark = _Undefined,
    String? menuIds,
    String? creator,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysTenantPackage(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      remark: remark is String? ? remark : this.remark,
      menuIds: menuIds ?? this.menuIds,
      creator: creator ?? this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysTenantPackageTable extends _i1.Table<int?> {
  SysTenantPackageTable({super.tableRelation})
      : super(tableName: 'sys_tenant_package') {
    name = _i1.ColumnString(
      'name',
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
    menuIds = _i1.ColumnString(
      'menuIds',
      this,
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
    deleted = _i1.ColumnBool(
      'deleted',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString remark;

  late final _i1.ColumnString menuIds;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        status,
        remark,
        menuIds,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysTenantPackageInclude extends _i1.IncludeObject {
  SysTenantPackageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysTenantPackage.t;
}

class SysTenantPackageIncludeList extends _i1.IncludeList {
  SysTenantPackageIncludeList._({
    _i1.WhereExpressionBuilder<SysTenantPackageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysTenantPackage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysTenantPackage.t;
}

class SysTenantPackageRepository {
  const SysTenantPackageRepository._();

  /// Returns a list of [SysTenantPackage]s matching the given query parameters.
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
  Future<List<SysTenantPackage>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysTenantPackageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysTenantPackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysTenantPackageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysTenantPackage>(
      where: where?.call(SysTenantPackage.t),
      orderBy: orderBy?.call(SysTenantPackage.t),
      orderByList: orderByList?.call(SysTenantPackage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysTenantPackage] matching the given query parameters.
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
  Future<SysTenantPackage?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysTenantPackageTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysTenantPackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysTenantPackageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysTenantPackage>(
      where: where?.call(SysTenantPackage.t),
      orderBy: orderBy?.call(SysTenantPackage.t),
      orderByList: orderByList?.call(SysTenantPackage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysTenantPackage] by its [id] or null if no such row exists.
  Future<SysTenantPackage?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysTenantPackage>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysTenantPackage]s in the list and returns the inserted rows.
  ///
  /// The returned [SysTenantPackage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysTenantPackage>> insert(
    _i1.Session session,
    List<SysTenantPackage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysTenantPackage>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysTenantPackage] and returns the inserted row.
  ///
  /// The returned [SysTenantPackage] will have its `id` field set.
  Future<SysTenantPackage> insertRow(
    _i1.Session session,
    SysTenantPackage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysTenantPackage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysTenantPackage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysTenantPackage>> update(
    _i1.Session session,
    List<SysTenantPackage> rows, {
    _i1.ColumnSelections<SysTenantPackageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysTenantPackage>(
      rows,
      columns: columns?.call(SysTenantPackage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysTenantPackage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysTenantPackage> updateRow(
    _i1.Session session,
    SysTenantPackage row, {
    _i1.ColumnSelections<SysTenantPackageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysTenantPackage>(
      row,
      columns: columns?.call(SysTenantPackage.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysTenantPackage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysTenantPackage>> delete(
    _i1.Session session,
    List<SysTenantPackage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysTenantPackage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysTenantPackage].
  Future<SysTenantPackage> deleteRow(
    _i1.Session session,
    SysTenantPackage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysTenantPackage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysTenantPackage>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysTenantPackageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysTenantPackage>(
      where: where(SysTenantPackage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysTenantPackageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysTenantPackage>(
      where: where?.call(SysTenantPackage.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
