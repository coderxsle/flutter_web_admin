import 'package:flutter/material.dart';
import '../models/filter_model.dart';
import '../models/sort_model.dart';
import '../config/table_column_config.dart';
import '../config/table_selection_config.dart';
import '../config/table_pagination_config.dart';
import '../utils/data_processor.dart';

/// 高级表格控制器
class AdvancedTableController<T> extends ChangeNotifier {
  /// 原始数据
  List<T> _rawData = <T>[];
  
  /// 筛选后的数据
  List<T> _filteredData = <T>[];
  
  /// 排序后的数据
  List<T> _sortedData = <T>[];
  
  /// 显示的数据（分页后）
  List<T> _displayData = <T>[];
  
  /// 列配置
  List<TableColumnConfig<T>> _columns = <TableColumnConfig<T>>[];
  
  /// 选中的行键
  Set<String> _selectedRowKeys = <String>{};
  
  /// 筛选模型
  FilterModel? _filterModel;
  
  /// 排序模型
  SortModel? _sortModel;
  
  /// 当前页码
  int _currentPage = 1;
  
  /// 每页大小
  int _pageSize = 10;
  
  /// 总数据量
  int _total = 0;
  
  /// 是否加载中
  bool _loading = false;
  
  /// 是否全屏
  bool _isFullscreen = false;
  
  /// 是否显示边框
  bool _showBorder = true;
  
  /// 是否显示斑马纹
  bool _showStripe = false;
  
  /// 展开的行键集合
  Set<String> _expandedRowKeys = <String>{};

  /// 配置
  TableSelectionConfig<T>? selectionConfig;
  TablePaginationConfig? paginationConfig;

  /// 构造函数
  AdvancedTableController({
    List<T>? initialData,
    List<TableColumnConfig<T>>? columns,
    this.selectionConfig,
    this.paginationConfig,
  }) {
    if (initialData != null) {
      setData(initialData);
    }
    if (columns != null) {
      _columns = columns;
    }
    if (paginationConfig != null) {
      _pageSize = paginationConfig!.pageSize;
    }
  }

  // ==================== Getters ====================
  
  /// 获取原始数据
  List<T> get rawData => _rawData;
  
  /// 获取筛选后的数据
  List<T> get filteredData => _filteredData;
  
  /// 获取显示的数据
  List<T> get displayData => _displayData;
  
  /// 获取列配置
  List<TableColumnConfig<T>> get columns => _columns;
  
  /// 获取可见列
  List<TableColumnConfig<T>> get visibleColumns => 
      _columns.where((col) => col.show).toList();
  
  /// 获取选中的行键
  Set<String> get selectedRowKeys => _selectedRowKeys;
  
  /// 获取选中的行数据
  List<T> get selectedRows {
    if (selectionConfig?.getRowKey == null) return [];
    return _rawData.where((record) {
      final key = selectionConfig!.getRowKey!(record);
      return _selectedRowKeys.contains(key);
    }).toList();
  }
  
  /// 获取筛选模型
  FilterModel? get filterModel => _filterModel;
  
  /// 获取排序模型
  SortModel? get sortModel => _sortModel;
  
  /// 获取当前页码
  int get currentPage => _currentPage;
  
  /// 获取每页大小
  int get pageSize => _pageSize;
  
  /// 获取总数据量
  int get total => _total;
  
  /// 获取总页数
  int get totalPages => (_total / _pageSize).ceil();
  
  /// 是否加载中
  bool get loading => _loading;
  
  /// 是否全屏
  bool get isFullscreen => _isFullscreen;
  
  /// 是否显示边框
  bool get showBorder => _showBorder;
  
  /// 是否显示斑马纹
  bool get showStripe => _showStripe;
  
  /// 是否有选中的行
  bool get hasSelection => _selectedRowKeys.isNotEmpty;
  
  /// 是否全选
  bool get isAllSelected {
    if (_displayData.isEmpty || selectionConfig?.getRowKey == null) return false;
    return _displayData.every((record) {
      final key = selectionConfig!.getRowKey!(record);
      return _selectedRowKeys.contains(key);
    });
  }
  
  /// 是否部分选中
  bool get isIndeterminate {
    if (_selectedRowKeys.isEmpty || selectionConfig?.getRowKey == null) return false;
    final selectedCount = _displayData.where((record) {
      final key = selectionConfig!.getRowKey!(record);
      return _selectedRowKeys.contains(key);
    }).length;
    return selectedCount > 0 && selectedCount < _displayData.length;
  }

  // ==================== 数据操作 ====================
  
  /// 设置数据
  void setData(List<T> data) {
    _rawData = data;
    _total = data.length;
    _processData();
    notifyListeners();
  }

  /// 添加数据
  void addData(T record) {
    _rawData.add(record);
    _total = _rawData.length;
    _processData();
    notifyListeners();
  }

  /// 批量添加数据
  void addAllData(List<T> records) {
    _rawData.addAll(records);
    _total = _rawData.length;
    _processData();
    notifyListeners();
  }

  /// 更新数据
  void updateData(int index, T record) {
    if (index >= 0 && index < _rawData.length) {
      _rawData[index] = record;
      _processData();
      notifyListeners();
    }
  }

  /// 删除数据
  void removeData(T record) {
    _rawData.remove(record);
    _total = _rawData.length;
    _processData();
    notifyListeners();
  }

  /// 批量删除数据
  void removeAllData(List<T> records) {
    for (final record in records) {
      _rawData.remove(record);
    }
    _total = _rawData.length;
    _processData();
    notifyListeners();
  }

  /// 清空数据
  void clearData() {
    _rawData.clear();
    _total = 0;
    _processData();
    notifyListeners();
  }

  /// 刷新数据
  Future<void> refresh() async {
    if (paginationConfig?.serverSide == true && paginationConfig?.onPageLoad != null) {
      await loadPage(_currentPage, _pageSize);
    } else {
      _processData();
    }
    notifyListeners();
  }

  // ==================== 筛选操作 ====================
  
  /// 设置筛选条件
  void setFilter(FilterModel? filter) {
    _filterModel = filter;
    _currentPage = 1; // 重置到第一页
    _processData();
    notifyListeners();
  }

  /// 添加筛选条件
  void addFilterCondition(FilterCondition condition) {
    final current = _filterModel ?? const FilterModel();
    _filterModel = current.addCondition(condition);
    _currentPage = 1;
    _processData();
    notifyListeners();
  }

  /// 移除筛选条件
  void removeFilterCondition(String columnKey) {
    if (_filterModel == null) return;
    _filterModel = _filterModel!.removeCondition(columnKey);
    _processData();
    notifyListeners();
  }

  /// 更新筛选条件
  void updateFilterCondition(FilterCondition condition) {
    final current = _filterModel ?? const FilterModel();
    _filterModel = current.updateCondition(condition);
    _currentPage = 1;
    _processData();
    notifyListeners();
  }

  /// 设置全局搜索
  void setGlobalSearch(String? search) {
    final current = _filterModel ?? const FilterModel();
    _filterModel = current.setGlobalSearch(search);
    _currentPage = 1;
    _processData();
    notifyListeners();
  }

  /// 清空筛选
  void clearFilter() {
    _filterModel = null;
    _currentPage = 1;
    _processData();
    notifyListeners();
  }

  // ==================== 排序操作 ====================
  
  /// 设置排序
  void setSort(SortModel? sort) {
    _sortModel = sort;
    _processData();
    notifyListeners();
  }

  /// 切换排序
  void toggleSort(String columnKey) {
    final column = _columns.firstWhere(
      (col) => col.columnKey == columnKey,
      orElse: () => throw Exception('Column $columnKey not found'),
    );

    if (_sortModel?.columnKey == columnKey) {
      // 切换排序方向
      _sortModel = _sortModel!.toggleDirection();
    } else {
      // 新的排序列
      _sortModel = SortModel(
        columnKey: columnKey,
        direction: SortDirection.ascending,
        sorter: column.sorter as int Function(dynamic, dynamic)?,
      );
    }
    _processData();
    notifyListeners();
  }

  /// 清空排序
  void clearSort() {
    _sortModel = null;
    _processData();
    notifyListeners();
  }

  // ==================== 分页操作 ====================
  
  /// 设置当前页
  void setPage(int page) {
    if (page < 1 || page > totalPages) return;
    _currentPage = page;
    
    if (paginationConfig?.serverSide == true) {
      loadPage(page, _pageSize);
    } else {
      _processData();
    }
    notifyListeners();
  }

  /// 设置每页大小
  void setPageSize(int size) {
    _pageSize = size;
    _currentPage = 1;
    
    if (paginationConfig?.serverSide == true) {
      loadPage(1, size);
    } else {
      _processData();
    }
    notifyListeners();
  }

  /// 下一页
  void nextPage() {
    if (_currentPage < totalPages) {
      setPage(_currentPage + 1);
    }
  }

  /// 上一页
  void previousPage() {
    if (_currentPage > 1) {
      setPage(_currentPage - 1);
    }
  }

  /// 加载页面（服务端分页）
  Future<void> loadPage(int page, int pageSize) async {
    if (paginationConfig?.onPageLoad == null) return;
    
    _loading = true;
    notifyListeners();
    try {
      await paginationConfig!.onPageLoad!(page, pageSize);
      _currentPage = page;
      _pageSize = pageSize;
    } catch (e) {
      debugPrint('加载页面失败: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // ==================== 选择操作 ====================
  
  /// 选择行
  void selectRow(String rowKey) {
    if (selectionConfig?.type == SelectionType.single) {
      _selectedRowKeys.clear();
    }
    _selectedRowKeys.add(rowKey);
    _notifySelectionChange();
    notifyListeners();
  }

  /// 取消选择行
  void unselectRow(String rowKey) {
    _selectedRowKeys.remove(rowKey);
    _notifySelectionChange();
    notifyListeners();
  }

  /// 切换行选择
  void toggleRowSelection(String rowKey) {
    if (_selectedRowKeys.contains(rowKey)) {
      unselectRow(rowKey);
    } else {
      selectRow(rowKey);
    }
  }

  /// 全选
  void selectAll() {
    if (selectionConfig?.getRowKey == null) return;
    for (final record in _displayData) {
      final key = selectionConfig!.getRowKey!(record);
      _selectedRowKeys.add(key);
    }
    _notifySelectionChange();
    notifyListeners();
  }

  /// 清空选择
  void clearSelection() {
    _selectedRowKeys.clear();
    _notifySelectionChange();
    notifyListeners();
  }

  /// 反选
  void invertSelection() {
    if (selectionConfig?.getRowKey == null) return;
    final newSelection = <String>{};
    for (final record in _displayData) {
      final key = selectionConfig!.getRowKey!(record);
      if (!_selectedRowKeys.contains(key)) {
        newSelection.add(key);
      }
    }
    _selectedRowKeys
      ..clear()
      ..addAll(newSelection);
    _notifySelectionChange();
    notifyListeners();
  }

  /// 通知选择变化
  void _notifySelectionChange() {
    selectionConfig?.onSelectionChange?.call(_selectedRowKeys, selectedRows);
  }

  // ==================== 列操作 ====================
  
  /// 设置列配置
  void setColumns(List<TableColumnConfig<T>> columns) {
    _columns = columns;
    notifyListeners();
  }

  /// 更新列配置
  void updateColumn(String columnKey, TableColumnConfig<T> column) {
    final index = _columns.indexWhere((col) => col.columnKey == columnKey);
    if (index != -1) {
      _columns[index] = column;
      notifyListeners();
    }
  }

  /// 切换列显示
  void toggleColumnVisibility(String columnKey) {
    final index = _columns.indexWhere((col) => col.columnKey == columnKey);
    if (index != -1) {
      _columns[index] = _columns[index].copyWith(show: !_columns[index].show);
      notifyListeners();
    }
  }

  /// 重新排序列
  void reorderColumns(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final column = _columns.removeAt(oldIndex);
    _columns.insert(newIndex, column);
    notifyListeners();
  }

  /// 更新列宽
  void updateColumnWidth(String columnKey, double width) {
    final index = _columns.indexWhere((col) => col.columnKey == columnKey);
    if (index != -1) {
      _columns[index] = _columns[index].copyWith(width: width);
      notifyListeners();
    }
  }

  /// 重置列配置
  void resetColumns(List<TableColumnConfig<T>> originalColumns) {
    _columns = originalColumns.map((col) => col.copyWith(show: true)).toList();
    notifyListeners();
  }

  // ==================== 展开行操作 ====================
  
  /// 展开行
  void expandRow(String rowKey) {
    _expandedRowKeys.add(rowKey);
    notifyListeners();
  }

  /// 折叠行
  void collapseRow(String rowKey) {
    _expandedRowKeys.remove(rowKey);
    notifyListeners();
  }

  /// 切换行展开
  void toggleRowExpansion(String rowKey) {
    if (_expandedRowKeys.contains(rowKey)) {
      collapseRow(rowKey);
    } else {
      expandRow(rowKey);
    }
  }

  /// 是否展开
  bool isRowExpanded(String rowKey) {
    return _expandedRowKeys.contains(rowKey);
  }

  /// 展开所有
  void expandAll() {
    if (selectionConfig?.getRowKey == null) return;
    for (final record in _displayData) {
      final key = selectionConfig!.getRowKey!(record);
      _expandedRowKeys.add(key);
    }
    notifyListeners();
  }

  /// 折叠所有
  void collapseAll() {
    _expandedRowKeys.clear();
    notifyListeners();
  }

  // ==================== 其他操作 ====================
  
  /// 切换全屏
  void toggleFullscreen() {
    _isFullscreen = !_isFullscreen;
    notifyListeners();
  }

  /// 切换边框
  void toggleBorder() {
    _showBorder = !_showBorder;
    notifyListeners();
  }

  /// 切换斑马纹
  void toggleStripe() {
    _showStripe = !_showStripe;
    notifyListeners();
  }

  /// 设置加载状态
  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  /// 设置总数（服务端分页时使用）
  void setTotal(int total) {
    _total = total;
    notifyListeners();
  }

  // ==================== 内部方法 ====================
  
  /// 处理数据（筛选、排序、分页）
  void _processData() {
    // 1. 应用筛选
    _filteredData = DataProcessor.applyFilter(
      _rawData,
      _filterModel,
      _columns,
    );

    // 2. 应用排序
    _sortedData = DataProcessor.applySort(
      _filteredData,
      _sortModel,
      _columns,
    );

    // 3. 更新总数（筛选后的总数）
    if (paginationConfig?.serverSide != true) {
      _total = _sortedData.length;
    }

    // 4. 应用分页
    if (paginationConfig?.enabled == true && paginationConfig?.serverSide != true) {
      _displayData = DataProcessor.applyPagination(
        _sortedData,
        _currentPage,
        _pageSize,
      );
    } else {
      _displayData = _sortedData;
    }
  }

  @override
  void dispose() {
    _rawData.clear();
    _filteredData.clear();
    _sortedData.clear();
    _displayData.clear();
    _columns.clear();
    _selectedRowKeys.clear();
    _expandedRowKeys.clear();
    super.dispose();
  }
}



