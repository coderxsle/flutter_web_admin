import 'package:flutter/material.dart';
import '../controller/advanced_table_controller.dart';
import '../config/table_export_config.dart';

/// 表格工具栏
class TableToolbar<T> extends StatelessWidget {
  /// 控制器
  final AdvancedTableController<T> controller;
  
  /// 标题
  final String? title;
  
  /// 自定义标题组件
  final Widget? customTitle;
  
  /// 自定义额外操作组件
  final Widget? customExtra;
  
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
  
  /// 导出配置
  final TableExportConfig? exportConfig;
  
  /// 刷新回调
  final VoidCallback? onRefresh;

  const TableToolbar({
    super.key,
    required this.controller,
    this.title,
    this.customTitle,
    this.customExtra,
    this.showRefresh = true,
    this.showFullscreen = true,
    this.showBorderToggle = true,
    this.showStripeToggle = true,
    this.showColumnSetting = true,
    this.showExport = false,
    this.exportConfig,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // 左侧标题
            Expanded(
              child: customTitle ?? _buildTitle(context),
            ),
            
            // 右侧操作按钮
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (customExtra != null) ...[
                  customExtra!,
                  const SizedBox(width: 8),
                ],
                
                // 刷新按钮
                if (showRefresh)
                  IconButton(
                    icon: const Icon(Icons.refresh, size: 20),
                    tooltip: '刷新',
                    onPressed: () {
                      onRefresh?.call();
                      controller.refresh();
                    },
                  ),
                
                // 全屏按钮
                if (showFullscreen)
                  IconButton(
                    icon: Icon(
                      controller.isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                      size: 20,
                    ),
                    tooltip: controller.isFullscreen ? '退出全屏' : '全屏',
                    onPressed: controller.toggleFullscreen,
                  ),
                
                // 边框切换
                if (showBorderToggle)
                  IconButton(
                    icon: Icon(
                      controller.showBorder ? Icons.border_all : Icons.border_clear,
                      size: 20,
                      color: controller.showBorder ? Theme.of(context).primaryColor : null,
                    ),
                    tooltip: '边框',
                    onPressed: controller.toggleBorder,
                  ),
                
                // 斑马纹切换
                if (showStripeToggle)
                  Tooltip(
                    message: '斑马纹',
                    child: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: controller.showStripe,
                        onChanged: (_) => controller.toggleStripe(),
                      ),
                    ),
                  ),
                
                // 列设置
                if (showColumnSetting)
                  _buildColumnSettingButton(context),
                
                // 导出按钮
                if (showExport && exportConfig?.enabled == true)
                  _buildExportButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建标题
  Widget _buildTitle(BuildContext context) {
    if (title == null || title!.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Text(
      title!,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// 构建列设置按钮
  Widget _buildColumnSettingButton(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.settings,
        size: 20,
        color: Theme.of(context).primaryColor,
      ),
      tooltip: '列设置',
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: SizedBox(
            width: 250,
            child: _buildColumnSettingPanel(context),
          ),
        ),
      ],
    );
  }

  /// 构建列设置面板
  Widget _buildColumnSettingPanel(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '列设置',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  // 重置列
                  Navigator.pop(context);
                },
                child: const Text('重置', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        
        const Divider(height: 1),
        
        // 列列表
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.columns.length,
            itemBuilder: (context, index) {
              final column = controller.columns[index];
              return CheckboxListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: Text(
                  column.title,
                  style: const TextStyle(fontSize: 13),
                ),
                value: column.show,
                onChanged: column.hideable
                    ? (value) {
                        controller.toggleColumnVisibility(column.columnKey);
                      }
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }

  /// 构建导出按钮
  Widget _buildExportButton(BuildContext context) {
    return PopupMenuButton<ExportFormat>(
      icon: const Icon(Icons.download, size: 20),
      tooltip: '导出',
      onSelected: (format) {
        _handleExport(format);
      },
      itemBuilder: (context) {
        final items = <PopupMenuEntry<ExportFormat>>[];
        
        if (exportConfig?.enableExcel == true) {
          items.add(
            const PopupMenuItem(
              value: ExportFormat.excel,
              child: Row(
                children: [
                  Icon(Icons.table_chart, size: 16),
                  SizedBox(width: 8),
                  Text('导出 Excel'),
                ],
              ),
            ),
          );
        }
        
        if (exportConfig?.enableCSV == true) {
          items.add(
            const PopupMenuItem(
              value: ExportFormat.csv,
              child: Row(
                children: [
                  Icon(Icons.description, size: 16),
                  SizedBox(width: 8),
                  Text('导出 CSV'),
                ],
              ),
            ),
          );
        }
        
        if (exportConfig?.enableJSON == true) {
          items.add(
            const PopupMenuItem(
              value: ExportFormat.json,
              child: Row(
                children: [
                  Icon(Icons.code, size: 16),
                  SizedBox(width: 8),
                  Text('导出 JSON'),
                ],
              ),
            ),
          );
        }
        
        return items;
      },
    );
  }

  /// 处理导出
  void _handleExport(ExportFormat format) {
    // 导出功能将在后续实现
    debugPrint('导出格式: $format');
  }
}


