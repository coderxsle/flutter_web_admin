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

/// 用于定义系统角色与权限之间的关系，支持细粒度的权限管理
abstract class RolePermission
    implements _i1.TableRow, _i1.ProtocolSerialization {
  RolePermission._({
    this.id,
    required this.roleId,
    required this.permissionKey,
    DateTime? createTime,
    DateTime? updateTime,
  })  : createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now();

  factory RolePermission({
    int? id,
    required int roleId,
    required String permissionKey,
    DateTime? createTime,
    DateTime? updateTime,
  }) = _RolePermissionImpl;

  factory RolePermission.fromJson(Map<String, dynamic> jsonSerialization) {
    return RolePermission(
      id: jsonSerialization['id'] as int?,
      roleId: jsonSerialization['roleId'] as int,
      permissionKey: jsonSerialization['permissionKey'] as String,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  static final t = RolePermissionTable();

  static const db = RolePermissionRepository._();

  @override
  int? id;

  /// 角色ID，用于关联角色表
  int roleId;

  /// 权限标识，用于定义具体的权限（如 "READ_BOOK", "MANAGE_USERS"）
  String permissionKey;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  @override
  _i1.Table get table => t;

  RolePermission copyWith({
    int? id,
    int? roleId,
    String? permissionKey,
    DateTime? createTime,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roleId': roleId,
      'permissionKey': permissionKey,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'roleId': roleId,
      'permissionKey': permissionKey,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
    };
  }

  static RolePermissionInclude include() {
    return RolePermissionInclude._();
  }

  static RolePermissionIncludeList includeList({
    _i1.WhereExpressionBuilder<RolePermissionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RolePermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RolePermissionTable>? orderByList,
    RolePermissionInclude? include,
  }) {
    return RolePermissionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RolePermission.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RolePermission.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RolePermissionImpl extends RolePermission {
  _RolePermissionImpl({
    int? id,
    required int roleId,
    required String permissionKey,
    DateTime? createTime,
    DateTime? updateTime,
  }) : super._(
          id: id,
          roleId: roleId,
          permissionKey: permissionKey,
          createTime: createTime,
          updateTime: updateTime,
        );

  @override
  RolePermission copyWith({
    Object? id = _Undefined,
    int? roleId,
    String? permissionKey,
    DateTime? createTime,
    DateTime? updateTime,
  }) {
    return RolePermission(
      id: id is int? ? id : this.id,
      roleId: roleId ?? this.roleId,
      permissionKey: permissionKey ?? this.permissionKey,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class RolePermissionTable extends _i1.Table {
  RolePermissionTable({super.tableRelation})
      : super(tableName: 'role_permission') {
    roleId = _i1.ColumnInt(
      'roleId',
      this,
    );
    permissionKey = _i1.ColumnString(
      'permissionKey',
      this,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
      hasDefault: true,
    );
    updateTime = _i1.ColumnDateTime(
      'updateTime',
      this,
      hasDefault: true,
    );
  }

  /// 角色ID，用于关联角色表
  late final _i1.ColumnInt roleId;

  /// 权限标识，用于定义具体的权限（如 "READ_BOOK", "MANAGE_USERS"）
  late final _i1.ColumnString permissionKey;

  /// 记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  @override
  List<_i1.Column> get columns => [
        id,
        roleId,
        permissionKey,
        createTime,
        updateTime,
      ];
}

class RolePermissionInclude extends _i1.IncludeObject {
  RolePermissionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => RolePermission.t;
}

class RolePermissionIncludeList extends _i1.IncludeList {
  RolePermissionIncludeList._({
    _i1.WhereExpressionBuilder<RolePermissionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RolePermission.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => RolePermission.t;
}

class RolePermissionRepository {
  const RolePermissionRepository._();

  Future<List<RolePermission>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RolePermissionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RolePermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RolePermissionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<RolePermission>(
      where: where?.call(RolePermission.t),
      orderBy: orderBy?.call(RolePermission.t),
      orderByList: orderByList?.call(RolePermission.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<RolePermission?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RolePermissionTable>? where,
    int? offset,
    _i1.OrderByBuilder<RolePermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RolePermissionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<RolePermission>(
      where: where?.call(RolePermission.t),
      orderBy: orderBy?.call(RolePermission.t),
      orderByList: orderByList?.call(RolePermission.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<RolePermission?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<RolePermission>(
      id,
      transaction: transaction,
    );
  }

  Future<List<RolePermission>> insert(
    _i1.Session session,
    List<RolePermission> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RolePermission>(
      rows,
      transaction: transaction,
    );
  }

  Future<RolePermission> insertRow(
    _i1.Session session,
    RolePermission row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RolePermission>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RolePermission>> update(
    _i1.Session session,
    List<RolePermission> rows, {
    _i1.ColumnSelections<RolePermissionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RolePermission>(
      rows,
      columns: columns?.call(RolePermission.t),
      transaction: transaction,
    );
  }

  Future<RolePermission> updateRow(
    _i1.Session session,
    RolePermission row, {
    _i1.ColumnSelections<RolePermissionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RolePermission>(
      row,
      columns: columns?.call(RolePermission.t),
      transaction: transaction,
    );
  }

  Future<List<RolePermission>> delete(
    _i1.Session session,
    List<RolePermission> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RolePermission>(
      rows,
      transaction: transaction,
    );
  }

  Future<RolePermission> deleteRow(
    _i1.Session session,
    RolePermission row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RolePermission>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RolePermission>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RolePermissionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RolePermission>(
      where: where(RolePermission.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RolePermissionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RolePermission>(
      where: where?.call(RolePermission.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
