
// /// 菜单项类型
// enum MenuItemType {
//   /// 分组
//   group,
//   /// 菜单项
//   item,
// }


// /// 菜单项数据模型
// class MenuItem {
//   /// 菜单ID
//   final String id;
  
//   /// 菜单标题
//   final String title;
  
//   /// 菜单图标
//   final String? icon;
  
//   /// 路由路径
//   final String? route;
  
//   /// 子菜单列表
//   final List<MenuItem>? children;
  
//   /// 是否显示
//   final bool visible;
  
//   /// 菜单类型 (group: 分组, item: 菜单项)
//   final MenuItemType type;
  
//   /// 权限标识
//   final String? permission;
  
//   /// 排序
//   final int sort;
  
//   /// 外部链接
//   final String? externalUrl;

//   const MenuItem({
//     required this.id,
//     required this.title,
//     this.icon,
//     this.route,
//     this.children,
//     this.visible = true,
//     this.type = MenuItemType.item,
//     this.permission,
//     this.sort = 0,
//     this.externalUrl,
//   });

//   /// 从JSON创建菜单项
//   factory MenuItem.fromJson(Map<String, dynamic> json) {
//     return MenuItem(
//       id: json['id'] ?? '',
//       title: json['title'] ?? '',
//       icon: json['icon'],
//       route: json['route'],
//       children: json['children'] != null
//           ? (json['children'] as List)
//               .map((child) => MenuItem.fromJson(child))
//               .toList()
//           : null,
//       visible: json['visible'] ?? true,
//       type: MenuItemType.values.firstWhere(
//         (e) => e.name == json['type'],
//         orElse: () => MenuItemType.item,
//       ),
//       permission: json['permission'],
//       sort: json['sort'] ?? 0,
//       externalUrl: json['externalUrl'],
//     );
//   }

//   /// 转换为JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'icon': icon,
//       'route': route,
//       'children': children?.map((child) => child.toJson()).toList(),
//       'visible': visible,
//       'type': type.name,
//       'permission': permission,
//       'sort': sort,
//       'externalUrl': externalUrl,
//     };
//   }

//   /// 是否有子菜单
//   bool get hasChildren => children != null && children!.isNotEmpty;

//   /// 获取可见的子菜单
//   List<MenuItem> get visibleChildren =>
//       children?.where((child) => child.visible).toList() ?? [];

//   /// 复制并修改属性
//   MenuItem copyWith({
//     String? id,
//     String? title,
//     String? icon,
//     String? route,
//     List<MenuItem>? children,
//     bool? visible,
//     MenuItemType? type,
//     String? permission,
//     int? sort,
//     String? externalUrl,
//   }) {
//     return MenuItem(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       icon: icon ?? this.icon,
//       route: route ?? this.route,
//       children: children ?? this.children,
//       visible: visible ?? this.visible,
//       type: type ?? this.type,
//       permission: permission ?? this.permission,
//       sort: sort ?? this.sort,
//       externalUrl: externalUrl ?? this.externalUrl,
//     );
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is MenuItem && other.id == id;
//   }

//   @override
//   int get hashCode => id.hashCode;

//   @override
//   String toString() {
//     return 'MenuItem(id: $id, title: $title, route: $route, hasChildren: $hasChildren)';
//   }
// }
