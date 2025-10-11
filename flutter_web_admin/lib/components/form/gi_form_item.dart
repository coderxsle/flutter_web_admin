import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'gi_form_column.dart';

/// Gi 表单项组件
/// 
/// 根据配置动态生成不同类型的表单控件
class GiFormItem extends StatefulWidget {
  /// 表单列配置
  final GiFormColumn column;
  
  /// 当前值
  final dynamic value;
  
  /// 选项数据
  final List<GiSelectOption>? options;
  
  /// 是否禁用
  final bool disabled;
  
  /// 值变化回调
  final void Function(dynamic value) onChanged;
  
  /// 验证器
  final String? Function(dynamic value)? validator;

  const GiFormItem({
    super.key,
    required this.column,
    this.value,
    this.options,
    this.disabled = false,
    required this.onChanged,
    this.validator,
  });

  @override
  State<GiFormItem> createState() => _GiFormItemState();
}

class _GiFormItemState extends State<GiFormItem> {
  late TextEditingController _textController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.value?.toString() ?? '');
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(GiFormItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _textController.text = widget.value?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 如果有自定义构建器，使用自定义构建器
    if (widget.column.builder != null) {
      return widget.column.builder!(
        context,
        widget.column.field,
        widget.value,
        widget.onChanged,
        widget.validator,
        !widget.disabled,
      );
    }

    // 根据类型构建不同的表单控件
    switch (widget.column.type) {
      case GiFormItemType.input:
        return _buildTextField();
      case GiFormItemType.textarea:
        return _buildTextArea();
      case GiFormItemType.select:
        return _buildSelect();
      case GiFormItemType.multiSelect:
        return _buildMultiSelect();
      case GiFormItemType.radioGroup:
        return _buildRadioGroup();
      case GiFormItemType.checkboxGroup:
        return _buildCheckboxGroup();
      case GiFormItemType.datePicker:
        return _buildDatePicker();
      case GiFormItemType.timePicker:
        return _buildTimePicker();
      case GiFormItemType.dateTimePicker:
        return _buildDateTimePicker();
      case GiFormItemType.dateRange:
        return _buildDateRangePicker();
      case GiFormItemType.switchItem:
        return _buildSwitch();
      case GiFormItemType.slider:
        return _buildSlider();
      case GiFormItemType.rate:
        return _buildRate();
      case GiFormItemType.upload:
        return _buildUpload();
      case GiFormItemType.groupTitle:
        return _buildGroupTitle();
    }
  }

  /// 构建文本输入框
  Widget _buildTextField() {
    final props = widget.column.props ?? {};
    
    return TextFormField(
      controller: _textController,
      focusNode: _focusNode,
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: widget.column.getHintText(),
        border: const OutlineInputBorder(),
        prefixIcon: props['prefixIcon'] as Widget?,
        suffixIcon: props['suffixIcon'] as Widget?,
      ),
      keyboardType: _getKeyboardType(props['keyboardType']),
      inputFormatters: _getInputFormatters(props['inputFormatters']),
      maxLength: props['maxLength'] as int?,
      obscureText: props['obscureText'] as bool? ?? false,
      validator: widget.validator,
      onChanged: (value) {
        widget.onChanged(value);
      },
    );
  }

  /// 构建文本域
  Widget _buildTextArea() {
    final props = widget.column.props ?? {};
    
    return TextFormField(
      controller: _textController,
      focusNode: _focusNode,
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: widget.column.getHintText(),
        border: const OutlineInputBorder(),
      ),
      maxLines: props['maxLines'] as int? ?? 3,
      maxLength: props['maxLength'] as int?,
      validator: widget.validator,
      onChanged: (value) {
        widget.onChanged(value);
      },
    );
  }

  /// 构建下拉选择框
  Widget _buildSelect() {
    final options = widget.options ?? [];
    
    return DropdownButtonFormField<dynamic>(
      value: widget.value,
      decoration: InputDecoration(
        hintText: widget.column.getHintText(),
        border: const OutlineInputBorder(),
      ),
      items: options.map((option) {
        return DropdownMenuItem<dynamic>(
          value: option.value,
          child: Text(option.label),
        );
      }).toList(),
      onChanged: widget.disabled ? null : (value) {
        widget.onChanged(value);
      },
      validator: widget.validator,
    );
  }

  /// 构建多选下拉框
  Widget _buildMultiSelect() {
    final options = widget.options ?? [];
    final selectedValues = widget.value as List<dynamic>? ?? [];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: selectedValues.isEmpty
              ? Text(
                  widget.column.getHintText(),
                  style: TextStyle(color: Colors.grey[600]),
                )
              : Wrap(
                  spacing: 4,
                  children: selectedValues.map((value) {
                    final option = options.firstWhere(
                      (opt) => opt.value == value,
                      orElse: () => GiSelectOption(label: value.toString(), value: value),
                    );
                    return Chip(
                      label: Text(option.label),
                      onDeleted: widget.disabled ? null : () {
                        final newValues = List<dynamic>.from(selectedValues)..remove(value);
                        widget.onChanged(newValues);
                      },
                    );
                  }).toList(),
                ),
        ),
        if (!widget.disabled)
          PopupMenuButton<dynamic>(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Text('添加选项', style: TextStyle(color: Colors.blue)),
            ),
            itemBuilder: (context) {
              return options.where((opt) => !selectedValues.contains(opt.value)).map((option) {
                return PopupMenuItem<dynamic>(
                  value: option.value,
                  child: Text(option.label),
                );
              }).toList();
            },
            onSelected: (value) {
              final newValues = List<dynamic>.from(selectedValues)..add(value);
              widget.onChanged(newValues);
            },
          ),
      ],
    );
  }

  /// 构建单选按钮组
  Widget _buildRadioGroup() {
    final options = widget.options ?? [];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options.map((option) {
        return RadioListTile<dynamic>(
          title: Text(option.label),
          value: option.value,
          groupValue: widget.value,
          onChanged: widget.disabled ? null : (value) {
            widget.onChanged(value);
          },
        );
      }).toList(),
    );
  }

  /// 构建复选框组
  Widget _buildCheckboxGroup() {
    final options = widget.options ?? [];
    final selectedValues = widget.value as List<dynamic>? ?? [];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options.map((option) {
        final isSelected = selectedValues.contains(option.value);
        return CheckboxListTile(
          title: Text(option.label),
          value: isSelected,
          onChanged: widget.disabled ? null : (checked) {
            final newValues = List<dynamic>.from(selectedValues);
            if (checked == true) {
              newValues.add(option.value);
            } else {
              newValues.remove(option.value);
            }
            widget.onChanged(newValues);
          },
        );
      }).toList(),
    );
  }

  /// 构建日期选择器
  Widget _buildDatePicker() {
    return InkWell(
      onTap: widget.disabled ? null : () async {
        final date = await showDatePicker(
          context: context,
          initialDate: widget.value as DateTime? ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          widget.onChanged(date);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: widget.column.getHintText(),
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          widget.value != null 
              ? _formatDate(widget.value as DateTime)
              : '',
        ),
      ),
    );
  }

  /// 构建时间选择器
  Widget _buildTimePicker() {
    return InkWell(
      onTap: widget.disabled ? null : () async {
        final time = await showTimePicker(
          context: context,
          initialTime: widget.value as TimeOfDay? ?? TimeOfDay.now(),
        );
        if (time != null) {
          widget.onChanged(time);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: widget.column.getHintText(),
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.access_time),
        ),
        child: Text(
          widget.value != null 
              ? (widget.value as TimeOfDay).format(context)
              : '',
        ),
      ),
    );
  }

  /// 构建日期时间选择器
  Widget _buildDateTimePicker() {
    return InkWell(
      onTap: widget.disabled ? null : () async {
        final date = await showDatePicker(
          context: context,
          initialDate: widget.value as DateTime? ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(date),
          );
          if (time != null) {
            final dateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );
            widget.onChanged(dateTime);
          }
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: widget.column.getHintText(),
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.event),
        ),
        child: Text(
          widget.value != null 
              ? _formatDateTime(widget.value as DateTime)
              : '',
        ),
      ),
    );
  }

  /// 构建日期范围选择器
  Widget _buildDateRangePicker() {
    return InkWell(
      onTap: widget.disabled ? null : () async {
        final range = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          initialDateRange: widget.value as DateTimeRange?,
        );
        if (range != null) {
          widget.onChanged(range);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: widget.column.getHintText(),
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.date_range),
        ),
        child: Text(
          widget.value != null 
              ? _formatDateRange(widget.value as DateTimeRange)
              : '',
        ),
      ),
    );
  }

  /// 构建开关
  Widget _buildSwitch() {
    return SwitchListTile(
      title: Text(widget.column.label),
      value: widget.value as bool? ?? false,
      onChanged: widget.disabled ? null : (value) {
        widget.onChanged(value);
      },
    );
  }

  /// 构建滑块
  Widget _buildSlider() {
    final props = widget.column.props ?? {};
    final min = props['min'] as double? ?? 0.0;
    final max = props['max'] as double? ?? 100.0;
    final divisions = props['divisions'] as int?;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${widget.column.label}: ${widget.value ?? min}'),
        Slider(
          value: (widget.value as double? ?? min).clamp(min, max),
          min: min,
          max: max,
          divisions: divisions,
          onChanged: widget.disabled ? null : (value) {
            widget.onChanged(value);
          },
        ),
      ],
    );
  }

  /// 构建评分
  Widget _buildRate() {
    final props = widget.column.props ?? {};
    final maxRating = props['maxRating'] as int? ?? 5;
    
    return Row(
      children: [
        Text('${widget.column.label}: '),
        ...List.generate(maxRating, (index) {
          return IconButton(
            icon: Icon(
              index < (widget.value as int? ?? 0) ? Icons.star : Icons.star_border,
              color: Colors.amber,
            ),
            onPressed: widget.disabled ? null : () {
              widget.onChanged(index + 1);
            },
          );
        }),
      ],
    );
  }

  /// 构建上传组件
  Widget _buildUpload() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text('点击或拖拽文件到此区域上传', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  /// 构建分组标题
  Widget _buildGroupTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        widget.column.label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.blue.shade700,
        ),
      ),
    );
  }

  /// 获取键盘类型
  TextInputType? _getKeyboardType(dynamic keyboardType) {
    if (keyboardType == null) return null;
    if (keyboardType is TextInputType) return keyboardType;
    
    switch (keyboardType.toString()) {
      case 'number':
        return TextInputType.number;
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
      case 'url':
        return TextInputType.url;
      default:
        return TextInputType.text;
    }
  }

  /// 获取输入格式器
  List<TextInputFormatter>? _getInputFormatters(dynamic formatters) {
    if (formatters == null) return null;
    if (formatters is List<TextInputFormatter>) return formatters;
    return null;
  }

  /// 格式化日期
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// 格式化日期时间
  String _formatDateTime(DateTime dateTime) {
    return '${_formatDate(dateTime)} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// 格式化日期范围
  String _formatDateRange(DateTimeRange range) {
    return '${_formatDate(range.start)} - ${_formatDate(range.end)}';
  }
}
