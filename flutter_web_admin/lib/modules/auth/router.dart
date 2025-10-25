import 'package:getx_go/getx_go.dart';
import 'package:flutter/material.dart';
import 'controller.dart';
import 'login_page.dart';

class LoginRouter extends RouteControllerConfig {
  @override
  GetxGoBuilder builder() {
    return (context, state) {
      return ControllerBindingEntry(
        controllers: [ControllerEntry<LoginController>(() => LoginController(), permanent: true)],
        view: () => const LoginPage(),
      );
    };
  }

  @override
  CustomTransitionBuilder? transitionsBuilder() {
    return (context, animation, secondaryAnimation, child) {
      // 淡入淡出动画，适合登录页面
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    };
  }

  @override
  Duration? transitionDuration() {
    return const Duration(milliseconds: 300);
  }
}
