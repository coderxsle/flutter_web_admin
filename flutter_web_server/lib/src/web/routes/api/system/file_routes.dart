import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import '../../../../services/system/file_service.dart';
import '../delegate_utils.dart';
import '../serverpod_envelope.dart';

void registerFileRoutes(Serverpod pod) {
  const envelope = ServerpodEnvelopeBuilder();
  final routes = <String, ActionRoute>{
    '/api/file/getFileList': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) => FileService.getFileList(
        session,
        parentId: request.queryInt('parentId'),
        fileType: request.queryString('fileType'),
        keyword: request.queryString('keyword'),
      ),
    ),
    '/api/file/getDetail': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) => FileService.getDetail(session, request.queryId()),
    ),
    '/api/file/getTree': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) => FileService.getTree(session),
    ),
    '/api/file/getUsage': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) => FileService.getUsage(session),
    ),
    '/api/file/createFolder': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      successStatus: 201,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        return FileService.createFolder(
          session,
          parentId: asIntOrNull(body['parentId']),
          name: requiredText(body, 'name'),
        );
      },
    ),
    '/api/file/upload': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      successStatus: 201,
      handler: (session, request) async {
        final name = request.queryString('name');
        if (name == null) throw const RestException.badRequest('缺少上传文件名');
        final bytes = await _readBytes(request);
        final mimeType = request.headers['content-type']?.first.split(';').first.trim() ?? 'application/octet-stream';
        return FileService.upload(
          session,
          parentId: request.queryInt('parentId'),
          name: name,
          mimeType: mimeType,
          bytes: bytes,
        );
      },
    ),
    '/api/file/rename': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final id = asIntOrNull(body['id']);
        if (id == null || id <= 0) throw const RestException.badRequest('请求体缺少合法的 id');
        return FileService.rename(session, id: id, name: requiredText(body, 'name'));
      },
    ),
    '/api/file/move': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final id = asIntOrNull(body['id']);
        if (id == null || id <= 0) throw const RestException.badRequest('请求体缺少合法的 id');
        return FileService.move(session, id: id, targetParentId: asIntOrNull(body['targetParentId']));
      },
    ),
    '/api/file/delete': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final id = extractSingleId(body);
        return FileService.delete(session, id);
      },
    ),
    '/api/file/deleteBatch': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        return FileService.deleteBatch(session, requiredIntList(body, 'ids', aliases: const ['id']));
      },
    ),
  };
  routes.forEach((path, route) => pod.webServer.addRoute(route, path));
  pod.webServer.addRoute(FileContentRoute(download: false), '/api/file/preview');
  pod.webServer.addRoute(FileContentRoute(download: true), '/api/file/download');
}

Future<List<int>> _readBytes(Request request) async {
  final builder = BytesBuilder(copy: false);
  await for (final chunk in request.read(maxLength: 1024 * 1024 * 1024)) {
    builder.add(chunk);
  }
  return builder.takeBytes();
}

class FileContentRoute extends Route {
  FileContentRoute({required this.download}) : super(methods: const {Method.get});

  final bool download;

  @override
  Future<Result> handleCall(Session session, Request request) async {
    try {
      final id = request.queryId();
      final row = await FileService.getFileForDownload(session, id);
      final file = File('${FileService.storageRoot}/${row.storageKey}');
      final mimeType = MimeType.parse(row.mimeType ?? 'application/octet-stream');
      final contentDisposition = download ? 'attachment' : 'inline';
      final fileName = Uri.encodeComponent('${row.name}${row.extendName == null ? '' : '.${row.extendName}'}');
      final headers = Headers.build((values) {
        values['Content-Disposition'] = ["$contentDisposition; filename*=UTF-8''$fileName"];
        values['Cache-Control'] = ['private, max-age=3600'];
      });
      return Response(
        200,
        headers: headers,
        body: Body.fromDataStream(
          file.openRead().map(Uint8List.fromList),
          contentLength: await file.length(),
          mimeType: mimeType,
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
      session.log('文件内容读取失败：$error', level: LogLevel.error, exception: error, stackTrace: stackTrace);
      return Response(
        500,
        body: Body.fromString(jsonEncode({'code': 500, 'message': '文件读取失败'}), mimeType: MimeType.json),
      );
    }
  }
}
