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

/// 用于存储用户和角色的关联关系
abstract class SysUserRole
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  SysUserRole._({
    this.id,
    int? roleId,
    int? userId,
  })  : roleId = roleId ?? 0,
        userId = userId ?? 0;

  factory SysUserRole({
    int? id,
    int? roleId,
    int? userId,
  }) = _SysUserRoleImpl;

  factory SysUserRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysUserRole(
      id: jsonSerialization['id'] as int?,
      roleId: jsonSerialization['roleId'] as int,
      userId: jsonSerialization['userId'] as int,
    );
  }

  static final t = SysUserRoleTable();

  static const db = SysUserRoleRepository._();

  @override
  int? id;

  /// 角色id
  int roleId;

  /// 用户id
  int userId;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [SysUserRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysUserRole copyWith({
    int? id,
    int? roleId,
    int? userId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roleId': roleId,
      'userId': userId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'roleId': roleId,
      'userId': userId,
    };
  }

  static SysUserRoleInclude include() {
    return SysUserRoleInclude._();
  }

  static SysUserRoleIncludeList includeList({
    _i1.WhereExpressionBuilder<SysUserRoleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysUserRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysUserRoleTable>? orderByList,
    SysUserRoleInclude? include,
  }) {
    return SysUserRoleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysUserRole.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysUserRole.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysUserRoleImpl extends SysUserRole {
  _SysUserRoleImpl({
    int? id,
    int? roleId,
    int? userId,
  }) : super._(
          id: id,
          roleId: roleId,
          userId: userId,
        );

  /// Returns a shallow copy of this [SysUserRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysUserRole copyWith({
    Object? id = _Undefined,
    int? roleId,
    int? userId,
  }) {
    return SysUserRole(
      id: id is int? ? id : this.id,
      roleId: roleId ?? this.roleId,
      userId: userId ?? this.userId,
    );
  }
}

class SysUserRoleTable extends _i1.Table<int> {
  SysUserRoleTable({super.tableRelation}) : super(tableName: 'sys_user_role') {
    roleId = _i1.ColumnInt(
      'roleId',
      this,
      hasDefault: true,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
      hasDefault: true,
    );
  }

  /// 角色id
  late final _i1.ColumnInt roleId;

  /// 用户id
  late final _i1.ColumnInt userId;

  @override
  List<_i1.Column> get columns => [
        id,
        roleId,
        userId,
      ];
}

class SysUserRoleInclude extends _i1.IncludeObject {
  SysUserRoleInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => SysUserRole.t;
}

class SysUserRoleIncludeList extends _i1.IncludeList {
  SysUserRoleIncludeList._({
    _i1.WhereExpressionBuilder<SysUserRoleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysUserRole.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => SysUserRole.t;
}

class SysUserRoleRepository {
  const SysUserRoleRepository._();

  /// Returns a list of [SysUserRole]s matching the given query parameters.
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
  Future<List<SysUserRole>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysUserRoleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysUserRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysUserRoleTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysUserRole>(
      where: where?.call(SysUserRole.t),
      orderBy: orderBy?.call(SysUserRole.t),
      orderByList: orderByList?.call(SysUserRole.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysUserRole] matching the given query parameters.
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
  Future<SysUserRole?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysUserRoleTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysUserRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysUserRoleTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysUserRole>(
      where: where?.call(SysUserRole.t),
      orderBy: orderBy?.call(SysUserRole.t),
      orderByList: orderByList?.call(SysUserRole.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysUserRole] by its [id] or null if no such row exists.
  Future<SysUserRole?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysUserRole>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysUserRole]s in the list and returns the inserted rows.
  ///
  /// The returned [SysUserRole]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysUserRole>> insert(
    _i1.Session session,
    List<SysUserRole> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysUserRole>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysUserRole] and returns the inserted row.
  ///
  /// The returned [SysUserRole] will have its `id` field set.
  Future<SysUserRole> insertRow(
    _i1.Session session,
    SysUserRole row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysUserRole>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysUserRole]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysUserRole>> update(
    _i1.Session session,
    List<SysUserRole> rows, {
    _i1.ColumnSelections<SysUserRoleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysUserRole>(
      rows,
      columns: columns?.call(SysUserRole.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysUserRole]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysUserRole> updateRow(
    _i1.Session session,
    SysUserRole row, {
    _i1.ColumnSelections<SysUserRoleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysUserRole>(
      row,
      columns: columns?.call(SysUserRole.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysUserRole]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysUserRole>> delete(
    _i1.Session session,
    List<SysUserRole> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysUserRole>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysUserRole].
  Future<SysUserRole> deleteRow(
    _i1.Session session,
    SysUserRole row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysUserRole>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysUserRole>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysUserRoleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysUserRole>(
      where: where(SysUserRole.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysUserRoleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysUserRole>(
      where: where?.call(SysUserRole.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
