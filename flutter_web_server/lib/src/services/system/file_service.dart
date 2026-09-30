import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as path;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import '../../common/common.dart';

class FileService {
  static const _imageExtensions = {'jpg', 'jpeg', 'png', 'gif', 'webp', 'svg', 'bmp'};
  static const _documentExtensions = {'txt', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'pdf', 'md', 'csv'};
  static const _videoExtensions = {'mp4', 'webm', 'mov', 'avi', 'mkv'};
  static const _audioExtensions = {'mp3', 'wav', 'ogg', 'aac', 'flac', 'm4a'};
  static const _otherExtensions = {'zip', 'rar', '7z', 'css', 'js', 'ts', 'html', 'json', 'xml'};
  static const _maxUploadBytes = 1024 * 1024 * 1024;

  static final Random _random = Random.secure();

  static String get storageRoot =>
      Platform.environment['FILE_STORAGE_ROOT'] ?? path.join(Directory.current.path, 'data', 'files');

  static Future<Map<String, dynamic>> getFileList(
    Session session, {
    int? parentId,
    String? fileType,
    String? keyword,
  }) async {
    final scope = await _getScope(session);
    final rows = await InfraFile.db.find(
      session,
      where: (table) {
        Expression filter =
            table.tenantId.equals(scope.tenantId) & table.deleted.equals(false) & table.parentId.equals(parentId);
        final normalizedKeyword = keyword?.trim();
        if (normalizedKeyword != null && normalizedKeyword.isNotEmpty) {
          filter = filter & table.name.like('%$normalizedKeyword%');
        }
        final extensions = _extensionsFor(fileType);
        if (extensions != null) {
          filter = filter & table.extendName.inSet(extensions);
        }
        return filter;
      },
      orderByList: (table) => [table.isDir.desc(), table.name.asc(), table.id.asc()],
    );

    return {
      'total': rows.length,
      'records': [for (final row in rows) _toListItem(row)],
    };
  }

  static Future<Map<String, dynamic>> getDetail(Session session, int id) async {
    final scope = await _getScope(session);
    final row = await _findFile(session, scope, id);
    return _toDetail(row);
  }

  static Future<List<Map<String, dynamic>>> getTree(Session session) async {
    final scope = await _getScope(session);
    final rows = await InfraFile.db.find(
      session,
      where: (table) => table.tenantId.equals(scope.tenantId) & table.deleted.equals(false) & table.isDir.equals(true),
      orderByList: (table) => [table.path.asc(), table.name.asc(), table.id.asc()],
    );

    final nodes = <int, Map<String, dynamic>>{
      for (final row in rows)
        row.id!: {
          'id': row.id,
          'key': row.id.toString(),
          'title': row.name,
          'parentId': row.parentId,
          'children': <Map<String, dynamic>>[],
        },
    };
    final roots = <Map<String, dynamic>>[];
    for (final row in rows) {
      final node = nodes[row.id]!;
      final parent = row.parentId == null ? null : nodes[row.parentId];
      if (parent == null) {
        roots.add(node);
      } else {
        (parent['children'] as List<Map<String, dynamic>>).add(node);
      }
    }
    return roots;
  }

  static Future<Map<String, dynamic>> getUsage(Session session) async {
    final scope = await _getScope(session);
    final rows = await InfraFile.db.find(
      session,
      where: (table) => table.tenantId.equals(scope.tenantId) & table.deleted.equals(false) & table.isDir.equals(false),
    );
    final byType = <String, int>{'image': 0, 'document': 0, 'video': 0, 'audio': 0, 'other': 0};
    var used = 0;
    for (final row in rows) {
      used += row.size;
      final type = _categoryFor(row.extendName);
      byType[type] = (byType[type] ?? 0) + row.size;
    }
    final capacity =
        int.tryParse(Platform.environment['FILE_STORAGE_CAPACITY_BYTES'] ?? '') ?? 512 * 1024 * 1024 * 1024;
    return {'capacity': capacity, 'used': used, 'remaining': max(capacity - used, 0), 'byType': byType};
  }

  static Future<Map<String, dynamic>> createFolder(
    Session session, {
    required int? parentId,
    required String name,
  }) async {
    final scope = await _getScope(session);
    final normalizedName = _normalizeName(name);
    if (normalizedName.isEmpty) throw const RestException.badRequest('目录名称不能为空');
    final parent = await _findParent(session, scope, parentId);
    await _ensureSiblingAvailable(session, scope, parentId, normalizedName, null);
    final now = DateTime.now();
    final row = InfraFile(
      tenantId: scope.tenantId,
      configId: (await _ensureLocalConfig(session, scope)).id,
      parentId: parentId,
      name: normalizedName,
      isDir: true,
      path: _pathForParent(parent),
      type: 'dir',
      size: 0,
      creator: scope.creator,
      createTime: now,
      updater: scope.creator,
      updateTime: now,
      deleted: false,
    );
    final inserted = await InfraFile.db.insertRow(session, row);
    return _toDetail(inserted);
  }

  static Future<Map<String, dynamic>> upload(
    Session session, {
    required int? parentId,
    required String name,
    required String mimeType,
    required List<int> bytes,
  }) async {
    if (bytes.isEmpty) throw const RestException.badRequest('上传文件不能为空');
    if (bytes.length > _maxUploadBytes) throw const RestException.badRequest('单个文件不能超过 1 GB');

    final scope = await _getScope(session);
    final parent = await _findParent(session, scope, parentId);
    final safeName = _normalizeFileName(name);
    if (safeName.isEmpty) throw const RestException.badRequest('文件名称不能为空');
    final extendName = _extensionOf(safeName);
    final baseName = _baseNameOf(safeName);
    await _ensureSiblingAvailable(session, scope, parentId, baseName, extendName);

    final config = await _ensureLocalConfig(session, scope);
    final storageKey = _newStorageKey(scope.tenantId, extendName);
    final diskFile = File(path.join(storageRoot, storageKey));
    await diskFile.parent.create(recursive: true);
    try {
      await diskFile.writeAsBytes(bytes, flush: true);
      final now = DateTime.now();
      final row = InfraFile(
        tenantId: scope.tenantId,
        configId: config.id,
        parentId: parentId,
        name: baseName,
        isDir: false,
        path: _pathForParent(parent),
        storageKey: storageKey,
        type: _categoryFor(extendName),
        extendName: extendName.isEmpty ? null : extendName,
        mimeType: mimeType.trim().isEmpty ? 'application/octet-stream' : mimeType.trim(),
        size: bytes.length,
        creator: scope.creator,
        createTime: now,
        updater: scope.creator,
        updateTime: now,
        deleted: false,
      );
      final inserted = await InfraFile.db.insertRow(session, row);
      return _toDetail(inserted);
    } catch (_) {
      if (await diskFile.exists()) await diskFile.delete();
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> rename(Session session, {required int id, required String name}) async {
    final scope = await _getScope(session);
    final row = await _findFile(session, scope, id);
    final normalizedName = row.isDir ? _normalizeName(name) : _normalizeFileName(name);
    if (normalizedName.isEmpty) throw const RestException.badRequest('名称不能为空');
    final requestedExtendName = row.isDir ? null : _extensionOf(normalizedName);
    final newBaseName = row.isDir || requestedExtendName == null || requestedExtendName.isEmpty
        ? (row.isDir ? normalizedName : _baseNameOf(normalizedName))
        : _baseNameOf(normalizedName);
    final newExtendName = row.isDir
        ? null
        : (requestedExtendName == null || requestedExtendName.isEmpty ? row.extendName : requestedExtendName);
    await _ensureSiblingAvailable(session, scope, row.parentId, newBaseName, newExtendName, exceptId: id);
    final now = DateTime.now();
    final updated = await InfraFile.db.updateRow(
      session,
      row.copyWith(
        name: newBaseName,
        extendName: newExtendName,
        type: row.isDir ? 'dir' : _categoryFor(newExtendName),
        updater: scope.creator,
        updateTime: now,
      ),
    );
    if (row.isDir && row.id != null) {
      await _updateDescendantPaths(session, scope, updated);
    }
    return _toDetail(updated);
  }

  static Future<Map<String, dynamic>> move(Session session, {required int id, required int? targetParentId}) async {
    final scope = await _getScope(session);
    final row = await _findFile(session, scope, id);
    final targetParent = await _findParent(session, scope, targetParentId);
    if (row.parentId == targetParentId) return _toDetail(row);
    if (row.isDir && targetParentId != null && await _isDescendant(session, scope, row.id!, targetParentId)) {
      throw const RestException.badRequest('不能移动到当前目录或其子目录中');
    }
    await _ensureSiblingAvailable(session, scope, targetParentId, row.name, row.extendName, exceptId: id);
    final newPath = _pathForParent(targetParent);
    final now = DateTime.now();
    final updated = await InfraFile.db.updateRow(
      session,
      row.copyWith(parentId: targetParentId, path: newPath, updater: scope.creator, updateTime: now),
    );
    if (row.isDir && row.id != null) {
      await _updateDescendantPaths(session, scope, updated);
    }
    return _toDetail(updated);
  }

  static Future<Map<String, dynamic>> delete(Session session, int id) async {
    final scope = await _getScope(session);
    final row = await _findFile(session, scope, id);
    final rows = <InfraFile>[row];
    if (row.isDir && row.id != null) {
      rows.addAll(await _collectDescendants(session, scope, row.id!));
    }
    final now = DateTime.now();
    for (final item in rows) {
      if (!item.isDir && item.storageKey != null) {
        final diskFile = File(path.join(storageRoot, item.storageKey!));
        if (await diskFile.exists()) await diskFile.delete();
      }
      await InfraFile.db.updateRow(session, item.copyWith(deleted: true, updater: scope.creator, updateTime: now));
    }
    return {'id': id, 'deletedCount': rows.length};
  }

  static Future<Map<String, dynamic>> deleteBatch(Session session, List<int> ids) async {
    final successIds = <int>[];
    final failedIds = <int>[];
    for (final id in ids.toSet()) {
      try {
        await delete(session, id);
        successIds.add(id);
      } on RestException {
        failedIds.add(id);
      }
    }
    return {
      'total': successIds.length + failedIds.length,
      'successCount': successIds.length,
      'notFoundCount': failedIds.length,
      'successIds': successIds,
      'failedIds': failedIds,
    };
  }

  static Future<InfraFile> getFileForDownload(Session session, int id) async {
    final scope = await _getScope(session);
    final row = await _findFile(session, scope, id);
    if (row.isDir || row.storageKey == null) throw const RestException.badRequest('目录不支持文件下载');
    final diskFile = File(path.join(storageRoot, row.storageKey!));
    if (!await diskFile.exists()) throw const RestException.notFound('文件内容不存在');
    return row;
  }

  static Future<InfraFile> _findFile(Session session, _FileScope scope, int id) async {
    final row = await InfraFile.db.findFirstRow(
      session,
      where: (table) => table.id.equals(id) & table.tenantId.equals(scope.tenantId) & table.deleted.equals(false),
    );
    if (row == null) throw const RestException.notFound('文件不存在或已删除');
    return row;
  }

  static Future<InfraFile?> _findParent(Session session, _FileScope scope, int? parentId) async {
    if (parentId == null) return null;
    final parent = await _findFile(session, scope, parentId);
    if (!parent.isDir) throw const RestException.badRequest('目标位置不是目录');
    return parent;
  }

  static Future<void> _ensureSiblingAvailable(
    Session session,
    _FileScope scope,
    int? parentId,
    String name,
    String? extendName, {
    int? exceptId,
  }) async {
    final duplicate = await InfraFile.db.findFirstRow(
      session,
      where: (table) {
        Expression filter =
            table.tenantId.equals(scope.tenantId) &
            table.parentId.equals(parentId) &
            table.name.equals(name) &
            table.extendName.equals(extendName) &
            table.deleted.equals(false);
        if (exceptId != null) filter = filter & table.id.notEquals(exceptId);
        return filter;
      },
    );
    if (duplicate != null) throw const RestException.badRequest('同一目录下已存在同名文件');
  }

  static Future<InfraFileConfig> _ensureLocalConfig(Session session, _FileScope scope) async {
    final existing = await InfraFileConfig.db.findFirstRow(
      session,
      where: (table) => table.name.equals('local') & table.deleted.equals(false),
    );
    if (existing != null) return existing;
    final now = DateTime.now();
    final config = InfraFileConfig(
      name: 'local',
      storage: 1,
      description: '本地磁盘存储',
      master: true,
      config: jsonEncode({'root': storageRoot}),
      creator: scope.creator,
      createTime: now,
      updater: scope.creator,
      updateTime: now,
      deleted: false,
    );
    return InfraFileConfig.db.insertRow(session, config);
  }

  static Future<List<InfraFile>> _collectDescendants(Session session, _FileScope scope, int parentId) async {
    final children = await InfraFile.db.find(
      session,
      where: (table) =>
          table.tenantId.equals(scope.tenantId) & table.parentId.equals(parentId) & table.deleted.equals(false),
    );
    final result = <InfraFile>[];
    for (final child in children) {
      result.add(child);
      if (child.isDir && child.id != null) result.addAll(await _collectDescendants(session, scope, child.id!));
    }
    return result;
  }

  static Future<bool> _isDescendant(Session session, _FileScope scope, int sourceId, int targetId) async {
    if (sourceId == targetId) return true;
    var current = await _findFile(session, scope, targetId);
    while (current.parentId != null) {
      if (current.parentId == sourceId) return true;
      current = await _findFile(session, scope, current.parentId!);
    }
    return false;
  }

  static Future<void> _updateDescendantPaths(Session session, _FileScope scope, InfraFile parent) async {
    final children = await InfraFile.db.find(
      session,
      where: (table) =>
          table.tenantId.equals(scope.tenantId) & table.parentId.equals(parent.id) & table.deleted.equals(false),
    );
    final parentPath = _pathForParent(parent);
    final now = DateTime.now();
    for (final child in children) {
      final updatedPath = parentPath;
      await InfraFile.db.updateRow(session, child.copyWith(path: updatedPath, updateTime: now, updater: scope.creator));
      if (child.isDir && child.id != null) {
        final refreshedChild = child.copyWith(path: updatedPath);
        await _updateDescendantPaths(session, scope, refreshedChild);
      }
    }
  }

  static Future<_FileScope> _getScope(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw const RestException.unauthorized();
    final user = await SysUser.db.findFirstRow(
      session,
      where: (table) => table.authUserId.equals(authInfo.authUserId) & table.deleted.equals(false),
    );
    return _FileScope(tenantId: user?.tenantId ?? 0, creator: user?.username ?? authInfo.authUserId.toString());
  }

  static Map<String, dynamic> _toListItem(InfraFile row) => {
    'id': row.id,
    'parentId': row.parentId,
    'name': row.name,
    'extendName': row.extendName ?? '',
    'src': row.isDir ? '' : '/api/file/preview?id=${row.id}',
    'updateTime': row.updateTime.toLocal().toIso8601String(),
    'isDir': row.isDir,
    'filePath': row.path,
    'size': row.size,
    'mimeType': row.mimeType,
    'type': row.type,
  };

  static Map<String, dynamic> _toDetail(InfraFile row) => {
    ..._toListItem(row),
    'storageKey': row.storageKey,
    'creator': row.creator,
    'createTime': row.createTime.toLocal().toIso8601String(),
    'updater': row.updater,
    'sha256': row.sha256,
  };

  static Set<String>? _extensionsFor(String? fileType) {
    switch (int.tryParse(fileType ?? '0')) {
      case 1:
        return _imageExtensions;
      case 2:
        return _documentExtensions;
      case 3:
        return _videoExtensions;
      case 4:
        return _audioExtensions;
      case 5:
        return _otherExtensions;
      default:
        return null;
    }
  }

  static String _categoryFor(String? extendName) {
    final normalized = extendName?.toLowerCase() ?? '';
    if (_imageExtensions.contains(normalized)) return 'image';
    if (_documentExtensions.contains(normalized)) return 'document';
    if (_videoExtensions.contains(normalized)) return 'video';
    if (_audioExtensions.contains(normalized)) return 'audio';
    return 'other';
  }

  static String _pathForParent(InfraFile? parent) {
    if (parent == null) return '/';
    if (parent.path == '/') return '/${parent.name}';
    return '${parent.path}/${parent.name}';
  }

  static String _newStorageKey(int tenantId, String extendName) {
    final suffix = extendName.isEmpty ? '' : '.$extendName';
    final randomPart = base64Url
        .encode(List<int>.generate(18, (_) => _random.nextInt(256)))
        .replaceAll('=', '')
        .replaceAll('/', '_');
    return '$tenantId/${DateTime.now().microsecondsSinceEpoch}_$randomPart$suffix';
  }

  static String _normalizeName(String value) => value.trim().replaceAll(RegExp(r'[/\\]'), '');

  static String _normalizeFileName(String value) => path.basename(value.trim()).replaceAll(RegExp(r'[/\\]'), '');

  static String _extensionOf(String value) {
    final extension = path.extension(value).replaceFirst('.', '').toLowerCase();
    return extension == value.toLowerCase() ? '' : extension;
  }

  static String _baseNameOf(String value) {
    final extension = path.extension(value);
    if (extension.isEmpty) return value;
    return value.substring(0, value.length - extension.length);
  }
}

class _FileScope {
  const _FileScope({required this.tenantId, required this.creator});

  final int tenantId;
  final String creator;
}
