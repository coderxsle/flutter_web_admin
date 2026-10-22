import 'package:get/get.dart';

import '../controller/zhongyi_billing_controller.dart';

/// 结算记录列表绑定：控制器随页面创建、随页面销毁。
class ZhongyiBillingBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind<ZhongyiBillingController>.builder(create: (_) => ZhongyiBillingController(), autoRemove: true),
      ];
}
