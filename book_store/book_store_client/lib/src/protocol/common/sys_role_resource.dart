/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// 用于存储角色和资源的关联关系
abstract class SysRoleResource implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 角色id
  int roleId;

  /// 资源id
  int resourceId;

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
