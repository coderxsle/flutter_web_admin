import 'package:serverpod/serverpod.dart';

/// 一个用于显示 Serverpod 版本和当前运行模式的组件。
/// 它使用 built_with_serverpod.html 模板来渲染页面。
/// [name] 属性应与服务器 web/templates 目录下的模板文件名对应。
class BuiltWithServerpodPageWidget extends Widget {
  BuiltWithServerpodPageWidget() : super(name: 'built_with_serverpod') {
    values = {'served': DateTime.now(), 'runmode': Serverpod.instance.runMode};
  }
}