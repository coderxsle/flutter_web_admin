import 'package:flutter/material.dart';
import 'package:flutter_web_admin/components/dot/gi_dot.dart';

/// GiDot 组件演示页面
/// 
/// 展示 GiDot 组件的各种使用方式和样式效果
class GiDotDemoPage extends StatefulWidget {
  final String title;
  const GiDotDemoPage({super.key, required this.title});

  @override
  State<GiDotDemoPage> createState() => _GiDotDemoPageState();
}

class _GiDotDemoPageState extends State<GiDotDemoPage> {
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
                Icons.circle,
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
                  // 基础用法 - 带动画
                  _buildBasicUsageCard(),
                  const SizedBox(height: 24),
                  
                  // 不带动画
                  _buildNoAnimationCard(),
                  const SizedBox(height: 24),
                  
                  // 不同尺寸
                  _buildSizeVariantsCard(),
                  const SizedBox(height: 24),
                  
                  // 实际应用场景
                  _buildUsageScenariosCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 基础用法卡片 - 带动画
  Widget _buildBasicUsageCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '点（带动画）',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              spacing: 20,
              children: [
                GiDot(type: DotType.primary),
                GiDot(type: DotType.success),
                GiDot(type: DotType.warning),
                GiDot(type: DotType.danger),
                GiDot(type: DotType.info),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 不带动画卡片
  Widget _buildNoAnimationCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '点（不带动画）',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              spacing: 20,
              children: [
                GiDot(type: DotType.primary, animation: false),
                GiDot(type: DotType.success, animation: false),
                GiDot(type: DotType.warning, animation: false),
                GiDot(type: DotType.danger, animation: false),
                GiDot(type: DotType.info, animation: false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 不同尺寸变体卡片
  Widget _buildSizeVariantsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '不同尺寸',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              spacing: 20,
              children: [
                GiDot(type: DotType.primary, size: 6, animation: false),
                GiDot(type: DotType.success, size: 8, animation: false),
                GiDot(type: DotType.warning, size: 10, animation: false),
                GiDot(type: DotType.danger, size: 12, animation: false),
                GiDot(type: DotType.info, size: 14, animation: false),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              spacing: 20,
              children: [
                GiDot(type: DotType.primary, size: 6),
                GiDot(type: DotType.success, size: 8),
                GiDot(type: DotType.warning, size: 10),
                GiDot(type: DotType.danger, size: 12),
                GiDot(type: DotType.info, size: 14),
              ],
            ),
          ],
        ),
      ),
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
                _buildStatusItem('在线状态', DotType.success),
                const SizedBox(height: 12),
                _buildStatusItem('忙碌状态', DotType.warning),
                const SizedBox(height: 12),
                _buildStatusItem('正在处理', DotType.primary),
                const SizedBox(height: 12),
                _buildStatusItem('离线状态', DotType.danger, animation: false),
                const SizedBox(height: 12),
                _buildStatusItem('未知状态', DotType.info, animation: false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建状态项
  Widget _buildStatusItem(String label, DotType type, {bool animation = true}) {
    return Row(
      children: [
        GiDot(type: type, animation: animation),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  /// 获取点的颜色
  Color _getDotColor(DotType type) {
    switch (type) {
      case DotType.primary:
        return Theme.of(context).primaryColor;
      case DotType.success:
        return Colors.green;
      case DotType.warning:
        return Colors.orange;
      case DotType.danger:
        return Colors.red;
      case DotType.info:
        return Colors.grey;
    }
  }
}
