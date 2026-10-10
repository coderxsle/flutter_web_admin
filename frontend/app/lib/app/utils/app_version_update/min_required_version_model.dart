///@description 更新版本使用的模型，是最小获取的版本号。信息。不包含lastForceUpdate字段的信息是自由自愿更新，不强制。
///@updateTime 2025/7/31 14:35
class MinRequiredVersionModel {
  //创建的时间
  String? createDate;
  //下载的地址连接
  String? downloadUrl;
  //是否强制更新
  num? forceUpdate;
  //平台：2是ios，1是android  特别重要，不能错
  num? platform;
  //升级的备注信息：也即是更新日志
  String? remark;
  //软件的id
  num? softwareId;
  //目前服务器上的正常在用的版本号
  String? softwareVersion;
  //二维码的扫码图片地址
  String? zxingAddress;

  //最后一个版本的版本信息
  LastForceUpdate? lastForceUpdate;

  MinRequiredVersionModel({
    this.createDate,
    this.downloadUrl,
    this.forceUpdate,
    this.platform,
    this.remark,
    this.softwareId,
    this.softwareVersion,
    this.zxingAddress,
    this.lastForceUpdate,
  });

  MinRequiredVersionModel.fromJson(Map<String, dynamic> json) {
    createDate = json['createDate'];
    downloadUrl = json['downloadUrl'];
    forceUpdate = json['forceUpdate'];
    platform = json['platform'];
    remark = json['remark'];
    softwareId = json['softwareId'];
    softwareVersion = json['softwareVersion'];
    zxingAddress = json['zxingAddress'];
    lastForceUpdate = json['lastForceUpdate'] != null ? LastForceUpdate.fromJson(json['lastForceUpdate']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createDate'] = createDate;
    data['downloadUrl'] = downloadUrl;
    data['forceUpdate'] = forceUpdate;
    data['platform'] = platform;
    data['remark'] = remark;
    data['softwareId'] = softwareId;
    data['softwareVersion'] = softwareVersion;
    data['zxingAddress'] = zxingAddress;
    data['lastForceUpdate'] = lastForceUpdate?.toJson();
    return data;
  }
}

///@description 最后一个版本的信息内容，用于做强制更新的
///@updateTime 2025/7/31 14:47
///@author itchenqi175@163.com
class LastForceUpdate {
  //创建的时间
  String? createDate;
  //下载的url
  String? downloadUrl;
  //是否强制更新
  num? forceUpdate;
  //平台：2是ios，1是android  特别重要，不能错
  num? platform;
  //升级的备注信息：也即是更新日志
  String? remark;
  //软件的id
  num? softwareId;
  //目前服务器上的正常在用的版本号
  String? softwareVersion;
  //二维码的扫码图片地址
  String? zxingAddress;

  LastForceUpdate({
    this.createDate,
    this.downloadUrl,
    this.forceUpdate,
    this.platform,
    this.remark,
    this.softwareId,
    this.softwareVersion,
    this.zxingAddress,
  });

  LastForceUpdate.fromJson(Map<String, dynamic> json) {
    createDate = json['createDate'];
    downloadUrl = json['downloadUrl'];
    forceUpdate = json['forceUpdate'];
    platform = json['platform'];
    remark = json['remark'];
    softwareId = json['softwareId'];
    softwareVersion = json['softwareVersion'];
    zxingAddress = json['zxingAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createDate'] = createDate;
    data['downloadUrl'] = downloadUrl;
    data['forceUpdate'] = forceUpdate;
    data['platform'] = platform;
    data['remark'] = remark;
    data['softwareId'] = softwareId;
    data['softwareVersion'] = softwareVersion;
    data['zxingAddress'] = zxingAddress;
    return data;
  }
}
