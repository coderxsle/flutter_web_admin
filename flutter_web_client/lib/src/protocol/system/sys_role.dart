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
    required this.type,
    int? dataScope,
    this.dataScopeDeptIds,
    this.menus,
    this.apis,
    this.description,
    required this.status,
    required this.deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
  }) : tenantId = tenantId ?? 0,
       dataScope = dataScope ?? 5,
       createTime = createTime ?? DateTime.now();

  factory SysRole({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    required int sort,
    required int type,
    int? dataScope,
    List<int>? dataScopeDeptIds,
    List<_i2.SysMenu>? menus,
    List<_i3.SysApi>? apis,
    String? description,
    required int status,
    required bool deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) = _SysRoleImpl;

  factory SysRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysRole(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      sort: jsonSerialization['sort'] as int,
      type: jsonSerialization['type'] as int,
      dataScope: jsonSerialization['dataScope'] as int?,
      dataScopeDeptIds: jsonSerialization['dataScopeDeptIds'] == null
          ? null
          : _i4.Protocol().deserialize<List<int>>(
              jsonSerialization['dataScopeDeptIds'],
            ),
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
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as int,
      deleted: _i1.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
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

  int type;

  int dataScope;

  List<int>? dataScopeDeptIds;

  List<_i2.SysMenu>? menus;

  List<_i3.SysApi>? apis;

  String? description;

  int status;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  /// Returns a shallow copy of this [SysRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysRole copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? code,
    int? sort,
    int? type,
    int? dataScope,
    List<int>? dataScopeDeptIds,
    List<_i2.SysMenu>? menus,
    List<_i3.SysApi>? apis,
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
      '__className__': 'SysRole',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'code': code,
      'sort': sort,
      'type': type,
      'dataScope': dataScope,
      if (dataScopeDeptIds != null)
        'dataScopeDeptIds': dataScopeDeptIds?.toJson(),
      if (menus != null) 'menus': menus?.toJson(valueToJson: (v) => v.toJson()),
      if (apis != null) 'apis': apis?.toJson(valueToJson: (v) => v.toJson()),
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
    required int type,
    int? dataScope,
    List<int>? dataScopeDeptIds,
    List<_i2.SysMenu>? menus,
    List<_i3.SysApi>? apis,
    String? description,
    required int status,
    required bool deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         code: code,
         sort: sort,
         type: type,
         dataScope: dataScope,
         dataScopeDeptIds: dataScopeDeptIds,
         menus: menus,
         apis: apis,
         description: description,
         status: status,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
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
    int? type,
    int? dataScope,
    Object? dataScopeDeptIds = _Undefined,
    Object? menus = _Undefined,
    Object? apis = _Undefined,
    Object? description = _Undefined,
    int? status,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return SysRole(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      code: code ?? this.code,
      sort: sort ?? this.sort,
      type: type ?? this.type,
      dataScope: dataScope ?? this.dataScope,
      dataScopeDeptIds: dataScopeDeptIds is List<int>?
          ? dataScopeDeptIds
          : this.dataScopeDeptIds?.map((e0) => e0).toList(),
      menus: menus is List<_i2.SysMenu>?
          ? menus
          : this.menus?.map((e0) => e0.copyWith()).toList(),
      apis: apis is List<_i3.SysApi>?
          ? apis
          : this.apis?.map((e0) => e0.copyWith()).toList(),
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
