import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {

    // bool token = GetStorage().read("token") ?? false;
    // if (!token) {
    //   debugPrint("route = $route"); // route = shop_cart
    //   return const RouteSettings(name: AppRouters.login);
    // }
    if (AppManager.userAccount == null || AppManager.currentShop == null) {
      debugPrint("AppManager.userAccount = ${AppManager.userAccount}");
      debugPrint("AppManager.currentShop = ${AppManager.currentShop}");
      debugPrint("AppManager.userAccount == null, RootMiddleWare 重定向到登录页面");
      return const RouteSettings(name: "/LoginAccountPage");
    }else {
      if (AppManager.activeAdvert != null) {
        // debugPrint("AppManager.activeAdvert != null RootMiddleWare 选择了广告界面");
        // return const RouteSettings(name: "/ActiveAdvertPage");
        return null;
      }else {
        // 不需要人脸认证了
        // if (AppManager.getAuthState() != true && AppManager.isFirstInstall != true) {
        //   debugPrint("AppManager.getAuthState != true 需要进行生物识别认证！");
        //   debugPrint("RootMiddleWare 选择了认证界面");
        //   return const RouteSettings(name: "/FaceAuthPage");
        // }else {
        //   debugPrint("AppManager.auth = true 不需要进行生物识别认证");
        //   // 正常跳转，不做处理
        //   debugPrint("RootMiddleWare 不做中间拦截处理，route = $route");
        //   // debugPrint("AppManager.userAccount == null, RootMiddleWare 选择了首页");
        //   // return const RouteSettings(name: AppRouter.index);
        //   return null;
        // }
        return null;
      }
    }
  }
}
