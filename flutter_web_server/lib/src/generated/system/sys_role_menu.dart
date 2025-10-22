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

/// 角色和菜单关联表
abstract class SysRoleMenu
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysRoleMenu._({
    this.id,
    int? tenantId,
    required this.roleId,
    required this.menuId,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory SysRoleMenu({
    int? id,
    int? tenantId,
    required int roleId,
    required int menuId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysRoleMenuImpl;

  factory SysRoleMenu.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysRoleMenu(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      roleId: jsonSerialization['roleId'] as int,
      menuId: jsonSerialization['menuId'] as int,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysRoleMenuTable();

  static const db = SysRoleMenuRepository._();

  @override
  int? id;

  int tenantId;

  int roleId;

  int menuId;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysRoleMenu]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysRoleMenu copyWith({
    int? id,
    int? tenantId,
    int? roleId,
    int? menuId,
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
      'tenantId': tenantId,
      'roleId': roleId,
      'menuId': menuId,
      if (creator != null) 'creator': creator,
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
      'tenantId': tenantId,
      'roleId': roleId,
      'menuId': menuId,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysRoleMenuInclude include() {
    return SysRoleMenuInclude._();
  }

  static SysRoleMenuIncludeList includeList({
    _i1.WhereExpressionBuilder<SysRoleMenuTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysRoleMenuTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysRoleMenuTable>? orderByList,
    SysRoleMenuInclude? include,
  }) {
    return SysRoleMenuIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysRoleMenu.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysRoleMenu.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysRoleMenuImpl extends SysRoleMenu {
  _SysRoleMenuImpl({
    int? id,
    int? tenantId,
    required int roleId,
    required int menuId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          roleId: roleId,
          menuId: menuId,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysRoleMenu]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysRoleMenu copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? roleId,
    int? menuId,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysRoleMenu(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      roleId: roleId ?? this.roleId,
      menuId: menuId ?? this.menuId,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysRoleMenuTable extends _i1.Table<int?> {
  SysRoleMenuTable({super.tableRelation}) : super(tableName: 'sys_role_menu') {
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
      hasDefault: true,
    );
    roleId = _i1.ColumnInt(
      'roleId',
      this,
    );
    menuId = _i1.ColumnInt(
      'menuId',
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

  late final _i1.ColumnInt tenantId;

  late final _i1.ColumnInt roleId;

  late final _i1.ColumnInt menuId;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        tenantId,
        roleId,
        menuId,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysRoleMenuInclude extends _i1.IncludeObject {
  SysRoleMenuInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysRoleMenu.t;
}

class SysRoleMenuIncludeList extends _i1.IncludeList {
  SysRoleMenuIncludeList._({
    _i1.WhereExpressionBuilder<SysRoleMenuTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysRoleMenu.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysRoleMenu.t;
}

class SysRoleMenuRepository {
  const SysRoleMenuRepository._();

  /// Returns a list of [SysRoleMenu]s matching the given query parameters.
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
  Future<List<SysRoleMenu>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysRoleMenuTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysRoleMenuTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysRoleMenuTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysRoleMenu>(
      where: where?.call(SysRoleMenu.t),
      orderBy: orderBy?.call(SysRoleMenu.t),
      orderByList: orderByList?.call(SysRoleMenu.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysRoleMenu] matching the given query parameters.
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
  Future<SysRoleMenu?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysRoleMenuTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysRoleMenuTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysRoleMenuTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysRoleMenu>(
      where: where?.call(SysRoleMenu.t),
      orderBy: orderBy?.call(SysRoleMenu.t),
      orderByList: orderByList?.call(SysRoleMenu.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysRoleMenu] by its [id] or null if no such row exists.
  Future<SysRoleMenu?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysRoleMenu>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysRoleMenu]s in the list and returns the inserted rows.
  ///
  /// The returned [SysRoleMenu]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysRoleMenu>> insert(
    _i1.Session session,
    List<SysRoleMenu> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysRoleMenu>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysRoleMenu] and returns the inserted row.
  ///
  /// The returned [SysRoleMenu] will have its `id` field set.
  Future<SysRoleMenu> insertRow(
    _i1.Session session,
    SysRoleMenu row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysRoleMenu>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysRoleMenu]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysRoleMenu>> update(
    _i1.Session session,
    List<SysRoleMenu> rows, {
    _i1.ColumnSelections<SysRoleMenuTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysRoleMenu>(
      rows,
      columns: columns?.call(SysRoleMenu.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysRoleMenu]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysRoleMenu> updateRow(
    _i1.Session session,
    SysRoleMenu row, {
    _i1.ColumnSelections<SysRoleMenuTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysRoleMenu>(
      row,
      columns: columns?.call(SysRoleMenu.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysRoleMenu]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysRoleMenu>> delete(
    _i1.Session session,
    List<SysRoleMenu> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysRoleMenu>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysRoleMenu].
  Future<SysRoleMenu> deleteRow(
    _i1.Session session,
    SysRoleMenu row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysRoleMenu>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysRoleMenu>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysRoleMenuTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysRoleMenu>(
      where: where(SysRoleMenu.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysRoleMenuTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysRoleMenu>(
      where: where?.call(SysRoleMenu.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
