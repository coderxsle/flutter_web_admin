import 'package:getx_go/getx_go.dart';
import 'package:flutter/material.dart';
import '../controllers/layout_admin_controller.dart';
import '../pages/layout_admin_page.dart';

class LayoutAdminRouter extends RouteControllerConfig {
  @override
  GetxGoBuilder builder() {
    return (context, state) {
      return ControllerBindingEntry(
        controllers: [ControllerEntry<LayoutAdminController>(() => LayoutAdminController(), permanent: true)],
        view: () => const LayoutAdminPage(),
      );
    };
  }

  @override
  CustomTransitionBuilder? transitionsBuilder() {
    return (context, animation, secondaryAnimation, child) {
      // 从小到大的缩放动画效果，适合 web admin 项目
      const begin = 0.0;
      const end = 1.0;
      const curve = Curves.easeInOut;
      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      
      return ScaleTransition(
        scale: animation.drive(tween),
        child: child,
      );
    };
  }

  @override
  Duration? transitionDuration() {
    return const Duration(milliseconds: 300);
  }
}
