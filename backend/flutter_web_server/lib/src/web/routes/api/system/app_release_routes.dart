import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import '../../../../services/system/app_release_service.dart';
import '../delegate_utils.dart';
import '../serverpod_envelope.dart';

/// 后台版本发布管理接口（JWT + 当前租户隔离）。
void registerAppReleaseRoutes(Serverpod pod) {
  const envelope = ServerpodEnvelopeBuilder();
  final routes = <String, ActionRoute>{
    '/api/app/release/getList': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) => AppReleaseService.list(
        session,
        platform: request.queryString('platform'),
        channel: request.queryString('channel'),
        status: request.queryString('status'),
        keyword: request.queryString('keyword'),
        page: request.queryInt('page') ?? 1,
        pageSize: request.queryInt('pageSize') ?? request.queryInt('size') ?? 20,
      ),
    ),
    '/api/app/release/getDetail': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) => AppReleaseService.detail(session, request.queryId()),
    ),
    '/api/app/release/create': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      successStatus: 201,
      handler: (session, request) async => AppReleaseService.create(session, await request.jsonObjectBody()),
    ),
    '/api/app/release/update': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async => AppReleaseService.update(session, await request.jsonObjectBody()),
    ),
    '/api/app/release/upload': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      successStatus: 201,
      handler: (session, request) async {
        final id = request.queryInt('id');
        if (id == null || id <= 0) throw RestException.badRequest('缺少合法的 id');
        final name = request.queryString('name');
        if (name == null) throw RestException.badRequest('缺少上传文件名');
        return AppReleaseService.upload(
          session,
          id: id,
          fileName: name,
          bytes: request.read(maxLength: AppReleaseService.maxPackageBytes + 1024 * 1024),
        );
      },
    ),
    '/api/app/release/publish': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final id = asIntOrNull(body['id']);
        if (id == null || id <= 0) throw RestException.badRequest('请求体缺少合法的 id');
        final publishAt = body['publishAt'] == null ? null : DateTime.tryParse(body['publishAt'].toString());
        if (body['publishAt'] != null && publishAt == null) throw RestException.badRequest('publishAt 必须是 ISO8601 时间');
        return AppReleaseService.publish(
          session,
          id: id,
          rolloutPercent: asIntOrNull(body['rolloutPercent']) ?? 100,
          forceUpdate: body['forceUpdate'] == true,
          publishAt: publishAt,
        );
      },
    ),
    '/api/app/release/changeStatus': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final id = asIntOrNull(body['id']);
        if (id == null || id <= 0) throw RestException.badRequest('请求体缺少合法的 id');
        return AppReleaseService.changeStatus(session, id: id, status: requiredText(body, 'status'));
      },
    ),
    '/api/app/release/delete': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        return AppReleaseService.delete(session, extractSingleId(body));
      },
    ),
    '/api/app/policy/get': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) => AppReleaseService.getPolicy(
        session,
        platform: request.queryString('platform'),
        channel: request.queryString('channel'),
      ),
    ),
    '/api/app/policy/update': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async => AppReleaseService.updatePolicy(session, await request.jsonObjectBody()),
    ),
  };
  routes.forEach((path, route) => pod.webServer.addRoute(route, path));
}
