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

/// 菜单权限表
abstract class SysMenu implements _i1.SerializableModel {
  SysMenu._({
    this.id,
    required this.name,
    String? permission,
    required this.type,
    int? sort,
    int? parentId,
    String? path,
    this.icon,
    this.component,
    this.componentName,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    bool? deleted,
  })  : permission = permission ?? '',
        sort = sort ?? 0,
        parentId = parentId ?? 0,
        path = path ?? '',
        status = status ?? 0,
        visible = visible ?? true,
        keepAlive = keepAlive ?? true,
        alwaysShow = alwaysShow ?? true,
        createTime = createTime ?? DateTime.now(),
        deleted = deleted ?? false;

  factory SysMenu({
    int? id,
    required String name,
    String? permission,
    required int type,
    int? sort,
    int? parentId,
    String? path,
    String? icon,
    String? component,
    String? componentName,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    bool? deleted,
  }) = _SysMenuImpl;

  factory SysMenu.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysMenu(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      permission: jsonSerialization['permission'] as String,
      type: jsonSerialization['type'] as int,
      sort: jsonSerialization['sort'] as int,
      parentId: jsonSerialization['parentId'] as int,
      path: jsonSerialization['path'] as String?,
      icon: jsonSerialization['icon'] as String?,
      component: jsonSerialization['component'] as String?,
      componentName: jsonSerialization['componentName'] as String?,
      status: jsonSerialization['status'] as int,
      visible: jsonSerialization['visible'] as bool,
      keepAlive: jsonSerialization['keepAlive'] as bool,
      alwaysShow: jsonSerialization['alwaysShow'] as bool,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  /// 菜单ID，主键
  int? id;

  /// 菜单名称
  String name;

  /// 权限标识
  String permission;

  /// 菜单类型
  int type;

  /// 显示顺序
  int sort;

  /// 父菜单ID
  int parentId;

  /// 路由地址
  String? path;

  /// 菜单图标
  String? icon;

  /// 组件路径
  String? component;

  /// 组件名
  String? componentName;

  /// 菜单状态
  int status;

  /// 是否可见
  bool visible;

  /// 是否缓存
  bool keepAlive;

  /// 是否总是显示
  bool alwaysShow;

  /// 创建者
  String? creator;

  /// 创建时间
  DateTime createTime;

  /// 更新者
  String? updater;

  /// 更新时间
  DateTime updateTime;

  /// 是否删除
  bool deleted;

  /// Returns a shallow copy of this [SysMenu]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysMenu copyWith({
    int? id,
    String? name,
    String? permission,
    int? type,
    int? sort,
    int? parentId,
    String? path,
    String? icon,
    String? component,
    String? componentName,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
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
      'name': name,
      'permission': permission,
      'type': type,
      'sort': sort,
      'parentId': parentId,
      if (path != null) 'path': path,
      if (icon != null) 'icon': icon,
      if (component != null) 'component': component,
      if (componentName != null) 'componentName': componentName,
      'status': status,
      'visible': visible,
      'keepAlive': keepAlive,
      'alwaysShow': alwaysShow,
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

class _SysMenuImpl extends SysMenu {
  _SysMenuImpl({
    int? id,
    required String name,
    String? permission,
    required int type,
    int? sort,
    int? parentId,
    String? path,
    String? icon,
    String? component,
    String? componentName,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    bool? deleted,
  }) : super._(
          id: id,
          name: name,
          permission: permission,
          type: type,
          sort: sort,
          parentId: parentId,
          path: path,
          icon: icon,
          component: component,
          componentName: componentName,
          status: status,
          visible: visible,
          keepAlive: keepAlive,
          alwaysShow: alwaysShow,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysMenu]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysMenu copyWith({
    Object? id = _Undefined,
    String? name,
    String? permission,
    int? type,
    int? sort,
    int? parentId,
    Object? path = _Undefined,
    Object? icon = _Undefined,
    Object? component = _Undefined,
    Object? componentName = _Undefined,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysMenu(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      permission: permission ?? this.permission,
      type: type ?? this.type,
      sort: sort ?? this.sort,
      parentId: parentId ?? this.parentId,
      path: path is String? ? path : this.path,
      icon: icon is String? ? icon : this.icon,
      component: component is String? ? component : this.component,
      componentName:
          componentName is String? ? componentName : this.componentName,
      status: status ?? this.status,
      visible: visible ?? this.visible,
      keepAlive: keepAlive ?? this.keepAlive,
      alwaysShow: alwaysShow ?? this.alwaysShow,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
