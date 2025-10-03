import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';


late Logger logger;


class LoggerTool {

  static jsonFormat(dynamic message) {
    final stack = indexOfStack();
    dynamic dataToFormat;
    if (message is String) {
      try {
        dataToFormat = json.decode(message); // 将 JSON 字符串解析为对象
      } catch (e) {
        dataToFormat = message; // 如果解析失败，直接使用原字符串
      }
    } else {
      dataToFormat = message;
    }
    var data = const JsonEncoder.withIndent('  ').convert(dataToFormat);
    if (kDebugMode) logger.i('$data\n$stack\n');
  }

  // 获取当前堆栈信息
  static String indexOfStack({int? index}) {
    final frames = StackTrace.current.toString().split('\n');
    final regex = RegExp(r'#\d+\s+(.+?):(\d+):(\d+)');
    final match = regex.firstMatch(frames[index??2]);
    if (match != null) {
      final filePath = match.group(1);
      final lineNumber = match.group(2);
      return '$filePath:$lineNumber)';
    }
    return "No relevant stack trace found!";
  }

  static initLogger() {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0, // Number of method calls to be displayed
        errorMethodCount: 8, // Number of method calls if stacktrace is provided
        // lineLength: 250, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        noBoxingByDefault:true,//不要打印框
        // Should each log print contain a timestamp
        dateTimeFormat: DateTimeFormat.none,
        // levelColors: {
        //   Level.debug: AnsiColor.fg(8),
        //   Level.info: AnsiColor.fg(2),
        //   Level.warning: AnsiColor.fg(3),
        //   Level.error: AnsiColor.fg(1),
        //   Level.off: AnsiColor.fg(1),
        // }
        // Level.trace: AnsiColor.fg(AnsiColor.grey(0.5)),
        // Level.debug: const AnsiColor.none(),
        // Level.info: const AnsiColor.fg(12),
        // Level.warning: const AnsiColor.fg(208),
        // Level.error: const AnsiColor.fg(196),
        // Level.fatal: const AnsiColor.fg(199),
      ),
    );
  }
}