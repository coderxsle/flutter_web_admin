import 'package:getx_go/getx_go.dart';
import 'package:getx_go_main/modules/home/controllers/home_controller.dart';
import 'package:getx_go_main/modules/home/views/home_view.dart';

class HomeRouter extends RouteControllerConfig {
  @override
  GetxGoBuilder builder() {
    return (context, state) {
      return ControllerBindingEntry(
        controllers: [ControllerEntry<HomeController>(() => HomeController(), permanent: true)],
        view: () => const HomeView(),
      );
    };
  }
}
