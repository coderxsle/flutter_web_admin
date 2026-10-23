import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_web_server/src/common/common.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 客户端更新检测：租户候选版本、灰度分桶、强制门槛、下载签名。
class AppUpdateService {
  AppUpdateService._();

  static const channels = {'official', 'huawei', 'xiaomi', 'yingyongbao'};
  static const _liveStatuses = {'rolling', 'published'};

  static Future<Map<String, dynamic>> check(
    Session session,
    Map<String, dynamic> body, {
    required String origin,
  }) async {
    final platform = _platform(body['platform']);
    final channel = _channel(body['channel']);
    final clientBuild = _requiredInt(body, 'versionCode');
    final deviceId = _requiredText(body, 'deviceId');
    final tenantId = _tenantId(body['tenantId']);
    final osVersion = _clean(body['osVersion']?.toString());

    final policy = await _policy(session, tenantId, platform, channel);
    if (!policy.enabled) {
      return {
        'hasUpdate': false,
        'force': false,
        'latest': null,
        'minSupportedVersionCode': policy.minSupportedVersionCode,
        'promptCooldownHours': policy.promptCooldownHours,
        'serverTime': DateTime.now(),
      };
    }

    final pool = await _releasePool(session, tenantId: tenantId, platform: platform, channel: channel);
    AppRelease? picked;
    for (final release in pool) {
      if (!_osAtLeast(osVersion, release.minOsVersion)) continue;
      if (release.status == 'published' || _inRollout(release, deviceId)) {
        picked = release;
        break;
      }
    }

    final hasUpdate = picked != null && picked.versionCode > clientBuild;
    final force = hasUpdate && clientBuild < policy.minSupportedVersionCode;
    if (picked == null) {
      return {
        'hasUpdate': false,
        'force': false,
        'latest': null,
        'minSupportedVersionCode': policy.minSupportedVersionCode,
        'promptCooldownHours': policy.promptCooldownHours,
        'serverTime': DateTime.now(),
      };
    }

    final expires = DateTime.now().add(Duration(minutes: policy.downloadUrlTtlMinutes));
    final token = _sign(picked.id!, expires.millisecondsSinceEpoch);
    return {
      'hasUpdate': hasUpdate,
      'force': force,
      'latest': _publicJson(picked, includeContent: hasUpdate),
      'downloadUrl': platform == 'android' && hasUpdate
          ? '$origin/api/app/update/download/${picked.id}?expires=${expires.millisecondsSinceEpoch}&token=$token'
          : null,
      'downloadExpiresAt': platform == 'android' && hasUpdate ? expires : null,
      'minSupportedVersionCode': policy.minSupportedVersionCode,
      'promptCooldownHours': policy.promptCooldownHours,
      'serverTime': DateTime.now(),
    };
  }

  static Future<Map<String, dynamic>?> latest(
    Session session, {
    required String platform,
    String? channel,
    int? tenantId,
  }) async {
    final plat = _platform(platform);
    final chan = _channel(channel);
    final pool = await _releasePool(session, tenantId: _tenantId(tenantId), platform: plat, channel: chan);
    final published = pool.where((row) => row.status == 'published').toList();
    if (published.isEmpty) return null;
    return _publicJson(published.first);
  }

  static Future<List<Map<String, dynamic>>> history(
    Session session, {
    required String platform,
    String? channel,
    int? tenantId,
    int limit = 20,
  }) async {
    final plat = _platform(platform);
    final chan = _channel(channel);
    final pool = await _releasePool(session, tenantId: _tenantId(tenantId), platform: plat, channel: chan);
    return pool.where((row) => row.status == 'published').take(limit.clamp(1, 50)).map(_publicJson).toList();
  }

  /// 下载前校验：签名 + 过期 + 包存在。
  static Future<AppRelease> findDownloadable(
    Session session, {
    required int releaseId,
    required int expires,
    required String token,
  }) async {
    if (expires < DateTime.now().millisecondsSinceEpoch) {
      throw RestException(403, '下载地址已过期', code: ResultCode.forbidden.code);
    }
    if (!_verify(releaseId, expires, token)) {
      throw RestException(403, '下载地址无效', code: ResultCode.forbidden.code);
    }
    final row = await AppRelease.db.findFirstRow(
      session,
      where: (table) => table.id.equals(releaseId) & table.deleted.equals(false),
    );
    if (row == null || row.storageKey == null || row.storageKey!.isEmpty) {
      throw RestException(404, '安装包不存在', code: ResultCode.validateFailed.code);
    }
    return row;
  }

  static Future<void> countDownload(Session session, int releaseId) async {
    final row = await AppRelease.db.findById(session, releaseId);
    if (row == null) return;
    await AppRelease.db.updateRow(session, row.copyWith(downloadCount: row.downloadCount + 1));
  }

  // ── 内部 ────────────────────────────────────────────────────────────────

  /// 租户有自建版本时用自己的，没有才回落到平台默认（tenantId=0）。
  static Future<List<AppRelease>> _releasePool(
    Session session, {
    required int tenantId,
    required String platform,
    required String channel,
  }) async {
    final own = await _liveReleases(session, tenantId, platform, channel);
    if (own.isNotEmpty || tenantId == 0) return own;
    return _liveReleases(session, 0, platform, channel);
  }

  static Future<List<AppRelease>> _liveReleases(Session session, int tenantId, String platform, String channel) {
    final now = DateTime.now();
    return AppRelease.db.find(
      session,
      where: (table) =>
          table.tenantId.equals(tenantId) &
          table.platform.equals(platform) &
          table.channel.equals(channel) &
          table.deleted.equals(false) &
          table.status.inSet(_liveStatuses) &
          (table.publishedAt <= now),
      orderByList: (table) => [table.versionCode.desc()],
    );
  }

  static Future<_Policy> _policy(Session session, int tenantId, String platform, String channel) async {
    final own = await _findPolicy(session, tenantId, platform, channel);
    if (own != null) return own;
    if (tenantId != 0) {
      final global = await _findPolicy(session, 0, platform, channel);
      if (global != null) return global;
    }
    return const _Policy(minSupportedVersionCode: 0, promptCooldownHours: 24, downloadUrlTtlMinutes: 120);
  }

  static Future<_Policy?> _findPolicy(Session session, int tenantId, String platform, String channel) async {
    final row = await AppUpdatePolicy.db.findFirstRow(
      session,
      where: (table) =>
          table.tenantId.equals(tenantId) &
          table.platform.equals(platform) &
          table.channel.equals(channel) &
          table.deleted.equals(false),
    );
    if (row == null) return null;
    return _Policy(
      minSupportedVersionCode: row.minSupportedVersionCode,
      promptCooldownHours: row.promptCooldownHours,
      downloadUrlTtlMinutes: row.downloadUrlTtlMinutes,
      enabled: row.enabled,
    );
  }

  /// 稳定分桶：同一设备同一版本每次结果一致，比例上调不会把已命中的人踢出去。
  static bool _inRollout(AppRelease release, String deviceId) {
    if (release.status == 'published') return true;
    final percent = release.rolloutPercent.clamp(0, 100);
    if (percent <= 0) return false;
    if (percent >= 100) return true;
    return _bucket('${release.id}:$deviceId') < percent;
  }

  static int _bucket(String input) {
    var hash = 0x811c9dc5;
    for (final byte in utf8.encode(input)) {
      hash ^= byte;
      hash = (hash * 0x01000193) & 0xffffffff;
    }
    return hash % 100;
  }

  static bool _osAtLeast(String? device, String? minimum) {
    if (minimum == null || minimum.isEmpty) return true;
    if (device == null || device.isEmpty) return true;
    final left = device.split('.').map(int.tryParse).toList();
    final right = minimum.split('.').map(int.tryParse).toList();
    if (left.any((e) => e == null) || right.any((e) => e == null)) return true;
    final length = left.length > right.length ? left.length : right.length;
    for (var i = 0; i < length; i++) {
      final a = i < left.length ? left[i]! : 0;
      final b = i < right.length ? right[i]! : 0;
      if (a > b) return true;
      if (a < b) return false;
    }
    return true;
  }

  static String _sign(int releaseId, int expires) {
    final mac = Hmac(sha256, utf8.encode(_secret)).convert(utf8.encode('$releaseId|$expires'));
    return base64Url.encode(mac.bytes).replaceAll('=', '');
  }

  static bool _verify(int releaseId, int expires, String token) {
    final expected = _sign(releaseId, expires);
    if (token.length != expected.length) return false;
    var diff = 0;
    for (var i = 0; i < expected.length; i++) {
      diff |= expected.codeUnitAt(i) ^ token.codeUnitAt(i);
    }
    return diff == 0;
  }

  static String get _secret {
    final secret = Serverpod.instance.getPassword('appDownloadTokenSecret');
    if (secret == null || secret.isEmpty) throw StateError('缺少 appDownloadTokenSecret 配置');
    return secret;
  }

  static Map<String, dynamic> _publicJson(AppRelease row, {bool includeContent = true}) => {
    'releaseId': row.id,
    'versionName': row.versionName,
    'versionCode': row.versionCode,
    'releaseNotes': row.releaseNotes,
    'minOsVersion': row.minOsVersion,
    if (includeContent) 'fileSize': row.fileSize,
    if (includeContent) 'sha256': row.sha256,
    'storeUrl': row.storeUrl,
    'publishedAt': row.publishedAt,
  };

  static String _platform(Object? value) {
    final text = _clean(value?.toString());
    if (text == null || (text != 'android' && text != 'ios')) {
      throw RestException.badRequest('platform 只能是 android / ios');
    }
    return text;
  }

  static String _channel(Object? value) {
    final text = _clean(value?.toString()) ?? 'official';
    if (!channels.contains(text)) throw RestException.badRequest('channel 不合法');
    return text;
  }

  static int _tenantId(Object? value) {
    final parsed = value is int ? value : int.tryParse(value?.toString() ?? '');
    return parsed != null && parsed > 0 ? parsed : 0;
  }

  static String _requiredText(Map<String, dynamic> body, String key) {
    final text = _clean(body[key]?.toString());
    if (text == null) throw RestException.badRequest('$key 不能为空');
    return text;
  }

  static int _requiredInt(Map<String, dynamic> body, String key) {
    final value = body[key];
    final parsed = value is int ? value : int.tryParse(value?.toString() ?? '');
    if (parsed == null || parsed <= 0) throw RestException.badRequest('$key 必须是正整数');
    return parsed;
  }

  static String? _clean(String? value) {
    final text = value?.trim();
    return text == null || text.isEmpty ? null : text;
  }
}

class _Policy {
  const _Policy({
    required this.minSupportedVersionCode,
    required this.promptCooldownHours,
    required this.downloadUrlTtlMinutes,
    this.enabled = true,
  });

  final int minSupportedVersionCode;
  final int promptCooldownHours;
  final int downloadUrlTtlMinutes;
  final bool enabled;
}
