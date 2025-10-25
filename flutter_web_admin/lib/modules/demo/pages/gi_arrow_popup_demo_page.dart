import 'package:flutter/material.dart';
import 'package:flutter_web_admin/components/popup/gi_arrow_popup_wrapper.dart';
import 'package:flutter_web_admin/components/button/gi_arco_button.dart';

/// GiArrowPopupWrapper 组件演示页面
class GiArrowPopupDemoPage extends StatefulWidget {
  final String title;
  const GiArrowPopupDemoPage({super.key, required this.title});

  @override
  State<GiArrowPopupDemoPage> createState() => _GiArrowPopupDemoPageState();
}

class _GiArrowPopupDemoPageState extends State<GiArrowPopupDemoPage> {
  String _selectedValue = '请选择';
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 页面标题
          Row(
            children: [
              Icon(
                Icons.smart_button,
                size: 26,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 说明文档
                  _buildInfoCard(),
                  
                  const SizedBox(height: 32),
                  
                  // 基本用法
                  _buildSection(
                    title: '基本用法',
                    description: '四个方向的弹出示例',
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildDirectionDemo(PopupDirection.top, '向上弹出'),
                        _buildDirectionDemo(PopupDirection.bottom, '向下弹出'),
                        _buildDirectionDemo(PopupDirection.left, '向左弹出'),
                        _buildDirectionDemo(PopupDirection.right, '向右弹出'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // 不同尺寸
                  _buildSection(
                    title: '不同尺寸',
                    description: '支持自定义弹框宽高',
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildSizeDemo(const Size(150, 100), '小尺寸'),
                        _buildSizeDemo(const Size(200, 140), '中等尺寸'),
                        _buildSizeDemo(const Size(300, 180), '大尺寸'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // 实际应用示例
                  _buildSection(
                    title: '实际应用示例',
                    description: '模拟真实使用场景',
                    child: Column(
                      children: [
                        // 下拉选择器
                        Row(
                          children: [
                            const Text('选择城市：'),
                            const SizedBox(width: 12),
                            _buildSelectDemo(),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // 操作菜单
                        Row(
                          children: [
                            const Text('操作菜单：'),
                            const SizedBox(width: 12),
                            _buildMenuDemo(),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // 用户信息卡片
                        Row(
                          children: [
                            const Text('用户信息：'),
                            const SizedBox(width: 12),
                            _buildUserCardDemo(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // 自定义样式
                  _buildSection(
                    title: '自定义样式',
                    description: '支持自定义背景色、圆角、阴影等',
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildCustomStyleDemo(
                          Colors.blue[50]!,
                          '浅蓝背景',
                        ),
                        _buildCustomStyleDemo(
                          Colors.green[50]!,
                          '浅绿背景',
                        ),
                        _buildCustomStyleDemo(
                          Colors.orange[50]!,
                          '浅橙背景',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
              const SizedBox(width: 8),
              Text(
                'GiArrowPopupWrapper 通用弹出组件',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '这是一个通用的 Overlay 弹出组件，支持四个方向弹出、带箭头指向、自定义内容、点击外部关闭等功能。',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '特性：',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '• 支持 top/bottom/left/right 四个方向弹出\n'
            '• 带箭头指向触发按钮\n'
            '• 支持自定义弹框尺寸和内容\n'
            '• 点击外部区域自动关闭\n'
            '• 支持动画效果\n'
            '• 多实例独立使用，不相互影响',
            style: TextStyle(
              fontSize: 13,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildDirectionDemo(PopupDirection direction, String label) {
    VoidCallback? showPopupCallback;
    
    return GiArrowPopupWrapper(
      direction: direction,
      size: const Size(160, 110),
      popupBuilder: (context) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getDirectionIcon(direction),
              size: 24,
              color: Colors.blue[600],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '这是一个示例弹框',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      onTrigger: (showPopup) {
        showPopupCallback = showPopup;
      },
      child: GiArcoButton(
        type: GiArcoButtonType.outline,
        text: label,
        onPressed: () {
          showPopupCallback?.call();
        },
      ),
    );
  }

  Widget _buildSizeDemo(Size size, String label) {
    VoidCallback? showPopupCallback;
    
    return GiArrowPopupWrapper(
      direction: PopupDirection.bottom,
      size: size,
      popupBuilder: (context) => Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '尺寸：${size.width.toInt()} x ${size.height.toInt()}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      onTrigger: (showPopup) {
        showPopupCallback = showPopup;
      },
      child: GiArcoButton(
        type: GiArcoButtonType.normal,
        text: label,
        onPressed: () {
          showPopupCallback?.call();
        },
      ),
    );
  }

  Widget _buildSelectDemo() {
    return GiArrowPopupWrapper(
      direction: PopupDirection.bottom,
      size: const Size(140, 200),
      popupBuilder: (context) => Container(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 4),
          shrinkWrap: true,
          children: [
            '北京',
            '上海',
            '广州',
            '深圳',
            '杭州',
          ].map((city) => InkWell(
            onTap: () {
              setState(() {
                _selectedValue = city;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  if (_selectedValue == city) ...[
                    const Icon(Icons.check, size: 14, color: Color(0xFF165DFF)),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    city,
                    style: TextStyle(
                      fontSize: 14,
                      color: _selectedValue == city ? const Color(0xFF165DFF) : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          )).toList(),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_selectedValue),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_drop_down, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuDemo() {
    VoidCallback? showPopupCallback;
    
    return GiArrowPopupWrapper(
      direction: PopupDirection.bottom,
      size: const Size(120, 180),
      popupBuilder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            _buildMenuItem(Icons.edit, '编辑'),
            _buildMenuItem(Icons.copy, '复制'),
            _buildMenuItem(Icons.share, '分享'),
            _buildMenuItem(Icons.delete, '删除', isDestructive: true),
          ],
        ),
      ),
      onTrigger: (showPopup) {
        showPopupCallback = showPopup;
      },
      child: GiArcoButton(
        type: GiArcoButtonType.text,
        icon: Icons.more_vert,
        onPressed: () {
          showPopupCallback?.call();
        },
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, {bool isDestructive = false}) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: isDestructive ? Colors.red[600] : Colors.grey[700],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isDestructive ? Colors.red[600] : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCardDemo() {
    return GiArrowPopupWrapper(
      direction: PopupDirection.top,
      size: const Size(200, 120),
      popupBuilder: (context) => Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue[100],
              child: Text(
                '张',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '张三',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '产品经理',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'zhangsan@example.com',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.blue,
              child: Text(
                '张',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 6),
            Text('张三'),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomStyleDemo(Color backgroundColor, String label) {
    VoidCallback? showPopupCallback;
    
    return GiArrowPopupWrapper(
      direction: PopupDirection.top,
      size: const Size(140, 90),
      offset: const Offset(0, -6),
      backgroundColor: backgroundColor,
      borderRadius: 12,
      elevation: 4,
      popupBuilder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '自定义样式',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      onTrigger: (showPopup) {
        showPopupCallback = showPopup;
      },
      child: GiArcoButton(
        type: GiArcoButtonType.secondary,
        text: label,
        onPressed: () {
          showPopupCallback?.call();
        },
      ),
    );
  }

  IconData _getDirectionIcon(PopupDirection direction) {
    switch (direction) {
      case PopupDirection.top:
        return Icons.keyboard_arrow_up;
      case PopupDirection.bottom:
        return Icons.keyboard_arrow_down;
      case PopupDirection.left:
        return Icons.keyboard_arrow_left;
      case PopupDirection.right:
        return Icons.keyboard_arrow_right;
    }
  }
}
