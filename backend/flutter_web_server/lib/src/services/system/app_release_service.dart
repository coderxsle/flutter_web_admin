import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/services/system/file_service.dart';
import 'package:path/path.dart' as path;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// App 版本发布管理：租户内 CRUD、安装包上传、发布与状态流转、更新策略。
class AppReleaseService {
  AppReleaseService._();

  static const platforms = {'android', 'ios'};
  static const channels = {'official', 'huawei', 'xiaomi', 'yingyongbao'};
  static const statuses = {'draft', 'rolling', 'published', 'paused', 'offline'};
  static const liveStatuses = {'rolling', 'published'};
  static const maxPackageBytes = 300 * 1024 * 1024;

  static String get storageRoot => FileService.storageRoot;

  static Future<PageResponse> list(
    Session session, {
    String? platform,
    String? channel,
    String? status,
    String? keyword,
    int page = 1,
    int pageSize = 20,
  }) async {
    final actor = await _actor(session);
    final safePage = page <= 0 ? 1 : page;
    final size = pageSize <= 0 ? 20 : pageSize.clamp(1, 100);
    final key = _clean(keyword);
    final plat = _clean(platform);
    final chan = _clean(channel);
    final state = _clean(status);

    Expression where(AppReleaseTable table) {
      var filter = table.tenantId.equals(actor.tenantId) & table.deleted.equals(false);
      if (plat != null) filter = filter & table.platform.equals(plat);
      if (chan != null) filter = filter & table.channel.equals(chan);
      if (state != null) filter = filter & table.status.equals(state);
      if (key != null) filter = filter & (table.versionName.like('%$key%') | table.releaseNotes.like('%$key%'));
      return filter;
    }

    final rows = await AppRelease.db.find(
      session,
      where: where,
      orderByList: (table) => [table.versionCode.desc(), table.id.desc()],
      limit: size,
      offset: (safePage - 1) * size,
    );
    final total = await AppRelease.db.count(session, where: where);
    return PageResponse.restPage(data: rows.map(_toJson).toList(), page: safePage, pageSize: size, total: total);
  }

  static Future<Map<String, dynamic>> detail(Session session, int id) async {
    final actor = await _actor(session);
    return _toJson(await _findOwned(session, actor, id));
  }

  static Future<Map<String, dynamic>> create(Session session, Map<String, dynamic> body) async {
    final actor = await _actor(session);
    return _guard('创建版本失败', () async {
      final platform = _platform(body['platform']);
      final channel = _channel(body['channel']);
      final versionCode = _requiredInt(body, 'versionCode');
      final versionName = _requiredText(body, 'versionName');
      final minOsVersion = _versionText(body['minOsVersion']);
      if (await _versionExists(session, actor.tenantId, platform, channel, versionCode, includeDeleted: true)) {
        throw RestException.badRequest('该渠道下 versionCode $versionCode 已存在（含已删除记录），请换一个构建号');
      }
      final now = DateTime.now();
      final row = AppRelease(
        tenantId: actor.tenantId,
        platform: platform,
        channel: channel,
        versionName: versionName,
        versionCode: versionCode,
        releaseNotes: _text(body['releaseNotes']),
        minOsVersion: minOsVersion,
        status: 'draft',
        rolloutPercent: 0,
        forceUpdate: body['forceUpdate'] == true,
        storeUrl: platform == 'ios' ? _clean(body['storeUrl']) : null,
        publishedAt: null,
        downloadCount: 0,
        creator: actor.username,
        createTime: now,
        updater: actor.username,
        updateTime: now,
        deleted: false,
      );
      return _toJson(await AppRelease.db.insertRow(session, row));
    });
  }

  static Future<Map<String, dynamic>> update(Session session, Map<String, dynamic> body) async {
    final actor = await _actor(session);
    return _guard('更新版本失败', () async {
      final id = _requiredInt(body, 'id');
      final row = await _findOwned(session, actor, id);
      final now = DateTime.now();
      final isDraft = row.status == 'draft';

      // 构建号与渠道只在草稿期可改，避免已投放设备对不上号。
      var platform = row.platform;
      var channel = row.channel;
      var versionCode = row.versionCode;
      if (isDraft) {
        platform = body.containsKey('platform') ? _platform(body['platform']) : row.platform;
        channel = body.containsKey('channel') ? _channel(body['channel']) : row.channel;
        versionCode = body.containsKey('versionCode') ? _requiredInt(body, 'versionCode') : row.versionCode;
        if (platform != row.platform || channel != row.channel || versionCode != row.versionCode) {
          if (await _versionExists(
            session,
            actor.tenantId,
            platform,
            channel,
            versionCode,
            exceptId: id,
            includeDeleted: true,
          )) {
            throw RestException.badRequest('该渠道下 versionCode $versionCode 已存在（含已删除记录），请换一个构建号');
          }
        }
      }

      final rollout = body.containsKey('rolloutPercent')
          ? _requiredInt(body, 'rolloutPercent').clamp(0, 100).toInt()
          : row.rolloutPercent;
      if (!isDraft && rollout != row.rolloutPercent && row.status != 'rolling') {
        throw RestException.badRequest('只有灰度中的版本可以调整比例');
      }

      final updated = row.copyWith(
        platform: platform,
        channel: channel,
        versionCode: versionCode,
        versionName: body.containsKey('versionName') ? _requiredText(body, 'versionName') : row.versionName,
        releaseNotes: body.containsKey('releaseNotes') ? _text(body['releaseNotes']) : row.releaseNotes,
        minOsVersion: body.containsKey('minOsVersion') ? _versionText(body['minOsVersion']) : row.minOsVersion,
        forceUpdate: body.containsKey('forceUpdate') ? body['forceUpdate'] == true : row.forceUpdate,
        rolloutPercent: rollout,
        storeUrl: platform == 'ios' ? (body.containsKey('storeUrl') ? _clean(body['storeUrl']) : row.storeUrl) : null,
        updater: actor.username,
        updateTime: now,
      );
      return _toJson(await AppRelease.db.updateRow(session, updated));
    });
  }

  /// 流式写盘并同步计算 sha256；同名旧包只在无人引用时删除。
  static Future<Map<String, dynamic>> upload(
    Session session, {
    required int id,
    required String fileName,
    required Stream<List<int>> bytes,
  }) async {
    final actor = await _actor(session);
    return _guard('安装包上传失败', () async {
      final row = await _findOwned(session, actor, id);
      if (row.status != 'draft') throw RestException.badRequest('只有草稿状态可以上传安装包');
      if (row.platform != 'android') throw RestException.badRequest('iOS 版本不需要上传安装包');
      final safeName = _safeFileName(fileName);
      if (!safeName.toLowerCase().endsWith('.apk')) throw RestException.badRequest('只支持 .apk 文件');

      final tmpDir = Directory(path.join(storageRoot, '_packages', '.tmp'));
      await tmpDir.create(recursive: true);
      final tmp = File(path.join(tmpDir.path, '${row.id}_${DateTime.now().microsecondsSinceEpoch}.part'));
      final sink = tmp.openWrite();
      final digestSink = _DigestSink();
      final hasher = sha256.startChunkedConversion(digestSink);
      var size = 0;
      try {
        await for (final chunk in bytes) {
          size += chunk.length;
          if (size > maxPackageBytes) {
            throw RestException.badRequest('安装包不能超过 ${maxPackageBytes ~/ 1024 ~/ 1024}MB');
          }
          hasher.add(chunk);
          sink.add(chunk);
        }
        await sink.flush();
        await sink.close();
        hasher.close();
      } catch (_) {
        try {
          await sink.close();
        } catch (_) {}
        if (await tmp.exists()) await tmp.delete();
        rethrow;
      }
      if (size == 0) {
        await tmp.delete();
        throw RestException.badRequest('安装包内容为空');
      }

      final digest = digestSink.value.toString();
      final key = path.join('_packages', row.platform, '${row.versionCode}-${digest.substring(0, 8)}.apk');
      final target = File(path.join(storageRoot, key));
      await target.parent.create(recursive: true);
      if (await target.exists()) await target.delete();
      await tmp.rename(target.path);

      final oldKey = row.storageKey;
      final updated = await AppRelease.db.updateRow(
        session,
        row.copyWith(
          storageKey: key,
          fileName: safeName,
          fileSize: size,
          sha256: digest,
          updater: actor.username,
          updateTime: DateTime.now(),
        ),
      );
      if (oldKey != null && oldKey != key) await _deleteIfUnreferenced(session, oldKey);
      return _toJson(updated);
    });
  }

  static Future<Map<String, dynamic>> publish(
    Session session, {
    required int id,
    required int rolloutPercent,
    required bool forceUpdate,
    DateTime? publishAt,
  }) async {
    final actor = await _actor(session);
    return _guard('发布版本失败', () async {
      final row = await _findOwned(session, actor, id);
      if (row.status != 'draft' && row.status != 'paused') {
        throw RestException.badRequest('只有草稿或已暂停的版本可以发布');
      }
      if (row.platform == 'android' && (row.storageKey == null || row.sha256 == null || row.fileSize <= 0)) {
        throw RestException.badRequest('请先上传安装包');
      }
      if (row.platform == 'ios' && _clean(row.storeUrl) == null) {
        throw RestException.badRequest('请填写 App Store 地址');
      }
      final pct = rolloutPercent.clamp(0, 100).toInt();
      if (pct == 0) throw RestException.badRequest('灰度比例需在 1-100 之间');

      final latest = await AppRelease.db.findFirstRow(
        session,
        where: (table) =>
            table.tenantId.equals(actor.tenantId) &
            table.platform.equals(row.platform) &
            table.channel.equals(row.channel) &
            table.deleted.equals(false) &
            table.status.inSet(liveStatuses) &
            table.id.notEquals(row.id!),
        orderByList: (table) => [table.versionCode.desc()],
      );
      if (latest != null && row.versionCode <= latest.versionCode) {
        throw RestException.badRequest('versionCode 必须大于当前线上版本 ${latest.versionCode}');
      }

      final now = DateTime.now();
      final updated = await AppRelease.db.updateRow(
        session,
        row.copyWith(
          status: pct >= 100 ? 'published' : 'rolling',
          rolloutPercent: pct,
          forceUpdate: forceUpdate,
          publishedAt: publishAt ?? row.publishedAt ?? now,
          updater: actor.username,
          updateTime: now,
        ),
      );
      return _toJson(updated);
    });
  }

  static Future<Map<String, dynamic>> changeStatus(Session session, {required int id, required String status}) async {
    final actor = await _actor(session);
    return _guard('变更版本状态失败', () async {
      if (!statuses.contains(status) || status == 'draft') throw RestException.badRequest('不支持的目标状态：$status');
      final row = await _findOwned(session, actor, id);
      if (row.status == 'draft') throw RestException.badRequest('草稿请走发布流程');
      if (row.status == status) return _toJson(row);
      if (row.status == 'offline' && status != 'published' && status != 'rolling') {
        throw RestException.badRequest('已下架版本只能重新发布');
      }
      final now = DateTime.now();
      final updated = await AppRelease.db.updateRow(
        session,
        row.copyWith(
          status: status,
          rolloutPercent: status == 'published' ? 100 : row.rolloutPercent,
          publishedAt: status == 'published' || status == 'rolling' ? row.publishedAt ?? now : row.publishedAt,
          updater: actor.username,
          updateTime: now,
        ),
      );
      return _toJson(updated);
    });
  }

  static Future<Map<String, dynamic>> delete(Session session, int id) async {
    final actor = await _actor(session);
    return _guard('删除版本失败', () async {
      final row = await _findOwned(session, actor, id);
      if (row.status != 'draft' && row.status != 'offline') {
        throw RestException.badRequest('只有草稿或已下架的版本可以删除');
      }
      await AppRelease.db.updateRow(
        session,
        row.copyWith(deleted: true, updater: actor.username, updateTime: DateTime.now()),
      );
      if (row.storageKey != null) await _deleteIfUnreferenced(session, row.storageKey!);
      return {'id': id};
    });
  }

  static Future<Map<String, dynamic>> getPolicy(Session session, {String? platform, String? channel}) async {
    final actor = await _actor(session);
    final plat = _platform(platform);
    final chan = _channel(channel);
    final row = await AppUpdatePolicy.db.findFirstRow(
      session,
      where: (table) =>
          table.tenantId.equals(actor.tenantId) &
          table.platform.equals(plat) &
          table.channel.equals(chan) &
          table.deleted.equals(false),
    );
    return row == null ? _defaultPolicy(actor.tenantId, plat, chan) : _policyJson(row);
  }

  static Future<Map<String, dynamic>> updatePolicy(Session session, Map<String, dynamic> body) async {
    final actor = await _actor(session);
    return _guard('保存更新策略失败', () async {
      final plat = _platform(body['platform']);
      final chan = _channel(body['channel']);
      final minSupported = _requiredInt(body, 'minSupportedVersionCode');
      final cooldown = body.containsKey('promptCooldownHours') ? _requiredInt(body, 'promptCooldownHours') : 24;
      final ttl = body.containsKey('downloadUrlTtlMinutes') ? _requiredInt(body, 'downloadUrlTtlMinutes') : 120;
      if (minSupported < 0) throw RestException.badRequest('最低支持版本不能为负数');
      if (cooldown < 1 || cooldown > 720) throw RestException.badRequest('提醒冷却需在 1-720 小时之间');
      if (ttl < 5 || ttl > 1440) throw RestException.badRequest('下载有效期需在 5-1440 分钟之间');

      final existing = await AppUpdatePolicy.db.findFirstRow(
        session,
        where: (table) =>
            table.tenantId.equals(actor.tenantId) &
            table.platform.equals(plat) &
            table.channel.equals(chan) &
            table.deleted.equals(false),
      );
      final now = DateTime.now();
      if (existing == null) {
        final row = AppUpdatePolicy(
          tenantId: actor.tenantId,
          platform: plat,
          channel: chan,
          minSupportedVersionCode: minSupported,
          promptCooldownHours: cooldown,
          downloadUrlTtlMinutes: ttl,
          enabled: body['enabled'] != false,
          creator: actor.username,
          createTime: now,
          updater: actor.username,
          updateTime: now,
          deleted: false,
        );
        return _policyJson(await AppUpdatePolicy.db.insertRow(session, row));
      }
      final updated = await AppUpdatePolicy.db.updateRow(
        session,
        existing.copyWith(
          minSupportedVersionCode: minSupported,
          promptCooldownHours: cooldown,
          downloadUrlTtlMinutes: ttl,
          enabled: body.containsKey('enabled') ? body['enabled'] != false : existing.enabled,
          updater: actor.username,
          updateTime: now,
        ),
      );
      return _policyJson(updated);
    });
  }

  // ── 内部 ────────────────────────────────────────────────────────────────

  static Future<_Actor> _actor(Session session) async {
    final auth = session.authenticated;
    if (auth == null) throw const RestException.unauthorized();
    final user = await SysUser.db.findFirstRow(
      session,
      where: (table) => table.authUserId.equals(auth.authUserId) & table.deleted.equals(false),
    );
    if (user == null) throw RestException(401, '登录账号不存在，请重新登录', code: 401);
    return _Actor(username: user.username, tenantId: session.tenantId);
  }

  static Future<AppRelease> _findOwned(Session session, _Actor actor, int id) async {
    final row = await AppRelease.db.findFirstRow(
      session,
      where: (table) => table.id.equals(id) & table.tenantId.equals(actor.tenantId) & table.deleted.equals(false),
    );
    if (row == null) throw RestException(404, '版本不存在或已删除', code: ResultCode.validateFailed.code);
    return row;
  }

  static Future<bool> _versionExists(
    Session session,
    int tenantId,
    String platform,
    String channel,
    int versionCode, {
    int? exceptId,
    bool includeDeleted = false,
  }) async {
    final row = await AppRelease.db.findFirstRow(
      session,
      where: (table) {
        var filter =
            table.tenantId.equals(tenantId) &
            table.platform.equals(platform) &
            table.channel.equals(channel) &
            table.versionCode.equals(versionCode);
        if (!includeDeleted) filter = filter & table.deleted.equals(false);
        if (exceptId != null) filter = filter & table.id.notEquals(exceptId);
        return filter;
      },
    );
    return row != null;
  }

  static Future<void> _deleteIfUnreferenced(Session session, String storageKey) async {
    final used = await AppRelease.db.count(
      session,
      where: (table) => table.storageKey.equals(storageKey) & table.deleted.equals(false),
    );
    if (used > 0) return;
    final file = File(path.join(storageRoot, storageKey));
    if (await file.exists()) await file.delete();
  }

  static String _platform(Object? value) {
    final text = _clean(value?.toString());
    if (text == null || !platforms.contains(text)) throw RestException.badRequest('platform 只能是 android / ios');
    return text;
  }

  static String _channel(Object? value) {
    final text = _clean(value?.toString()) ?? 'official';
    if (!channels.contains(text)) throw RestException.badRequest('channel 只能是 ${channels.join(' / ')}');
    return text;
  }

  static String? _versionText(Object? value) {
    final text = _clean(value?.toString());
    if (text == null) return null;
    if (!RegExp(r'^\d+(\.\d+){0,3}$').hasMatch(text)) throw RestException.badRequest('系统版本号格式不正确');
    return text;
  }

  static String _safeFileName(String value) {
    final name = path.basename(value.trim()).replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
    if (name.isEmpty) throw RestException.badRequest('文件名不能为空');
    return name.length <= 120 ? name : name.substring(name.length - 120);
  }

  static String _requiredText(Map<String, dynamic> body, String key) {
    final text = _clean(body[key]?.toString());
    if (text == null) throw RestException.badRequest('$key 不能为空');
    return text;
  }

  static int _requiredInt(Map<String, dynamic> body, String key) {
    final value = body[key];
    final parsed = value is int ? value : int.tryParse(value?.toString() ?? '');
    if (parsed == null) throw RestException.badRequest('$key 必须是整数');
    return parsed;
  }

  static String _text(Object? value) => _clean(value?.toString()) ?? '';

  static String? _clean(String? value) {
    final text = value?.trim();
    return text == null || text.isEmpty ? null : text;
  }

  static Map<String, dynamic> _toJson(AppRelease row) => {
    'id': row.id,
    'tenantId': row.tenantId,
    'platform': row.platform,
    'channel': row.channel,
    'versionName': row.versionName,
    'versionCode': row.versionCode,
    'releaseNotes': row.releaseNotes,
    'minOsVersion': row.minOsVersion,
    'status': row.status,
    'rolloutPercent': row.rolloutPercent,
    'forceUpdate': row.forceUpdate,
    'fileName': row.fileName,
    'fileSize': row.fileSize,
    'sha256': row.sha256,
    'storeUrl': row.storeUrl,
    'hasPackage': row.storageKey != null,
    'publishedAt': row.publishedAt,
    'downloadCount': row.downloadCount,
    'creator': row.creator,
    'createTime': row.createTime,
    'updater': row.updater,
    'updateTime': row.updateTime,
  };

  static Map<String, dynamic> _defaultPolicy(int tenantId, String platform, String channel) => {
    'id': null,
    'tenantId': tenantId,
    'platform': platform,
    'channel': channel,
    'minSupportedVersionCode': 0,
    'promptCooldownHours': 24,
    'downloadUrlTtlMinutes': 120,
    'enabled': true,
  };

  static Map<String, dynamic> _policyJson(AppUpdatePolicy row) => {
    'id': row.id,
    'tenantId': row.tenantId,
    'platform': row.platform,
    'channel': row.channel,
    'minSupportedVersionCode': row.minSupportedVersionCode,
    'promptCooldownHours': row.promptCooldownHours,
    'downloadUrlTtlMinutes': row.downloadUrlTtlMinutes,
    'enabled': row.enabled,
    'createTime': row.createTime,
    'updateTime': row.updateTime,
  };

  static Future<T> _guard<T>(String message, Future<T> Function() action) async {
    try {
      return await action();
    } on RestException {
      rethrow;
    } catch (_) {
      throw RestException(500, message, code: ResultCode.failed.code);
    }
  }
}

class _Actor {
  const _Actor({required this.username, required this.tenantId});

  final String username;
  final int tenantId;
}

class _DigestSink implements Sink<Digest> {
  Digest? value;

  @override
  void add(Digest data) => value = data;

  @override
  void close() {}
}
