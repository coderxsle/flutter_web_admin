import 'package:flutter/material.dart';
import 'gi_table.dart';
import 'gi_table_column.dart';

/// GiTable 工具栏组件
/// 
/// 提供:
/// - 标题/自定义标题区域
/// - 自定义工具按钮区域
/// - 斑马纹开关
/// - 刷新按钮
/// - 全屏/退出全屏按钮
/// - 边框显示切换
/// - 表格尺寸选择
/// - 列设置按钮
class GiTableToolbar<T> extends StatelessWidget {
  /// 标题
  final String? title;
  
  /// 自定义标题区域
  final Widget Function(BuildContext)? customTitle;
  
  /// 自定义工具按钮区域
  final Widget Function(BuildContext)? customExtra;
  
  /// 斑马纹状态
  final bool isStriped;
  
  /// 边框状态
  final bool isBordered;
  
  /// 全屏状态
  final bool isFullscreen;
  
  /// 当前尺寸
  final GiTableSize size;
  
  /// 所有列
  final List<GiTableColumn<T>> columns;
  
  /// 可见列
  final List<GiTableColumn<T>> visibleColumns;
  
  /// 禁止控制的列
  final List<String> disabledColumnKeys;
  
  /// 斑马纹切换回调
  final VoidCallback onStripedToggle;
  
  /// 边框切换回调
  final VoidCallback onBorderedToggle;
  
  /// 刷新回调
  final VoidCallback? onRefresh;
  
  /// 全屏切换回调
  final VoidCallback onFullscreenToggle;
  
  /// 尺寸变化回调
  final void Function(GiTableSize size) onSizeChange;
  
  /// 列设置打开回调
  final VoidCallback onColumnSettingsOpen;
  
  /// 列重新排序回调
  final void Function(List<GiTableColumn<T>> columns) onColumnsReordered;

  const GiTableToolbar({
    super.key,
    this.title,
    this.customTitle,
    this.customExtra,
    required this.isStriped,
    required this.isBordered,
    required this.isFullscreen,
    required this.size,
    required this.columns,
    required this.visibleColumns,
    required this.disabledColumnKeys,
    required this.onStripedToggle,
    required this.onBorderedToggle,
    this.onRefresh,
    required this.onFullscreenToggle,
    required this.onSizeChange,
    required this.onColumnSettingsOpen,
    required this.onColumnsReordered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左侧标题区域
          Expanded(
            child: _buildTitleArea(context),
          ),
          
          // 右侧工具栏
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // 自定义额外按钮
              if (customExtra != null) customExtra!(context),
              
              // 工具按钮组
              Wrap(
                spacing: 14,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // 斑马纹开关
                  _buildStripedSwitch(context),
                  
                  // 刷新按钮
                  if (onRefresh != null) _buildRefreshButton(context),
                  
                  // 全屏按钮
                  _buildFullscreenButton(context),
                  
                  // 边框按钮
                  _buildBorderButton(context),
                  
                  // 尺寸选择
                  _buildSizeSelector(context),
                  
                  // 列设置按钮
                  if (columns.isNotEmpty) _buildColumnSettingsButton(context),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  /// 构建标题区域
  Widget _buildTitleArea(BuildContext context) {
    if (customTitle != null) {
      return customTitle!(context);
    }
    
    if (title != null && title!.isNotEmpty) {
      return Text(
        title!,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
      );
    }
    
    return const SizedBox.shrink();
  }
  
  /// 构建斑马纹开关
  Widget _buildStripedSwitch(BuildContext context) {
    return Tooltip(
      message: '斑马纹',
      child: Transform.scale(
        scale: 0.8,
        child: Switch(
          value: isStriped,
          onChanged: (_) => onStripedToggle(),
          // 使用全局主题配置，无需指定任何样式属性
        ),
      ),
    );
  }
  
  /// 构建刷新按钮
  Widget _buildRefreshButton(BuildContext context) {
    return Tooltip(
      message: '刷新',
      child: IconButton(
        icon: const Icon(Icons.refresh, size: 18),
        onPressed: onRefresh,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
  
  /// 构建全屏按钮
  Widget _buildFullscreenButton(BuildContext context) {
    return Tooltip(
      message: isFullscreen ? '退出全屏' : '全屏',
      child: IconButton(
        icon: Icon(
          isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
          size: 18,
        ),
        onPressed: onFullscreenToggle,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
  
  /// 构建边框按钮
  Widget _buildBorderButton(BuildContext context) {
    return Tooltip(
      message: '显示边框',
      child: IconButton(
        icon: Icon(
          isBordered ? Icons.border_all : Icons.border_clear,
          size: 18,
        ),
        onPressed: onBorderedToggle,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
  
  /// 构建尺寸选择器
  Widget _buildSizeSelector(BuildContext context) {
    return Tooltip(
      message: '表格尺寸',
      child: PopupMenuButton<GiTableSize>(
        icon: const Icon(Icons.format_size, size: 18),
        padding: EdgeInsets.zero,
        iconSize: 18,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        offset: const Offset(0, 40),
        onSelected: onSizeChange,
        itemBuilder: (context) => [
          _buildSizeMenuItem(context, GiTableSize.mini, '迷你'),
          _buildSizeMenuItem(context, GiTableSize.small, '小型'),
          _buildSizeMenuItem(context, GiTableSize.medium, '中等'),
          _buildSizeMenuItem(context, GiTableSize.large, '大型'),
        ],
      ),
    );
  }
  
  /// 构建尺寸菜单项
  PopupMenuItem<GiTableSize> _buildSizeMenuItem(
    BuildContext context,
    GiTableSize itemSize,
    String label,
  ) {
    final isSelected = size == itemSize;
    return PopupMenuItem<GiTableSize>(
      value: itemSize,
      child: Row(
        children: [
          if (isSelected)
            Icon(
              Icons.check,
              size: 16,
              color: Theme.of(context).primaryColor,
            )
          else
            const SizedBox(width: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Theme.of(context).primaryColor : null,
              fontWeight: isSelected ? FontWeight.w500 : null,
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建列设置按钮
  Widget _buildColumnSettingsButton(BuildContext context) {
    return Tooltip(
      message: '列设置',
      child: IconButton(
        icon: const Icon(Icons.settings, size: 18),
        onPressed: onColumnSettingsOpen,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

