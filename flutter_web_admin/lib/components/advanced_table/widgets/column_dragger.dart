import 'package:flutter/material.dart';

/// 列拖拽器
class ColumnDragger extends StatelessWidget {
  /// 列索引
  final int columnIndex;
  
  /// 列标题
  final String columnTitle;
  
  /// 是否可拖拽
  final bool draggable;
  
  /// 子组件
  final Widget child;
  
  /// 拖拽完成回调
  final void Function(int oldIndex, int newIndex)? onDragComplete;

  const ColumnDragger({
    super.key,
    required this.columnIndex,
    required this.columnTitle,
    this.draggable = true,
    required this.child,
    this.onDragComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (!draggable) {
      return child;
    }

    return LongPressDraggable<int>(
      data: columnIndex,
      feedback: Material(
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            columnTitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: child,
      ),
      child: DragTarget<int>(
        onWillAccept: (data) => data != null && data != columnIndex,
        onAccept: (oldIndex) {
          onDragComplete?.call(oldIndex, columnIndex);
        },
        builder: (context, candidateData, rejectedData) {
          final isHovering = candidateData.isNotEmpty;
          return Container(
            decoration: BoxDecoration(
              border: isHovering
                  ? Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    )
                  : null,
            ),
            child: child,
          );
        },
      ),
    );
  }
}

