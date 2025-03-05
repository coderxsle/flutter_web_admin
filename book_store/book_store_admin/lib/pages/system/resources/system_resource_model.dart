import 'package:get/get.dart';

class SystemResourceModel {
  int id;
  String name;
  String uri;
  String permission;
  int type; // 0为目录，1为菜单，2为按钮
  String icon;
  int sn;
  int parentId;
  List<SystemResourceModel>? children;
  RxBool isExpanded = true.obs;

  SystemResourceModel({
    required this.id,
    required this.name,
    required this.uri,
    required this.permission,
    required this.type,
    required this.icon,
    required this.sn,
    required this.parentId,
    this.children,
  });

  factory SystemResourceModel.fromJson(Map<String, dynamic> json) {
    return SystemResourceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      uri: json['uri'] as String,
      permission: json['permission'] as String,
      type: json['type'] as int,
      icon: json['icon'] as String,
      sn: json['sn'] as int,
      parentId: json['parentId'] as int,
      children: json['children'] != null
          ? (json['children'] as List<dynamic>)
              .map((e) => SystemResourceModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final result = {
      'id': id,
      'name': name,
      'uri': uri,
      'permission': permission,
      'type': type,
      'icon': icon,
      'sn': sn,
      'parentId': parentId,
    };
    
    if (children != null) {
      result['children'] = children!.map((e) => e.toJson()).toList();
    }
    
    return result;
  }

  // 获取资源类型名称
  String get typeName {
    switch (type) {
      case 0:
        return '目录';
      case 1:
        return '菜单';
      case 2:
        return '按钮';
      default:
        return '未知';
    }
  }
} 