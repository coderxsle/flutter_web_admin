import 'package:flutter_web_admin_server/server.dart';
import 'package:flutter_web_admin_shared/flutter_web_admin_shared.dart';

/// This is the starting point for your Serverpod server. Typically, there is
/// no need to modify this file.
void main(List<String> args) {
  LoggerTool.initLogger();
  run(args);
}
