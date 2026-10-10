///@description 跳转到哪个页面的逻辑判断
///@updateTime 2025/1/14 16:07
class JumpAppMessage {
// {"jumpApp": "MyClientView"}
  //跳转页面的判断，如果将来扩展，还从这里扩展。
  final String? jumpApp;

  JumpAppMessage({
    this.jumpApp,
  });

  factory JumpAppMessage.fromJson(Map<String, dynamic> json) {
    return JumpAppMessage(
      jumpApp: json['jumpApp'],
    );
  }

  Map<String, dynamic> toJson() => {
        'jumpApp': jumpApp,
      };
}
