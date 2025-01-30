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
    implements _i1.TableRow, _i1.ProtocolSerialization {
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
  _i1.Table get table => t;

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

class SysRoleResourceTable extends _i1.Table {
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
  _i1.Table get table => SysRoleResource.t;
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
  _i1.Table get table => SysRoleResource.t;
}

class SysRoleResourceRepository {
  const SysRoleResourceRepository._();

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
