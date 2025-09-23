import 'package:flutter/material.dart';

class ResizableTableColumn extends StatefulWidget {
  final Widget label;
  final double initialWidth;
  final ValueChanged<double>? onWidthChanged;

  const ResizableTableColumn({
    Key? key,
    required this.label,
    required this.initialWidth,
    this.onWidthChanged,
  }) : super(key: key);

  @override
  State<ResizableTableColumn> createState() => _ResizableTableColumnState();
}

class _ResizableTableColumnState extends State<ResizableTableColumn> {
  late double width;

  @override
  void initState() {
    super.initState();
    width = widget.initialWidth;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            width += details.delta.dx;
            if (width < 50) width = 50; // 最小宽度
            widget.onWidthChanged?.call(width);
          });
        },
        child: Container(
          width: width,
          child: Row(
            children: [
              Expanded(child: widget.label),
              Container(
                width: 8,
                color: Colors.transparent,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 