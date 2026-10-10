import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

/// H5 与原生交互的通用桥接入口
/// 原业务相关的 handler（车辆详情、订单、图片下载等）已随业务模块移除，后续按新业务需要在此补充
class JavaScriptApi {
  JavaScriptApi._();

  static void register(InAppWebViewController controller) {
    // 关闭当前 H5 页面
    controller.addJavaScriptHandler(
      handlerName: 'closePage',
      callback: (args) {
        Get.back();
        return null;
      },
    );
  }
}
