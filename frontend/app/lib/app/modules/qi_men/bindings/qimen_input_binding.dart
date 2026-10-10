import 'package:get/get.dart';

import '../controller/qimen_controller.dart';

class QiMenInputBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind<QiMenInputController>.builder(
          create: (_) => QiMenInputController(),
          autoRemove: false,
        ),
      ];
}
