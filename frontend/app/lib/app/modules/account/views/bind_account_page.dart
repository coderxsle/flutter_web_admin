import 'package:auto_shop_server/app/modules/account_manager/account_manager.dart';
import 'package:auto_shop_server/app/utils/common_widget/common_widget.dart';
import 'package:auto_shop_server/app/utils/common_widget/my_dialog.dart';
import 'package:auto_shop_server/common/widgets/navigator_title.dart';
import 'package:auto_shop_server/common/widgets/select_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BindAccountPage extends StatefulWidget {
  final ValueChanged<bool> callback;
  const BindAccountPage({super.key, required this.callback});

  @override
  State<BindAccountPage> createState() => _BindAccountPageState();
}

class _BindAccountPageState extends State<BindAccountPage> {
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  int? selectedCompanyId = 0;
  
  final companyVC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const NavigatorTitle("绑定账号"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 企业选择下拉框
 
            SelectValue("公司：", "请选择要绑定的公司名称", tec: companyVC, decoration: BoxDecorationRadius.allRadius(), onTap: () async {
              AccountManager.selectUnBindCompanyList(onSelected: (model) {
                setState(() {
                  selectedCompanyId = model.id;
                  companyVC.text = model.title ?? ""; 
                });
              });
            }),
            SizedBox(height: 16.h),
            // 手机号输入框
            TextField(
              controller: phoneCtrl,
              decoration: InputDecoration(
                labelText: '手机号',
                hintText: '请输入手机号',
                prefixIcon: const Icon(Icons.phone_android, color: Color(0xFFE53935)),
                labelStyle: TextStyle(color: Colors.grey[600]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.h),
            // 密码输入框
            TextField(
              controller: passwordCtrl,
              decoration: InputDecoration(
                labelText: '密码',
                hintText: '请输入密码',
                prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFE53935)),
                labelStyle: TextStyle(color: Colors.grey[600]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              obscureText: true,
            ),
            SizedBox(height: 32.h),
            // 绑定按钮
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              onPressed: _handleBind,
              child: Text(
                '绑定',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBind() async {
    if (selectedCompanyId == null) {
      // Get.snackbar('提示', '请选择企业');
      showMessage('请选择企业');
      return;
    }
    if (phoneCtrl.text.isEmpty) {
      // Get.snackbar('提示', '请输入手机号');
      showMessage('请输入手机号');
      return;
    }
    if (passwordCtrl.text.isEmpty) {
      // Get.snackbar('提示', '请输入密码');
      showMessage('请输入密码');
      return;
    }

    final result = await AccountManager.bindAccount(phoneCtrl.text, passwordCtrl.text, selectedCompanyId!);
    widget.callback(result);
  }

  @override
  void dispose() {
    phoneCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }


} 