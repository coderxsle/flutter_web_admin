import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/menu_item.dart';
import 'sidebar_menu.dart';

class LayoutSidebar extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggleExpansion;
  final RxList<MenuItem> menuItems;
  final Function(String) onMenuTap;
  final Function(String) onToggleItem;
  final String currentRoute;

  const LayoutSidebar({
    super.key,
    required this.isExpanded,
    required this.onToggleExpansion,
    required this.menuItems,
    required this.onMenuTap,
    required this.onToggleItem,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? 280 : 80,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border(
            right: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ), 
          ),
        ),
        child: Column(
          children: [
            // 顶部标题栏
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blue[600],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.admin_panel_settings,
                    color: Colors.white,
                    size: isExpanded ? 24 : 20,
                  ),
                  if (isExpanded) ...[
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Admin Panel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onToggleExpansion,
                      icon: Icon(
                        isExpanded
                            ? Icons.chevron_left
                            : Icons.chevron_right,
                        color: Colors.white,
                      ),
                      tooltip: isExpanded ? '收起菜单' : '展开菜单',
                    ),
                  ] else ...[
                    const Spacer(),
                    IconButton(
                      onPressed: onToggleExpansion,
                      icon: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                      tooltip: '展开菜单',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: 20,
                    ),
                  ],
                ],
              ),
            ),
            
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
}
