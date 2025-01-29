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

/// 用于存储系统角色信息
abstract class SysRole implements _i1.TableRow, _i1.ProtocolSerialization {
  SysRole._({
    this.id,
    String? name,
  }) : name = name ?? '';

  factory SysRole({
    int? id,
    String? name,
  }) = _SysRoleImpl;

  factory SysRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysRole(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
    );
  }

  static final t = SysRoleTable();

  static const db = SysRoleRepository._();

  @override
  int? id;

  /// 角色名称
  String name;

  @override
  _i1.Table get table => t;

  SysRole copyWith({
    int? id,
    String? name,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
    };
  }

  static SysRoleInclude include() {
    return SysRoleInclude._();
  }

  static SysRoleIncludeList includeList({
    _i1.WhereExpressionBuilder<SysRoleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysRoleTable>? orderByList,
    SysRoleInclude? include,
  }) {
    return SysRoleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysRole.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysRole.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysRoleImpl extends SysRole {
  _SysRoleImpl({
    int? id,
    String? name,
  }) : super._(
          id: id,
          name: name,
        );

  @override
  SysRole copyWith({
    Object? id = _Undefined,
    String? name,
  }) {
    return SysRole(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
    );
  }
}

class SysRoleTable extends _i1.Table {
  SysRoleTable({super.tableRelation}) : super(tableName: 'sys_role') {
    name = _i1.ColumnString(
      'name',
      this,
      hasDefault: true,
    );
  }

  /// 角色名称
  late final _i1.ColumnString name;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
      ];
}

class SysRoleInclude extends _i1.IncludeObject {
  SysRoleInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => SysRole.t;
}

class SysRoleIncludeList extends _i1.IncludeList {
  SysRoleIncludeList._({
    _i1.WhereExpressionBuilder<SysRoleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysRole.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => SysRole.t;
}

class SysRoleRepository {
  const SysRoleRepository._();

  Future<List<SysRole>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysRoleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysRoleTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysRole>(
      where: where?.call(SysRole.t),
      orderBy: orderBy?.call(SysRole.t),
      orderByList: orderByList?.call(SysRole.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<SysRole?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysRoleTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysRoleTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysRole>(
      where: where?.call(SysRole.t),
      orderBy: orderBy?.call(SysRole.t),
      orderByList: orderByList?.call(SysRole.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<SysRole?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysRole>(
      id,
      transaction: transaction,
    );
  }

  Future<List<SysRole>> insert(
    _i1.Session session,
    List<SysRole> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysRole>(
      rows,
      transaction: transaction,
    );
  }

  Future<SysRole> insertRow(
    _i1.Session session,
    SysRole row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysRole>(
      row,
      transaction: transaction,
    );
  }

  Future<List<SysRole>> update(
    _i1.Session session,
    List<SysRole> rows, {
    _i1.ColumnSelections<SysRoleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysRole>(
      rows,
      columns: columns?.call(SysRole.t),
      transaction: transaction,
    );
  }

  Future<SysRole> updateRow(
    _i1.Session session,
    SysRole row, {
    _i1.ColumnSelections<SysRoleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysRole>(
      row,
      columns: columns?.call(SysRole.t),
      transaction: transaction,
    );
  }

  Future<List<SysRole>> delete(
    _i1.Session session,
    List<SysRole> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysRole>(
      rows,
      transaction: transaction,
    );
  }

  Future<SysRole> deleteRow(
    _i1.Session session,
    SysRole row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysRole>(
      row,
      transaction: transaction,
    );
  }

  Future<List<SysRole>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysRoleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysRole>(
      where: where(SysRole.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysRoleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysRole>(
      where: where?.call(SysRole.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
