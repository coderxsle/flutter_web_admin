import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/gi_space.dart';
import 'gi_table_column.dart';

/// Gi 表格工具栏组件
/// 
/// 提供表格的各种操作功能，如刷新、全屏、边框切换、尺寸调整、列设置等
class GiTableToolbar<T> extends StatefulWidget {
  /// 表格标题
  final String? title;
  
  /// 自定义标题组件
  final Widget? customTitle;
  
  /// 自定义额外操作组件
  final Widget? customExtra;
  
  /// 工具栏配置
  final GiTableToolbarConfig config;
  
  /// 表格列配置
  final List<GiTableColumn<T>> columns;
  
  /// 禁用列设置的列键
  final Set<String> disabledColumnKeys;
  
  /// 当前表格尺寸
  final GiTableSize size;
  
  /// 是否显示边框
  final bool showBorder;
  
  /// 是否显示斑马纹
  final bool showStripe;
  
  /// 是否全屏
  final bool isFullscreen;
  
  /// 刷新回调
  final VoidCallback? onRefresh;
  
  /// 全屏切换回调
  final void Function(bool isFullscreen)? onFullscreenChanged;
  
  /// 边框切换回调
  final void Function(bool showBorder)? onBorderChanged;
  
  /// 斑马纹切换回调
  final void Function(bool showStripe)? onStripeChanged;
  
  /// 尺寸变化回调
  final void Function(GiTableSize size)? onSizeChanged;
  
  /// 列设置变化回调
  final void Function(List<GiTableColumn<T>> columns)? onColumnsChanged;

  const GiTableToolbar({
    Key? key,
    this.title,
    this.customTitle,
    this.customExtra,
    this.config = const GiTableToolbarConfig(),
    required this.columns,
    this.disabledColumnKeys = const {},
    required this.size,
    required this.showBorder,
    required this.showStripe,
    required this.isFullscreen,
    this.onRefresh,
    this.onFullscreenChanged,
    this.onBorderChanged,
    this.onStripeChanged,
    this.onSizeChanged,
    this.onColumnsChanged,
  }) : super(key: key);

  @override
  State<GiTableToolbar<T>> createState() => _GiTableToolbarState<T>();
}

class _GiTableToolbarState<T> extends State<GiTableToolbar<T>> {
  late List<GiTableColumn<T>> _workingColumns;

  @override
  void initState() {
    super.initState();
    _workingColumns = List.from(widget.columns);
  }

  @override
  void didUpdateWidget(GiTableToolbar<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.columns != oldWidget.columns) {
      _workingColumns = List.from(widget.columns);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左侧标题区域
          Expanded(
            child: widget.customTitle ?? _buildTitle(),
          ),
          
          // 右侧工具栏
          GiSpace(
            spacing: 8,
            children: [
              if (widget.customExtra != null) widget.customExtra!,
              _buildToolbarActions(),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建标题
  Widget _buildTitle() {
    if (widget.title == null || widget.title!.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Text(
      widget.title!,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// 构建工具栏操作按钮
  Widget _buildToolbarActions() {
    return GiSpace(
      spacing: 4,
      children: [
        // 斑马纹开关
        if (widget.config.showStripe)
          Tooltip(
            message: '斑马纹',
            child: Transform.scale(
              scale: 0.8,
              child: Switch(
                value: widget.showStripe,
                onChanged: widget.onStripeChanged,
              ),
            ),
          ),

        // 刷新按钮
        if (widget.config.showRefresh)
          Tooltip(
            message: '刷新',
            child: IconButton(
              onPressed: widget.onRefresh,
              icon: const Icon(Icons.refresh),
              iconSize: 20,
            ),
          ),

        // 全屏按钮
        if (widget.config.showFullscreen)
          Tooltip(
            message: widget.isFullscreen ? '退出全屏' : '全屏',
            child: IconButton(
              onPressed: () => widget.onFullscreenChanged?.call(!widget.isFullscreen),
              icon: Icon(widget.isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
              iconSize: 20,
            ),
          ),

        // 边框切换按钮
        if (widget.config.showBorder)
          Tooltip(
            message: '显示边框',
            child: IconButton(
              onPressed: () => widget.onBorderChanged?.call(!widget.showBorder),
              icon: Icon(
                widget.showBorder ? Icons.border_all : Icons.border_clear,
                color: widget.showBorder ? Theme.of(context).primaryColor : null,
              ),
              iconSize: 20,
            ),
          ),

        // 尺寸设置按钮
        if (widget.config.showSize)
          _buildSizeSelector(),

        // 列设置按钮
        if (widget.config.showColumnSetting && widget.columns.isNotEmpty)
          _buildColumnSettingButton(),
      ],
    );
  }

  /// 构建尺寸选择器
  Widget _buildSizeSelector() {
    return PopupMenuButton<GiTableSize>(
      tooltip: '表格尺寸',
      icon: const Icon(Icons.table_rows, size: 20),
      onSelected: widget.onSizeChanged,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: GiTableSize.mini,
          child: Text('迷你'),
        ),
        const PopupMenuItem(
          value: GiTableSize.small,
          child: Text('小型'),
        ),
        const PopupMenuItem(
          value: GiTableSize.medium,
          child: Text('中等'),
        ),
        const PopupMenuItem(
          value: GiTableSize.large,
          child: Text('大型'),
        ),
      ],
    );
  }

  /// 构建列设置按钮
  Widget _buildColumnSettingButton() {
    return PopupMenuButton(
      tooltip: '列设置',
      icon: Icon(Icons.settings, size: 20, color: Theme.of(context).primaryColor),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: SizedBox(
            width: 200,
            child: _buildColumnSettingContent(),
          ),
        ),
      ],
    );
  }

  /// 构建列设置内容
  Widget _buildColumnSettingContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 标题
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Text(
            '列设置',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        
        // 列设置列表
        Container(
          constraints: const BoxConstraints(maxHeight: 300),
          child: ReorderableListView.builder(
            shrinkWrap: true,
            itemCount: _workingColumns.length,
            onReorder: _handleReorder,
            itemBuilder: (context, index) {
              final column = _workingColumns[index];
              final isDisabled = widget.disabledColumnKeys.contains(column.columnKey);
              
              return Container(
                key: ValueKey(column.columnKey),
                child: CheckboxListTile(
                  title: Text(
                    column.title,
                    style: const TextStyle(fontSize: 12),
                  ),
                  value: column.show,
                  onChanged: isDisabled ? null : (value) {
                    setState(() {
                      _workingColumns[index] = column.copyWith(show: value ?? false);
                    });
                    widget.onColumnsChanged?.call(_workingColumns);
                  },
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  secondary: const Icon(Icons.drag_indicator, size: 16),
                ),
              );
            },
          ),
        ),
        
        const Divider(),
        
        // 重置按钮
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: _handleReset,
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('重置'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ],
    );
  }

  /// 处理列重排序
  void _handleReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final column = _workingColumns.removeAt(oldIndex);
      _workingColumns.insert(newIndex, column);
    });
    widget.onColumnsChanged?.call(_workingColumns);
  }

  /// 处理重置
  void _handleReset() {
    setState(() {
      _workingColumns = widget.columns.map((col) => col.copyWith(show: true)).toList();
    });
    widget.onColumnsChanged?.call(_workingColumns);
    
    // 关闭弹窗
    Navigator.of(context).pop();
    
    Get.snackbar(
      '提示',
      '列设置已重置',
      duration: const Duration(seconds: 2),
    );
  }
}
