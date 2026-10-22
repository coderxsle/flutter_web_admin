import 'package:get/get.dart';

import '../controller/zhongyi_template_controller.dart';

/// 处方模板列表绑定：控制器随页面创建、随页面销毁。
class ZhongyiTemplateBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind<ZhongyiTemplateController>.builder(create: (_) => ZhongyiTemplateController(), autoRemove: true),
      ];
}
