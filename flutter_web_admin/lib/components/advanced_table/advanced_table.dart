import 'package:flutter/material.dart';
import 'controller/advanced_table_controller.dart';
import 'config/table_column_config.dart';
import 'config/table_selection_config.dart';
import 'config/table_pagination_config.dart';
import 'config/table_export_config.dart';
import 'widgets/table_toolbar.dart';
import 'widgets/table_header.dart';
import 'widgets/table_body.dart';
import 'widgets/table_footer.dart';

/// 高级表格组件
/// 
/// 功能完善的企业级表格组件，支持：
/// - 虚拟滚动（大数据量优化）
/// - 高级筛选和搜索
/// - 列操作（拖拽、调整宽度、固定列）
/// - 展开行/树形表格
/// - 单元格编辑
/// - 批量操作
/// - 导出（Excel/CSV）
/// - 服务端分页
class AdvancedTable<T> extends StatefulWidget {
  /// 控制器
  final AdvancedTableController<T>? controller;
  
  /// 列配置
  final List<TableColumnConfig<T>> columns;
  
  /// 初始数据
  final List<T>? data;
  
  /// 标题
  final String? title;
  
  /// 自定义标题组件
  final Widget? customTitle;
  
  /// 自定义额外操作组件
  final Widget? customExtra;
  
  /// 选择配置
  final TableSelectionConfig<T>? selectionConfig;
  
  /// 分页配置
  final TablePaginationConfig paginationConfig;
  
  /// 导出配置
  final TableExportConfig? exportConfig;
  
  /// 是否显示工具栏
  final bool showToolbar;
  
  /// 是否显示刷新按钮
  final bool showRefresh;
  
  /// 是否显示全屏按钮
  final bool showFullscreen;
  
  /// 是否显示边框切换
  final bool showBorderToggle;
  
  /// 是否显示斑马纹切换
  final bool showStripeToggle;
  
  /// 是否显示列设置
  final bool showColumnSetting;
  
  /// 是否显示导出按钮
  final bool showExport;
  
  /// 是否显示边框
  final bool showBorder;
  
  /// 是否显示斑马纹
  final bool showStripe;
  
  /// 行高
  final double rowHeight;
  
  /// 空数据组件
  final Widget? emptyWidget;
  
  /// 加载组件
  final Widget? loadingWidget;
  
  /// 行点击回调
  final void Function(T record, int index)? onRowTap;
  
  /// 行双击回调
  final void Function(T record, int index)? onRowDoubleTap;
  
  /// 刷新回调
  final VoidCallback? onRefresh;
  
  /// 展开行构建器
  final Widget Function(BuildContext context, T record, int index)? expandedBuilder;
  
  /// 表格高度
  final double? height;
  
  /// 是否启用虚拟滚动
  final bool enableVirtualScroll;

  const AdvancedTable({
    super.key,
    this.controller,
    required this.columns,
    this.data,
    this.title,
    this.customTitle,
    this.customExtra,
    this.selectionConfig,
    this.paginationConfig = const TablePaginationConfig(),
    this.exportConfig,
    this.showToolbar = true,
    this.showRefresh = true,
    this.showFullscreen = true,
    this.showBorderToggle = true,
    this.showStripeToggle = true,
    this.showColumnSetting = true,
    this.showExport = false,
    this.showBorder = true,
    this.showStripe = false,
    this.rowHeight = 48,
    this.emptyWidget,
    this.loadingWidget,
    this.onRowTap,
    this.onRowDoubleTap,
    this.onRefresh,
    this.expandedBuilder,
    this.height,
    this.enableVirtualScroll = false,
  });

  @override
  State<AdvancedTable<T>> createState() => _AdvancedTableState<T>();
}

class _AdvancedTableState<T> extends State<AdvancedTable<T>> {
  late AdvancedTableController<T> _controller;
  bool _isInternalController = false;
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _bodyScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    // 如果没有提供控制器，创建内部控制器
    if (widget.controller == null) {
      _controller = AdvancedTableController<T>(
        initialData: widget.data,
        columns: widget.columns,
        selectionConfig: widget.selectionConfig,
        paginationConfig: widget.paginationConfig,
      );
      _isInternalController = true;
    } else {
      _controller = widget.controller!;
      // 设置初始配置
      _controller.setColumns(widget.columns);
      if (widget.data != null) {
        _controller.setData(widget.data!);
      }
      _controller.selectionConfig = widget.selectionConfig;
      _controller.paginationConfig = widget.paginationConfig;
    }
    
    // 设置滚动同步
    _setupScrollSync();
  }
  
  /// 设置滚动同步
  void _setupScrollSync() {
    // 表头滚动时同步表体
    _horizontalScrollController.addListener(() {
      if (_horizontalScrollController.hasClients && _bodyScrollController.hasClients) {
        final offset = _horizontalScrollController.offset;
        if ((_bodyScrollController.offset - offset).abs() > 1.0) {
          _bodyScrollController.jumpTo(offset);
        }
      }
    });
    
    // 表体滚动时同步表头
    _bodyScrollController.addListener(() {
      if (_bodyScrollController.hasClients && _horizontalScrollController.hasClients) {
        final offset = _bodyScrollController.offset;
        if ((_horizontalScrollController.offset - offset).abs() > 1.0) {
          _horizontalScrollController.jumpTo(offset);
        }
      }
    });
  }

  @override
  void didUpdateWidget(AdvancedTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // 更新列配置
    if (widget.columns != oldWidget.columns) {
      _controller.setColumns(widget.columns);
    }
    
    // 更新数据
    if (widget.data != oldWidget.data && widget.data != null) {
      _controller.setData(widget.data!);
    }
  }

  @override
  void dispose() {
    // 只释放内部创建的控制器
    if (_isInternalController) {
      _controller.dispose();
    }
    _horizontalScrollController.dispose();
    _bodyScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (_controller.isFullscreen) {
          return _buildFullscreenTable(context);
        }
        return _buildNormalTable(context);
      },
    );
  }

  /// 构建普通表格
  Widget _buildNormalTable(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          border: _controller.showBorder
              ? Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // 工具栏
            if (widget.showToolbar)
              TableToolbar<T>(
                controller: _controller,
                title: widget.title,
                customTitle: widget.customTitle,
                customExtra: widget.customExtra,
                showRefresh: widget.showRefresh,
                showFullscreen: widget.showFullscreen,
                showBorderToggle: widget.showBorderToggle,
                showStripeToggle: widget.showStripeToggle,
                showColumnSetting: widget.showColumnSetting,
                showExport: widget.showExport,
                exportConfig: widget.exportConfig,
                onRefresh: widget.onRefresh,
              ),
            
            // 表格内容区域 - 包含滚动条
            Expanded(
              child: _buildTableWithScrollbars(context),
            ),
            
            // 分页
            if (widget.paginationConfig.enabled)
              TableFooter<T>(
                controller: _controller,
                config: widget.paginationConfig,
              ),
          ],
        ),
      ),
    );
  }

  /// 构建全屏表格
  Widget _buildFullscreenTable(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildNormalTable(context),
        ),
      ),
    );
  }

  /// 构建带滚动条的表格
  Widget _buildTableWithScrollbars(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (_controller.loading) {
          return widget.loadingWidget ?? _buildLoadingWidget(context);
        }

        return ScrollbarTheme(
          data: ScrollbarThemeData(
            thumbVisibility: WidgetStateProperty.all(true),
            trackVisibility: WidgetStateProperty.all(true),
            thickness: WidgetStateProperty.all(12),
            radius: const Radius.circular(6),
            thumbColor: WidgetStateProperty.all(
              Theme.of(context).primaryColor.withValues(alpha: 0.7),
            ),
            trackColor: WidgetStateProperty.all(
              Theme.of(context).dividerColor.withValues(alpha: 0.3),
            ),
            trackBorderColor: WidgetStateProperty.all(
              Theme.of(context).dividerColor,
            ),
            minThumbLength: 80,
            crossAxisMargin: 2,
            mainAxisMargin: 8,
          ),
          child: Row(
            children: [
              // 表格内容
              Expanded(
                child: Scrollbar(
                  controller: _bodyScrollController,
                  child: _buildTableContent(context),
                ),
              ),
              // 垂直滚动条
              Scrollbar(
                controller: _bodyScrollController,
                child: const SizedBox(width: 0), // 占位，实际滚动条由上面的 Scrollbar 显示
              ),
            ],
          ),
        );
      },
    );
  }

  /// 构建表格内容
  Widget _buildTableContent(BuildContext context) {
    return Column(
      children: [
        // 表头
        TableHeader<T>(
          controller: _controller,
          columns: _controller.visibleColumns,
          selectionConfig: widget.selectionConfig,
          showBorder: _controller.showBorder,
          scrollController: _horizontalScrollController,
        ),
        
        // 表体
        Expanded(
          child: TableBody<T>(
            controller: _controller,
            columns: _controller.visibleColumns,
            selectionConfig: widget.selectionConfig,
            showBorder: _controller.showBorder,
            showStripe: _controller.showStripe,
            onRowTap: widget.onRowTap,
            onRowDoubleTap: widget.onRowDoubleTap,
            rowHeight: widget.rowHeight,
            emptyWidget: widget.emptyWidget,
            expandedBuilder: widget.expandedBuilder,
            scrollController: _horizontalScrollController,
            verticalScrollController: _bodyScrollController,
          ),
        ),
      ],
    );
  }

  /// 构建加载组件
  Widget _buildLoadingWidget(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}


