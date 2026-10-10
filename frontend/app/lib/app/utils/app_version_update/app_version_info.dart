class AppVersionInfo {
  final String version;
  final String platform;
  final String buildNumber;
  final String releaseNotes;
  final String downloadUrl;

  AppVersionInfo({
    required this.version,
    required this.platform,
    required this.buildNumber,
    required this.releaseNotes,
    required this.downloadUrl,
  });

  // 从华 API 构造
  factory AppVersionInfo.fromJson(Map<String, dynamic> json) {
    return AppVersionInfo(
      platform: json["platform"],
      version: json['versionName'],
      buildNumber: json['versionCode'].toString(),
      releaseNotes: json['releaseNotes'],
      downloadUrl: json['apkUrl'],
    );
  }

  // 从 iOS App Store API 构造
  factory AppVersionInfo.fromIOSAppStore(Map<String, dynamic> json) {
    // 从 iOS App Store API 构造
    final model = _AppStoreInfoModel.fromJson(json);
    final result = model.results?.first;
    return AppVersionInfo(
      platform: "iOS",
      version: result?.version ?? '',
      buildNumber: '',
      releaseNotes: result?.releaseNotes ?? '',
      downloadUrl: '',
    );
  }

  // 从小米商店 API 构造
  factory AppVersionInfo.fromXiaomiAppStore(Map<String, dynamic> json) {
    return AppVersionInfo(
      platform: "Android - Xiaomi",
      version: json['versionName'],
      buildNumber: json['versionCode'].toString(),
      releaseNotes: json['releaseNotes'],
      downloadUrl: json['apkUrl'],
    );
  }

  // 从华为商店 API 构造
  factory AppVersionInfo.fromHuaweiStore(Map<String, dynamic> json) {
    return AppVersionInfo(
      platform: "Android - Huawei",
      version: json['versionName'],
      buildNumber: json['versionCode'].toString(),
      releaseNotes: json['releaseNotes'],
      downloadUrl: json['apkUrl'],
    );
  }
}



// =============================================================================
//                                iOS App Store Version Info
// =============================================================================
class _AppStoreInfoModel {
  num? resultCount;
  List<_AppStoreInfoModelResults>? results;
  _AppStoreInfoModel(this.resultCount, this.results);
  factory _AppStoreInfoModel.fromJson(Map<String, dynamic> json) {
    return _AppStoreInfoModel(json['resultCount'] as num, (json['results'] as List).map((i) => _AppStoreInfoModelResults.fromJson(i)).toList());
  }
}

class _AppStoreInfoModelResults {
  String? version;
  String? releaseNotes;
  _AppStoreInfoModelResults(this.version, this.releaseNotes);
  factory _AppStoreInfoModelResults.fromJson(Map<String, dynamic> json) {
    return _AppStoreInfoModelResults(json['version'] as String, json['releaseNotes'] as String);
  }
}
