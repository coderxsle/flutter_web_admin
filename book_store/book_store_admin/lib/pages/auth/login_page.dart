import 'package:book_store_client/book_store_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../global/global.dart';
import '../../services/api_service.dart';
import '../../utils/message_util.dart';

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
      showInfo(Get.context!, '用户名和密码不能为空');
      return;
    }

    isLoading.value = true;
    EasyLoading.show(status: '登录中...');

    try {
      final result = await _apiService.login(username, password);
      EasyLoading.dismiss();
      if (result.isSuccess) {   
        LoginResponse model = LoginResponse.fromJson(result.data);
        await Global.setToken(model.token);
        await Global.setUserInfo(model.toJson());
        Get.offAllNamed('/books');
      } else {
        showError(Get.context!, result.message ?? '登录失败');
      }
    } catch (e) {
      EasyLoading.dismiss();
      showError(Get.context!, '登录失败: ${e.toString()}');
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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(LoginController());
  bool _obscurePassword = true;

  void _handleSubmit() {
    if (_formKey.currentState!.validate() && !_controller.isLoading.value) {
      _controller.login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 12, 79, 124).withOpacity(0.8),  // 柔和的蓝色
              const Color.fromARGB(255, 38, 58, 77),  // 深蓝灰色
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo和标题
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.book,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '爱自然生命力',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '图书库存管理系统',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  // 登录表单
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _controller.usernameController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: '用户名',
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '请输入用户名';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _controller.passwordController,
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (_) => _handleSubmit(),
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: '密码',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '请输入密码';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          Obx(() => SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _controller.isLoading.value ? null : _handleSubmit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[700],
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _controller.isLoading.value
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text('登录'),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
} 