import 'package:serverpod/serverpod.dart';

/// 一个用于显示页面生成时间和当前运行模式的组件。
/// 它使用 index.html 模板来渲染页面。
/// [name] 属性应与服务器 web/templates 目录下的模板文件名对应。
class ServerpodPageWidget extends TemplateWidget {
  ServerpodPageWidget() : super(name: 'index') {
    values = {'served': DateTime.now(), 'runmode': Serverpod.instance.runMode};
  }
}

class ServerpodPageRoute extends WidgetRoute {
  @override
  Future<WebWidget> build(Session session, Request request) async => ServerpodPageWidget();
}

