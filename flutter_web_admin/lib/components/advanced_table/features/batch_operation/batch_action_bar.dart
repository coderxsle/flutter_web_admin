import 'package:flutter/material.dart';

/// 批量操作按钮
class BatchActionButton {
  /// 图标
  final IconData icon;
  
  /// 标签
  final String label;
  
  /// 点击回调
  final VoidCallback onTap;
  
  /// 颜色
  final Color? color;
  
  /// 是否危险操作
  final bool isDangerous;

  const BatchActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.isDangerous = false,
  });
}

/// 批量操作栏
class BatchActionBar extends StatelessWidget {
  /// 选中数量
  final int selectedCount;
  
  /// 批量操作按钮列表
  final List<BatchActionButton> actions;
  
  /// 清空选择回调
  final VoidCallback? onClearSelection;
  
  /// 全选回调
  final VoidCallback? onSelectAll;
  
  /// 反选回调
  final VoidCallback? onInvertSelection;

  const BatchActionBar({
    super.key,
    required this.selectedCount,
    required this.actions,
    this.onClearSelection,
    this.onSelectAll,
    this.onInvertSelection,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedCount == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // 选中信息
          Icon(
            Icons.check_circle,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            '已选择 $selectedCount 项',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // 选择操作
          if (onClearSelection != null)
            TextButton.icon(
              onPressed: onClearSelection,
              icon: const Icon(Icons.clear, size: 16),
              label: const Text('清空'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          
          if (onSelectAll != null) ...[
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: onSelectAll,
              icon: const Icon(Icons.select_all, size: 16),
              label: const Text('全选'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
          
          if (onInvertSelection != null) ...[
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: onInvertSelection,
              icon: const Icon(Icons.swap_horiz, size: 16),
              label: const Text('反选'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
          
          const Spacer(),
          
          // 批量操作按钮
          ...actions.map((action) {
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ElevatedButton.icon(
                onPressed: action.onTap,
                icon: Icon(action.icon, size: 16),
                label: Text(action.label),
                style: ElevatedButton.styleFrom(
                  backgroundColor: action.isDangerous 
                      ? Colors.red 
                      : action.color,
                  foregroundColor: action.isDangerous || action.color != null
                      ? Colors.white
                      : null,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

