import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../global/global.dart';
import '../../services/api_service.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    // 如果已经登录，直接跳转到首页
    if (Global.isLoggedIn) {
      Get.offAllNamed('/books');
    }
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        '错误',
        '用户名和密码不能为空',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[100],
      );
      return;
    }

    isLoading.value = true;
    EasyLoading.show(status: '登录中...');

    try {
      // 调用登录接口
      final response = await _apiService.login(username, password);
      
      // 保存token和用户信息
      // await Global.setToken(response.token);
      await Global.setUserInfo(response.toJson());

      // print('response: ${response.toJson()}');


      EasyLoading.dismiss();
      // Get.offAllNamed('/books');

      EasyLoading.showSuccess(response.toJson().toString());

    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        '登录失败',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[100],
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: Center(
        child: Container(
          width: 400.w,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '书店后台管理系统',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.h),
              TextField(
                controller: controller.usernameController,
                decoration: const InputDecoration(
                  labelText: '用户名',
                  prefixIcon: Icon(Icons.person),
                ),
                onSubmitted: (_) => controller.login(),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: '密码',
                  prefixIcon: Icon(Icons.lock),
                ),
                onSubmitted: (_) => controller.login(),
              ),
              SizedBox(height: 30.h),
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.login,
                      child: controller.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('登录'),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
} 