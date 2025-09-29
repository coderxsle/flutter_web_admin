/// @file Menu 模型
/// @description 路由记录模型
import 'package:flutter/material.dart';

/// 路由元数据
class Menu {
  final String? title;  /// 路由标题
  final bool hidden;  /// 是否隐藏
  final String? svgIcon;  /// SVG图标名称
  final IconData? icon;  /// 图标数据
  final bool affix;  /// 是否固定标签页
  final bool breadcrumb;  /// 面包屑是否显示
  final String? activeMenu;  /// 激活的菜单路径
  final bool noShowingChildren;  /// 是否不显示子菜单
  final String? redirect;  /// 重定向路径

  const Menu({
    this.title,
    this.hidden = false,
    this.svgIcon,
    this.icon,
    this.affix = false,
    this.breadcrumb = true,
    this.activeMenu,
    this.noShowingChildren = false,
    this.redirect,
  });

  /// 从Map创建RouteMeta
  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      title: map['title'],
      hidden: map['hidden'] ?? false,
      svgIcon: map['svgIcon'],
      icon: map['icon'],
      affix: map['affix'] ?? false,
      breadcrumb: map['breadcrumb'] ?? true,
      activeMenu: map['activeMenu'],
      noShowingChildren: map['noShowingChildren'] ?? false,
      redirect: map['redirect'],
    );
  }

  /// 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'hidden': hidden,
      'svgIcon': svgIcon,
      'icon': icon,
      'affix': affix,
      'breadcrumb': breadcrumb,
      'activeMenu': activeMenu,
      'noShowingChildren': noShowingChildren,
      'redirect': redirect,
    };
  }
}