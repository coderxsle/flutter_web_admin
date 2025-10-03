///
/// @file HeaderRightBar 组件
/// @description 头部右侧工具栏组件，包含项目配置、消息通知、全屏切换、主题切换和用户菜单等功能
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/global.dart';

/// 头部右侧工具栏组件
/// 
/// 功能特性：
/// - 项目配置按钮
/// - 消息通知下拉框
/// - 全屏切换按钮
/// - 主题切换按钮
/// - 用户菜单下拉框
/// - 响应式设计
class HeaderRightBar extends StatefulWidget {
  const HeaderRightBar({super.key});

  @override
  State<HeaderRightBar> createState() => _HeaderRightBarState();
}

class _HeaderRightBarState extends State<HeaderRightBar> {
  /// 应用状态控制器
  final _appController = Get.find<GlobalController>();
  
  /// 是否全屏状态
  bool _isFullscreen = false;
  
  /// 通知数量
  int _notificationCount = 9;

  /// 用户菜单项配置
  final List<UserMenuItem> _userMenuItems = [
    UserMenuItem(
      key: 'user',
      label: '个人中心',
      icon: Icons.person,
      iconColor: Colors.blue,
    ),
    UserMenuItem(
      key: 'github',
      label: '项目地址',
      icon: Icons.code,
      iconColor: Colors.green,
    ),
    UserMenuItem(
      key: 'password',
      label: '修改密码',
      icon: Icons.lock,
      iconColor: Colors.orange,
    ),
  ];

  /// 处理项目配置按钮点击
  void _handleOpenSettings() {
    // 打开设置抽屉
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildSettingsDrawer(),
    );
  }

  /// 处理全屏切换
  void _handleFullscreenToggle() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
    
    // 这里可以实现实际的全屏逻辑
    // 例如使用 window_manager 包
  }

  /// 处理主题切换
  void _handleThemeToggle() {
    _appController.toggleTheme();
  }

  /// 处理用户菜单项点击
  void _handleUserMenuItemClick(String key) {
    switch (key) {
      case 'user':
        Get.toNamed('/system/account');
        break;
      case 'github':
        // 打开项目地址
        // launchUrl(Uri.parse('https://gitee.com/lin0716/gi-demo'));
        break;
      case 'password':
        Get.snackbar('提示', '修改密码功能');
        break;
    }
  }

  /// 处理退出登录
  void _handleLogout() {
    Get.dialog(
      AlertDialog(
        title: const Text('提示'),
        content: const Text('确认退出登录？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              try {
                await _appController.logout();
                Get.offAllNamed('/login');
              } catch (e) {
                Get.snackbar('错误', '退出登录失败');
              }
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 构建设置抽屉
  Widget _buildSettingsDrawer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // 抽屉标题
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  '项目配置',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          
          // 配置内容
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSettingItem(
                  title: '菜单折叠',
                  subtitle: '切换菜单展开/折叠状态',
                  trailing: Switch(
                    value: _appController.menuCollapse,
                    onChanged: (value) => _appController.setMenuCollapse(value),
                  ),
                ),
                _buildSettingItem(
                  title: '暗黑模式',
                  subtitle: '切换深色/浅色主题',
                  trailing: Switch(
                    value: _appController.isDarkMode,
                    onChanged: (value) => _appController.toggleTheme(),
                  ),
                ),
                _buildSettingItem(
                  title: '标签页显示',
                  subtitle: '显示/隐藏页面标签页',
                  trailing: Switch(
                    value: _appController.tabVisible,
                    onChanged: (value) => _appController.setTabVisible(value),
                  ),
                ),
                _buildSettingItem(
                  title: '手风琴菜单',
                  subtitle: '菜单手风琴展开模式',
                  trailing: Switch(
                    value: _appController.menuAccordion,
                    onChanged: (value) => _appController.setMenuAccordion(value),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建设置项
  Widget _buildSettingItem({
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing,
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
    );
  }

  /// 构建消息通知内容
  Widget _buildNoticeContent() {
    return Container(
      width: 300,
      height: 400,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '消息通知',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text('${index + 1}'),
                  ),
                  title: Text('通知消息 ${index + 1}'),
                  subtitle: const Text('这是一条示例通知消息'),
                  trailing: const Text('刚刚'),
                  contentPadding: EdgeInsets.zero,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    return GetBuilder<GlobalController>(
      builder: (controller) {
        final userInfo = controller.userInfo;
        final username = userInfo?['username'] ?? '管理员';
        final avatar = userInfo?['avatar'] ?? '';

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 项目配置按钮
            IconButton(
              onPressed: _handleOpenSettings,
              icon: const Icon(Icons.settings, size: 18),
              tooltip: '项目配置',
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            ),

            // 消息通知
            PopupMenuButton<String>(
              offset: const Offset(0, 40),
              tooltip: '消息通知',
              child: Stack(
                children: [
                  IconButton(
                    onPressed: null,
                    icon: const Icon(Icons.notifications, size: 18),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                  ),
                  if (_notificationCount > 0)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                ],
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  enabled: false,
                  child: _buildNoticeContent(),
                ),
              ],
            ),

            // 全屏切换（平板和桌面显示）
            if (isTablet || isDesktop)
              IconButton(
                onPressed: _handleFullscreenToggle,
                icon: Icon(
                  _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                  size: 18,
                ),
                tooltip: '全屏切换',
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),

            // 主题切换
            IconButton(
              onPressed: _handleThemeToggle,
              icon: Icon(
                controller.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                size: 18,
              ),
              tooltip: '主题切换',
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            ),

            const SizedBox(width: 8),

            // 用户菜单
            PopupMenuButton<String>(
              onSelected: _handleUserMenuItemClick,
              offset: const Offset(0, 40),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: avatar.isNotEmpty
                        ? ClipOval(child: Image.network(avatar, fit: BoxFit.cover))
                        : const Icon(Icons.person, size: 20, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    username,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down, size: 16),
                ],
              ),
              itemBuilder: (context) => [
                // 用户信息
                PopupMenuItem(
                  enabled: false,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Icon(Icons.person, size: 18, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            userInfo?['email'] ?? 'admin@example.com',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                
                // 菜单项
                ..._userMenuItems.map((item) => PopupMenuItem(
                  value: item.key,
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: item.iconColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(
                          item.icon,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(item.label),
                    ],
                  ),
                )),
                
                const PopupMenuDivider(),
                
                // 退出登录
                PopupMenuItem(
                  value: 'logout',
                  onTap: _handleLogout,
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.logout,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('退出登录'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// 用户菜单项数据模型
class UserMenuItem {
  final String key;
  final String label;
  final IconData icon;
  final Color iconColor;

  const UserMenuItem({
    required this.key,
    required this.label,
    required this.icon,
    required this.iconColor,
  });
}
