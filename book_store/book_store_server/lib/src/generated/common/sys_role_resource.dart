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

/// 用于存储角色和资源的关联关系
abstract class SysRoleResource
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  SysRoleResource._({
    this.id,
    int? roleId,
    int? resourceId,
  })  : roleId = roleId ?? 0,
        resourceId = resourceId ?? 0;

  factory SysRoleResource({
    int? id,
    int? roleId,
    int? resourceId,
  }) = _SysRoleResourceImpl;

  factory SysRoleResource.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysRoleResource(
      id: jsonSerialization['id'] as int?,
      roleId: jsonSerialization['roleId'] as int,
      resourceId: jsonSerialization['resourceId'] as int,
    );
  }

  static final t = SysRoleResourceTable();

  static const db = SysRoleResourceRepository._();

  @override
  int? id;

  /// 角色id
  int roleId;

  /// 资源id
  int resourceId;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [SysRoleResource]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysRoleResource copyWith({
    int? id,
    int? roleId,
    int? resourceId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roleId': roleId,
      'resourceId': resourceId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'roleId': roleId,
      'resourceId': resourceId,
    };
  }

  static SysRoleResourceInclude include() {
    return SysRoleResourceInclude._();
  }

  static SysRoleResourceIncludeList includeList({
    _i1.WhereExpressionBuilder<SysRoleResourceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysRoleResourceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysRoleResourceTable>? orderByList,
    SysRoleResourceInclude? include,
  }) {
    return SysRoleResourceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysRoleResource.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysRoleResource.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysRoleResourceImpl extends SysRoleResource {
  _SysRoleResourceImpl({
    int? id,
    int? roleId,
    int? resourceId,
  }) : super._(
          id: id,
          roleId: roleId,
          resourceId: resourceId,
        );

  /// Returns a shallow copy of this [SysRoleResource]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysRoleResource copyWith({
    Object? id = _Undefined,
    int? roleId,
    int? resourceId,
  }) {
    return SysRoleResource(
      id: id is int? ? id : this.id,
      roleId: roleId ?? this.roleId,
      resourceId: resourceId ?? this.resourceId,
    );
  }
}

class SysRoleResourceTable extends _i1.Table<int> {
  SysRoleResourceTable({super.tableRelation})
      : super(tableName: 'sys_role_resource') {
    roleId = _i1.ColumnInt(
      'roleId',
      this,
      hasDefault: true,
    );
    resourceId = _i1.ColumnInt(
      'resourceId',
      this,
      hasDefault: true,
    );
  }

  /// 角色id
  late final _i1.ColumnInt roleId;

  /// 资源id
  late final _i1.ColumnInt resourceId;

  @override
  List<_i1.Column> get columns => [
        id,
        roleId,
        resourceId,
      ];
}

class SysRoleResourceInclude extends _i1.IncludeObject {
  SysRoleResourceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => SysRoleResource.t;
}

class SysRoleResourceIncludeList extends _i1.IncludeList {
  SysRoleResourceIncludeList._({
    _i1.WhereExpressionBuilder<SysRoleResourceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysRoleResource.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => SysRoleResource.t;
}

class SysRoleResourceRepository {
  const SysRoleResourceRepository._();

  /// Returns a list of [SysRoleResource]s matching the given query parameters.
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
  Future<List<SysRoleResource>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysRoleResourceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysRoleResourceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysRoleResourceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysRoleResource>(
      where: where?.call(SysRoleResource.t),
      orderBy: orderBy?.call(SysRoleResource.t),
      orderByList: orderByList?.call(SysRoleResource.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysRoleResource] matching the given query parameters.
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
  Future<SysRoleResource?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysRoleResourceTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysRoleResourceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysRoleResourceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysRoleResource>(
      where: where?.call(SysRoleResource.t),
      orderBy: orderBy?.call(SysRoleResource.t),
      orderByList: orderByList?.call(SysRoleResource.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysRoleResource] by its [id] or null if no such row exists.
  Future<SysRoleResource?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysRoleResource>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysRoleResource]s in the list and returns the inserted rows.
  ///
  /// The returned [SysRoleResource]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysRoleResource>> insert(
    _i1.Session session,
    List<SysRoleResource> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysRoleResource>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysRoleResource] and returns the inserted row.
  ///
  /// The returned [SysRoleResource] will have its `id` field set.
  Future<SysRoleResource> insertRow(
    _i1.Session session,
    SysRoleResource row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysRoleResource>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysRoleResource]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysRoleResource>> update(
    _i1.Session session,
    List<SysRoleResource> rows, {
    _i1.ColumnSelections<SysRoleResourceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysRoleResource>(
      rows,
      columns: columns?.call(SysRoleResource.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysRoleResource]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysRoleResource> updateRow(
    _i1.Session session,
    SysRoleResource row, {
    _i1.ColumnSelections<SysRoleResourceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysRoleResource>(
      row,
      columns: columns?.call(SysRoleResource.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysRoleResource]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysRoleResource>> delete(
    _i1.Session session,
    List<SysRoleResource> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysRoleResource>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysRoleResource].
  Future<SysRoleResource> deleteRow(
    _i1.Session session,
    SysRoleResource row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysRoleResource>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysRoleResource>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysRoleResourceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysRoleResource>(
      where: where(SysRoleResource.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysRoleResourceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysRoleResource>(
      where: where?.call(SysRoleResource.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
