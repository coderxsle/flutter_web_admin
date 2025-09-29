import 'package:getx_go/getx_go.dart';
import '../controllers/layout_admin_controller.dart';
import '../pages/layout_admin_page.dart';

class LayoutAdminRouter extends RouteControllerConfig {
  @override
  GetxGoBuilder builder() {
    return (context, state) {
      return ControllerBindingEntry(
        controllers: [ControllerEntry<LayoutAdminController>(() => LayoutAdminController(), permanent: true)],
        view: () => const LayoutAdminPage(),
      );
    };
  }
}


