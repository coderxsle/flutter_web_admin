import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LeftSlidingDelete extends StatelessWidget {
  final VoidCallback onDelete;
  final Widget child;
  const LeftSlidingDelete({super.key, required this.onDelete, required this.child});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      // 滑动方向，设置为从右向左
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.25, // 设置按钮占用的比例
        children: [
          // 添加删除按钮
          SlidableAction(
            // 执行删除操作
            onPressed: (context) => onDelete(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: '删除',
          ),
        ],
      ),
      child: child,
    );
  }



}
