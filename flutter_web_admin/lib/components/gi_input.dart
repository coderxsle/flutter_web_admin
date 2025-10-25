import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// GiInput 输入框组件 - 完全复制Arco Design的输入框样式
class GiInput extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;
  final String? label;
  final bool required;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool allowClear;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  const GiInput({
    super.key,
    required this.controller,
    this.placeholder,
    this.label,
    this.required = false,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.allowClear = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
  });

  @override
  State<GiInput> createState() => _GiInputState();
}

class _GiInputState extends State<GiInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _hasError = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTextChanged() {
    setState(() {});
    
    // 实时验证
    if (widget.validator != null) {
      final error = widget.validator!(widget.controller.text);
      setState(() {
        _hasError = error != null;
        _errorText = error;
      });
    }
    
    widget.onChanged?.call(widget.controller.text);
  }

  void _clearText() {
    widget.controller.clear();
    widget.onChanged?.call('');
  }

  Color _getBorderColor() {
    if (_hasError) return Colors.red;
    if (_isFocused) return Theme.of(context).primaryColor;
    return Colors.grey[300]!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标签
        if (widget.label != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: RichText(
              text: TextSpan(
                children: [
                  if (widget.required)
                    TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: Colors.red[500],
                        fontSize: 14,
                      ),
                    ),
                  if (widget.required) const TextSpan(text: ' '),
                  TextSpan(
                    text: widget.label!,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        
        // 输入框
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _getBorderColor(),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            maxLength: widget.maxLength,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            onEditingComplete: widget.onEditingComplete,
            onFieldSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              // 移除所有边框，因为我们用Container来控制
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              
              // 内边距
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              
              // 前缀图标
              prefixIcon: widget.prefixIcon,
              
              // 后缀图标 - 清除按钮或自定义图标
              suffixIcon: _buildSuffixIcon(),
              
              // 计数器样式
              counterStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
              
              // 不显示错误文本，我们自己处理
              errorStyle: const TextStyle(height: 0),
            ),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        
        // 错误提示
        if (_hasError && _errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            _errorText!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }
    
    if (widget.allowClear && widget.controller.text.isNotEmpty && !widget.readOnly) {
      return IconButton(
        icon: Icon(
          Icons.clear,
          size: 16,
          color: Colors.grey[400],
        ),
        onPressed: _clearText,
        splashRadius: 16,
      );
    }
    
    return null;
  }
}
