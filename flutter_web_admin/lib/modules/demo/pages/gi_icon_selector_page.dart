import 'package:flutter/material.dart';
import 'package:flutter_web_admin/components/icon_selector/gi_icon_selector.dart';

/// GiIconSelector 组件演示页面
/// 
/// 展示 GiIconSelector 组件的各种使用方式和样式效果
class GiIconSelectorDemoPage extends StatefulWidget {
  final String title;
  const GiIconSelectorDemoPage({super.key, required this.title});

  @override
  State<GiIconSelectorDemoPage> createState() => _GiIconSelectorDemoPageState();
}

class _GiIconSelectorDemoPageState extends State<GiIconSelectorDemoPage> {
  String _selectedIcon = '';
  String _selectedCustomIcon = '';

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
                Icons.select_all,
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
          // 页面内容 
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 基础用法
                  SizedBox(width: 1000, child: _buildBasicUsageCard()),
                  const SizedBox(height: 24),
                  
                  // 功能演示
                  SizedBox(width: 1000, child: _buildFeatureDemoCard()),
                  const SizedBox(height: 24),
                  
                  // 实际应用场景
                  SizedBox(width: 1000, child: _buildUsageScenariosCard()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 基础用法卡片
  Widget _buildBasicUsageCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '图标选择器',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Material 图标选择器:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      GiIconSelector(
                        value: _selectedIcon,
                        type: IconType.material,
                        placeholder: '请选择图标',
                        onChanged: (value) {
                          setState(() {
                            _selectedIcon = value;
                          });
                        },
                        onSelect: (icon) {
                          _showMessage('选择了图标: $icon');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('自定义图标选择器:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      GiIconSelector(
                        value: _selectedCustomIcon,
                        type: IconType.custom,
                        placeholder: '请选择自定义图标',
                        onChanged: (value) {
                          setState(() {
                            _selectedCustomIcon = value;
                          });
                        },
                        onSelect: (icon) {
                          _showMessage('选择了自定义图标: $icon');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_selectedIcon.isNotEmpty || _selectedCustomIcon.isNotEmpty) ...[
              const Text('当前选择:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_selectedIcon.isNotEmpty)
                      Text('Material 图标: $_selectedIcon', style: const TextStyle(fontSize: 12)), 
                    if (_selectedCustomIcon.isNotEmpty)
                      Text('自定义图标: $_selectedCustomIcon', style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// 功能演示卡片
  Widget _buildFeatureDemoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '功能演示',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                _buildFeatureItem(
                  '搜索功能',
                  '支持按图标名称搜索',
                  Icons.search,
                ),
                const SizedBox(height: 12),
                _buildFeatureItem(
                  '视图切换',
                  '支持网格视图和列表视图',
                  Icons.view_module,
                ),
                const SizedBox(height: 12),
                _buildFeatureItem(
                  '分页显示',
                  '大量图标分页显示，提升性能',
                  Icons.pages,
                ),
                const SizedBox(height: 12),
                _buildFeatureItem(
                  '清除选择',
                  '可以清除当前选择的图标',
                  Icons.clear,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建功能项
  Widget _buildFeatureItem(String title, String description, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 实际应用场景卡片
  Widget _buildUsageScenariosCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '实际应用场景',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                _buildScenarioItem('菜单配置', '为系统菜单选择合适的图标'),
                const SizedBox(height: 12),
                _buildScenarioItem('按钮设计', '为操作按钮选择直观的图标'),
                const SizedBox(height: 12),
                _buildScenarioItem('状态指示', '用图标表示不同的状态'),
                const SizedBox(height: 12),
                _buildScenarioItem('导航元素', '为导航项选择清晰的图标'),
                const SizedBox(height: 12),
                _buildScenarioItem('数据展示', '用图标增强数据的可读性'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建场景项
  Widget _buildScenarioItem(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 显示消息
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
