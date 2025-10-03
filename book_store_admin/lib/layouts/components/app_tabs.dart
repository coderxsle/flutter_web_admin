///
/// @file Tabs 组件
/// @description 系统标签页组件，支持多种标签样式、右键菜单和快捷操作
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/global.dart';
import '../../models/tab_model.dart';

/// 标签页样式枚举
enum TabStyle {
  /// 默认样式
  line('line'),
  /// 卡片样式
  card('card'),
  /// 自定义样式1
  custom1('custom1'),
  /// 自定义样式2
  custom2('custom2');

  const TabStyle(this.value);
  final String value;
}

/// 系统标签页组件
/// 
/// 功能特性：
/// - 多种标签样式
/// - 右键菜单操作
/// - 标签拖拽排序
/// - 快捷操作按钮
/// - 标签缓存管理
class AppTabs extends StatefulWidget {
  const AppTabs({super.key});

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs>
    with SingleTickerProviderStateMixin {
  /// 应用状态控制器
  final _appController = Get.find<GlobalController>();
  
  /// 标签页控制器
  late TabController _tabController;
  
  /// 当前路由
  String get _currentRoute => Get.currentRoute;

  @override
  void initState() {
    super.initState();
    _initializeTabs();
  }

  /// 初始化标签页
  void _initializeTabs() {
    final tabList = _appController.tabList;
    final currentIndex = tabList.indexWhere((tab) => tab.path == _currentRoute);
    
    _tabController = TabController(
      length: tabList.length,
      initialIndex: currentIndex >= 0 ? currentIndex : 0,
      vsync: this,
    );
    
    _tabController.addListener(_handleTabChange);
  }

  /// 处理标签页切换
  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      final tabList = _appController.tabList;
      if (_tabController.index < tabList.length) {
        final targetTab = tabList[_tabController.index];
        Get.toNamed(targetTab.fullPath ?? targetTab.path);
      }
    }
  }

  /// 获取标签页样式类型
  TabStyle get _tabStyleType {
    final tabValue = _appController.tabStyle;
    return TabStyle.values.firstWhere(
      (style) => style.value == tabValue,
      orElse: () => TabStyle.line,
    );
  }

  /// 处理标签页点击
  void _handleTabClick(String path) {
    final targetTab = _appController.tabList.firstWhereOrNull(
      (tab) => tab.path == path,
    );
    if (targetTab != null) {
      Get.toNamed(targetTab.fullPath ?? targetTab.path);
    }
  }

  /// 处理标签页关闭
  void _handleTabClose(String path) {
    _appController.closeTab(path);
    _updateTabController();
  }

  /// 更新标签页控制器
  void _updateTabController() {
    final tabList = _appController.tabList;
    final currentIndex = tabList.indexWhere((tab) => tab.path == _currentRoute);
    
    _tabController.dispose();
    _tabController = TabController(
      length: tabList.length,
      initialIndex: currentIndex >= 0 ? currentIndex : 0,
      vsync: this,
    );
    _tabController.addListener(_handleTabChange);
    
    setState(() {});
  }

  /// 构建标签页操作菜单
  Widget _buildTabContextMenu(TabModel tab) {
    return PopupMenuButton<String>(
      onSelected: (value) => _handleTabMenuAction(value, tab.path),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'close_current',
          child: Row(
            children: [
              Icon(Icons.close, size: 16),
              SizedBox(width: 8),
              Text('关闭当前'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'close_right',
          child: Row(
            children: [
              Icon(Icons.close, size: 16),
              SizedBox(width: 8),
              Text('关闭右侧'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'close_other',
          child: Row(
            children: [
              Icon(Icons.clear_all, size: 16),
              SizedBox(width: 8),
              Text('关闭其他'),
            ],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: _currentRoute == tab.path 
              ? Theme.of(context).primaryColor
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tab.title,
              style: TextStyle(
                fontSize: 12,
                color: _currentRoute == tab.path 
                    ? Colors.white
                    : Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            if (!tab.affix) ...[
              const SizedBox(width: 4),
              InkWell(
                onTap: () => _handleTabClose(tab.path),
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: _currentRoute == tab.path 
                      ? Colors.white
                      : Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// 处理标签页菜单操作
  void _handleTabMenuAction(String action, String path) {
    switch (action) {
      case 'close_current':
        _appController.closeTab(path);
        break;
      case 'close_right':
        _appController.closeRightTabs(path);
        break;
      case 'close_other':
        _appController.closeOtherTabs(path);
        break;
    }
    _updateTabController();
  }

  /// 构建标签页额外操作
  Widget _buildTabExtra() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 刷新按钮
        IconButton(
          onPressed: () => _appController.reloadCurrentPage(),
          icon: const Icon(Icons.refresh, size: 16),
          tooltip: '刷新页面',
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
        ),
        
        // 更多操作
        PopupMenuButton<String>(
          onSelected: (value) => _handleGlobalTabAction(value),
          icon: const Icon(Icons.more_horiz, size: 16),
          tooltip: '更多操作',
          padding: const EdgeInsets.all(4),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'close_current',
              child: Row(
                children: [
                  Icon(Icons.close, size: 16),
                  SizedBox(width: 8),
                  Text('关闭当前'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'close_right',
              child: Row(
                children: [
                  Icon(Icons.close, size: 16),
                  SizedBox(width: 8),
                  Text('关闭右侧'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'close_other',
              child: Row(
                children: [
                  Icon(Icons.clear_all, size: 16),
                  SizedBox(width: 8),
                  Text('关闭其他'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'close_all',
              child: Row(
                children: [
                  Icon(Icons.remove, size: 16),
                  SizedBox(width: 8),
                  Text('关闭全部'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 处理全局标签页操作
  void _handleGlobalTabAction(String action) {
    switch (action) {
      case 'close_current':
        _appController.closeTab(_currentRoute);
        break;
      case 'close_right':
        _appController.closeRightTabs(_currentRoute);
        break;
      case 'close_other':
        _appController.closeOtherTabs(_currentRoute);
        break;
      case 'close_all':
        _appController.closeAllTabs();
        break;
    }
    _updateTabController();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      builder: (controller) {
        final tabList = controller.tabList;
        
        if (tabList.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 40,
          padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // 标签页列表
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _tabStyleType == TabStyle.custom2
                        ? tabList.map((tab) => _buildTabContextMenu(tab)).toList()
                        : _buildNormalTabs(tabList),
                  ),
                ),
              ),
              
              // 额外操作按钮
              _buildTabExtra(),
            ],
          ),
        );
      },
    );
  }

  /// 构建普通标签页
  List<Widget> _buildNormalTabs(List<TabModel> tabList) {
    return tabList.map((tab) {
      final isActive = _currentRoute == tab.path;
      
      return InkWell(
        onTap: () => _handleTabClick(tab.path),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isActive 
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isActive 
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tab.title,
                style: TextStyle(
                  fontSize: 13,
                  color: isActive 
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
              if (!tab.affix) ...[
                const SizedBox(width: 6),
                InkWell(
                  onTap: () => _handleTabClose(tab.path),
                  child: Icon(
                    Icons.close,
                    size: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
