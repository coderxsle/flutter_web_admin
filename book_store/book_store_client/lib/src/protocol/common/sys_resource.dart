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

/// 用于存储系统的菜单、按钮等资源信息
abstract class SysResource implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [SysResource]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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

  /// Returns a shallow copy of this [SysResource]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
