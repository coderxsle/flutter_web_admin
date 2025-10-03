import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'controller.dart';
import 'background.dart';
import 'dart:math';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          ServerpodBackground(
            // enableBubbles: false,
            // 是否显示动画 随机
            enableBubbles: Random().nextBool(),
            child: _buildLoginForm(context),
          ),
          // 左下角隐藏按钮
          // Positioned(
          //   left: 15,
          //   bottom: 15,
          //   child: GestureDetector(
          //     onTap: () {
          //       Get.toNamed(Routes.HOME2);
          //     },
          //     child: Container(
          //       width: 80,
          //       height: 80,
          //       decoration: BoxDecoration(
          //         color: Colors.white.withOpacity(0.1),
          //         shape: BoxShape.circle,
          //       ),
          //       child: Icon(
          //         Icons.home,
          //         size: 50,
          //         color: const Color.fromARGB(255, 154, 147, 147).withOpacity(0.2),
          //       ),
          //     ),
          //   ),
          // ),
          // 右下角隐藏按钮
          // Positioned(
          //   right: 15,
          //   bottom: 15,
          //   child: GestureDetector(
          //     onTap: () {
          //       Get.toNamed(Routes.HOME);
          //     },
          //     child: Container(
          //       width: 80,
          //       height: 80,
          //       decoration: BoxDecoration(
          //         color: Colors.white.withOpacity(0.1),
          //         shape: BoxShape.circle,
          //       ),
          //       child: Icon(
          //         Icons.mic,
          //         size: 50,
          //         color: const Color.fromARGB(255, 154, 147, 147).withOpacity(0.2),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final obscurePassword = true.obs;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo 和 标题
        Container(
          padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 63, 104, 224).withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/icons/app_icon.png', width: 100, height: 100),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'appName',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'appNameEn',
          style: TextStyle(
            fontSize: 28,
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'appNameIntro', 
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        
        const SizedBox(height: 18),
        // 登录表单
        Container(
          constraints: const BoxConstraints(maxWidth: 340),
          padding: const EdgeInsets.all(32),
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 80),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 20,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: controller.usernameController,
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
                Obx(() => TextFormField(
                  controller: controller.passwordController,
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (_) => _handleSubmit(formKey),
                  obscureText: obscurePassword.value,
                  decoration: InputDecoration(
                    labelText: '密码',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        obscurePassword.value = !obscurePassword.value;
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
                )),
                
                // 验证码区域
                Obx(() => controller.captchaEnabled.value 
                  ? Column(
                      children: [
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: controller.captchaController,
                                textInputAction: TextInputAction.go,
                                onFieldSubmitted: (_) => _handleSubmit(formKey),
                                decoration: InputDecoration(
                                  labelText: '验证码',
                                  prefixIcon: const Icon(Icons.security),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                ),
                                validator: (value) {
                                  if (controller.captchaEnabled.value && 
                                      (value == null || value.isEmpty)) {
                                    return '请输入验证码';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 48,
                                // 验证码加载中
                                child: controller.isCaptchaLoading.value
                                  ? const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                  : controller.captchaImage.value != null
                                    ? InkWell(
                                        onTap: controller.refreshCaptcha,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.memory(
                                            controller.captchaImage.value!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: controller.refreshCaptcha,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: const Center(
                                            child: Text(
                                              '点击刷新',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox()),
                  
                const SizedBox(height: 32),
                Obx(() => SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : () => _handleSubmit(formKey),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isLoading.value
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
    );
  }

  void _handleSubmit(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate() && !controller.isLoading.value) {
      controller.login2();
    }
  }
}
