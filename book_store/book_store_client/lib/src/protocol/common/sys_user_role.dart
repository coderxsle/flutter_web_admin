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

/// 用于存储用户和角色的关联关系
abstract class SysUserRole implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 角色id
  int roleId;

  /// 用户id
  int userId;

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
