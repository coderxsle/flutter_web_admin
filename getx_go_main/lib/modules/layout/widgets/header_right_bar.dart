/// @file HeaderRightBar 组件
/// @description 头部右侧工具栏组件，包含项目配置、消息通知、全屏切换、主题切换和用户菜单等功能
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_go_main/app_manager.dart';
import 'package:getx_go_main/components/svg_icon/gi_svg_icon.dart';
import 'package:getx_go_main/theme/app_theme.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'notice_widget.dart';
import 'setting_drawer.dart';

/// 头部右侧工具栏组件
class HeaderRightBar extends StatefulWidget {
  const HeaderRightBar({super.key});

  @override
  State<HeaderRightBar> createState() => _HeaderRightBarState();
}

class _HeaderRightBarState extends State<HeaderRightBar> {
  /// 全屏状态
  bool _isFullscreen = false;

  /// 用户菜单项配置
  final List<Map<String, dynamic>> _userMenuItems = [
    {
      'key': 'user',
      'label': '个人中心',
      'icon': Icons.person,
      'iconColor': Colors.blue,
      'route': '/system/account',
    },
    {
      'key': 'github',
      'label': '项目地址',
      'icon': Icons.code,
      'iconColor': Colors.green,
      'url': 'https://github.com/example/project',
    },
    {
      'key': 'password',
      'label': '修改密码',
      'icon': Icons.lock,
      'iconColor': Colors.orange,
      'action': 'changePassword',
    },
  ];

  /// 打开设置抽屉
  void _handleOpenSettings() {
    SmartDialog.show(
      tag: 'settingDrawer',
      alignment: Alignment.centerRight,
      // maskColor: Colors.black.withOpacity(0.3),
      clickMaskDismiss: true,
      animationBuilder: (controller, child, animationParam) {
        // 从右侧滑入动画
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: controller,
            curve: Curves.easeInOut,
          )),
          child: child,
        );
      },
      builder: (_) => const SettingDrawer(),
    );
  }

  /// 切换全屏
  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
    
    // 这里可以集成真实的全屏API
    Get.snackbar(
      '提示',
      _isFullscreen ? '已进入全屏模式' : '已退出全屏模式',
      duration: const Duration(seconds: 1),
    );
  }

  /// 处理用户菜单项点击
  void _handleUserMenuClick(String value) {
    switch (value) {
      case 'user':
        Get.toNamed('/system/account');
        break;
      case 'github':
        // 这里可以使用url_launcher打开外部链接
        Get.snackbar('提示', '打开项目地址: https://github.com/example/project');
        break;
      case 'password':
        Get.snackbar('提示', '修改密码功能');
        break;
      case 'logout':
        _handleLogout();
        break;
    }
  }

  /// 处理退出登录
  void _handleLogout() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('提示'),
        content: const Text('确认退出登录？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              AppManager.signOut();
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }

  /// 构建工具按钮
  Widget _buildToolButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
    Widget? badge,
  }) {
    return Tooltip(
      message: tooltip,
      child: badge != null
          ? Badge(
              label: badge,
              child: _buildIconButton(icon, onPressed),
            )
          : _buildIconButton(icon, onPressed),
    );
  }

  /// 构建图标按钮
  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      iconSize: 22,
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(
        minWidth: 32,
        minHeight: 32,
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: Theme.of(context).textTheme.bodyMedium?.color),
    );
  }

  /// 构建用户菜单项
  Widget _buildUserMenuItem(Map<String, dynamic> item) {
    return PopupMenuItem<String>(
      value: item['key'] as String,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: item['iconColor'] ?? Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              item['icon'],
              size: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Text(item['label']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 项目配置按钮
        _buildToolButton(
          icon: Icons.settings,
          tooltip: '项目配置',
          onPressed: _handleOpenSettings,
        ),
        
        const SizedBox(width: 12),
        
        // 消息通知按钮
        PopupMenuButton<String>(
          offset: const Offset(0, 40),
          child: _buildToolButton(
            icon: Icons.notifications,
            tooltip: '消息通知',
            onPressed: () {},
            badge: const Text('9', style: TextStyle(fontSize: 10)),
          ),
          itemBuilder: (context) => [
            const PopupMenuItem(
              enabled: false,
              child: SizedBox(
                width: 300,
                height: 200,
                child: NoticeWidget(),
              ),
            ),
          ],
        ),
        
        const SizedBox(width: 12),
        
        // 全屏切换按钮（仅在桌面端显示）
        if (isDesktop) ...[
          _buildToolButton(
            icon: _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
            tooltip: '全屏切换',
            onPressed: _toggleFullscreen,
          ),
          
          const SizedBox(width: 12),
        ],
        
        // 主题切换按钮
        _buildToolButton(
          tooltip: '主题切换',
          icon: AppTheme.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          onPressed: () => AppTheme.toggleThemeMode(),
        ),
        
        const SizedBox(width: 16),
        
        // 用户下拉菜单
        PopupMenuButton<String>(
          onSelected: _handleUserMenuClick,
          offset: const Offset(0, 40),
          itemBuilder: (context) => [
            ..._userMenuItems.map((item) => _buildUserMenuItem(item) as PopupMenuItem<String>),
            const PopupMenuDivider(),
            PopupMenuItem<String>(
              value: 'logout',
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.logout,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('退出登录'),
                ],
              ),
            ),
          ],
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 用户头像
              CircleAvatar(
                radius: 16,
                backgroundColor: theme.primaryColor,
                child: (AppManager.userInfo?.avatar?.isNotEmpty ?? false)
                    ? ClipOval(
                        child: Image.network(
                          AppManager.userInfo!.avatar!,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                              GiSvgIcon(name: 'avatar_woman', size: 32),
                        ),
                      )
                    : GiSvgIcon(name: 'avatar_woman', size: 32),
              ),
              
              const SizedBox(width: 8),
              
              // 用户名
              Text(
                AppManager.userInfo?.username ?? '未知用户',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.textTheme.titleMedium?.color,
                ),
              ),
              
              const SizedBox(width: 4),
              
              // 下拉箭头
              Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: theme.iconTheme.color?.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
