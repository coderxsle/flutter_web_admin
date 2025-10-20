/// 选择类型
enum SelectionType {
  none,      // 不支持选择
  single,    // 单选
  multiple,  // 多选
}

/// 表格选择配置
class TableSelectionConfig<T> {
  /// 选择类型
  final SelectionType type;
  
  /// 是否显示全选
  final bool showSelectAll;
  
  /// 获取行键的函数（用于标识唯一行）
  final String Function(T record)? getRowKey;
  
  /// 选择变化回调
  final void Function(Set<String> selectedKeys, List<T> selectedRows)? onSelectionChange;
  
  /// 行是否可选择
  final bool Function(T record)? rowSelectable;
  
  /// 固定选择列
  final bool fixedSelection;
  
  /// 选择列宽度
  final double selectionWidth;

  const TableSelectionConfig({
    this.type = SelectionType.none,
    this.showSelectAll = true,
    this.getRowKey,
    this.onSelectionChange,
    this.rowSelectable,
    this.fixedSelection = true,
    this.selectionWidth = 50.0,
  });

  /// 是否启用选择
  bool get enabled => type != SelectionType.none;

  /// 是否多选
  bool get isMultiple => type == SelectionType.multiple;

  /// 是否单选
  bool get isSingle => type == SelectionType.single;

  /// 复制并修改
  TableSelectionConfig<T> copyWith({
    SelectionType? type,
    bool? showSelectAll,
    String Function(T record)? getRowKey,
    void Function(Set<String> selectedKeys, List<T> selectedRows)? onSelectionChange,
    bool Function(T record)? rowSelectable,
    bool? fixedSelection,
    double? selectionWidth,
  }) {
    return TableSelectionConfig<T>(
      type: type ?? this.type,
      showSelectAll: showSelectAll ?? this.showSelectAll,
      getRowKey: getRowKey ?? this.getRowKey,
      onSelectionChange: onSelectionChange ?? this.onSelectionChange,
      rowSelectable: rowSelectable ?? this.rowSelectable,
      fixedSelection: fixedSelection ?? this.fixedSelection,
      selectionWidth: selectionWidth ?? this.selectionWidth,
    );
  }
}



