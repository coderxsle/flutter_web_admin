import 'package:flutter/material.dart';

/// 表单条件函数类型定义
typedef GiFormCondition = bool Function(Map<String, dynamic> model);
/// 表单请求函数类型定义
typedef GiFormRequest = Future<List<GiSelectOption>> Function(Map<String, dynamic> model);
/// 表单结果格式化函数类型定义
typedef GiFormResultFormat = List<GiSelectOption> Function(dynamic data);

/// 表单项类型枚举
enum GiFormItemType {
  input,                      /// 输入框
  textarea,                   /// 文本域
  select,                     /// 选择器
  multiSelect,                /// 多选框
  radioGroup,                 /// 单选框
  checkboxGroup,              /// 多选框组
  datePicker,                 /// 日期选择器
  timePicker,                 /// 时间选择器
  dateTimePicker,             /// 日期时间选择器
  dateRange,                  /// 日期范围选择器
  switchItem,                 /// 开关
  slider,                     /// 滑块
  rate,                       /// 评分
  upload,                     /// 上传
  groupTitle,                 /// 分组标题
}

/// 表单验证规则类
class GiValidationRule {
  final bool isRequired;  /// 是否必填
  final String? message;  /// 错误提示信息
  final String? pattern;  /// 正则表达式模式
  final int? minLength;   /// 最小长度
  final int? maxLength;   /// 最大长度
  final double? min;      /// 最小值
  final double? max;      /// 最大值
  final String? Function(dynamic value)? validator; /// 自定义验证函数

  const GiValidationRule({
    this.isRequired = false,
    this.message,
    this.pattern,
    this.minLength,
    this.maxLength,
    this.min,
    this.max,
    this.validator,
  });

  /// 验证值
  String? validate(dynamic value, String label) {
    // 必填验证
    if (isRequired && (value == null || value.toString().isEmpty)) {
      return message ?? '$label为必填项';
    }

    if (value == null || value.toString().isEmpty) {
      return null; // 非必填且为空时不验证
    }

    final stringValue = value.toString();

    // 长度验证
    if (minLength != null && stringValue.length < minLength!) {
      return message ?? '$label长度不能少于$minLength个字符';
    }
    if (maxLength != null && stringValue.length > maxLength!) {
      return message ?? '$label长度不能超过$maxLength个字符';
    }

    // 正则验证
    if (pattern != null && !RegExp(pattern!).hasMatch(stringValue)) {
      return message ?? '$label格式不正确';
    }

    // 数值验证
    if (value is num) {
      if (min != null && value < min!) {
        return message ?? '$label不能小于$min';
      }
      if (max != null && value > max!) {
        return message ?? '$label不能大于$max';
      }
    }

    // 自定义验证
    if (validator != null) {
      return validator!(value);
    }

    return null;
  }
}

/// 表单列配置类
class GiFormColumn<T> {
  final String field; /// 字段名
  final String label; /// 标签文本
  final GiFormItemType type; /// 表单项类型
  final int span; /// 栅格跨度 (1-24)
  final Map<String, dynamic>? props; /// 组件属性
  final List<GiValidationRule>? rules; /// 验证规则
  final GiFormCondition? show; /// 显示条件函数
  final GiFormCondition? hide; /// 隐藏条件函数
  final GiFormCondition? disabled; /// 禁用条件函数
  final List<String>? cascader; /// 级联字段（当这些字段变化时触发数据请求）
  final GiFormRequest? request; /// 数据请求函数
  final bool init; /// 是否初始化时请求数据
  final GiFormResultFormat? resultFormat; /// 结果格式化函数
  
  final Widget Function(
    BuildContext context,
    String field,
    dynamic value,
    void Function(dynamic) onChanged,
    String? Function(dynamic)? validator,
    bool enabled,
  )? builder; /// 自定义组件构建器
  
  final String? hintText; /// 提示文本
  
  /// 是否必填
  bool get isRequired => rules?.any((rule) => rule.isRequired) ?? false;

  const GiFormColumn({
    required this.field,
    required this.label,
    required this.type,
    this.span = 12,
    this.props,
    this.rules,
    this.show,
    this.hide,
    this.disabled,
    this.cascader,
    this.request,
    this.init = false,
    this.resultFormat,
    this.builder,
    this.hintText,
  });

  /// 判断是否显示
  bool isVisible(Map<String, dynamic> model) {
    if (show != null) return show!(model);
    if (hide != null) return !hide!(model);
    return true;
  }

  /// 判断是否禁用
  bool isDisabled(Map<String, dynamic> model) {
    return disabled?.call(model) ?? false;
  }

  /// 获取提示文本
  String getHintText() {
    if (hintText != null) return hintText!;
    
    switch (type) {
      case GiFormItemType.input:
      case GiFormItemType.textarea:
        return '请输入$label';
      case GiFormItemType.select:
      case GiFormItemType.multiSelect:
      case GiFormItemType.radioGroup:
      case GiFormItemType.checkboxGroup:
        return '请选择$label';
      case GiFormItemType.datePicker:
        return '请选择日期';
      case GiFormItemType.timePicker:
        return '请选择时间';
      case GiFormItemType.dateTimePicker:
        return '请选择日期时间';
      case GiFormItemType.dateRange:
        return '请选择日期范围';
      default:
        return '';
    }
  }

  /// 验证字段值
  String? validate(dynamic value) {
    if (rules == null || rules!.isEmpty) return null;

    for (final rule in rules!) {
      final error = rule.validate(value, label);
      if (error != null) return error;
    }
    return null;
  }

  /// 复制并修改配置
  GiFormColumn<T> copyWith({
    String? field,
    String? label,
    GiFormItemType? type,
    int? span,
    Map<String, dynamic>? props,
    List<GiValidationRule>? rules,
    GiFormCondition? show,
    GiFormCondition? hide,
    GiFormCondition? disabled,
    List<String>? cascader,
    GiFormRequest? request,
    bool? init,
    GiFormResultFormat? resultFormat,
    Widget Function(BuildContext, String, dynamic, void Function(dynamic), String? Function(dynamic)?, bool)? builder,
    String? hintText,
  }) {
    return GiFormColumn<T>(
      field: field ?? this.field,
      label: label ?? this.label,
      type: type ?? this.type,
      span: span ?? this.span,
      props: props ?? this.props,
      rules: rules ?? this.rules,
      show: show ?? this.show,
      hide: hide ?? this.hide,
      disabled: disabled ?? this.disabled,
      cascader: cascader ?? this.cascader,
      request: request ?? this.request,
      init: init ?? this.init,
      resultFormat: resultFormat ?? this.resultFormat,
      builder: builder ?? this.builder,
      hintText: hintText ?? this.hintText,
    );
  }
}

/// 选择项数据类
class GiSelectOption {
  final String label; /// 显示文本
  final dynamic value; /// 选项值
  final bool disabled; /// 是否禁用
  final Map<String, dynamic>? extra; /// 额外数据

  const GiSelectOption({
    required this.label,
    required this.value,
    this.disabled = false,
    this.extra,
  });

  factory GiSelectOption.fromMap(Map<String, dynamic> map) {
    return GiSelectOption(
      label: map['label']?.toString() ?? '',
      value: map['value'],
      disabled: map['disabled'] ?? false,
      extra: map['extra'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'value': value,
      'disabled': disabled,
      'extra': extra,
    };
  }

  @override
  String toString() => 'GiSelectOption(label: $label, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GiSelectOption && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

/// 表单布局配置
class GiFormLayout {
  final int columns;                          /// 列数
  final double horizontalSpacing;             /// 水平间距
  final double verticalSpacing;               /// 垂直间距
  final double? labelWidth;                   /// 标签宽度
  final CrossAxisAlignment labelAlignment;    /// 标签对齐方式

  const GiFormLayout({
    this.columns = 2,
    this.horizontalSpacing = 16.0,
    this.verticalSpacing = 16.0,
    this.labelWidth,
    this.labelAlignment = CrossAxisAlignment.start,
  });
}

/// 搜索表单配置
class GiSearchFormConfig {
  final String searchButtonText;    /// 搜索按钮文本
  final String resetButtonText;     /// 重置按钮文本
  final bool showCollapseButton;    /// 是否显示折叠按钮
  final bool defaultCollapsed;      /// 默认是否折叠
  final int collapsedRows;          /// 折叠时显示的行数

  const GiSearchFormConfig({
    this.searchButtonText = '搜索',
    this.resetButtonText = '重置',
    this.showCollapseButton = true,
    this.defaultCollapsed = false,
    this.collapsedRows = 1,
  });
}
