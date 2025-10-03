import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input/gi_input.dart';

/// 添加用户表单组件 - 完全复制Vue.js版本的样式和功能
class AddUserForm extends StatefulWidget {
  const AddUserForm({super.key});

  @override
  State<AddUserForm> createState() => AddUserFormState();
}

class AddUserFormState extends State<AddUserForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  // 中文正则表达式
  static final RegExp _chineseRegex = RegExp(r'^[\u4e00-\u9fa5]+$');
  // 手机号正则表达式
  static final RegExp _phoneRegex = RegExp(r'^1[3-9]\d{9}$');

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 用户名输入框
        GiInput(
          controller: _nameController,
          label: '用户名',
          placeholder: '请输入用户名',
          required: true,
          inputFormatters: [
            LengthLimitingTextInputFormatter(4),
          ],
          validator: _validateName,
        ),
        
        const SizedBox(height: 16),
        
        // 手机号输入框
        GiInput(
          controller: _phoneController,
          label: '手机号',
          placeholder: '请输入手机号',
          required: true,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            LengthLimitingTextInputFormatter(11),
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: _validatePhone,
        ),
      ],
    );
  }



  /// 验证姓名
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入姓名';
    }
    if (!_chineseRegex.hasMatch(value)) {
      return '只能是中文姓名';
    }
    if (value.length < 1 || value.length > 4) {
      return '名字最长不超过4个字符';
    }
    return null;
  }

  /// 验证手机号
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入手机号';
    }
    if (!_phoneRegex.hasMatch(value)) {
      return '手机号格式不正确';
    }
    return null;
  }

  /// 模拟保存用户API
  Future<bool> _saveUserApi() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  /// 处理添加用户
  Future<bool> handleAddUser() async {
    // 手动验证输入
    final nameError = _validateName(_nameController.text);
    final phoneError = _validatePhone(_phoneController.text);
    
    if (nameError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(nameError),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    
    if (phoneError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(phoneError),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    try {
      // 显示加载状态
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('正在添加用户...'),
            ],
          ),
        ),
      );

      await _saveUserApi();
      
      // 关闭加载对话框
      Navigator.of(context).pop();
      
      // 显示成功消息
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('用户添加成功！'),
          backgroundColor: Colors.green,
        ),
      );
      
      return true;
    } catch (e) {
      // 关闭加载对话框
      Navigator.of(context).pop();
      
      // 显示错误消息
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('添加用户失败：$e'),
          backgroundColor: Colors.red,
        ),
      );
      
      return false;
    }
  }
}
