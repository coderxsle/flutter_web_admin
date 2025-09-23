import 'package:serverpod/serverpod.dart';

import 'package:book_store_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

// 这是 Serverpod 服务器的入口起点。大多数情况下，只有在你添加 Future Call、
// 配置 Relic（Serverpod 的 Web 服务器），或需要进行自定义初始化时，才需要
// 在这个文件中进行改动。

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  // 在网站根路径设置一个默认页面。
  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');
  // 提供 /static 目录下的所有静态文件服务。
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'web/static', basePath: '/'),
    '/*',
  );

  // 启动服务器。
  await pod.start();

  // 服务器启动后，你可以注册 Future Call。Future Call 是将在未来执行，或
  // 独立于请求/响应周期执行的任务。例如，你可以用它发送邮件，或调度延迟
  // 执行的任务。Future Call 在后台执行，其调度信息会持久化到数据库，因此
  // 即使服务器重启也不会丢失。

  // pod.registerFutureCall(
  //   BirthdayReminder(),
  //   FutureCallNames.birthdayReminder.name,
  // );

  // 你可以在启动期间安排稍后执行的 Future Call；也可以在任意 endpoint 或
  // web route 中通过 session 对象来调度。若想在指定时间执行，可使用
  // [futureCallAtTime]。
  // await pod.futureCallWithDelay(
  //   FutureCallNames.birthdayReminder.name,
  //   Greeting(
  //     message: 'Hello!',
  //     author: 'Serverpod Server',
  //     timestamp: DateTime.now(),
  //   ),
  //   Duration(seconds: 5),
  // );
}

/// 服务器中所有 Future Call 的名称。
///
/// 使用枚举优于直接写字符串字面量，这可降低拼写错误的风险，并使重构更容易。
enum FutureCallNames { birthdayReminder }
