import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_web_admin/components/gi_arco.dart';

/// GiTag 组件演示页面
/// 
/// 展示 GiTag 组件的各种使用方式和样式效果
class GiTagDemoPage extends StatefulWidget {
  final String title;
  const GiTagDemoPage({super.key, required this.title});

  @override
  State<GiTagDemoPage> createState() => _GiTagDemoPageState();
}

class _GiTagDemoPageState extends State<GiTagDemoPage> {
  /// 处理标签关闭事件
  void _onTagClose(String tagName) {
    GiArcoMessage.info('点击了关闭图标: $tagName');
  }

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
          // 页面内容 
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(// GiTag 组件演示
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBasicUsageSection(),
                  const SizedBox(height: 24),
                  _buildBaseColorsSection(),
                  const SizedBox(height: 24),
                  _buildCustomColorsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );  
  }

  /// 基本使用示例
  Widget _buildBasicUsageSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '基本使用',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Light 类型标签
            GiSpace(
              wrap: true,
              children: [
                const GiTag(text: 'light'),
                GiTag(
                  text: '标签',
                  status: GiTagStatus.success,
                  closable: true,
                  onClose: () => _onTagClose('success'),
                ),
                const GiTag(
                  text: '标签',
                  status: GiTagStatus.warning,
                ),
                GiTag(
                  text: '标签',
                  status: GiTagStatus.danger,
                  closable: true,
                  onClose: () => _onTagClose('danger'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Dark 类型标签
            GiSpace(
              wrap: true,
              children: [
                const GiTag(
                  text: 'dark',
                  type: GiTagType.dark,
                  size: GiTagSize.mini,
                ),
                GiTag(
                  text: '标签',
                  type: GiTagType.dark,
                  size: GiTagSize.mini,
                  status: GiTagStatus.success,
                  closable: true,
                  onClose: () => _onTagClose('dark success'),
                ),
                const GiTag(
                  text: '标签',
                  type: GiTagType.dark,
                  size: GiTagSize.mini,
                  status: GiTagStatus.warning,
                ),
                GiTag(
                  text: '标签',
                  type: GiTagType.dark,
                  size: GiTagSize.mini,
                  status: GiTagStatus.danger,
                  closable: true,
                  onClose: () => _onTagClose('dark danger'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Outline 类型标签
            GiSpace(
              wrap: true,
              children: [
                const GiTag(
                  text: 'outline',
                  type: GiTagType.outline,
                ),
                GiTag(
                  text: '标签',
                  type: GiTagType.outline,
                  status: GiTagStatus.success,
                  closable: true,
                  onClose: () => _onTagClose('outline success'),
                ),
                const GiTag(
                  text: '标签',
                  type: GiTagType.outline,
                  status: GiTagStatus.warning,
                ),
                GiTag(
                  text: '标签',
                  type: GiTagType.outline,
                  status: GiTagStatus.danger,
                  closable: true,
                  onClose: () => _onTagClose('outline danger'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Light-outline 类型标签
            GiSpace(
              wrap: true,
              children: [
                const GiTag(
                  text: 'light-outline',
                  type: GiTagType.lightOutline,
                ),
                GiTag(
                  text: '标签',
                  type: GiTagType.lightOutline,
                  status: GiTagStatus.success,
                  closable: true,
                  onClose: () => _onTagClose('light-outline success'),
                ),
                const GiTag(
                  text: '标签',
                  type: GiTagType.lightOutline,
                  status: GiTagStatus.warning,
                ),
                GiTag(
                  text: '标签',
                  type: GiTagType.lightOutline,
                  status: GiTagStatus.danger,
                  closable: true,
                  onClose: () => _onTagClose('light-outline danger'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 基础颜色示例
  Widget _buildBaseColorsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '基础颜色',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Light 类型基础颜色
            GiSpace(
              wrap: true,
              children: [
                GiTag(
                  text: 'red',
                  color: 'red',
                  closable: true,
                  onClose: () => _onTagClose('red'),
                ),
                const GiTag(text: 'orangered', color: 'orangered'),
                const GiTag(text: 'orange', color: 'orange'),
                const GiTag(text: 'gold', color: 'gold'),
                const GiTag(text: 'lime', color: 'lime'),
                const GiTag(text: 'green', color: 'green'),
                const GiTag(text: 'cyan', color: 'cyan'),
                const GiTag(text: 'blue', color: 'blue'),
                const GiTag(text: 'purple', color: 'purple'),
                const GiTag(text: 'pink', color: 'pink'),
                const GiTag(text: 'gray', color: 'gray'),
              ],
            ),
            const SizedBox(height: 12),
            
            // Dark 类型基础颜色
            GiSpace(
              wrap: true,
              children: [
                GiTag(
                  text: 'red',
                  type: GiTagType.dark,
                  color: 'red',
                  closable: true,
                  onClose: () => _onTagClose('dark red'),
                ),
                const GiTag(text: 'orangered', type: GiTagType.dark, color: 'orangered'),
                const GiTag(text: 'orange', type: GiTagType.dark, color: 'orange'),
                const GiTag(text: 'gold', type: GiTagType.dark, color: 'gold'),
                const GiTag(text: 'lime', type: GiTagType.dark, color: 'lime'),
                const GiTag(text: 'green', type: GiTagType.dark, color: 'green'),
                const GiTag(text: 'cyan', type: GiTagType.dark, color: 'cyan'),
                const GiTag(text: 'blue', type: GiTagType.dark, color: 'blue'),
                const GiTag(text: 'purple', type: GiTagType.dark, color: 'purple'),
                const GiTag(text: 'pink', type: GiTagType.dark, color: 'pink'),
                const GiTag(text: 'gray', type: GiTagType.dark, color: 'gray'),
              ],
            ),
            const SizedBox(height: 12),
            
            // Outline 类型基础颜色
            GiSpace(
              wrap: true,
              children: [
                GiTag(
                  text: 'red',
                  type: GiTagType.outline,
                  color: 'red',
                  closable: true,
                  onClose: () => _onTagClose('outline red'),
                ),
                const GiTag(text: 'orangered', type: GiTagType.outline, color: 'orangered'),
                const GiTag(text: 'orange', type: GiTagType.outline, color: 'orange'),
                const GiTag(text: 'gold', type: GiTagType.outline, color: 'gold'),
                const GiTag(text: 'lime', type: GiTagType.outline, color: 'lime'),
                const GiTag(text: 'green', type: GiTagType.outline, color: 'green'),
                const GiTag(text: 'cyan', type: GiTagType.outline, color: 'cyan'),
                const GiTag(text: 'blue', type: GiTagType.outline, color: 'blue'),
                const GiTag(text: 'purple', type: GiTagType.outline, color: 'purple'),
                const GiTag(text: 'pink', type: GiTagType.outline, color: 'pink'),
                const GiTag(text: 'gray', type: GiTagType.outline, color: 'gray'),
              ],
            ),
            const SizedBox(height: 12),
            
            // Light-outline 类型基础颜色
            GiSpace(
              wrap: true,
              children: [
                GiTag(
                  text: 'red',
                  type: GiTagType.lightOutline,
                  color: 'red',
                  closable: true,
                  onClose: () => _onTagClose('light-outline red'),
                ),
                const GiTag(text: 'orangered', type: GiTagType.lightOutline, color: 'orangered'),
                const GiTag(text: 'orange', type: GiTagType.lightOutline, color: 'orange'),
                const GiTag(text: 'gold', type: GiTagType.lightOutline, color: 'gold'),
                const GiTag(text: 'lime', type: GiTagType.lightOutline, color: 'lime'),
                const GiTag(text: 'green', type: GiTagType.lightOutline, color: 'green'),
                const GiTag(text: 'cyan', type: GiTagType.lightOutline, color: 'cyan'),
                const GiTag(text: 'blue', type: GiTagType.lightOutline, color: 'blue'),
                const GiTag(text: 'purple', type: GiTagType.lightOutline, color: 'purple'),
                const GiTag(text: 'pink', type: GiTagType.lightOutline, color: 'pink'),
                const GiTag(text: 'gray', type: GiTagType.lightOutline, color: 'gray'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 自定义颜色示例
  Widget _buildCustomColorsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '自定义颜色',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Light 类型自定义颜色
            GiSpace(
              wrap: true,
              children: [
                GiTag(
                  text: '#4E6EF2',
                  color: '#4E6EF2',
                  closable: true,
                  onClose: () => _onTagClose('#4E6EF2'),
                ),
                const GiTag(text: '#1BA035', color: '#1BA035'),
                const GiTag(text: '#AB57E3', color: '#AB57E3'),
                const GiTag(text: '#FF6C9D', color: '#FF6C9D'),
                const GiTag(text: '#0fc6c2', color: '#0fc6c2'),
              ],
            ),
            const SizedBox(height: 12),
            
            // Dark 类型自定义颜色
            GiSpace(
              wrap: true,
              children: [
                GiTag(
                  text: '#4E6EF2',
                  type: GiTagType.dark,
                  color: '#4E6EF2',
                  closable: true,
                  onClose: () => _onTagClose('dark #4E6EF2'),
                ),
                const GiTag(text: '#1BA035', type: GiTagType.dark, color: '#1BA035'),
                const GiTag(text: '#AB57E3', type: GiTagType.dark, color: '#AB57E3'),
                const GiTag(text: '#FF6C9D', type: GiTagType.dark, color: '#FF6C9D'),
                const GiTag(text: '#0fc6c2', type: GiTagType.dark, color: '#0fc6c2'),
              ],
            ),
            const SizedBox(height: 12),
            
            // Outline 类型自定义颜色
            GiSpace(
              wrap: true,
              children: [
                GiTag(
                  text: '#4E6EF2',
                  type: GiTagType.outline,
                  color: '#4E6EF2',
                  closable: true,
                  onClose: () => _onTagClose('outline #4E6EF2'),
                ),
                const GiTag(text: '#1BA035', type: GiTagType.outline, color: '#1BA035'),
                const GiTag(text: '#AB57E3', type: GiTagType.outline, color: '#AB57E3'),
                const GiTag(text: '#FF6C9D', type: GiTagType.outline, color: '#FF6C9D'),
                const GiTag(text: '#0fc6c2', type: GiTagType.outline, color: '#0fc6c2'),
              ],
            ),
            const SizedBox(height: 12),
            
            // Light-outline 类型自定义颜色（mini 尺寸）
            GiSpace(
              wrap: true,
              children: [
                GiTag(
                  text: '#4E6EF2',
                  type: GiTagType.lightOutline,
                  size: GiTagSize.mini,
                  color: '#4E6EF2',
                  closable: true,
                  onClose: () => _onTagClose('mini #4E6EF2'),
                ),
                const GiTag(
                  text: '#1BA035',
                  type: GiTagType.lightOutline,
                  size: GiTagSize.mini,
                  color: '#1BA035',
                ),
                const GiTag(
                  text: '#AB57E3',
                  type: GiTagType.lightOutline,
                  size: GiTagSize.mini,
                  color: '#AB57E3',
                ),
                const GiTag(
                  text: '#FF6C9D',
                  type: GiTagType.lightOutline,
                  size: GiTagSize.mini,
                  color: '#FF6C9D',
                ),
                const GiTag(
                  text: '#0fc6c2',
                  type: GiTagType.lightOutline,
                  size: GiTagSize.mini,
                  color: '#0fc6c2',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
