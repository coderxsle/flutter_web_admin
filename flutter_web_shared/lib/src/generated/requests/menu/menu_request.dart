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
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i1;

/// 新增、修改菜单请求参数
abstract class MenuRequest implements _i1.SerializableModel {
  MenuRequest._({
    this.id,
    required this.title,
    String? permission,
    required this.type,
    int? sort,
    int? parentId,
    bool? breadcrumb,
    String? path,
    this.icon,
    this.component,
    this.componentName,
    this.redirect,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    this.activeMenu,
    bool? showInTabs,
    bool? affix,
  }) : permission = permission ?? '',
       sort = sort ?? 0,
       parentId = parentId ?? 0,
       breadcrumb = breadcrumb ?? true,
       path = path ?? '',
       status = status ?? 1,
       visible = visible ?? true,
       keepAlive = keepAlive ?? true,
       alwaysShow = alwaysShow ?? true,
       showInTabs = showInTabs ?? true,
       affix = affix ?? false;

  factory MenuRequest({
    int? id,
    required String title,
    String? permission,
    required int type,
    int? sort,
    int? parentId,
    bool? breadcrumb,
    String? path,
    String? icon,
    String? component,
    String? componentName,
    String? redirect,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    String? activeMenu,
    bool? showInTabs,
    bool? affix,
  }) = _MenuRequestImpl;

  factory MenuRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuRequest(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      permission: jsonSerialization['permission'] as String?,
      type: jsonSerialization['type'] as int,
      sort: jsonSerialization['sort'] as int?,
      parentId: jsonSerialization['parentId'] as int?,
      breadcrumb: jsonSerialization['breadcrumb'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['breadcrumb']),
      path: jsonSerialization['path'] as String?,
      icon: jsonSerialization['icon'] as String?,
      component: jsonSerialization['component'] as String?,
      componentName: jsonSerialization['componentName'] as String?,
      redirect: jsonSerialization['redirect'] as String?,
      status: jsonSerialization['status'] as int?,
      visible: jsonSerialization['visible'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['visible']),
      keepAlive: jsonSerialization['keepAlive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['keepAlive']),
      alwaysShow: jsonSerialization['alwaysShow'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['alwaysShow']),
      activeMenu: jsonSerialization['activeMenu'] as String?,
      showInTabs: jsonSerialization['showInTabs'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['showInTabs']),
      affix: jsonSerialization['affix'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['affix']),
    );
  }

  int? id;

  String title;

  String? permission;

  int type;

  int? sort;

  int? parentId;

  bool? breadcrumb;

  String? path;

  String? icon;

  String? component;

  String? componentName;

  String? redirect;

  int? status;

  bool? visible;

  bool? keepAlive;

  bool? alwaysShow;

  String? activeMenu;

  bool? showInTabs;

  bool? affix;

  /// Returns a shallow copy of this [MenuRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MenuRequest copyWith({
    int? id,
    String? title,
    String? permission,
    int? type,
    int? sort,
    int? parentId,
    bool? breadcrumb,
    String? path,
    String? icon,
    String? component,
    String? componentName,
    String? redirect,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    String? activeMenu,
    bool? showInTabs,
    bool? affix,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuRequest',
      if (id != null) 'id': id,
      'title': title,
      if (permission != null) 'permission': permission,
      'type': type,
      if (sort != null) 'sort': sort,
      if (parentId != null) 'parentId': parentId,
      if (breadcrumb != null) 'breadcrumb': breadcrumb,
      if (path != null) 'path': path,
      if (icon != null) 'icon': icon,
      if (component != null) 'component': component,
      if (componentName != null) 'componentName': componentName,
      if (redirect != null) 'redirect': redirect,
      if (status != null) 'status': status,
      if (visible != null) 'visible': visible,
      if (keepAlive != null) 'keepAlive': keepAlive,
      if (alwaysShow != null) 'alwaysShow': alwaysShow,
      if (activeMenu != null) 'activeMenu': activeMenu,
      if (showInTabs != null) 'showInTabs': showInTabs,
      if (affix != null) 'affix': affix,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuRequestImpl extends MenuRequest {
  _MenuRequestImpl({
    int? id,
    required String title,
    String? permission,
    required int type,
    int? sort,
    int? parentId,
    bool? breadcrumb,
    String? path,
    String? icon,
    String? component,
    String? componentName,
    String? redirect,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    String? activeMenu,
    bool? showInTabs,
    bool? affix,
  }) : super._(
         id: id,
         title: title,
         permission: permission,
         type: type,
         sort: sort,
         parentId: parentId,
         breadcrumb: breadcrumb,
         path: path,
         icon: icon,
         component: component,
         componentName: componentName,
         redirect: redirect,
         status: status,
         visible: visible,
         keepAlive: keepAlive,
         alwaysShow: alwaysShow,
         activeMenu: activeMenu,
         showInTabs: showInTabs,
         affix: affix,
       );

  /// Returns a shallow copy of this [MenuRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MenuRequest copyWith({
    Object? id = _Undefined,
    String? title,
    Object? permission = _Undefined,
    int? type,
    Object? sort = _Undefined,
    Object? parentId = _Undefined,
    Object? breadcrumb = _Undefined,
    Object? path = _Undefined,
    Object? icon = _Undefined,
    Object? component = _Undefined,
    Object? componentName = _Undefined,
    Object? redirect = _Undefined,
    Object? status = _Undefined,
    Object? visible = _Undefined,
    Object? keepAlive = _Undefined,
    Object? alwaysShow = _Undefined,
    Object? activeMenu = _Undefined,
    Object? showInTabs = _Undefined,
    Object? affix = _Undefined,
  }) {
    return MenuRequest(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      permission: permission is String? ? permission : this.permission,
      type: type ?? this.type,
      sort: sort is int? ? sort : this.sort,
      parentId: parentId is int? ? parentId : this.parentId,
      breadcrumb: breadcrumb is bool? ? breadcrumb : this.breadcrumb,
      path: path is String? ? path : this.path,
      icon: icon is String? ? icon : this.icon,
      component: component is String? ? component : this.component,
      componentName: componentName is String?
          ? componentName
          : this.componentName,
      redirect: redirect is String? ? redirect : this.redirect,
      status: status is int? ? status : this.status,
      visible: visible is bool? ? visible : this.visible,
      keepAlive: keepAlive is bool? ? keepAlive : this.keepAlive,
      alwaysShow: alwaysShow is bool? ? alwaysShow : this.alwaysShow,
      activeMenu: activeMenu is String? ? activeMenu : this.activeMenu,
      showInTabs: showInTabs is bool? ? showInTabs : this.showInTabs,
      affix: affix is bool? ? affix : this.affix,
    );
  }
}
