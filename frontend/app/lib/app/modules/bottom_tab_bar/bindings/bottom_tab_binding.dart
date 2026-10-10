import 'package:auto_shop_server/app/modules/ba_zi/controller/bazi_controller.dart';
import 'package:auto_shop_server/app/modules/message/controller/message_controller.dart';
import 'package:auto_shop_server/app/modules/qi_men/controller/qimen_controller.dart';
import 'package:get/get.dart';

import '../controllers/bottom_tab_bar_controller.dart';

class BottomTabBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        // autoRemove:false —— 与旧 Get.lazyPut 一致：注册后不随路由销毁
        Bind<BottomTabBarController>.builder(
          create: (_) => BottomTabBarController(),
          autoRemove: false,
        ),
        Bind<MessageController>.builder(
          create: (_) => MessageController(),
          autoRemove: false,
        ),
        // 奇门 / 八字作为 Tab 根页面直接实例化，控制器需在此注册
        Bind<QiMenInputController>.builder(
          create: (_) => QiMenInputController(),
          autoRemove: false,
        ),
        Bind<BaziInputController>.builder(
          create: (_) => BaziInputController(),
          autoRemove: false,
        ),
      ];
}
