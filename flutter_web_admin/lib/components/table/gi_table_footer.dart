import 'package:flutter/material.dart';
import '../pagination/gi_pagination.dart';

/// GiTable 的 Footer 组件（分页器）
/// 
/// 这个组件作为独立的 StatefulWidget，可以响应外部参数变化而不需要重建整个表格
class GiTableFooter extends StatefulWidget {
  final int currentPage;
  final int pageSize;
  final int totalCount;
  final Function(int page)? onPageChange;
  final Function(int pageSize)? onPageSizeChange;

  const GiTableFooter({
    super.key,
    required this.currentPage,
    required this.pageSize,
    required this.totalCount,
    this.onPageChange,
    this.onPageSizeChange,
  });

  @override
  State<GiTableFooter> createState() => _GiTableFooterState();
}

class _GiTableFooterState extends State<GiTableFooter> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 根据屏幕宽度判断是否为移动端
        final isMobile = constraints.maxWidth < 768;
        
        return GiPagination(
          current: widget.currentPage,
          pageSize: widget.pageSize,
          total: widget.totalCount,
          showPageSize: !isMobile,
          showTotal: !isMobile,
          simple: isMobile,
          onPageChange: widget.onPageChange,
          onPageSizeChange: widget.onPageSizeChange,
        );
      },
    );
  }
}

