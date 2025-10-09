import 'package:flutter/material.dart';
import 'package:getx_go_main/models/menu_item.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SidebarMenu extends StatelessWidget {
  final MenuItem item;
  final int level;
  final bool isExpanded;
  final String currentRoute;
  final Function(String) onMenuTap;
  final Function(String) onToggleItem;

  const SidebarMenu ({super.key, required this.item, required this.level, required this.isExpanded, required this.currentRoute, required this.onMenuTap, required this.onToggleItem});

  @override
  Widget build(BuildContext context) {
    final indent = level * 16.0;
    final hasChildren = item.hasChildren;
    final isSelected = item.route == currentRoute;
    return Column(
      children: [
        // 菜单项
        Container(
          padding: EdgeInsets.only(left: indent + 12, right: 8, top: 4),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => _handleItemTap(hasChildren),
              child: Container(
                height: 36,
                padding: EdgeInsets.symmetric(horizontal: 4),
                // padding: EdgeInsets.symmetric(horizontal: isExpanded ? 8 : 16, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2) : null,
                  border: isSelected ? Border.all(color: Theme.of(context).colorScheme.primary, width: 1) : null,  
                  borderRadius: BorderRadius.circular(8),
                ),
                child:_buildItem(hasChildren, isSelected, isExpanded, context)
              ),
            ),
          ),
        ),
        
        // 子菜单
        if (hasChildren && item.isExpanded && isExpanded)
          ...item.children!.map((child) => SidebarMenu(
            item: child,
            level: level + 1,
            isExpanded: isExpanded,
            currentRoute: currentRoute,
            onMenuTap: onMenuTap,
            onToggleItem: onToggleItem,
          )),
      ],
    );
  }

  /// 处理菜单项点击
  Future<void> _handleItemTap(bool hasChildren) async {
    // 延迟200毫秒，确保水波纹动画效果执行完毕
    await Future.delayed(const Duration(milliseconds: 200));
    if (hasChildren) {
      onToggleItem(item.id);
    } else if (item.route != null) {
      onMenuTap(item.route!);
    }
  }

  /// 构建菜单项内容
  Widget _buildItem(bool hasChildren, bool isSelected, bool isExpanded, BuildContext context) {
    return Row(
      children: [
        // SVG图标或普通图标，只显示一个
        if (item.svgIcon != null) ...[
          SvgPicture.asset('assets/images/${item.svgIcon}', width: 28, height: 28),
          SizedBox(width: isExpanded ? 12 : 0),
        ] else if (item.icon != null) ...[
          Icon(item.icon, size: 28, color: Theme.of(context).textTheme.bodyMedium?.color),
          SizedBox(width: isExpanded ? 12 : 0),
        ],
        
        // 标题（仅在展开时显示）
        if (isExpanded) ...[
          Expanded(
            child: Text(
              item.title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
          
          // 展开/收起箭头（仅在有子菜单时显示）
          if (hasChildren)
            Icon(item.isExpanded 
              ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
              size: 18,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
        ],
      ],
    );
  }
}
