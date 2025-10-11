import 'package:flutter/material.dart';

class MenuItem {
  final String id;
  final String title;
  final IconData? icon;
  final String? svgIcon;
  final String? route;
  final List<MenuItem>? children;
  final bool isExpanded;
  final String? name;
  final Widget? page;

  const MenuItem({
    required this.id,
    required this.title,
    this.icon,
    this.svgIcon,
    this.route,
    this.children,
    this.isExpanded = false,
    this.name,
    this.page,
  });


  MenuItem copyWith({
    String? id,
    String? title,
    IconData? icon,
    String? svgIcon,
    String? route,
    List<MenuItem>? children,
    bool? isExpanded,
    String? name,
    Widget? page,
  }) {
    return MenuItem(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      svgIcon: svgIcon ?? this.svgIcon,
      route: route ?? this.route,
      children: children ?? this.children,
      isExpanded: isExpanded ?? this.isExpanded,
      name: name ?? this.name,
      page: page ?? this.page,
    );
  }

  bool get hasChildren => children != null && children!.isNotEmpty;
}
