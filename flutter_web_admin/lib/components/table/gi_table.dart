import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import 'gi_table_adapter.dart';
import 'gi_table_column.dart';
import 'gi_table_toolbar.dart';
import 'gi_table_column_setting.dart';
import 'gi_table_footer.dart';

/// 表格尺寸枚举
enum GiTableSize {
  mini,
  small,
  medium,
  large,
}

/// GiTable - 基于 trina_grid 封装的增强表格组件
/// 
/// 完全复刻 Vue 版 GiTable 的功能,提供:
/// - 工具栏(斑马纹、刷新、全屏、边框、尺寸、列设置)
/// - 数据自动适配(普通 Map → TrinaRow)
/// - 列配置简化
/// - 分页支持
/// - 行选择支持
class GiTable<T> extends StatefulWidget {
  /// 表格标题
  final String? title;
  
  /// 列配置
  final List<GiTableColumn<T>> columns;
  
  /// 数据源 (普通 Map 格式,会自动转换)
  final List<Map<String, dynamic>> data;
  
  /// 是否显示分页
  final bool showPagination;
  
  /// 当前页码（从1开始）
  final int currentPage;
  
  /// 每页条数
  final int pageSize;
  
  /// 总条数 (用于分页显示)
  final int totalCount;
  
  /// 页码变化回调
  final Function(int page)? onPageChange;
  
  /// 每页条数变化回调
  final Function(int pageSize)? onPageSizeChange;
  
  /// 刷新回调
  final VoidCallback? onRefresh;
  
  /// 自定义标题区域
  final Widget Function(BuildContext)? customTitle;
  
  /// 自定义工具栏额外按钮区域
  final Widget Function(BuildContext)? customExtra;
  
  /// 禁止控制显示隐藏的列 (通过 field 标识)
  final List<String> disabledColumnKeys;
  
  /// 行选择配置
  final bool enableRowSelection;
  
  /// 行选择类型 (单选/多选)
  final bool multipleSelection;
  
  /// 行选择变化回调
  final void Function(List<TrinaRow> selectedRows)? onRowSelectionChanged;
  
  /// 排序变化回调
  final void Function(TrinaGridOnSortedEvent event)? onSorted;
  
  /// 单元格值变化回调
  final void Function(TrinaGridOnChangedEvent event)? onCellChanged;
  
  /// 行双击回调
  final void Function(TrinaGridOnRowDoubleTapEvent event)? onRowDoubleTap;
  
  /// 加载状态
  final bool loading;
  
  /// 空数据提示组件
  final Widget? noRowsWidget;
  
  /// 初始斑马纹状态
  final bool initialStriped;
  
  /// 初始边框状态
  final bool initialBordered;
  
  /// 初始尺寸
  final GiTableSize initialSize;
  
  const GiTable({
    super.key,
    this.title,
    required this.columns,
    required this.data,
    this.showPagination = false,
    this.currentPage = 1,
    this.pageSize = 20,
    this.totalCount = 0,
    this.onPageChange,
    this.onPageSizeChange,
    this.onRefresh,
    this.customTitle,
    this.customExtra,
    this.disabledColumnKeys = const [],
    this.enableRowSelection = false,
    this.multipleSelection = true,
    this.onRowSelectionChanged,
    this.onSorted,
    this.onCellChanged,
    this.onRowDoubleTap,
    this.loading = false,
    this.noRowsWidget,
    this.initialStriped = false,
    this.initialBordered = true,
    this.initialSize = GiTableSize.medium,
  });

  @override
  State<GiTable<T>> createState() => _GiTableState<T>();
}

class _GiTableState<T> extends State<GiTable<T>> {
  /// trina_grid 状态管理器
  TrinaGridStateManager? _stateManager;
  
  /// 斑马纹状态
  late bool _isStriped;
  
  /// 边框状态
  late bool _isBordered;
  
  /// 全屏状态
  bool _isFullscreen = false;
  
  /// 当前尺寸
  late GiTableSize _size;
  
  /// 可见列 (用于列设置功能)
  late List<GiTableColumn<T>> _visibleColumns;
  
  /// 全屏 Overlay
  OverlayEntry? _overlayEntry;
  
  @override
  void initState() {
    super.initState();
    _isStriped = widget.initialStriped;
    _isBordered = widget.initialBordered;
    _size = widget.initialSize;
    _visibleColumns = List.from(widget.columns);
  }
  
  @override
  void didUpdateWidget(GiTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // 如果列配置变化,更新可见列
    if (widget.columns != oldWidget.columns) {
      _visibleColumns = List.from(widget.columns);
    }

    // 如果数据变化，更新表格行
    if (widget.data != oldWidget.data && _stateManager != null) {
      final newRows = GiTableAdapter.convertToTrinaRows(widget.data);
      _stateManager!.removeAllRows();
      _stateManager!.appendRows(newRows);
    }
    
    // 如果分页参数变化，强制重建以更新 Footer
    // 这会导致 TrinaGrid 重建（因为 Key 变化），但这是必要的，否则 createFooter 不会重新执行
    if (widget.showPagination && 
        (widget.currentPage != oldWidget.currentPage || 
         widget.pageSize != oldWidget.pageSize || 
         widget.totalCount != oldWidget.totalCount)) {
      setState(() {});
    }
  }
  
  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isFullscreen) {
      return Container(); // 全屏时主体返回空容器
    }
    
    return _buildTableContainer();
  }
  
  /// 构建表格容器
  Widget _buildTableContainer() {
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 工具栏
          GiTableToolbar(
            title: widget.title,
            customTitle: widget.customTitle,
            customExtra: widget.customExtra,
            isStriped: _isStriped,
            isBordered: _isBordered,
            isFullscreen: _isFullscreen,
            size: _size,
            columns: widget.columns,
            visibleColumns: _visibleColumns,
            disabledColumnKeys: widget.disabledColumnKeys,
            onStripedToggle: () => setState(() => _isStriped = !_isStriped),
            onBorderedToggle: () => setState(() => _isBordered = !_isBordered),
            onRefresh: widget.onRefresh,
            onFullscreenToggle: _toggleFullscreen,
            onSizeChange: (size) => setState(() => _size = size),
            onColumnSettingsOpen: _showColumnSettings,
            onColumnsReordered: (newColumns) {
              setState(() => _visibleColumns = newColumns);
            },
          ),
          
          // 表格内容
          Expanded(
            child: _buildTable(),
          ),
        ],
      ),
    );
  }
  
  /// 构建表格
  Widget _buildTable() {
    // 数据转换
    final trinaRows = GiTableAdapter.convertToTrinaRows(widget.data);
    final trinaColumns = GiTableAdapter.convertToTrinaColumns(_visibleColumns);
    
    // 构建配置
    final configuration = _buildConfiguration();
    
    // 关键：添加 Key 让 TrinaGrid 在分页参数变化时重建
    // 这样 createFooter 会重新调用，Footer 组件才能更新
    final gridKey = widget.showPagination
        ? ValueKey('grid_${widget.currentPage}_${widget.pageSize}_${widget.totalCount}')
        : null;
    
    return TrinaGrid(
      key: gridKey,
      columns: trinaColumns,
      rows: trinaRows,
      configuration: configuration,
      mode: widget.enableRowSelection 
          ? (widget.multipleSelection 
              ? TrinaGridMode.multiSelect 
              : TrinaGridMode.select)
          : TrinaGridMode.normal,
      onLoaded: (event) {
        _stateManager = event.stateManager;
        
        // 设置分页
        if (widget.showPagination) {
          _stateManager?.setPageSize(widget.pageSize);
          debugPrint('🔧 TrinaGrid: 设置每页条数为 ${widget.pageSize}');
        }
        
        if (widget.enableRowSelection) {
          _stateManager?.setSelectingMode(
            widget.multipleSelection 
                ? TrinaGridSelectingMode.row 
                : TrinaGridSelectingMode.none,
          );
        }
      },
      onSelected: widget.onRowSelectionChanged != null
          ? (event) {
              widget.onRowSelectionChanged!(event.selectedRows ?? []);
            }
          : null,
      onSorted: widget.onSorted,
      onChanged: widget.onCellChanged,
      onRowDoubleTap: widget.onRowDoubleTap,
      noRowsWidget: widget.noRowsWidget,
      // 使用自定义分页组件
      createFooter: widget.showPagination 
          ? (stateManager) => _buildPagination(stateManager)
          : null,
    );
  }
  
  /// 构建 TrinaGrid 配置
  TrinaGridConfiguration _buildConfiguration() {
    final theme = Theme.of(context);
    
    return TrinaGridConfiguration(
      // 尺寸和样式
      style: TrinaGridStyleConfig(
        rowHeight: _getRowHeight(),
        columnHeight: _getHeaderHeight(),
        
        // 斑马纹
        enableRowColorAnimation: _isStriped,
        oddRowColor: _isStriped ? const Color(0xFFF7F8FA) : null,
        evenRowColor: _isStriped ? Colors.white : null,
        
        // 边框
        enableColumnBorderVertical: _isBordered,
        enableColumnBorderHorizontal: _isBordered,
        enableCellBorderVertical: _isBordered,
        enableCellBorderHorizontal: _isBordered,
        borderColor: _isBordered ? const Color(0xFFE5E6EB) : Colors.transparent,
        
        // 字体样式
        columnTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: theme.textTheme.bodyLarge?.color,
        ),
        cellTextStyle: TextStyle(
          fontSize: 14,
          color: theme.textTheme.bodyMedium?.color,
        ),
        
        // 默认单元格内边距
        defaultCellPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      
      // 其他配置
      columnSize: const TrinaGridColumnSizeConfig(
        autoSizeMode: TrinaAutoSizeMode.none,
        resizeMode: TrinaResizeMode.normal,
      ),
      
      // 滚动条配置
      scrollbar: const TrinaGridScrollbarConfig(
        isDraggable: true,
        isAlwaysShown: true,
        thickness: 8,
      ),
      
      // 分页配置（用于 TrinaGrid 自带分页）
      enterKeyAction: TrinaGridEnterKeyAction.none,
    );
  }
  
  /// 获取行高
  double _getRowHeight() {
    switch (_size) {
      case GiTableSize.mini:
        return 32;
      case GiTableSize.small:
        return 40;
      case GiTableSize.medium:
        return 48;
      case GiTableSize.large:
        return 56;
    }
  }
  
  /// 获取表头高度
  double _getHeaderHeight() {
    switch (_size) {
      case GiTableSize.mini:
        return 36;
      case GiTableSize.small:
        return 44;
      case GiTableSize.medium:
        return 52;
      case GiTableSize.large:
        return 60;
    }
  }
  
  /// 构建分页
  Widget _buildPagination(TrinaGridStateManager stateManager) {
    return GiTableFooter(
      currentPage: widget.currentPage,
      pageSize: widget.pageSize,
      totalCount: widget.totalCount,
      onPageChange: widget.onPageChange,
      onPageSizeChange: widget.onPageSizeChange,
    );
  }
  
  /// 切换全屏
  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
    
    if (_isFullscreen) {
      _showFullscreenOverlay();
    } else {
      _hideFullscreenOverlay();
    }
  }
  
  /// 显示全屏覆盖层
  void _showFullscreenOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _buildTableContainer(),
          ),
        ),
      ),
    );
    
    Overlay.of(context).insert(_overlayEntry!);
  }
  
  /// 隐藏全屏覆盖层
  void _hideFullscreenOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
  
  /// 显示列设置弹窗
  void _showColumnSettings() {
    showDialog(
      context: context,
      builder: (context) => GiTableColumnSetting(
        columns: widget.columns,
        visibleColumns: _visibleColumns,
        disabledColumnKeys: widget.disabledColumnKeys,
        onColumnsChanged: (newColumns) {
          setState(() {
            _visibleColumns = newColumns;
          });
        },
      ),
    );
  }
}

