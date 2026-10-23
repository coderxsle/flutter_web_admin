import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:path/path.dart' as path;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import '../../../../common/common.dart';
import '../../../../services/system/app_release_service.dart';
import '../../../../services/system/app_update_service.dart';
import '../serverpod_envelope.dart';

/// 客户端更新检测与安装包下载（全部匿名，下载地址靠签名 + 过期时间保护）。
void registerAppUpdateRoutes(Serverpod pod) {
  const envelope = ServerpodEnvelopeBuilder();
  final routes = <String, ActionRoute>{
    '/api/app/update/check': ActionRoute(
      methods: const {Method.post},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) async =>
          AppUpdateService.check(session, await request.jsonObjectBody(), origin: _origin(request)),
    ),
    '/api/app/update/latest': ActionRoute(
      methods: const {Method.get},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) async => AppUpdateService.latest(
        session,
        platform: request.queryString('platform') ?? 'android',
        channel: request.queryString('channel'),
        tenantId: request.queryInt('tenantId'),
      ),
    ),
    '/api/app/update/history': ActionRoute(
      methods: const {Method.get},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) async => AppUpdateService.history(
        session,
        platform: request.queryString('platform') ?? 'android',
        channel: request.queryString('channel'),
        tenantId: request.queryInt('tenantId'),
        limit: request.queryInt('limit') ?? 20,
      ),
    ),
  };
  routes.forEach((url, route) => pod.webServer.addRoute(route, url));
  pod.webServer.addRoute(AppPackageDownloadRoute(), '/api/app/update/download/:releaseId');
}

String _origin(Request request) {
  final proto = request.headers['x-forwarded-proto']?.first ?? 'https';
  final host = request.headers['x-forwarded-host']?.first ?? request.headers['host']?.first ?? 'localhost';
  return '$proto://$host';
}

/// 安装包下载：支持 Range/206，直接流式回包，不走 /api/file/download。
class AppPackageDownloadRoute extends Route {
  AppPackageDownloadRoute() : super(methods: const {Method.get});

  @override
  Future<Result> handleCall(Session session, Request request) async {
    try {
      final releaseId = request.pathId(key: #releaseId);
      final expires = request.queryInt('expires');
      final token = request.queryString('token');
      if (expires == null || token == null) throw RestException.badRequest('缺少下载凭证');
      final release = await AppUpdateService.findDownloadable(
        session,
        releaseId: releaseId,
        expires: expires,
        token: token,
      );

      final file = File(path.join(AppReleaseService.storageRoot, release.storageKey!));
      if (!await file.exists()) throw RestException(404, '安装包文件不存在', code: ResultCode.validateFailed.code);
      final length = await file.length();
      final range = _parseRange(request.headers['range']?.first, length);
      final start = range?.start ?? 0;
      final end = range?.end ?? length - 1;
      if (length == 0) throw RestException(404, '安装包文件为空', code: ResultCode.validateFailed.code);
      final contentLength = end - start + 1;
      final status = range == null ? 200 : 206;
      final fileName = Uri.encodeComponent(release.fileName ?? '${release.versionName}.apk');

      if (range == null) {
        try {
          await AppUpdateService.countDownload(session, releaseId);
        } catch (_) {}
      }
      return Response(
        status,
        headers: Headers.build((values) {
          values['Content-Type'] = ['application/vnd.android.package-archive'];
          values['Content-Disposition'] = ["attachment; filename*=UTF-8''$fileName"];
          values['Accept-Ranges'] = ['bytes'];
          values['Content-Length'] = ['$contentLength'];
          values['ETag'] = ['"${release.sha256 ?? release.versionCode}"'];
          values['Cache-Control'] = ['no-store'];
          if (status == 206) values['Content-Range'] = ['bytes $start-$end/$length'];
        }),
        body: Body.fromDataStream(
          file.openRead(start, end + 1).map(Uint8List.fromList),
          contentLength: contentLength,
          mimeType: MimeType.parse('application/vnd.android.package-archive'),
        ),
      );
    } on RestException catch (error) {
      return Response(
        error.httpStatus,
        body: Body.fromString(
          jsonEncode({'code': error.code ?? error.httpStatus, 'message': error.message}),
          mimeType: MimeType.json,
        ),
      );
    } catch (error, stackTrace) {
      session.log('安装包下载失败：$error', level: LogLevel.error, exception: error, stackTrace: stackTrace);
      return Response(
        500,
        body: Body.fromString(jsonEncode({'code': 500, 'message': '安装包下载失败'}), mimeType: MimeType.json),
      );
    }
  }

  _ByteRange? _parseRange(String? header, int length) {
    if (header == null || !header.startsWith('bytes=')) return null;
    final spec = header.substring('bytes='.length).split(',').first.trim();
    final parts = spec.split('-');
    if (parts.length != 2) return null;
    var start = 0;
    var end = length - 1;
    if (parts[0].isEmpty) {
      final suffix = int.tryParse(parts[1]);
      if (suffix == null || suffix <= 0) return null;
      start = max(length - suffix, 0);
    } else {
      final parsedStart = int.tryParse(parts[0]);
      if (parsedStart == null || parsedStart >= length) return null;
      start = parsedStart;
      if (parts[1].isNotEmpty) {
        final parsedEnd = int.tryParse(parts[1]);
        if (parsedEnd == null) return null;
        end = min(parsedEnd, length - 1);
      }
    }
    if (start > end) return null;
    return _ByteRange(start, end);
  }
}

class _ByteRange {
  const _ByteRange(this.start, this.end);

  final int start;
  final int end;
}
