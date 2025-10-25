import 'package:flutter_web_server/server.dart';
import 'package:flutter_web_shared/shared.dart';

/// This is the starting point for your Serverpod server. Typically, there is
/// no need to modify this file.
void main(List<String> args) {
  LoggerTool.initLogger();
  run(args);
}
