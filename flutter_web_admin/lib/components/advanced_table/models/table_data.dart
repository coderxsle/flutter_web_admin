import 'package:flutter/material.dart';


/// 表格数据包装类
class TableData<T> {
  /// 数据列表
  final List<T> data;
  
  /// 总数据量（用于分页）
  final int total;
  
  /// 当前页码
  final int currentPage;
  
  /// 每页大小
  final int pageSize;

  const TableData({
    required this.data,
    required this.total,
    this.currentPage = 1,
    this.pageSize = 10,
  });

  /// 总页数
  int get totalPages => (total / pageSize).ceil();

  /// 是否有下一页
  bool get hasNextPage => currentPage < totalPages;

  /// 是否有上一页
  bool get hasPreviousPage => currentPage > 1;

  /// 当前页的起始索引
  int get startIndex => (currentPage - 1) * pageSize + 1;

  /// 当前页的结束索引
  int get endIndex => (currentPage * pageSize).clamp(0, total);

  /// 复制并修改
  TableData<T> copyWith({
    List<T>? data,
    int? total,
    int? currentPage,
    int? pageSize,
  }) {
    return TableData<T>(
      data: data ?? this.data,
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  /// 空数据
  static TableData<T> empty<T>() {
    return TableData<T>(
      data: [],
      total: 0,
      currentPage: 1,
      pageSize: 10,
    );
  }
}

/// 展开行配置
class ExpandableRowConfig<T> {
  /// 是否展开
  final bool expanded;
  
  /// 展开内容构建器
  final Widget Function(BuildContext context, T record, int index)? expandedBuilder;
  
  /// 展开图标
  final Widget? expandIcon;
  
  /// 折叠图标
  final Widget? collapseIcon;
  
  /// 是否支持展开
  final bool Function(T record)? expandable;

  const ExpandableRowConfig({
    this.expanded = false,
    this.expandedBuilder,
    this.expandIcon,
    this.collapseIcon,
    this.expandable,
  });
}

/// 树形数据节点
class TreeNode<T> {
  /// 节点数据
  final T data;
  
  /// 子节点
  final List<TreeNode<T>>? children;
  
  /// 是否展开
  bool isExpanded;
  
  /// 层级
  final int level;
  
  /// 父节点键
  final String? parentKey;
  
  /// 节点键
  final String key;

  TreeNode({
    required this.data,
    this.children,
    this.isExpanded = false,
    this.level = 0,
    this.parentKey,
    required this.key,
  });

  /// 是否有子节点
  bool get hasChildren => children != null && children!.isNotEmpty;

  /// 子节点数量
  int get childrenCount => children?.length ?? 0;
}


