import 'package:flutter/material.dart';
import 'package:flutter_web_admin/components/gi_arco.dart';

/// GiSpace 组件演示页面
/// 
/// 展示 GiSpace 组件的各种使用方式和布局效果
class GiSpaceDemoPage extends StatefulWidget {
  final String title;
  const GiSpaceDemoPage({super.key, required this.title});

  @override
  State<GiSpaceDemoPage> createState() => _GiSpaceDemoPageState();
}

class _GiSpaceDemoPageState extends State<GiSpaceDemoPage> {
  /// 控制动态按钮的显示/隐藏
  bool _showDynamicButton = true;

  /// 处理动态增删按钮点击
  void _onDynamicButtonClick() {
    setState(() {
      _showDynamicButton = !_showDynamicButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 24, 8, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 页面标题
          Row(
            children: [
              Icon(
                Icons.view_module,
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
                  _buildHorizontalDirectionSection(),
                  const SizedBox(height: 24),
                  _buildVerticalDirectionSection(),
                  const SizedBox(height: 24),
                  _buildVerticalAlignCenterSection(),
                  const SizedBox(height: 24),
                  _buildVerticalAlignStartSection(),
                  const SizedBox(height: 24),
                  _buildVerticalAlignEndSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );  
  }

  /// 水平方向示例
  Widget _buildHorizontalDirectionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '水平方向',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  text: '动态增删按钮',
                  onPressed: _onDynamicButtonClick,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            GiSpace(
              children: [
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  text: '按钮',
                ),
                if (_showDynamicButton)
                  GiArcoButton(
                    type: GiArcoButtonType.primary,
                    status: GiArcoButtonStatus.success,
                    text: '按钮',
                  ),
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  status: GiArcoButtonStatus.warning,
                  text: '按钮',
                ),
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  status: GiArcoButtonStatus.danger,
                  text: '按钮',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 垂直方向示例
  Widget _buildVerticalDirectionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '垂直方向',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            GiSpace(
              direction: Axis.vertical,
              children: [
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.mini,
                  text: '按钮',
                ),
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.mini,
                  text: '按钮',
                ),
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.mini,
                  text: '按钮',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 垂直对齐-居中示例
  Widget _buildVerticalAlignCenterSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '垂直对齐-居中',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            GiSpace(
              children: [
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.mini,
                  text: '按钮',
                ),
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.mini,
                  text: '按钮',
                ),
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.large,
                  text: '按钮',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 垂直对齐-顶部示例
  Widget _buildVerticalAlignStartSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '垂直对齐-顶部',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            GiSpace(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.mini,
                  text: '按钮',
                ),
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.mini,
                  text: '按钮',
                ),
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.large,
                  text: '按钮',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 垂直对齐-底部示例
  Widget _buildVerticalAlignEndSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '垂直对齐-底部',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            GiSpace(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.mini,
                  text: '按钮',
                ),
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.mini,
                  text: '按钮',
                ),
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.large,
                  text: '按钮',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
