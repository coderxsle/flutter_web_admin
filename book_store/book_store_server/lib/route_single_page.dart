import 'dart:io';

import 'package:serverpod/serverpod.dart';

/// 用于提供单页面应用的路由。
///
/// 该路由会为所有请求提供 `web/$appRootPath` 目录下的文件，  
/// 但前提是这些请求未匹配 `serverDirectory` 目录中的任何其他静态文件。
class RouteSinglePageApp extends RouteStaticDirectory {
  /// The path to the root file of the single page app.
  final String appRootFilePath;


  /// 创建单页面应用路由。
  ///
  /// [appRootPath] 是单页面应用根文件相对于 [serverDirectory] 的路径，默认为 'index.html'。
  RouteSinglePageApp({
    required super.serverDirectory,
    appRootPath = 'index.html',
    super.basePath,
    super.serveAsRootPath,
  }) : appRootFilePath = 'web/$serverDirectory/$appRootPath';

  @override
  Future<bool> handleCall(Session session, HttpRequest request) async {
    // 先尝试使用静态文件处理请求
    final staticFileFound = await super.handleCall(session, request);
    if (staticFileFound) {
      return staticFileFound;
    }

    try {
      // 如果没有找到匹配的静态文件，则返回 SPA 的根文件（通常是 index.html）
      var fileContents = await File(appRootFilePath).readAsBytes();
      request.response.add(fileContents);
      return true;
    } catch (_) {}

    return false;
  }
}