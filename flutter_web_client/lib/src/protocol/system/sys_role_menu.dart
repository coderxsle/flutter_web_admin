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

/// 角色和菜单关联表
abstract class SysRoleMenu implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int tenantId;

  int roleId;

  int menuId;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

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
