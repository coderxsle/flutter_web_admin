import 'package:flutter/material.dart';

/// 列宽调整器
class ColumnResizer extends StatefulWidget {
  /// 列键
  final String columnKey;
  
  /// 当前宽度
  final double currentWidth;
  
  /// 最小宽度
  final double minWidth;
  
  /// 最大宽度
  final double? maxWidth;
  
  /// 宽度变化回调
  final void Function(String columnKey, double width) onWidthChange;

  const ColumnResizer({
    super.key,
    required this.columnKey,
    required this.currentWidth,
    this.minWidth = 50,
    this.maxWidth,
    required this.onWidthChange,
  });

  @override
  State<ColumnResizer> createState() => _ColumnResizerState();
}

class _ColumnResizerState extends State<ColumnResizer> {
  bool _isDragging = false;
  double _startX = 0;
  double _startWidth = 0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: Container(
          width: 8,
          color: _isDragging 
              ? Theme.of(context).primaryColor.withOpacity(0.5)
              : Colors.transparent,
          child: Center(
            child: Container(
              width: 2,
              color: _isDragging
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
      _startX = details.globalPosition.dx;
      _startWidth = widget.currentWidth;
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final delta = details.globalPosition.dx - _startX;
    var newWidth = _startWidth + delta;
    
    // 应用最小/最大宽度限制
    newWidth = newWidth.clamp(
      widget.minWidth,
      widget.maxWidth ?? double.infinity,
    );
    
    widget.onWidthChange(widget.columnKey, newWidth);
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });
  }
}

