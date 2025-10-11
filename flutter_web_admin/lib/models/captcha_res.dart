class CaptchaRes {
  final bool captchaEnabled;
  final bool registerEnabled;
  final String img;
  final String uuid;

  CaptchaRes({
    required this.captchaEnabled,
    required this.registerEnabled,
    required this.img,
    required this.uuid,
  });

  factory CaptchaRes.fromJson(Map<String, dynamic> json) {
    return CaptchaRes(
      captchaEnabled: json['captchaEnabled'] ?? false,
      registerEnabled: json['registerEnabled'] ?? false,
      img: json['img'] ?? '',
      uuid: json['uuid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'captchaEnabled': captchaEnabled,
      'registerEnabled': registerEnabled,
      'img': img,
      'uuid': uuid,
    };
  }
}
