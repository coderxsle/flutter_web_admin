import 'package:book_store_server/server.dart';
import 'package:book_store_shared/book_store_shared.dart';

/// This is the starting point for your Serverpod server. Typically, there is
/// no need to modify this file.
void main(List<String> args) {
  LoggerTool.initLogger();
  run(args);
}
