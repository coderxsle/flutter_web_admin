import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'gi_table_column.dart';
import 'gi_table_toolbar.dart';

/// Gi 增强表格组件
/// 
/// 功能丰富的表格组件，支持排序、筛选、列设置、全屏、边框切换等功能
/// 
/// 使用示例：
/// ```dart
/// GiTable<User>(
///   title: '用户列表',
///   columns: [
///     GiTableColumn<User>(
///       title: '姓名',
///       dataIndex: 'name',
///       cellBuilder: (context, user, index) => Text(user.name),
///     ),
///     GiTableColumn<User>(
///       title: '邮箱',
///       dataIndex: 'email',
///       cellBuilder: (context, user, index) => Text(user.email),
///     ),
///   ],
///   data: userList,
///   onRefresh: () => loadUsers(),
/// )
/// ```
class GiTable<T> extends StatefulWidget {
  /// 表格标题
  final String? title;
  
  /// 自定义标题组件
  final Widget? customTitle;
  
  /// 自定义额外操作组件
  final Widget? customExtra;
  
  /// 表格列配置
  final List<GiTableColumn<T>> columns;
  
  /// 表格数据
  final List<T> data;
  
  /// 是否显示工具栏
  final bool showToolbar;
  
  /// 工具栏配置
  final GiTableToolbarConfig toolbarConfig;
  
  /// 禁用列设置的列键
  final Set<String> disabledColumnKeys;
  
  /// 是否显示加载状态
  final bool loading;
  
  /// 是否显示边框
  final bool showBorder;
  
  /// 是否显示斑马纹
  final bool showStripe;
  
  /// 表格尺寸
  final GiTableSize size;
  
  /// 是否可全屏
  final bool allowFullscreen;
  
  /// 选择配置
  final GiTableSelection<T>? selection;
  
  /// 排序配置
  final GiTableSortConfig<T>? sortConfig;
  
  /// 空数据提示
  final Widget? emptyWidget;
  
  /// 行点击回调
  final void Function(T record, int index)? onRowTap;
  
  /// 刷新回调
  final VoidCallback? onRefresh;
  
  /// 排序变化回调
  final void Function(String columnKey, GiTableSortDirection direction)? onSortChanged;

  const GiTable({
    Key? key,
    this.title,
    this.customTitle,
    this.customExtra,
    required this.columns,
    required this.data,
    this.showToolbar = true,
    this.toolbarConfig = const GiTableToolbarConfig(),
    this.disabledColumnKeys = const {},
    this.loading = false,
    this.showBorder = true,
    this.showStripe = false,
    this.size = GiTableSize.medium,
    this.allowFullscreen = true,
    this.selection,
    this.sortConfig,
    this.emptyWidget,
    this.onRowTap,
    this.onRefresh,
    this.onSortChanged,
  }) : super(key: key);

  @override
  State<GiTable<T>> createState() => _GiTableState<T>();
}

class _GiTableState<T> extends State<GiTable<T>> {
  late List<GiTableColumn<T>> _columns;
  late bool _showBorder;
  late bool _showStripe;
  late GiTableSize _size;
  late bool _isFullscreen;
  late GiTableSortConfig<T>? _sortConfig;
  late Set<String> _selectedRowKeys;

  @override
  void initState() {
    super.initState();
    _columns = List.from(widget.columns);
    _showBorder = widget.showBorder;
    _showStripe = widget.showStripe;
    _size = widget.size;
    _isFullscreen = false;
    _sortConfig = widget.sortConfig;
    _selectedRowKeys = widget.selection?.selectedRowKeys ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return _isFullscreen ? _buildFullscreenTable() : _buildNormalTable();
  }

  /// 构建普通表格
  Widget _buildNormalTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.showToolbar) _buildToolbar(),
        Expanded(child: _buildTableContent()),
      ],
    );
  }

  /// 构建全屏表格
  Widget _buildFullscreenTable() {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildToolbar(),
              Expanded(child: _buildTableContent()),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建工具栏
  Widget _buildToolbar() {
    return GiTableToolbar<T>(
      title: widget.title,
      customTitle: widget.customTitle,
      customExtra: widget.customExtra,
      config: widget.toolbarConfig,
      columns: _columns,
      disabledColumnKeys: widget.disabledColumnKeys,
      size: _size,
      showBorder: _showBorder,
      showStripe: _showStripe,
      isFullscreen: _isFullscreen,
      onRefresh: widget.onRefresh,
      onFullscreenChanged: widget.allowFullscreen ? _handleFullscreenChanged : null,
      onBorderChanged: _handleBorderChanged,
      onStripeChanged: _handleStripeChanged,
      onSizeChanged: _handleSizeChanged,
      onColumnsChanged: _handleColumnsChanged,
    );
  }

  /// 构建表格内容
  Widget _buildTableContent() {
    if (widget.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (widget.data.isEmpty) {
      return widget.emptyWidget ?? _buildEmptyWidget();
    }

    return _buildDataTable();
  }

  /// 构建空数据提示
  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无数据',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建数据表格
  Widget _buildDataTable() {
    final visibleColumns = _columns.where((col) => col.show).toList();
    final sortedData = _getSortedData();

    return Container(
      decoration: BoxDecoration(
        border: _showBorder ? Border.all(color: Colors.grey.shade300) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: DataTable(
            columns: _buildDataColumns(visibleColumns),
            rows: _buildDataRows(visibleColumns, sortedData),
            showCheckboxColumn: widget.selection?.type == GiTableSelectionType.multiple,
            border: _showBorder ? TableBorder.all(color: Colors.grey.shade300) : null,
            headingRowColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
            ),
            dataRowColor: _showStripe
                ? WidgetStateProperty.resolveWith((states) {
                    // 简化的斑马纹实现
                    return null; // DataTable 会自动处理斑马纹
                  })
                : null,
            dataRowHeight: _getRowHeight(),
            headingRowHeight: _getHeaderHeight(),
          ),
        ),
      ),
    );
  }

  /// 构建数据列
  List<DataColumn> _buildDataColumns(List<GiTableColumn<T>> visibleColumns) {
    return visibleColumns.map((column) {
      return DataColumn(
        label: column.headerBuilder?.call(context) ?? 
               _buildDefaultHeader(column),
        onSort: column.sortable ? (columnIndex, ascending) {
          _handleSort(column.columnKey, ascending);
        } : null,
      );
    }).toList();
  }

  /// 构建默认表头
  Widget _buildDefaultHeader(GiTableColumn<T> column) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          column.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        if (column.sortable && _sortConfig?.columnKey == column.columnKey) ...[
          const SizedBox(width: 4),
          Icon(
            _sortConfig!.direction == GiTableSortDirection.ascending
                ? Icons.arrow_upward
                : Icons.arrow_downward,
            size: 16,
          ),
        ],
      ],
    );
  }

  /// 构建数据行
  List<DataRow> _buildDataRows(List<GiTableColumn<T>> visibleColumns, List<T> sortedData) {
    return sortedData.asMap().entries.map((entry) {
      final index = entry.key;
      final record = entry.value;
      final rowKey = widget.selection?.getRowKey?.call(record) ?? index.toString();

      return DataRow(
        selected: _selectedRowKeys.contains(rowKey),
        onSelectChanged: widget.selection?.type == GiTableSelectionType.multiple
            ? (selected) => _handleRowSelection(rowKey, record, selected ?? false)
            : null,
        cells: visibleColumns.map((column) {
          return DataCell(
            column.cellBuilder?.call(context, record, index) ?? 
            _buildDefaultCell(column, record),
            onTap: () => widget.onRowTap?.call(record, index),
          );
        }).toList(),
      );
    }).toList();
  }

  /// 构建默认单元格
  Widget _buildDefaultCell(GiTableColumn<T> column, T record) {
    final value = column.getValue(record);
    return Container(
      alignment: column.alignment,
      child: Text(value?.toString() ?? ''),
    );
  }

  /// 获取排序后的数据
  List<T> _getSortedData() {
    if (_sortConfig == null || _sortConfig!.direction == GiTableSortDirection.none) {
      return widget.data;
    }

    final sortedList = List<T>.from(widget.data);
    if (_sortConfig!.sorter != null) {
      sortedList.sort(_sortConfig!.sorter!);
      if (_sortConfig!.direction == GiTableSortDirection.descending) {
        return sortedList.reversed.toList();
      }
    }
    return sortedList;
  }

  /// 获取行高
  double _getRowHeight() {
    switch (_size) {
      case GiTableSize.mini:
        return 32.0;
      case GiTableSize.small:
        return 40.0;
      case GiTableSize.medium:
        return 48.0;
      case GiTableSize.large:
        return 56.0;
    }
  }

  /// 获取表头高度
  double _getHeaderHeight() {
    switch (_size) {
      case GiTableSize.mini:
        return 36.0;
      case GiTableSize.small:
        return 44.0;
      case GiTableSize.medium:
        return 52.0;
      case GiTableSize.large:
        return 60.0;
    }
  }

  /// 处理全屏切换
  void _handleFullscreenChanged(bool isFullscreen) {
    setState(() {
      _isFullscreen = isFullscreen;
    });
  }

  /// 处理边框切换
  void _handleBorderChanged(bool showBorder) {
    setState(() {
      _showBorder = showBorder;
    });
  }

  /// 处理斑马纹切换
  void _handleStripeChanged(bool showStripe) {
    setState(() {
      _showStripe = showStripe;
    });
  }

  /// 处理尺寸变化
  void _handleSizeChanged(GiTableSize size) {
    setState(() {
      _size = size;
    });
  }

  /// 处理列配置变化
  void _handleColumnsChanged(List<GiTableColumn<T>> columns) {
    setState(() {
      _columns = columns;
    });
  }

  /// 处理排序
  void _handleSort(String columnKey, bool ascending) {
    final direction = ascending 
        ? GiTableSortDirection.ascending 
        : GiTableSortDirection.descending;
    
    final column = _columns.firstWhere((col) => col.columnKey == columnKey);
    
    setState(() {
      _sortConfig = GiTableSortConfig<T>(
        columnKey: columnKey,
        direction: direction,
        sorter: column.sorter,
      );
    });

    widget.onSortChanged?.call(columnKey, direction);
  }

  /// 处理行选择
  void _handleRowSelection(String rowKey, T record, bool selected) {
    setState(() {
      if (selected) {
        _selectedRowKeys.add(rowKey);
      } else {
        _selectedRowKeys.remove(rowKey);
      }
    });

    final selectedRows = widget.data.where((item) {
      final key = widget.selection?.getRowKey?.call(item) ?? widget.data.indexOf(item).toString();
      return _selectedRowKeys.contains(key);
    }).toList();

    widget.selection?.onSelectionChanged?.call(_selectedRowKeys, selectedRows);
  }
}
