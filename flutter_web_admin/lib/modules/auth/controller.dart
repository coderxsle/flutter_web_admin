import 'package:flutter_web_admin_client/flutter_web_admin_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_web_admin/api/client.dart';
import 'package:flutter_web_admin/app_manager.dart';
import 'package:flutter_web_admin/logger.dart';
import 'package:flutter_web_admin/message_utils.dart';
import 'package:flutter_web_admin/param_check.dart';
import 'package:flutter_web_admin/router/app_router.dart';
// import 'package:dang_gui_admin/api/login_api.dart';
// import 'package:dang_gui_admin/app_manager.dart';
// import 'package:dang_gui_admin/api/api_result_code.dart';
// import 'package:dang_gui_admin/models/login_res.dart';
// import 'package:dang_gui_admin/models/captcha_res.dart';
// import 'package:dang_gui_admin/utils/param_check.dart';
// import '../../routes/app_pages.dart';
// import '../../utils/message_utils.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final captchaController = TextEditingController();
  final isLoading = false.obs;
  
  // 验证码相关状态
  final captchaEnabled = false.obs;
  final captchaImage = Rx<Uint8List?>(null);
  final captchaUuid = ''.obs;
  final isCaptchaLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // if (kDebugMode) {
      usernameController.text = 'coderxslee';
      passwordController.text = 'asdfasdf';
    // }
    // 页面初始化时获取验证码
    // getCaptcha();
  }

  /// 获取验证码
  Future<void> getCaptcha() async {
    isCaptchaLoading.value = true;
    // try {
    //   final result = await UserApi.getCaptcha();
    //   if (result.success && result.data != null) {
    //     final captchaResponse = CaptchaRes.fromJson(result.data!);
    //     captchaEnabled.value = captchaResponse.captchaEnabled;
    //     captchaUuid.value = captchaResponse.uuid;
        
    //     // 解码base64图片
    //     if (captchaResponse.img.isNotEmpty) {
    //       try {
    //         captchaImage.value = base64Decode(captchaResponse.img);
    //       } catch (e) {
    //         showError('验证码图片解析失败');
    //       }
    //     }
    //   } else {
    //     showError(result.message ?? '获取验证码失败');
    //   }
    // } catch (e) {
    //   showError('获取验证码失败: ${e.toString()}');
    // } finally {
    //   isCaptchaLoading.value = false;
    // }
  }

  /// 刷新验证码
  Future<void> refreshCaptcha() async {
    captchaController.clear();
    await getCaptcha();
  }


  Future<void> login2() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final code = captchaEnabled.value ? captchaController.text.trim() : null;
    // final uuid = captchaEnabled.value ? captchaUuid.value : null;

    if (validate(username, '用户名不能为空')) return;
    if (validate(password, '密码不能为空')) return;
    // 如果启用了验证码，检查验证码是否输入
    if (captchaEnabled.value) {
      if (validate(code, '验证码不能为空')) return;
    }
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    // 确保在页面跳转前所有异步操作完成
    AppRouter.router.go(AppRoutes.home.path);
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final code = captchaEnabled.value ? captchaController.text.trim() : null;
    // final uuid = captchaEnabled.value ? captchaUuid.value : null;

    if (validate(username, '用户名不能为空')) return;
    if (validate(password, '密码不能为空')) return;
    // 如果启用了验证码，检查验证码是否输入
    if (captchaEnabled.value) {
      if (validate(code, '验证码不能为空')) return;
    }
    
    try {
      isLoading.value = true;
      final result = await serverpodClient.auth.login(username, password);
      if (result.isSuccess) {
        logger.i('Login response: ${result.data}');
        // LoginResponse loginResponse = 
        // final model = Login.fromJson(result.data);
        final model = LoginResponse.fromJson(result.data);
        AppManager.login(model, password: password);
        // 确保在页面跳转前所有异步操作完成
        AppRouter.router.go(AppRoutes.admin.path);
      } else {
        // 登录失败处理
        showError(result.message ?? '登录失败');
        // 如果启用了验证码，刷新验证码
        if (captchaEnabled.value) {
          await refreshCaptcha();
        }
      }
    } catch (e) {
      logger.e('Login error: $e');
      showError('登录失败: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    captchaController.dispose();
    super.onClose();
  }
}
