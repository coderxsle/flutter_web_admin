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

abstract class Menu implements _i1.SerializableModel {
  Menu._({
    this.id,
    required this.parentId,
    required this.type,
    required this.title,
    this.icon,
    required this.permission,
    this.path,
    this.redirect,
    this.component,
    this.componentName,
    this.activeMenu,
    required this.sort,
    required this.status,
    required this.breadcrumb,
    required this.visible,
    required this.keepAlive,
    required this.alwaysShow,
    required this.showInTabs,
    required this.affix,
  });

  factory Menu({
    int? id,
    required int parentId,
    required int type,
    required String title,
    String? icon,
    required String permission,
    String? path,
    String? redirect,
    String? component,
    String? componentName,
    String? activeMenu,
    required int sort,
    required int status,
    required bool breadcrumb,
    required bool visible,
    required bool keepAlive,
    required bool alwaysShow,
    required bool showInTabs,
    required bool affix,
  }) = _MenuImpl;

  factory Menu.fromJson(Map<String, dynamic> jsonSerialization) {
    return Menu(
      id: jsonSerialization['id'] as int?,
      parentId: jsonSerialization['parentId'] as int,
      type: jsonSerialization['type'] as int,
      title: jsonSerialization['title'] as String,
      icon: jsonSerialization['icon'] as String?,
      permission: jsonSerialization['permission'] as String,
      path: jsonSerialization['path'] as String?,
      redirect: jsonSerialization['redirect'] as String?,
      component: jsonSerialization['component'] as String?,
      componentName: jsonSerialization['componentName'] as String?,
      activeMenu: jsonSerialization['activeMenu'] as String?,
      sort: jsonSerialization['sort'] as int,
      status: jsonSerialization['status'] as int,
      breadcrumb: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['breadcrumb'],
      ),
      visible: _i1.BoolJsonExtension.fromJson(jsonSerialization['visible']),
      keepAlive: _i1.BoolJsonExtension.fromJson(jsonSerialization['keepAlive']),
      alwaysShow: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['alwaysShow'],
      ),
      showInTabs: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['showInTabs'],
      ),
      affix: _i1.BoolJsonExtension.fromJson(jsonSerialization['affix']),
    );
  }

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

  /// Returns a shallow copy of this [Menu]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Menu copyWith({
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
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Menu',
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
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuImpl extends Menu {
  _MenuImpl({
    int? id,
    required int parentId,
    required int type,
    required String title,
    String? icon,
    required String permission,
    String? path,
    String? redirect,
    String? component,
    String? componentName,
    String? activeMenu,
    required int sort,
    required int status,
    required bool breadcrumb,
    required bool visible,
    required bool keepAlive,
    required bool alwaysShow,
    required bool showInTabs,
    required bool affix,
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
       );

  /// Returns a shallow copy of this [Menu]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Menu copyWith({
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
  }) {
    return Menu(
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
    );
  }
}
