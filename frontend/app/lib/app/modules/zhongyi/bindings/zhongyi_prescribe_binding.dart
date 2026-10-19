import 'package:get/get.dart';

import '../controller/zhongyi_prescribe_controller.dart';

/// 开方结算页绑定：控制器随页面创建、随页面销毁，避免再次进入时残留上一张方。
class ZhongyiPrescribeBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind<ZhongyiPrescribeController>.builder(create: (_) => ZhongyiPrescribeController(), autoRemove: true),
      ];
}
