import 'package:flutter/material.dart';
import 'common_buttons.dart';

/// 按钮组件使用示例
class ButtonExamples extends StatefulWidget {
  const ButtonExamples({super.key});

  @override
  State<ButtonExamples> createState() => _ButtonExamplesState();
}

class _ButtonExamplesState extends State<ButtonExamples> {
  bool _isLoading = false;

  void _simulateLoading() {
    setState(() {
      _isLoading = true;
    });
    
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('按钮组件示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 主要按钮
            _buildSection(
              '主要按钮 (PrimaryButton)',
              [
                PrimaryButton(
                  text: '保存',
                  icon: Icons.save,
                  onPressed: () => _showSnackBar('主要按钮被点击'),
                ),
                const SizedBox(height: 8),
                PrimaryButton(
                  text: '加载中...',
                  isLoading: _isLoading,
                  onPressed: _isLoading ? null : _simulateLoading,
                ),
                const SizedBox(height: 8),
                PrimaryButton(
                  text: '禁用状态',
                  onPressed: null,
                ),
                const SizedBox(height: 8),
                PrimaryButton(
                  text: '自定义样式',
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  borderRadius: 20,
                  width: 200,
                  onPressed: () => _showSnackBar('自定义样式按钮'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 次要按钮
            _buildSection(
              '次要按钮 (SecondaryButton)',
              [
                SecondaryButton(
                  text: '取消',
                  icon: Icons.cancel,
                  onPressed: () => _showSnackBar('次要按钮被点击'),
                ),
                const SizedBox(height: 8),
                SecondaryButton(
                  text: '编辑',
                  icon: Icons.edit,
                  borderColor: Colors.orange,
                  textColor: Colors.orange,
                  onPressed: () => _showSnackBar('编辑按钮'),
                ),
                const SizedBox(height: 8),
                SecondaryButton(
                  text: '禁用状态',
                  onPressed: null,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 文本按钮
            _buildSection(
              '文本按钮 (CustomTextButton)',
              [
                Row(
                  children: [
                    CustomTextButton(
                      text: '查看详情',
                      icon: Icons.visibility,
                      onPressed: () => _showSnackBar('查看详情'),
                    ),
                    const SizedBox(width: 16),
                    CustomTextButton(
                      text: '更多操作',
                      textColor: Colors.blue,
                      onPressed: () => _showSnackBar('更多操作'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 图标按钮
            _buildSection(
              '图标按钮 (CustomIconButton)',
              [
                Row(
                  children: [
                    CustomIconButton(
                      icon: Icons.favorite,
                      tooltip: '收藏',
                      onPressed: () => _showSnackBar('收藏'),
                    ),
                    const SizedBox(width: 8),
                    CustomIconButton(
                      icon: Icons.share,
                      tooltip: '分享',
                      backgroundColor: Colors.blue[50],
                      iconColor: Colors.blue,
                      onPressed: () => _showSnackBar('分享'),
                    ),
                    const SizedBox(width: 8),
                    CustomIconButton(
                      icon: Icons.settings,
                      tooltip: '设置',
                      onPressed: () => _showSnackBar('设置'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 危险按钮
            _buildSection(
              '危险按钮 (DangerButton)',
              [
                DangerButton(
                  text: '删除',
                  icon: Icons.delete,
                  onPressed: () => _showConfirmDialog(),
                ),
                const SizedBox(height: 8),
                DangerButton(
                  text: '重置',
                  onPressed: () => _showSnackBar('重置操作'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 浮动操作按钮
            _buildSection(
              '浮动操作按钮 (CustomFloatingActionButton)',
              [
                Center(
                  child: CustomFloatingActionButton(
                    icon: Icons.add,
                    tooltip: '添加新项目',
                    onPressed: () => _showSnackBar('添加新项目'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 组合使用示例
            _buildSection(
              '组合使用示例',
              [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '表单操作按钮组',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: SecondaryButton(
                              text: '取消',
                              onPressed: () => _showSnackBar('取消'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: PrimaryButton(
                              text: '保存',
                              icon: Icons.save,
                              onPressed: () => _showSnackBar('保存'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 100), // 底部留白
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这个项目吗？此操作不可撤销。'),
        actions: [
          SecondaryButton(
            text: '取消',
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 8),
          DangerButton(
            text: '删除',
            onPressed: () {
              Navigator.of(context).pop();
              _showSnackBar('项目已删除');
            },
          ),
        ],
      ),
    );
  }
}
