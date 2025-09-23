
import 'package:book_store_server/src/web/components/built_with_serverpod_page.dart';
import 'package:serverpod/serverpod.dart';

class RootRoute extends WidgetRoute {
  @override
  Future<TemplateWidget> build(Session session, Request request) async {
    return BuiltWithServerpodPageWidget();
  }
}
