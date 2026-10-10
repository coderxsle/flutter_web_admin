import 'package:get/get.dart';

import '../controller/bazi_controller.dart';

class BaziInputBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind<BaziInputController>.builder(
          create: (_) => BaziInputController(),
          autoRemove: false,
        ),
      ];
}
