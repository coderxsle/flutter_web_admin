/// 登录用户信息，对应后端 `GET /api/user/info` 返回的 data。
///
/// 后端结构见 backend/flutter_web_server/lib/src/generated/responses/user_info_response.dart：
/// `{user, posts, roles, permissions, menus}`。
class UserInfoResponse {
  final UserInfo user;
  final List<String> posts; // 岗位名称
  final List<String> roles; // 角色名称
  final List<String> permissions; // 权限标识，例如 system:user:add
  final List<MenuInfo> menus; // 该账号可见的菜单

  UserInfoResponse({
    required this.user,
    this.posts = const [],
    this.roles = const [],
    this.permissions = const [],
    this.menus = const [],
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoResponse(
      user: UserInfo.fromJson(Map<String, dynamic>.from(json['user'] ?? {})),
      posts: _stringList(json['posts']),
      roles: _stringList(json['roles']),
      permissions: _stringList(json['permissions']),
      menus: (json['menus'] as List? ?? [])
          .map((e) => MenuInfo.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }

  /// 只用来控制前端显隐，真正拦得住的是服务端。
  bool hasPermission(String code) => permissions.contains(code);

  UserInfoResponse copyWith({
    UserInfo? user,
    List<String>? posts,
    List<String>? roles,
    List<String>? permissions,
    List<MenuInfo>? menus,
  }) {
    return UserInfoResponse(
      user: user ?? this.user,
      posts: posts ?? this.posts,
      roles: roles ?? this.roles,
      permissions: permissions ?? this.permissions,
      menus: menus ?? this.menus,
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'posts': posts,
        'roles': roles,
        'permissions': permissions,
        'menus': menus.map((e) => e.toJson()).toList(),
      };
}

List<String> _stringList(dynamic value) =>
    value == null ? const [] : List<String>.from((value as List).map((e) => e.toString()));

/// 对应后端 UserInfo（sys_user 的视图对象），字段名保持一致。
///
/// 只保留 App 用得上的字段，后端还有 loginTime / createTime 没取。
class UserInfo {
  final int? id;
  final int tenantId;
  final int? deptId;
  final String username;
  final String nickname;
  final String? phone;
  final int? gender;
  final String? email;
  final String? avatar;
  final String? description;
  final int? status;
  final int type;
  final bool isSuperuser;
  final String? loginIp;

  UserInfo({
    this.id,
    this.tenantId = 0,
    this.deptId,
    this.username = '',
    this.nickname = '',
    this.phone,
    this.gender,
    this.email,
    this.avatar,
    this.description,
    this.status,
    this.type = 0,
    this.isSuperuser = false,
    this.loginIp,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: (json['id'] as num?)?.toInt(),
      tenantId: (json['tenantId'] as num?)?.toInt() ?? 0,
      deptId: (json['deptId'] as num?)?.toInt(),
      username: json['username'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      phone: json['phone'] as String?,
      gender: (json['gender'] as num?)?.toInt(),
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      description: json['description'] as String?,
      status: (json['status'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt() ?? 0,
      isSuperuser: json['isSuperuser'] == true,
      loginIp: json['loginIp'] as String?,
    );
  }

  UserInfo copyWith({
    int? id,
    int? tenantId,
    int? deptId,
    String? username,
    String? nickname,
    String? phone,
    int? gender,
    String? email,
    String? avatar,
    String? description,
    int? status,
    int? type,
    bool? isSuperuser,
    String? loginIp,
  }) {
    return UserInfo(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      deptId: deptId ?? this.deptId,
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      description: description ?? this.description,
      status: status ?? this.status,
      type: type ?? this.type,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      loginIp: loginIp ?? this.loginIp,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'tenantId': tenantId,
        'deptId': deptId,
        'username': username,
        'nickname': nickname,
        'phone': phone,
        'gender': gender,
        'email': email,
        'avatar': avatar,
        'description': description,
        'status': status,
        'type': type,
        'isSuperuser': isSuperuser,
        'loginIp': loginIp,
      };
}

/// 对应后端 Menu，同样只取 App 用得上的展示字段。
class MenuInfo {
  final int? id;
  final int parentId;
  final int type; // 1 目录 2 菜单 3 按钮
  final String title;
  final String? icon;
  final String permission;
  final String? path;
  final int sort;
  final int status;
  final bool visible;

  MenuInfo({
    this.id,
    this.parentId = 0,
    this.type = 0,
    this.title = '',
    this.icon,
    this.permission = '',
    this.path,
    this.sort = 0,
    this.status = 0,
    this.visible = true,
  });

  factory MenuInfo.fromJson(Map<String, dynamic> json) {
    return MenuInfo(
      id: (json['id'] as num?)?.toInt(),
      parentId: (json['parentId'] as num?)?.toInt() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      icon: json['icon'] as String?,
      permission: json['permission'] as String? ?? '',
      path: json['path'] as String?,
      sort: (json['sort'] as num?)?.toInt() ?? 0,
      status: (json['status'] as num?)?.toInt() ?? 0,
      visible: json['visible'] != false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'parentId': parentId,
        'type': type,
        'title': title,
        'icon': icon,
        'permission': permission,
        'path': path,
        'sort': sort,
        'status': status,
        'visible': visible,
      };
}
