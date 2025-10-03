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
    this.maxLength = 1,
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
    if (_hasError) return const Color(0xFFF53F3F); // Arco Design的错误颜色
    if (_isFocused) return const Color(0xFF165DFF); // Arco Design的主色调
    return const Color(0xFFE5E6EB); // Arco Design的默认边框颜色（更浅的灰色）
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标签和输入框在同一行
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标签
            if (widget.label != null)
              Container(
                width: 70, // 减少标签宽度
                padding: const EdgeInsets.only(top: 6, right: 8), // 减少间距
                child: RichText(
                  textAlign: TextAlign.right, // 右对齐
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
                          color: Color(0xFF1D2129), // 与Arco Design保持一致的文字颜色
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            // 输入框
            Expanded(
              child: Container(
                height: 32, // 固定高度，与Vue版本保持一致
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
                      color: Color(0xFFC9CDD4), // 与Arco Design保持一致的placeholder颜色
                      fontSize: 14,
                    ),
                    // 移除所有边框，因为我们用Container来控制
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    
                    // 内边距 - 调整为与Arco Design一致，确保文字和占位符都垂直居中
                    contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    
                    // 前缀图标
                    prefixIcon: widget.prefixIcon,
                    
                    // 后缀图标 - 清除按钮或自定义图标
                    suffixIcon: _buildSuffixIcon(),
                    
                    // 不显示计数器
                    counterText: '',
                    
                    // 不显示错误文本，我们自己处理
                    errorStyle: const TextStyle(height: 0),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1D2129), // 与Arco Design保持一致的文字颜色
                  ),
                ),
              ),
            ),
          ],
        ),
        
        // 错误提示
        if (_hasError && _errorText != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 78), // 对齐输入框
            child: Text(
              _errorText!,
              style: const TextStyle(
                color: Color(0xFFF53F3F), // Arco Design的错误颜色
                fontSize: 12,
              ),
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
