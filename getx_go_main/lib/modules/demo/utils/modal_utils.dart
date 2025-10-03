import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_go_main/components/add_user_form.dart';
import 'package:getx_go_main/components/button/gi_arco_button.dart';

/// 模态框工具类 - 提供编程式打开弹窗的方法
class ModalUtils {
  
  /// 打开添加用户的弹窗 - 方式1：工具函数方式
  /// 完全复制Vue.js版本的openAddUserModal函数逻辑
  static void openAddUserModal() {
    final formKey = GlobalKey<AddUserFormState>();
    
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          '添加用户',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: SizedBox(
          width: 500, // 增加弹窗宽度
          child: AddUserForm(key: formKey),
        ),
        actions: [
          // 取消按钮
          GiArcoButton(
            type: GiArcoButtonType.normal,
            size: GiArcoButtonSize.small,
            text: '取消',
            onPressed: () => Navigator.of(context).pop(),
          ),
          
          const SizedBox(width: 8),
          
          // 添加按钮
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
        
        // 对话框样式
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        actionsPadding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      ),
    );
  }

}
