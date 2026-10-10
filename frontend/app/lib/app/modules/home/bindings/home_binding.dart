import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        // autoRemove:false —— 与旧 Get.lazyPut 一致：注册后不随路由销毁
        Bind<HomeController>.builder(
          create: (_) => HomeController(),
          autoRemove: false,
        ),
      ];
}
