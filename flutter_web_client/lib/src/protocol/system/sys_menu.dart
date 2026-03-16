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

/// 系统菜单权限表（支持目录/菜单/按钮三级权限模型）
/// 设计目标：
/// 1. 兼容前端动态路由（path/component/redirect）
/// 2. 支持菜单展示控制（visible/alwaysShow/activeMenu）
/// 3. 支持标签页行为控制（showInTabs/affix/keepAlive）
/// 4. 支持权限点控制（permission）与软删除审计字段
abstract class SysMenu implements _i1.SerializableModel {
  SysMenu._({
    this.id,
    int? parentId,
    required this.type,
    required this.title,
    this.icon,
    String? permission,
    String? path,
    this.redirect,
    this.component,
    this.componentName,
    this.activeMenu,
    int? sort,
    int? status,
    bool? breadcrumb,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    bool? showInTabs,
    bool? affix,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
  }) : parentId = parentId ?? 0,
       permission = permission ?? '',
       path = path ?? '',
       sort = sort ?? 0,
       status = status ?? 1,
       breadcrumb = breadcrumb ?? true,
       visible = visible ?? true,
       keepAlive = keepAlive ?? true,
       alwaysShow = alwaysShow ?? true,
       showInTabs = showInTabs ?? true,
       affix = affix ?? false,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now();

  factory SysMenu({
    int? id,
    int? parentId,
    required int type,
    required String title,
    String? icon,
    String? permission,
    String? path,
    String? redirect,
    String? component,
    String? componentName,
    String? activeMenu,
    int? sort,
    int? status,
    bool? breadcrumb,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    bool? showInTabs,
    bool? affix,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) = _SysMenuImpl;

  factory SysMenu.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysMenu(
      id: jsonSerialization['id'] as int?,
      parentId: jsonSerialization['parentId'] as int?,
      type: jsonSerialization['type'] as int,
      title: jsonSerialization['title'] as String,
      icon: jsonSerialization['icon'] as String?,
      permission: jsonSerialization['permission'] as String?,
      path: jsonSerialization['path'] as String?,
      redirect: jsonSerialization['redirect'] as String?,
      component: jsonSerialization['component'] as String?,
      componentName: jsonSerialization['componentName'] as String?,
      activeMenu: jsonSerialization['activeMenu'] as String?,
      sort: jsonSerialization['sort'] as int?,
      status: jsonSerialization['status'] as int?,
      breadcrumb: jsonSerialization['breadcrumb'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['breadcrumb']),
      visible: jsonSerialization['visible'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['visible']),
      keepAlive: jsonSerialization['keepAlive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['keepAlive']),
      alwaysShow: jsonSerialization['alwaysShow'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['alwaysShow']),
      showInTabs: jsonSerialization['showInTabs'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['showInTabs']),
      affix: jsonSerialization['affix'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['affix']),
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
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

  int parentId;

  int type;

  String title;

  String? icon;

  String permission;

  String? path;

  String? redirect;

  String? component;

  String? componentName;

  String? activeMenu;

  int sort;

  int status;

  bool breadcrumb;

  bool visible;

  bool keepAlive;

  bool alwaysShow;

  bool showInTabs;

  bool affix;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  /// Returns a shallow copy of this [SysMenu]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysMenu copyWith({
    int? id,
    int? parentId,
    int? type,
    String? title,
    String? icon,
    String? permission,
    String? path,
    String? redirect,
    String? component,
    String? componentName,
    String? activeMenu,
    int? sort,
    int? status,
    bool? breadcrumb,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    bool? showInTabs,
    bool? affix,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysMenu',
      if (id != null) 'id': id,
      'parentId': parentId,
      'type': type,
      'title': title,
      if (icon != null) 'icon': icon,
      'permission': permission,
      if (path != null) 'path': path,
      if (redirect != null) 'redirect': redirect,
      if (component != null) 'component': component,
      if (componentName != null) 'componentName': componentName,
      if (activeMenu != null) 'activeMenu': activeMenu,
      'sort': sort,
      'status': status,
      'breadcrumb': breadcrumb,
      'visible': visible,
      'keepAlive': keepAlive,
      'alwaysShow': alwaysShow,
      'showInTabs': showInTabs,
      'affix': affix,
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

class _SysMenuImpl extends SysMenu {
  _SysMenuImpl({
    int? id,
    int? parentId,
    required int type,
    required String title,
    String? icon,
    String? permission,
    String? path,
    String? redirect,
    String? component,
    String? componentName,
    String? activeMenu,
    int? sort,
    int? status,
    bool? breadcrumb,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    bool? showInTabs,
    bool? affix,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) : super._(
         id: id,
         parentId: parentId,
         type: type,
         title: title,
         icon: icon,
         permission: permission,
         path: path,
         redirect: redirect,
         component: component,
         componentName: componentName,
         activeMenu: activeMenu,
         sort: sort,
         status: status,
         breadcrumb: breadcrumb,
         visible: visible,
         keepAlive: keepAlive,
         alwaysShow: alwaysShow,
         showInTabs: showInTabs,
         affix: affix,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysMenu]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysMenu copyWith({
    Object? id = _Undefined,
    int? parentId,
    int? type,
    String? title,
    Object? icon = _Undefined,
    String? permission,
    Object? path = _Undefined,
    Object? redirect = _Undefined,
    Object? component = _Undefined,
    Object? componentName = _Undefined,
    Object? activeMenu = _Undefined,
    int? sort,
    int? status,
    bool? breadcrumb,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    bool? showInTabs,
    bool? affix,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return SysMenu(
      id: id is int? ? id : this.id,
      parentId: parentId ?? this.parentId,
      type: type ?? this.type,
      title: title ?? this.title,
      icon: icon is String? ? icon : this.icon,
      permission: permission ?? this.permission,
      path: path is String? ? path : this.path,
      redirect: redirect is String? ? redirect : this.redirect,
      component: component is String? ? component : this.component,
      componentName: componentName is String?
          ? componentName
          : this.componentName,
      activeMenu: activeMenu is String? ? activeMenu : this.activeMenu,
      sort: sort ?? this.sort,
      status: status ?? this.status,
      breadcrumb: breadcrumb ?? this.breadcrumb,
      visible: visible ?? this.visible,
      keepAlive: keepAlive ?? this.keepAlive,
      alwaysShow: alwaysShow ?? this.alwaysShow,
      showInTabs: showInTabs ?? this.showInTabs,
      affix: affix ?? this.affix,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}
