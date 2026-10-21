import 'package:get/get.dart';

import '../controller/arts_history_controller.dart';

/// 奇门 / 八字历史页各注入一个控制器；退出即销毁，下次进入重新拉数据
class ArtsHistoryBinding extends Binding {
  ArtsHistoryBinding(this.artsType);

  /// [ArtsRecordType.qimen] / [ArtsRecordType.bazi]
  final String artsType;

  @override
  List<Bind> dependencies() => [
        Bind<ArtsHistoryController>.builder(
          create: (_) => ArtsHistoryController(artsType),
          autoRemove: true,
        ),
      ];
}
