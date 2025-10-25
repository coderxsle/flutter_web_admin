import 'dart:io';
import 'package:flutter_web_server/src/web/components/built_with_serverpod_page.dart';
import 'package:serverpod/serverpod.dart';

class RootRoute extends WidgetRoute {
  @override
  Future<AbstractWidget> build(Session session, HttpRequest request) async {
    return BuiltWithServerpodPageWidget();
  }
}
