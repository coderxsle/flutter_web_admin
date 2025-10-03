///
/// @file TabModel
/// @description 标签页数据模型
///
import 'package:flutter/material.dart';

/// 标签页数据模型
/// 
/// 用于管理系统标签页的数据结构，包含：
/// - 页面路径和标题
/// - 是否为固定标签
/// - 完整路径（包含参数）
/// - 元数据信息
class TabModel {
  /// 页面路径
  final String path;
  
  /// 页面标题
  final String title;
  
  /// 是否为固定标签（不可关闭）
  final bool affix;
  
  /// 完整路径（包含查询参数等）
  final String? fullPath;
  
  /// 路由元数据
  final Map<String, dynamic>? meta;

  const TabModel({
    required this.path,
    required this.title,
    this.affix = false,
    this.fullPath,
    this.meta,
  });

  /// 从路由信息创建标签页
  factory TabModel.fromRoute({
    required String path,
    required String title,
    String? fullPath,
    Map<String, dynamic>? meta,
  }) {
    return TabModel(
      path: path,
      title: title,
      fullPath: fullPath ?? path,
      meta: meta,
      affix: meta?['affix'] == true,
    );
  }

  /// 复制并修改属性
  TabModel copyWith({
    String? path,
    String? title,
    bool? affix,
    String? fullPath,
    Map<String, dynamic>? meta,
  }) {
    return TabModel(
      path: path ?? this.path,
      title: title ?? this.title,
      affix: affix ?? this.affix,
      fullPath: fullPath ?? this.fullPath,
      meta: meta ?? this.meta,
    );
  }

  /// 转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'title': title,
      'affix': affix,
      'fullPath': fullPath,
      'meta': meta,
    };
  }

  /// 从 Map 创建
  factory TabModel.fromMap(Map<String, dynamic> map) {
    return TabModel(
      path: map['path'] ?? '',
      title: map['title'] ?? '',
      affix: map['affix'] ?? false,
      fullPath: map['fullPath'],
      meta: map['meta'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is TabModel &&
        other.path == path &&
        other.title == title &&
        other.affix == affix &&
        other.fullPath == fullPath;
  }

  @override
  int get hashCode {
    return path.hashCode ^
        title.hashCode ^
        affix.hashCode ^
        fullPath.hashCode;
  }

  @override
  String toString() {
    return 'TabModel(path: $path, title: $title, affix: $affix, fullPath: $fullPath)';
  }
}
