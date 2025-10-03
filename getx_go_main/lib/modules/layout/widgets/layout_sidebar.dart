import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/menu_item.dart';
import 'sidebar_menu.dart';

class LayoutSidebar extends StatelessWidget {
  final String? logo;
  final bool isExpanded;
  final VoidCallback onToggleExpansion;
  final RxList<MenuItem> menuItems;
  final Function(String) onMenuTap;
  final Function(String) onToggleItem;
  final String currentRoute;

  const LayoutSidebar({
    super.key,
    this.logo,
    required this.isExpanded,
    required this.onToggleExpansion,
    required this.menuItems,
    required this.onMenuTap,
    required this.onToggleItem,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? 230 : 60,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1,
              color: Theme.of(context).dividerColor
            ), 
          ),
        ),
        child: Column(
          children: [
            // 顶部标题栏
            _buildLogoTitle(theme),
            
            // 菜单列表
            Expanded(
              child: Obx(() => ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return SidebarMenu(
                    item: menuItems[index],
                    level: 0,
                    isExpanded: isExpanded,
                    currentRoute: currentRoute,
                    onMenuTap: onMenuTap,
                    onToggleItem: onToggleItem,
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }


  /// 顶部标题栏
  Widget _buildLogoTitle(ThemeData theme) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: theme.canvasColor,
        border: Border(bottom: BorderSide(width: 1, color: theme.dividerColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (logo != null) Image.asset(logo!, width: 36, height: 36),
          if (logo == null) Icon(Icons.admin_panel_settings, color: theme.textTheme.bodyMedium?.color, size: 36),
          if (isExpanded) ...[
            const SizedBox(width: 4),
            Text(
              'Flutter Admin Panel',
              style: TextStyle(
                color: theme.textTheme.bodyMedium?.color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
