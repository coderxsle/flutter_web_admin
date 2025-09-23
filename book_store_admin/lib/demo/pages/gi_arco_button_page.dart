// import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:book_store_admin/components/gi_arco.dart';


/// ArcoDesign 风格的按钮展示页面 - 完全还原 Vue demo
class GiArcoButtonDemoPage extends StatelessWidget {
  const GiArcoButtonDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArcoDesign 按钮展示'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 第一组：基础按钮类型（蓝色系）
            _buildButtonRow([
              GiArcoButton(type: GiArcoButtonType.primary, text: 'Primary', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.normal, text: 'Default', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, text: 'Dashed', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, text: 'Outline', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.text, text: 'Text', onPressed: _onButtonTap),
            ]),
            const SizedBox(height: 8),
            
            // 第二组：Success 状态按钮（绿色系）
            _buildButtonRow([
              GiArcoButton(type: GiArcoButtonType.primary, status: GiArcoButtonStatus.success, text: 'Primary', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.success, text: 'Default', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.success, text: 'Dashed', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.success, text: 'Outline', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.text, status: GiArcoButtonStatus.success, text: 'Text', onPressed: _onButtonTap),
            ]),
            const SizedBox(height: 8),
            
            // 第三组：Warning 状态按钮（橙色系）
            _buildButtonRow([
              GiArcoButton(type: GiArcoButtonType.primary, status: GiArcoButtonStatus.warning, text: 'Primary', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.warning, text: 'Default', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.warning, text: 'Dashed', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.warning, text: 'Outline', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.text, status: GiArcoButtonStatus.warning, text: 'Text', onPressed: _onButtonTap),
            ]),
            const SizedBox(height: 8),
            
            // 第四组：Danger 状态按钮（红色系）
            _buildButtonRow([
              GiArcoButton(type: GiArcoButtonType.primary, status: GiArcoButtonStatus.danger, text: 'Primary', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.danger, text: 'Default', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.danger, text: 'Dashed', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.danger, text: 'Outline', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.text, status: GiArcoButtonStatus.danger, text: 'Text', onPressed: _onButtonTap),
            ]),
            
            const SizedBox(height: 20),
            
            // 禁用状态按钮组
            _buildButtonRow([
              GiArcoButton(type: GiArcoButtonType.primary, text: 'Primary', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, text: 'Default', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, text: 'Dashed', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, text: 'Outline', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.text, text: 'Text', disabled: true, onPressed: _onButtonTap),
            ]),
            
            const SizedBox(height: 8),
            
            _buildButtonRow([
              GiArcoButton(type: GiArcoButtonType.primary, status: GiArcoButtonStatus.success, text: 'Primary', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.success, text: 'Default', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.success, text: 'Dashed', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.success, text: 'Outline', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.text, status: GiArcoButtonStatus.success, text: 'Text', disabled: true, onPressed: _onButtonTap),
            ]),
            const SizedBox(height: 8),
            
            _buildButtonRow([
              GiArcoButton(type: GiArcoButtonType.primary, status: GiArcoButtonStatus.warning, text: 'Primary', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.warning, text: 'Default', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.warning, text: 'Dashed', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.warning, text: 'Outline', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.text, status: GiArcoButtonStatus.warning, text: 'Text', disabled: true, onPressed: _onButtonTap),
            ]),
            const SizedBox(height: 8),
            
            _buildButtonRow([
              GiArcoButton(type: GiArcoButtonType.primary, status: GiArcoButtonStatus.danger, text: 'Primary', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.danger, text: 'Default', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.danger, text: 'Dashed', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.danger, text: 'Outline', disabled: true, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.text, status: GiArcoButtonStatus.danger, text: 'Text', disabled: true, onPressed: _onButtonTap),
            ]),
            
            const SizedBox(height: 20),
            
            // 形状和图标按钮 - 蓝色系
            _buildButtonRow([
              GiArcoButton(type: GiArcoButtonType.primary, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.primary, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.primary, icon: Icons.add, onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.primary, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.primary, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),

              GiArcoButton(type: GiArcoButtonType.secondary, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),

              GiArcoButton(type: GiArcoButtonType.dashed, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),

              GiArcoButton(type: GiArcoButtonType.outline, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),
              
            ]),

            // 形状和图标按钮 - 绿色系
            _buildButtonRow([
              GiArcoButton(status: GiArcoButtonStatus.success, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(status: GiArcoButtonStatus.success, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(status: GiArcoButtonStatus.success, icon: Icons.add, onPressed: _onButtonTap),
              GiArcoButton(status: GiArcoButtonStatus.success, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(status: GiArcoButtonStatus.success, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),

              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.success, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.success, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.success, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.success, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),

              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.success, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.success, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.success, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.success, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),
              
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.success, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.success, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.success, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.success, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),
            ]),

            // 形状和图标按钮 - 橙色系
            _buildButtonRow([
              GiArcoButton(status: GiArcoButtonStatus.warning, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(status: GiArcoButtonStatus.warning, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(status: GiArcoButtonStatus.warning, icon: Icons.add, onPressed: _onButtonTap),
              GiArcoButton(status: GiArcoButtonStatus.warning, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(status: GiArcoButtonStatus.warning, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),

              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.warning, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.warning, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.warning, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.warning, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),

              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.warning, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.warning, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.warning, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.warning, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),
              
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.warning, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.warning, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.warning, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.warning, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),
            ]),

            // 形状和图标按钮 - 红色系
            _buildButtonRow([
              GiArcoButton(status: GiArcoButtonStatus.danger, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(status: GiArcoButtonStatus.danger, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(status: GiArcoButtonStatus.danger, icon: Icons.add, onPressed: _onButtonTap),
              GiArcoButton(status: GiArcoButtonStatus.danger, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(status: GiArcoButtonStatus.danger, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),

              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.danger, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.danger, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.danger, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.secondary, status: GiArcoButtonStatus.danger, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),

              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.danger, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.danger, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.danger, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.dashed, status: GiArcoButtonStatus.danger, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),
              
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.danger, text: 'Square', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.danger, shape: GiArcoButtonShape.round, text: 'Round', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.danger, shape: GiArcoButtonShape.rect, icon: Icons.add, text: '', onPressed: _onButtonTap),
              GiArcoButton(type: GiArcoButtonType.outline, status: GiArcoButtonStatus.danger, shape: GiArcoButtonShape.circle, icon: Icons.add, onPressed: _onButtonTap),
            ]),
            const SizedBox(height: 20),
            
            // 按钮组
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GiButtonGroup(
                  children: [
                    ElevatedButton(
                      onPressed: _onButtonTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text('Publish'),
                    ),
                    ElevatedButton(
                      onPressed: _onButtonTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        fixedSize: const Size(32, 32),
                        minimumSize: const Size(32, 32),
                      ),
                      child: const Icon(Icons.keyboard_arrow_down, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                GiButtonGroup(
                  children: [
                    ElevatedButton(
                      onPressed: _onButtonTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text('Publish'),
                    ),
                    ElevatedButton(
                      onPressed: _onButtonTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        fixedSize: const Size(32, 32),
                        minimumSize: const Size(32, 32),
                      ),
                      child: const Icon(Icons.more_horiz, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                GiButtonGroup(
                  children: [
                    ElevatedButton(
                      onPressed: _onButtonTap,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, // 文字颜色
                        shadowColor: Colors.transparent, // 阴影颜色
                        backgroundColor: const Color(0xFF165DFF), // 背景颜色
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.chevron_left, size: 16),
                          Text('Prev'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _onButtonTap,
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF165DFF),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Next'),
                          Icon(Icons.chevron_right, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建按钮行
  Widget _buildButtonRow(List<GiArcoButton> buttons) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: buttons,
      ),
    );
  }
  
  /// 按钮点击回调
  void _onButtonTap() {
    GiArcoMessage.success('请求成功啦，哈哈~');
  }
}
