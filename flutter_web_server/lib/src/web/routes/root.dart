import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/web/components/built_with_serverpod_page.dart';

class RootRoute extends WidgetRoute {
  @override
  Future<WebWidget> build(Session session, Request request) async {
    return BuiltWithServerpodPageWidget();
  }
}
