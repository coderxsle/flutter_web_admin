class SystemUserModel {
  int id;
  String username;
  String truename;
  String nickname;
  String phone;
  String email;
  int status;
  DateTime createTime;
  DateTime loginTime;
  List<String>? roles;

  SystemUserModel({
    required this.id,
    required this.username,
    required this.truename,
    required this.nickname,
    required this.phone,
    required this.email,
    required this.status,
    required this.createTime,
    required this.loginTime,
    this.roles,
  });

  factory SystemUserModel.fromJson(Map<String, dynamic> json) {
    return SystemUserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      truename: json['truename'] as String,
      nickname: json['nickname'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      status: json['status'] as int,
      createTime: DateTime.parse(json['createTime']),
      loginTime: DateTime.parse(json['loginTime']),
      roles: (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'truename': truename,
      'nickname': nickname,
      'phone': phone,
      'email': email,
      'status': status,
      'createTime': createTime.toIso8601String(),
      'loginTime': loginTime.toIso8601String(),
      'roles': roles,
    };
  }
} 