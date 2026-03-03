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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../system/sys_menu.dart' as _i2;
import '../system/sys_api.dart' as _i3;
import 'package:flutter_web_client/src/protocol/protocol.dart' as _i4;

/// 系统角色表 - 支持多租户、数据权限范围控制
abstract class SysRole implements _i1.SerializableModel {
  SysRole._({
    this.id,
    int? tenantId,
    required this.name,
    required this.code,
    required this.sort,
    int? dataScope,
    this.dataScopeDeptIds,
    required this.status,
    required this.type,
    this.remark,
    this.menus,
    this.apis,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : tenantId = tenantId ?? 0,
       dataScope = dataScope ?? 5,
       createTime = createTime ?? DateTime.now();

  factory SysRole({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    required int sort,
    int? dataScope,
    List<int>? dataScopeDeptIds,
    required int status,
    required int type,
    String? remark,
    List<_i2.SysMenu>? menus,
    List<_i3.SysApi>? apis,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysRoleImpl;

  factory SysRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysRole(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      sort: jsonSerialization['sort'] as int,
      dataScope: jsonSerialization['dataScope'] as int?,
      dataScopeDeptIds: jsonSerialization['dataScopeDeptIds'] == null
          ? null
          : _i4.Protocol().deserialize<List<int>>(
              jsonSerialization['dataScopeDeptIds'],
            ),
      status: jsonSerialization['status'] as int,
      type: jsonSerialization['type'] as int,
      remark: jsonSerialization['remark'] as String?,
      menus: jsonSerialization['menus'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i2.SysMenu>>(
              jsonSerialization['menus'],
            ),
      apis: jsonSerialization['apis'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.SysApi>>(
              jsonSerialization['apis'],
            ),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int tenantId;

  String name;

  String code;

  int sort;

  int dataScope;

  List<int>? dataScopeDeptIds;

  int status;

  int type;

  String? remark;

  List<_i2.SysMenu>? menus;

  List<_i3.SysApi>? apis;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysRole copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? code,
    int? sort,
    int? dataScope,
    List<int>? dataScopeDeptIds,
    int? status,
    int? type,
    String? remark,
    List<_i2.SysMenu>? menus,
    List<_i3.SysApi>? apis,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysRole',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'code': code,
      'sort': sort,
      'dataScope': dataScope,
      if (dataScopeDeptIds != null)
        'dataScopeDeptIds': dataScopeDeptIds?.toJson(),
      'status': status,
      'type': type,
      if (remark != null) 'remark': remark,
      if (menus != null) 'menus': menus?.toJson(valueToJson: (v) => v.toJson()),
      if (apis != null) 'apis': apis?.toJson(valueToJson: (v) => v.toJson()),
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
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
    int? tenantId,
    required String name,
    required String code,
    required int sort,
    int? dataScope,
    List<int>? dataScopeDeptIds,
    required int status,
    required int type,
    String? remark,
    List<_i2.SysMenu>? menus,
    List<_i3.SysApi>? apis,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         code: code,
         sort: sort,
         dataScope: dataScope,
         dataScopeDeptIds: dataScopeDeptIds,
         status: status,
         type: type,
         remark: remark,
         menus: menus,
         apis: apis,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysRole copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    String? code,
    int? sort,
    int? dataScope,
    Object? dataScopeDeptIds = _Undefined,
    int? status,
    int? type,
    Object? remark = _Undefined,
    Object? menus = _Undefined,
    Object? apis = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysRole(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      code: code ?? this.code,
      sort: sort ?? this.sort,
      dataScope: dataScope ?? this.dataScope,
      dataScopeDeptIds: dataScopeDeptIds is List<int>?
          ? dataScopeDeptIds
          : this.dataScopeDeptIds?.map((e0) => e0).toList(),
      status: status ?? this.status,
      type: type ?? this.type,
      remark: remark is String? ? remark : this.remark,
      menus: menus is List<_i2.SysMenu>?
          ? menus
          : this.menus?.map((e0) => e0.copyWith()).toList(),
      apis: apis is List<_i3.SysApi>?
          ? apis
          : this.apis?.map((e0) => e0.copyWith()).toList(),
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
