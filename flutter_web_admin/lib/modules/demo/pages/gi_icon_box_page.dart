import 'package:flutter/material.dart';
import 'package:flutter_web_admin/components/icon_box/gi_icon_box.dart';

/// GiIconBox 组件演示页面
/// 
/// 展示 GiIconBox 组件的各种使用方式和样式效果
class GiIconBoxDemoPage extends StatefulWidget {
  final String title;
  const GiIconBoxDemoPage({super.key, required this.title});

  @override
  State<GiIconBoxDemoPage> createState() => _GiIconBoxDemoPageState();
}

class _GiIconBoxDemoPageState extends State<GiIconBoxDemoPage> {
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
                Icons.widgets,
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
                  _buildBasicUsageCard(),
                  const SizedBox(height: 24),
                  
                  // 不同颜色
                  _buildColorVariantsCard(),
                  const SizedBox(height: 24),
                  
                  // 不同尺寸
                  _buildSizeVariantsCard(),
                  const SizedBox(height: 24),
                  
                  // 不同形状
                  _buildShapeVariantsCard(),
                  const SizedBox(height: 24),
                  
                  // 可点击
                  _buildClickableCard(),
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
              '基础用法',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                GiIconBox(
                  color: '#4F6BF6',
                  icon: const Icon(Icons.edit),
                ),
                GiIconBox(
                  color: '#62C558',
                  icon: const Icon(Icons.file_upload),
                ),
                GiIconBox(
                  color: '#1677FF',
                  icon: const Icon(Icons.download),
                ),
                GiIconBox(
                  color: '#62C558',
                  icon: const Icon(Icons.attach_file),
                ),
                GiIconBox(
                  color: 'danger',
                  icon: const Icon(Icons.delete),
                ),
                GiIconBox(
                  color: 'danger',
                  size: 32,
                  icon: const Icon(Icons.delete),
                ),
                GiIconBox(
                  color: 'danger',
                  size: 32,
                  shape: 'round',
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 不同颜色变体卡片
  Widget _buildColorVariantsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '不同颜色',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                GiIconBox(
                  color: 'primary',
                  icon: const Icon(Icons.home),
                ),
                GiIconBox(
                  color: 'success',
                  icon: const Icon(Icons.check),
                ),
                GiIconBox(
                  color: 'warning',
                  icon: const Icon(Icons.warning),
                ),
                GiIconBox(
                  color: 'danger',
                  icon: const Icon(Icons.error),
                ),
                GiIconBox(
                  color: 'info',
                  icon: const Icon(Icons.info),
                ),
                GiIconBox(
                  color: '#9C27B0',
                  icon: const Icon(Icons.favorite),
                ),
                GiIconBox(
                  color: '#FF9800',
                  icon: const Icon(Icons.star),
                ),
                GiIconBox(
                  color: '#795548',
                  icon: const Icon(Icons.settings),
                ),
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
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                GiIconBox(
                  color: '#4F6BF6',
                  size: 16,
                  icon: const Icon(Icons.edit),
                ),
                GiIconBox(
                  color: '#4F6BF6',
                  size: 20,
                  icon: const Icon(Icons.edit),
                ),
                GiIconBox(
                  color: '#4F6BF6',
                  size: 24,
                  icon: const Icon(Icons.edit),
                ),
                GiIconBox(
                  color: '#4F6BF6',
                  size: 28,
                  icon: const Icon(Icons.edit),
                ),
                GiIconBox(
                  color: '#4F6BF6',
                  size: 32,
                  icon: const Icon(Icons.edit),
                ),
                GiIconBox(
                  color: '#4F6BF6',
                  size: 40,
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 不同形状变体卡片
  Widget _buildShapeVariantsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '不同形状',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                GiIconBox(
                  color: '#4F6BF6',
                  shape: 'square',
                  icon: const Icon(Icons.edit),
                ),
                GiIconBox(
                  color: '#62C558',
                  shape: 'round',
                  icon: const Icon(Icons.check),
                ),
                GiIconBox(
                  color: '#1677FF',
                  shape: 'square',
                  size: 32,
                  icon: const Icon(Icons.download),
                ),
                GiIconBox(
                  color: 'danger',
                  shape: 'round',
                  size: 32,
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 可点击卡片
  Widget _buildClickableCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '可点击',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                GiIconBox(
                  color: '#4F6BF6',
                  icon: const Icon(Icons.edit),
                  onTap: () => _showMessage('点击了编辑'),
                ),
                GiIconBox(
                  color: '#62C558',
                  icon: const Icon(Icons.check),
                  onTap: () => _showMessage('点击了确认'),
                ),
                GiIconBox(
                  color: '#1677FF',
                  icon: const Icon(Icons.download),
                  onTap: () => _showMessage('点击了下载'),
                ),
                GiIconBox(
                  color: 'danger',
                  icon: const Icon(Icons.delete),
                  onTap: () => _showMessage('点击了删除'),
                ),
              ],
            ),
          ],
        ),
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
