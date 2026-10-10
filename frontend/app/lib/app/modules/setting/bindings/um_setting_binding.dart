import 'package:get/get.dart';

import '../controllers/um_setting_controller.dart';

//友盟消息推送设置-华为审核
class UmSettingBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        // autoRemove:false —— 与旧 Get.lazyPut 一致：注册后不随路由销毁
        Bind<UmSettingController>.builder(
          create: (_) => UmSettingController(),
          autoRemove: false,
        ),
      ];
}
