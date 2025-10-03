import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_go_main/components/add_user_form.dart';
import '../utils/modal_utils.dart';
import 'package:getx_go_main/components/button/gi_arco_button.dart';

/// JS Modal Demo 页面 - 仿照Vue.js的js-modal示例
class GiJsModalPage extends StatelessWidget {
  final String title;
  
  const GiJsModalPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return _buildPageContainer(
      title: title,
      context: context,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 页面标题
              Text(
                'JS Modal 示例',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '演示两种不同方式打开模态框：',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              
              // 按钮区域
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                // 方式1按钮
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.small,
                  text: '打开添加用户弹窗(方式1)',
                  onPressed: _open1,
                ),
                
                // 方式2按钮
                GiArcoButton(
                  type: GiArcoButtonType.primary,
                  size: GiArcoButtonSize.small,
                  text: '打开添加用户弹窗(方式2)',
                  onPressed: _open2,
                ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // 说明文档
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '实现说明：',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('• 方式1：通过工具函数 openAddUserModal() 打开弹窗'),
                    const Text('• 方式2：直接调用 showDialog 并传入 AddUserForm 组件'),
                    const Text('• 表单验证：姓名仅支持中文，手机号格式验证'),
                    const Text('• 输入框样式：完全复制 Arco Design 的样式'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 方式1：使用工具函数打开弹窗
  void _open1() {
    ModalUtils.openAddUserModal();
  }

  /// 方式2：直接使用showDialog打开弹窗
  void _open2() {
    final formKey = GlobalKey<AddUserFormState>();
    
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('添加用户'),
        content: SizedBox(
          width: 500, // 增加弹窗宽度
          child: AddUserForm(key: formKey),
        ),
        actions: [
          GiArcoButton(
            type: GiArcoButtonType.normal,
            size: GiArcoButtonSize.small,
            text: '取消',
            onPressed: () => Navigator.of(context).pop(),
          ),
          
          const SizedBox(width: 8),
          
          GiArcoButton(
            type: GiArcoButtonType.primary,
            size: GiArcoButtonSize.small,
            text: '添加',
            onPressed: () async {
              final success = await formKey.currentState?.handleAddUser() ?? false;
              if (success) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  /// 页面容器
  Widget _buildPageContainer({
    required String title,
    required Widget child,
    required BuildContext context,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 页面标题
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Icon(
                  Icons.call_to_action,
                  size: 24,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          // 页面内容
          child,
        ],
      ),
    );
  }
}
