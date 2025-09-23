import 'package:book_store_admin/components/button/gi_arco_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/gi_space.dart';
import 'gi_form_column.dart';
import 'gi_form_item.dart';

/// Gi 动态表单组件
/// 
/// 支持 JSON 配置驱动的动态表单，具有丰富的表单控件和验证功能
/// 
/// 使用示例：
/// ```dart
/// GiForm(
///   columns: [
///     GiFormColumn(
///       field: 'name',
///       label: '姓名',
///       type: GiFormItemType.input,
///       rules: [GiValidationRule(required: true)],
///     ),
///     GiFormColumn(
///       field: 'email',
///       label: '邮箱',
///       type: GiFormItemType.input,
///       rules: [
///         GiValidationRule(
///           required: true,
///           pattern: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
///         ),
///       ],
///     ),
///   ],
///   model: formData,
///   onModelChanged: (data) => setState(() => formData = data),
/// )
/// ```
class GiForm extends StatefulWidget {
  /// 表单列配置
  final List<GiFormColumn> columns;
  
  /// 表单数据模型
  final Map<String, dynamic>? model;
  
  /// 表单布局配置
  final GiFormLayout layout;
  
  /// 是否为搜索模式
  final bool searchMode;
  
  /// 搜索表单配置
  final GiSearchFormConfig? searchConfig;
  
  /// 是否显示搜索按钮
  final bool showSearchButtons;
  
  /// 自定义搜索按钮区域
  final Widget? customSearchButtons;
  
  /// 数据变化回调
  final void Function(Map<String, dynamic> data)? onModelChanged;
  
  /// 搜索回调
  final VoidCallback? onSearch;
  
  /// 重置回调
  final VoidCallback? onReset;
  
  /// 表单验证失败回调
  final void Function(Map<String, String> errors)? onValidationFailed;

  const GiForm({
    super.key,
    required this.columns,
    required this.model,
    this.layout = const GiFormLayout(),
    this.searchMode = false,
    this.searchConfig,
    this.showSearchButtons = true,
    this.customSearchButtons,
    this.onModelChanged,
    this.onSearch,
    this.onReset,
    this.onValidationFailed,
  });

  @override
  State<GiForm> createState() => _GiFormState();
}

class _GiFormState extends State<GiForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> _formData;
  final Map<String, List<GiSelectOption>> _optionsData = {};
  bool _isCollapsed = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _formData = Map<String, dynamic>.from(widget.model ?? {});
    _isCollapsed = widget.searchConfig?.defaultCollapsed ?? false;
    _initializeOptionsData();
  }

  @override
  void didUpdateWidget(GiForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      _formData = Map<String, dynamic>.from(widget.model ?? {});
    }
    if (widget.columns != oldWidget.columns) {
      _initializeOptionsData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isLoading) const LinearProgressIndicator(),
          _buildFormContent(),
          if (widget.searchMode && widget.showSearchButtons)
            _buildSearchButtons(),
        ],
      ),
    );
  }

  /// 构建表单内容
  Widget _buildFormContent() {
    final visibleColumns = _getVisibleColumns();
    
    if (widget.searchMode) {
      return _buildSearchFormLayout(visibleColumns);
    } else {
      return _buildGridFormLayout(visibleColumns);
    }
  }

  /// 构建网格表单布局
  Widget _buildGridFormLayout(List<GiFormColumn> columns) {
    final children = <Widget>[];
    
    for (int i = 0; i < columns.length; i++) {
      final column = columns[i];
      children.add(_buildFormField(column));
    }

    return _buildResponsiveGrid(children);
  }

  /// 构建搜索表单布局
  Widget _buildSearchFormLayout(List<GiFormColumn> columns) {
    final visibleColumns = _getSearchVisibleColumns(columns);
    final children = <Widget>[];
    
    for (final column in visibleColumns) {
      children.add(_buildFormField(column));
    }

    return _buildResponsiveGrid(children);
  }

  /// 构建响应式网格
  Widget _buildResponsiveGrid(List<Widget> children) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final columns = _getResponsiveColumns(screenWidth);
        
        return _buildGridLayout(children, columns);
      },
    );
  }

  /// 构建网格布局
  Widget _buildGridLayout(List<Widget> children, int columns) {
    final rows = <Widget>[];
    
    for (int i = 0; i < children.length; i += columns) {
      final rowChildren = <Widget>[];
      
      for (int j = 0; j < columns; j++) {
        if (i + j < children.length) {
          rowChildren.add(Expanded(child: children[i + j]));
        } else {
          rowChildren.add(const Expanded(child: SizedBox.shrink()));
        }
        
        if (j < columns - 1) {
          rowChildren.add(SizedBox(width: widget.layout.horizontalSpacing));
        }
      }
      
      rows.add(Row(children: rowChildren));
      if (i + columns < children.length) {
        rows.add(SizedBox(height: widget.layout.verticalSpacing));
      }
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  /// 构建表单字段
  Widget _buildFormField(GiFormColumn column) {
    final isDisabled = column.isDisabled(_formData);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (column.type != GiFormItemType.groupTitle) ...[
            _buildLabel(column),
            const SizedBox(height: 4),
          ],
          GiFormItem(
            column: column,
            value: _formData[column.field],
            options: _optionsData[column.field],
            disabled: isDisabled,
            onChanged: (value) => _handleValueChanged(column.field, value),
            validator: (value) => column.validate(value),
          ),
        ],
      ),
    );
  }

  /// 构建标签
  Widget _buildLabel(GiFormColumn column) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          if (column.isRequired)
            const TextSpan(
              text: '* ',
              style: TextStyle(color: Colors.red),
            ),
          TextSpan(text: column.label),
        ],
      ),
    );
  }

  /// 构建搜索按钮
  Widget _buildSearchButtons() {
    final config = widget.searchConfig ?? const GiSearchFormConfig();
    
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: GiSpace(
        children: [
          if (widget.customSearchButtons != null)
            widget.customSearchButtons!
          else ...[
            GiArcoButton(
              type: GiArcoButtonType.primary,
              text: config.searchButtonText,
              onPressed: widget.onSearch,
            ),
            GiArcoButton(
              type: GiArcoButtonType.secondary,
              text: config.resetButtonText,
              onPressed: _handleReset,
            ),
            if (config.showCollapseButton && _shouldShowCollapseButton())
              GiArcoButton(
                type: GiArcoButtonType.text,
                text: _isCollapsed ? '展开' : '收起',
                icon: _isCollapsed ? Icons.expand_more : Icons.expand_less,
                onPressed: _toggleCollapse,
              ),
          ],
        ],
      ),
    );
  }

  /// 获取可见列
  List<GiFormColumn> _getVisibleColumns() {
    return widget.columns.where((column) => column.isVisible(_formData)).toList();
  }

  /// 获取搜索模式下的可见列
  List<GiFormColumn> _getSearchVisibleColumns(List<GiFormColumn> columns) {
    if (!_isCollapsed) return columns;
    
    final config = widget.searchConfig ?? const GiSearchFormConfig();
    final itemsPerRow = _getResponsiveColumns(MediaQuery.of(context).size.width);
    final maxItems = config.collapsedRows * itemsPerRow;
    
    return columns.take(maxItems).toList();
  }

  /// 获取响应式列数
  int _getResponsiveColumns(double screenWidth) {
    if (screenWidth < 600) return 1;
    if (screenWidth < 900) return 2;
    if (screenWidth < 1200) return 3;
    return widget.layout.columns;
  }

  /// 处理值变化
  void _handleValueChanged(String field, dynamic value) {
    setState(() {
      _formData[field] = value;
    });
    
    widget.onModelChanged?.call(_formData);
    _handleCascadeUpdate(field, value);
  }

  /// 处理级联更新
  Future<void> _handleCascadeUpdate(String field, dynamic value) async {
    final cascadeColumns = widget.columns
        .where((col) => col.cascader?.contains(field) ?? false)
        .toList();

    if (cascadeColumns.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      for (final column in cascadeColumns) {
        if (column.request != null) {
          if (value != null && value.toString().isNotEmpty) {
            final result = await column.request!(_formData);
            final options = column.resultFormat?.call(result) ?? result;
            
            setState(() {
              _optionsData[column.field] = options;
              // 清空级联字段的值
              _formData[column.field] = null;
            });
          } else {
            setState(() {
              _optionsData[column.field] = [];
              _formData[column.field] = null;
            });
          }
        }
      }
    } catch (e) {
      Get.snackbar('错误', '加载数据失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
      
      widget.onModelChanged?.call(_formData);
    }
  }

  /// 处理重置
  void _handleReset() {
    setState(() {
      _formData.clear();
      for (final column in widget.columns) {
        _formData[column.field] = null;
      }
    });
    
    widget.onModelChanged?.call(_formData);
    widget.onReset?.call();
  }

  /// 切换折叠状态
  void _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  /// 是否应该显示折叠按钮
  bool _shouldShowCollapseButton() {
    final config = widget.searchConfig ?? const GiSearchFormConfig();
    final visibleColumns = _getVisibleColumns();
    final itemsPerRow = _getResponsiveColumns(MediaQuery.of(context).size.width);
    final maxItems = config.collapsedRows * itemsPerRow;
    
    return visibleColumns.length > maxItems;
  }

  /// 初始化选项数据
  Future<void> _initializeOptionsData() async {
    final initColumns = widget.columns.where((col) => 
        col.request != null && col.init).toList();

    if (initColumns.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      for (final column in initColumns) {
        final result = await column.request!(_formData);
        final options = column.resultFormat?.call(result) ?? result;
        
        setState(() {
          _optionsData[column.field] = options;
        });
      }
    } catch (e) {
      Get.snackbar('错误', '初始化数据失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 验证表单
  bool validate() {
    final isValid = _formKey.currentState?.validate() ?? false;
    
    if (!isValid) {
      final errors = <String, String>{};
      for (final column in widget.columns) {
        final error = column.validate(_formData[column.field]);
        if (error != null) {
          errors[column.field] = error;
        }
      }
      widget.onValidationFailed?.call(errors);
    }
    
    return isValid;
  }

  /// 获取表单数据
  Map<String, dynamic> get formData => Map<String, dynamic>.from(_formData);

  /// 重置表单
  void reset() {
    _handleReset();
  }

  /// 设置字段值
  void setFieldValue(String field, dynamic value) {
    _handleValueChanged(field, value);
  }

  /// 获取字段值
  dynamic getFieldValue(String field) {
    return _formData[field];
  }
}
