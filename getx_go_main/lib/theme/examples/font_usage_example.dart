import 'package:flutter/material.dart';
import '../config/typography_config.dart';
import '../config/font_config.dart';

/// 字体使用示例
/// 展示如何在实际项目中使用统一的字体配置系统
class FontUsageExample extends StatelessWidget {
  const FontUsageExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('字体配置示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================================================
            // 方式一：使用 Theme.of(context).textTheme (推荐)
            // ================================================
            _buildSection(
              '方式一：使用 Theme.textTheme (推荐)',
              [
                Text('Display Large - 超大标题', style: theme.textTheme.displayLarge),
                Text('Display Medium - 大标题', style: theme.textTheme.displayMedium),
                Text('Display Small - 标题', style: theme.textTheme.displaySmall),
                const SizedBox(height: 16),
                Text('Headline Large - 页面主标题', style: theme.textTheme.headlineLarge),
                Text('Headline Medium - 区域标题', style: theme.textTheme.headlineMedium),
                Text('Headline Small - 小标题', style: theme.textTheme.headlineSmall),
                const SizedBox(height: 16),
                Text('Title Large - 卡片标题', style: theme.textTheme.titleLarge),
                Text('Title Medium - 列表标题', style: theme.textTheme.titleMedium),
                Text('Title Small - 小标题', style: theme.textTheme.titleSmall),
                const SizedBox(height: 16),
                Text('Body Large - 长文本段落', style: theme.textTheme.bodyLarge),
                Text('Body Medium - 正文内容', style: theme.textTheme.bodyMedium),
                Text('Body Small - 辅助文本', style: theme.textTheme.bodySmall),
                const SizedBox(height: 16),
                Text('Label Large - 按钮文本', style: theme.textTheme.labelLarge),
                Text('Label Medium - 小按钮', style: theme.textTheme.labelMedium),
                Text('Label Small - 标签', style: theme.textTheme.labelSmall),
              ],
            ),

            const Divider(height: 48),

            // ================================================
            // 方式二：直接使用 TypographyConfig
            // ================================================
            _buildSection(
              '方式二：直接使用 TypographyConfig',
              [
                Text(
                  '自定义颜色的标题',
                  style: TypographyConfig.headlineMedium(
                    color: Colors.blue,
                  ),
                ),
                Text(
                  '自定义颜色的正文',
                  style: TypographyConfig.bodyMedium(
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const Divider(height: 48),

            // ================================================
            // 方式三：基于主题样式修改
            // ================================================
            _buildSection(
              '方式三：基于主题样式修改',
              [
                Text(
                  '加粗的正文',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '红色的标题',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.red,
                  ),
                ),
                Text(
                  '斜体文本',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),

            const Divider(height: 48),

            // ================================================
            // 特殊样式示例
            // ================================================
            _buildSection(
              '特殊样式',
              [
                Text(
                  'const code = "Hello World";',
                  style: TypographyConfig.code(
                    color: theme.colorScheme.primary,
                  ),
                ),
                Text(
                  '123,456.78',
                  style: TypographyConfig.numeric(
                    color: theme.colorScheme.secondary,
                  ),
                ),
                Text(
                  '强调文本',
                  style: TypographyConfig.emphasis(
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
            ),

            const Divider(height: 48),

            // ================================================
            // 中英文混排示例
            // ================================================
            _buildSection(
              '中英文混排',
              [
                Text(
                  'English and 中文混合显示',
                  style: theme.textTheme.headlineMedium,
                ),
                Text(
                  '这是一段包含 English words 的中文段落。Flutter 使用 ${FontConfig.primaryFont} 作为主字体，${FontConfig.chineseFont} 作为中文回退字体。',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),

            const Divider(height: 48),

            // ================================================
            // 实际应用场景
            // ================================================
            _buildSection(
              '实际应用场景',
              [
                // 卡片示例
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('卡片标题', style: theme.textTheme.titleLarge),
                        const SizedBox(height: 8),
                        Text(
                          '这是卡片的描述内容，使用 bodyMedium 样式',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '辅助信息',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 列表项示例
                ListTile(
                  leading: const Icon(Icons.star),
                  title: Text('列表标题', style: theme.textTheme.titleMedium),
                  subtitle: Text('列表描述', style: theme.textTheme.bodySmall),
                  trailing: Text('标签', style: theme.textTheme.labelSmall),
                ),

                const SizedBox(height: 16),

                // 按钮示例
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '提交按钮',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 48),

            // ================================================
            // 字体信息
            // ================================================
            _buildSection(
              '当前字体配置',
              [
                Text(
                  '主字体: ${FontConfig.primaryFont}',
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  '中文字体: ${FontConfig.chineseFont}',
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  '等宽字体: ${FontConfig.monoFont}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

