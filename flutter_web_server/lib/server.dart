import 'dart:io';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import 'package:flutter_web_server/src/web/routes/api/routes.dart';
import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';

/// 服务器中所有 Future Call 的名称。
///
/// 使用枚举优于直接写字符串字面量，这可降低拼写错误的风险，并使重构更容易。
enum FutureCallNames { birthdayReminder }

// 这是 Serverpod 服务器的入口起点。大多数情况下，只有在你添加 Future Call、
// 配置 Relic（Serverpod 的 Web 服务器），或需要进行自定义初始化时，才需要
// 在这个文件中进行改动。

void run(List<String> args) async {
  // 创建 Serverpod 实例，传入命令行参数、协议、端点和认证处理器。
  final pod = Serverpod(args, Protocol(), Endpoints(), authenticationHandler: authhandler);

  // 初始化认证服务，使用 JwtTokenManager 管理 accessToken / refreshToken。
  // 相关密钥需要在 passwords.yaml 中配置：
  // - jwtRefreshTokenHashPepper
  // - jwtHmacSha512PrivateKey
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      JwtConfig(
        refreshTokenHashPepper: pod.getPassword('jwtRefreshTokenHashPepper')!,
        algorithm: JwtAlgorithm.hmacSha512(SecretKey(pod.getPassword('jwtHmacSha512PrivateKey')!)),
        // 修改 access token 有效期，例如改为 1 小时
        accessTokenLifetime: Duration(hours: 1),
        // 可选：同时修改 refresh token 有效期
        refreshTokenLifetime: Duration(days: 14),
      ),
    ],
  );

  // 将 admin 前端应用挂载到网站根路径，访问 http://localhost:8082/ 即可打开。
  // 同时保留 /admin 入口，兼容已有书签或外部链接。
  RoutesManager.mountSpa(pod, '/', 'web/admin');
  RoutesManager.mountSpa(pod, '/admin', 'web/admin');
  RoutesManager.mountSpa(pod, '/templates', 'web/templates');

  // 注册 REST 表现层（`/api/**`）—— 全部接口的唯一入口（8082）。
  // 这一层不写任何 ORM 调用，全部委托给 services/system/ 下的 Service。
  // 详见 lib/src/web/routes/api/api_routes.dart。
  RoutesManager.registerApiRoutes(pod);

  // 每页请求上限的全局单点（框架默认 2000）。改这一处全项目生效，
  // 部署时可用 MAX_PAGE_SIZE 覆盖，别在资源级再各配一个。
  CrudConfig.maxPageSize = int.tryParse(Platform.environment['MAX_PAGE_SIZE'] ?? '') ?? CrudConfig.maxPageSize;

  // 启动服务器。
  await pod.start();

  /// 启动后打印 API 相关信息，方便开发者快速访问。
  _printApiInfo();

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

/// 认证处理器
///
/// 该函数在每次请求时被调用，用于验证请求中的 token，并返回相应的认证信息。
/// 你可以在这里实现自定义的认证逻辑，例如检查 token的有效性、从数据库中获取用户信息等。
/// 返回的 [AuthenticationInfo] 对象将被用于后续的请求处理，例如访问控制和权限检查。
Future<AuthenticationInfo?> authhandler(Session session, String token) async {
  final authInfo = await AuthServices.instance.tokenManager.validateToken(session, token);
  return authInfo;
}

// 启动后打印 API 相关信息，方便开发者快速访问。
void _printApiInfo() {
  const webBaseUrl = 'http://localhost:8082';
  const cyan = '\x1B[36m';
  const green = '\x1B[32m';
  const blue = '\x1B[34m';
  const reset = '\x1B[0m';

  stdout.writeln('----------------------------------------------------------');
  stdout.writeln('$cyan📚 服务入口：$reset');
  stdout.writeln('$green- Web 运行信息页:$reset $blue$webBaseUrl/$reset');
  stdout.writeln('$green- REST 接口前缀:$reset $blue$webBaseUrl/api$reset');
  stdout.writeln('$green- 健康检查(GET):$reset $blue$webBaseUrl/api/system/health$reset');
  stdout.writeln('$green- 版本信息(GET):$reset $blue$webBaseUrl/api/system/version$reset');
  stdout.writeln('----------------------------------------------------------');
}
