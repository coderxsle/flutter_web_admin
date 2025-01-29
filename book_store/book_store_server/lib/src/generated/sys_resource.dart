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

/// 用于存储系统的菜单、按钮等资源信息
abstract class SysResource implements _i1.TableRow, _i1.ProtocolSerialization {
  SysResource._({
    this.id,
    String? name,
    String? uri,
    String? permission,
    int? type,
    String? icon,
    int? sn,
    int? parentId,
  })  : name = name ?? '',
        uri = uri ?? '',
        permission = permission ?? '',
        type = type ?? 0,
        icon = icon ?? '',
        sn = sn ?? 0,
        parentId = parentId ?? 0;

  factory SysResource({
    int? id,
    String? name,
    String? uri,
    String? permission,
    int? type,
    String? icon,
    int? sn,
    int? parentId,
  }) = _SysResourceImpl;

  factory SysResource.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysResource(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      uri: jsonSerialization['uri'] as String,
      permission: jsonSerialization['permission'] as String,
      type: jsonSerialization['type'] as int,
      icon: jsonSerialization['icon'] as String,
      sn: jsonSerialization['sn'] as int,
      parentId: jsonSerialization['parentId'] as int,
    );
  }

  static final t = SysResourceTable();

  static const db = SysResourceRepository._();

  @override
  int? id;

  /// 名称
  String name;

  /// 链接地址
  String uri;

  /// 权限标识
  String permission;

  /// 资源类型（0为目录，1为菜单，2为按钮）
  int type;

  /// 图标
  String icon;

  /// 序号
  int sn;

  /// 父资源id
  int parentId;

  @override
  _i1.Table get table => t;

  SysResource copyWith({
    int? id,
    String? name,
    String? uri,
    String? permission,
    int? type,
    String? icon,
    int? sn,
    int? parentId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'uri': uri,
      'permission': permission,
      'type': type,
      'icon': icon,
      'sn': sn,
      'parentId': parentId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'uri': uri,
      'permission': permission,
      'type': type,
      'icon': icon,
      'sn': sn,
      'parentId': parentId,
    };
  }

  static SysResourceInclude include() {
    return SysResourceInclude._();
  }

  static SysResourceIncludeList includeList({
    _i1.WhereExpressionBuilder<SysResourceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysResourceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysResourceTable>? orderByList,
    SysResourceInclude? include,
  }) {
    return SysResourceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysResource.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysResource.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysResourceImpl extends SysResource {
  _SysResourceImpl({
    int? id,
    String? name,
    String? uri,
    String? permission,
    int? type,
    String? icon,
    int? sn,
    int? parentId,
  }) : super._(
          id: id,
          name: name,
          uri: uri,
          permission: permission,
          type: type,
          icon: icon,
          sn: sn,
          parentId: parentId,
        );

  @override
  SysResource copyWith({
    Object? id = _Undefined,
    String? name,
    String? uri,
    String? permission,
    int? type,
    String? icon,
    int? sn,
    int? parentId,
  }) {
    return SysResource(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      uri: uri ?? this.uri,
      permission: permission ?? this.permission,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      sn: sn ?? this.sn,
      parentId: parentId ?? this.parentId,
    );
  }
}

class SysResourceTable extends _i1.Table {
  SysResourceTable({super.tableRelation}) : super(tableName: 'sys_resource') {
    name = _i1.ColumnString(
      'name',
      this,
      hasDefault: true,
    );
    uri = _i1.ColumnString(
      'uri',
      this,
      hasDefault: true,
    );
    permission = _i1.ColumnString(
      'permission',
      this,
      hasDefault: true,
    );
    type = _i1.ColumnInt(
      'type',
      this,
      hasDefault: true,
    );
    icon = _i1.ColumnString(
      'icon',
      this,
      hasDefault: true,
    );
    sn = _i1.ColumnInt(
      'sn',
      this,
      hasDefault: true,
    );
    parentId = _i1.ColumnInt(
      'parentId',
      this,
      hasDefault: true,
    );
  }

  /// 名称
  late final _i1.ColumnString name;

  /// 链接地址
  late final _i1.ColumnString uri;

  /// 权限标识
  late final _i1.ColumnString permission;

  /// 资源类型（0为目录，1为菜单，2为按钮）
  late final _i1.ColumnInt type;

  /// 图标
  late final _i1.ColumnString icon;

  /// 序号
  late final _i1.ColumnInt sn;

  /// 父资源id
  late final _i1.ColumnInt parentId;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        uri,
        permission,
        type,
        icon,
        sn,
        parentId,
      ];
}

class SysResourceInclude extends _i1.IncludeObject {
  SysResourceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => SysResource.t;
}

class SysResourceIncludeList extends _i1.IncludeList {
  SysResourceIncludeList._({
    _i1.WhereExpressionBuilder<SysResourceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysResource.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => SysResource.t;
}

class SysResourceRepository {
  const SysResourceRepository._();

  Future<List<SysResource>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysResourceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysResourceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysResourceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysResource>(
      where: where?.call(SysResource.t),
      orderBy: orderBy?.call(SysResource.t),
      orderByList: orderByList?.call(SysResource.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<SysResource?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysResourceTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysResourceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysResourceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysResource>(
      where: where?.call(SysResource.t),
      orderBy: orderBy?.call(SysResource.t),
      orderByList: orderByList?.call(SysResource.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<SysResource?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysResource>(
      id,
      transaction: transaction,
    );
  }

  Future<List<SysResource>> insert(
    _i1.Session session,
    List<SysResource> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysResource>(
      rows,
      transaction: transaction,
    );
  }

  Future<SysResource> insertRow(
    _i1.Session session,
    SysResource row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysResource>(
      row,
      transaction: transaction,
    );
  }

  Future<List<SysResource>> update(
    _i1.Session session,
    List<SysResource> rows, {
    _i1.ColumnSelections<SysResourceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysResource>(
      rows,
      columns: columns?.call(SysResource.t),
      transaction: transaction,
    );
  }

  Future<SysResource> updateRow(
    _i1.Session session,
    SysResource row, {
    _i1.ColumnSelections<SysResourceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysResource>(
      row,
      columns: columns?.call(SysResource.t),
      transaction: transaction,
    );
  }

  Future<List<SysResource>> delete(
    _i1.Session session,
    List<SysResource> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysResource>(
      rows,
      transaction: transaction,
    );
  }

  Future<SysResource> deleteRow(
    _i1.Session session,
    SysResource row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysResource>(
      row,
      transaction: transaction,
    );
  }

  Future<List<SysResource>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysResourceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysResource>(
      where: where(SysResource.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysResourceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysResource>(
      where: where?.call(SysResource.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
