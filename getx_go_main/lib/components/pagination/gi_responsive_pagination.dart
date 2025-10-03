import 'package:flutter/material.dart';
import 'gi_pagination.dart';

/// 响应式分页组件
/// 根据屏幕尺寸自动切换简单模式和完整模式
/// 完全复刻 gi-demo 项目中 usePagination hook 的响应式行为
class GiResponsivePagination extends StatelessWidget {
  /// 当前页码（从1开始）
  final int current;
  
  /// 每页显示条数
  final int pageSize;
  
  /// 数据总数
  final int total;
  
  /// 是否显示每页条数选择器
  final bool showPageSize;
  
  /// 是否显示总数
  final bool showTotal;
  
  /// 每页条数选择项
  final List<int> pageSizeOptions;
  
  /// 页码变化回调
  final Function(int page)? onPageChange;
  
  /// 每页条数变化回调
  final Function(int pageSize)? onPageSizeChange;
  
  /// 是否禁用
  final bool disabled;
  
  /// 移动端断点（屏幕宽度小于此值时使用简单模式）
  final double mobileBreakpoint;

  const GiResponsivePagination({
    super.key,
    required this.current,
    required this.pageSize,
    required this.total,
    this.showPageSize = true,
    this.showTotal = true,
    this.pageSizeOptions = const [10, 20, 50, 100],
    this.onPageChange,
    this.onPageSizeChange,
    this.disabled = false,
    this.mobileBreakpoint = 768,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 根据屏幕宽度判断是否为移动端
        final isMobile = constraints.maxWidth < mobileBreakpoint;
        
        return GiPagination(
          current: current,
          pageSize: pageSize,
          total: total,
          showPageSize: showPageSize && !isMobile,
          showTotal: showTotal && !isMobile,
          simple: isMobile,
          pageSizeOptions: pageSizeOptions,
          onPageChange: onPageChange,
          onPageSizeChange: onPageSizeChange,
          disabled: disabled,
        );
      },
    );
  }
}

/// 表格分页器 Hook
/// 复刻 gi-demo 项目中 useTable 和 usePagination 的功能
class TablePaginationController {
  /// 当前页码
  int _current = 1;
  
  /// 每页条数
  int _pageSize;
  
  /// 总数据量
  int _total = 0;
  
  /// 页码变化回调
  final VoidCallback? _onPageChange;

  TablePaginationController({
    int pageSize = 10,
    VoidCallback? onPageChange,
  }) : _pageSize = pageSize, _onPageChange = onPageChange;

  /// 当前页码
  int get current => _current;
  
  /// 每页条数
  int get pageSize => _pageSize;
  
  /// 总数据量
  int get total => _total;
  
  /// 总页数
  int get totalPages => (_total / _pageSize).ceil();

  /// 设置总数据量
  void setTotal(int total) {
    _total = total;
  }

  /// 页码变化
  void onPageChange(int page) {
    if (page >= 1 && page <= totalPages && page != _current) {
      _current = page;
      _onPageChange?.call();
    }
  }

  /// 每页条数变化
  void onPageSizeChange(int pageSize) {
    if (pageSize != _pageSize) {
      _pageSize = pageSize;
      _current = 1; // 重置到第一页
      _onPageChange?.call();
    }
  }

  /// 搜索（重置到第一页）
  void search() {
    _current = 1;
    _onPageChange?.call();
  }

  /// 刷新（保持当前页）
  void refresh() {
    _onPageChange?.call();
  }

  /// 构建分页组件
  Widget buildPagination({
    bool showPageSize = true,
    bool showTotal = true,
    List<int> pageSizeOptions = const [10, 20, 50, 100],
    bool disabled = false,
    double mobileBreakpoint = 768,
  }) {
    return GiResponsivePagination(
      current: current,
      pageSize: pageSize,
      total: total,
      showPageSize: showPageSize,
      showTotal: showTotal,
      pageSizeOptions: pageSizeOptions,
      onPageChange: onPageChange,
      onPageSizeChange: onPageSizeChange,
      disabled: disabled,
      mobileBreakpoint: mobileBreakpoint,
    );
  }
}
