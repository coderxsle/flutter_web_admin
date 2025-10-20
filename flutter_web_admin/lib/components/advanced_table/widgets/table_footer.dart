import 'package:flutter/material.dart';
import '../../pagination/gi_responsive_pagination.dart';
import '../controller/advanced_table_controller.dart';
import '../config/table_pagination_config.dart';

/// 表格底部（分页）
class TableFooter<T> extends StatelessWidget {
  /// 控制器
  final AdvancedTableController<T> controller;
  
  /// 分页配置
  final TablePaginationConfig config;

  const TableFooter({
    super.key,
    required this.controller,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    if (!config.enabled) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 1,
            ),
          ),
        ),
        child: GiResponsivePagination(
          current: controller.currentPage,
          pageSize: controller.pageSize,
          total: controller.total,
          showPageSize: config.showPageSize,
          showTotal: config.showTotal,
          pageSizeOptions: config.pageSizeOptions,
          onPageChange: (page) => controller.setPage(page),
          onPageSizeChange: (pageSize) => controller.setPageSize(pageSize),
          disabled: controller.loading,
        ),
      ),
    );
  }
}


