class LoginReq {
  final String username;
  final String password;
  final String? code;
  final String? uuid;

  LoginReq({
    required this.username,
    required this.password,
    this.code,
    this.uuid,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'username': username,
      'password': password,
    };
    
    // 只有在验证码存在时才添加到请求中
    if (code != null && code!.isNotEmpty) {
      data['code'] = code;
    }
    if (uuid != null && uuid!.isNotEmpty) {
      data['uuid'] = uuid;
    }
    
    return data;
  }
}