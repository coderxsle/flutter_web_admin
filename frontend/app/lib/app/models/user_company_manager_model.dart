class UserCompanyManagerModel {
  final List<UserCompanyModel>? customerBindingVoList;      // 客户绑定列表
  final List<UserCompanyModel>? otherCustomerList;          // 其他公司列表
  final UserCompanyModel? presentLogin;                     // 当前登录的公司信息

  UserCompanyManagerModel({
    this.customerBindingVoList = const [],
    this.otherCustomerList = const [],
    this.presentLogin,
  });

  factory UserCompanyManagerModel.fromJson(Map<String, dynamic> json) {
    return UserCompanyManagerModel(
      customerBindingVoList: (json['customerBindingVoList'] as List).map((e) => UserCompanyModel.fromJson(e)).toList(),
      otherCustomerList: (json['otherCustomerList'] as List).map((e) => UserCompanyModel.fromJson(e)).toList(),
      presentLogin: UserCompanyModel.fromJson(json['presentLogin']),
    );
  }
}



class UserCompanyModel {
  final List<int> actorIds;                  // 角色ID列表
  final List<dynamic> actorList;             // 角色列表
  final String actorName;                    // 角色名称
  final String actorStr;                     // 角色字符串
  final int companyId;                       // 公司ID
  final String companyName;                  // 公司名称
  final int createCustomerId;                // 创建客户ID
  final String createLoginName;              // 创建登录名
  final String createTrueName;               // 创建者真实姓名
  final int customerId;                      // 客户ID
  final int customerSources;                 // 客户来源
  final int customerType;                    // 客户类型
  final String email;                        // 邮箱
  final int isDelete;                        // 是否已删除
  final String? lastAuthorizationTime;       // 最后授权时间
  final String? lockedDate;                  // 锁定日期
  final int lockedState;                     // 锁定状态
  final String loginName;                    // 登录名
  final List<dynamic> managers;              // 管理员列表
  final String openUserId;                   // 开放用户ID
  final int? organizationId;                 // 组织ID
  final String organizationName;             // 组织名称
  final String password;                     // 密码
  final String passwordRandomCode;           // 密码随机码
  final String phone;                        // 电话号码
  final String photoUrl;                     // 头像URL
  final String prepend;                      // 前缀
  final bool presentLogin;                   // 是否当前登录
  final String recommendCode;                // 推荐码
  final String registerDate;                 // 注册日期
  final String registerIp;                   // 注册IP
  final String trueName;                     // 真实姓名
  final String trueNamel;                    // 真实姓名（备用）
  bool isSelected;                     // 是否选中

  UserCompanyModel({
    this.actorIds = const [],
    this.actorList = const [],
    this.actorName = "",
    this.actorStr = "",
    this.companyId = 0,
    this.companyName = "",
    this.createCustomerId = 0,
    this.createLoginName = "",
    this.createTrueName = "",
    this.customerId = 0,
    this.customerSources = 0,
    this.customerType = 0,
    this.email = "",
    this.isDelete = 0,
    this.lastAuthorizationTime,
    this.lockedDate,
    this.lockedState = 0,
    this.loginName = "",
    this.managers = const [],
    this.openUserId = "",
    this.organizationId,
    this.organizationName = "",
    this.password = "",
    this.passwordRandomCode = "",
    this.phone = "",
    this.photoUrl = "",
    this.prepend = "",
    this.presentLogin = false,
    this.recommendCode = "",
    this.registerDate = "",
    this.registerIp = "",
    this.trueName = "",
    this.trueNamel = "",
    this.isSelected = false,
  });

  factory UserCompanyModel.fromJson(Map<String, dynamic> json) {
    return UserCompanyModel(
      actorIds: List<int>.from(json['actorIds'] ?? []),
      actorList: json['actorList'] ?? [],
      actorName: json['actorName'] ?? "",
      actorStr: json['actorStr'] ?? "",
      companyId: json['companyId'] ?? 0,
      companyName: json['companyName'] ?? "",
      createCustomerId: json['createCustomerId'] ?? 0,
      createLoginName: json['createLoginName'] ?? "",
      createTrueName: json['createTrueName'] ?? "",
      customerId: json['customerId'] ?? 0,
      customerSources: json['customerSources'] ?? 0,
      customerType: json['customerType'] ?? 0,
      email: json['email'] ?? "",
      isDelete: json['isDelete'] ?? 0,
      lastAuthorizationTime: json['lastAuthorizationTime'],
      lockedDate: json['lockedDate'],
      lockedState: json['lockedState'] ?? 0,
      loginName: json['loginName'] ?? "",
      managers: json['managers'] ?? [],
      openUserId: json['openUserId'] ?? "",
      organizationId: json['organizationId'],
      organizationName: json['organizationName'] ?? "",
      password: json['password'] ?? "",
      passwordRandomCode: json['passwordRandomCode'] ?? "",
      phone: json['phone'] ?? "",
      photoUrl: json['photoUrl'] ?? "",
      prepend: json['prepend'] ?? "",
      presentLogin: json['presentLogin'] ?? false,
      recommendCode: json['recommendCode'] ?? "",
      registerDate: json['registerDate'] ?? "",
      registerIp: json['registerIp'] ?? "",
      trueName: json['trueName'] ?? "",
      trueNamel: json['trueNamel'] ?? "",
    );
  }
}

class Actor {
  final int actorId;                    // 角色ID
  final String actorName;               // 角色名称
  final int companyId;                  // 公司ID
  final String companyName;             // 公司名称
  final int? companyType;               // 公司类型
  final int isSuperAdmin;               // 是否超级管理员
  final int? oldActorId;                // 旧角色ID
  final String organizationFullName;    // 组织全称
  final int organizationId;             // 组织ID
  final int? positionId;                // 职位ID
  final String positionName;            // 职位名称

  const Actor({
    this.actorId = 0,
    this.actorName = "",
    this.companyId = 0,
    this.companyName = "",
    this.companyType,
    this.isSuperAdmin = 0,
    this.oldActorId,
    this.organizationFullName = "",
    this.organizationId = 0,
    this.positionId,
    this.positionName = "",
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      actorId: json['actorId'] ?? 0,
      actorName: json['actorName'] ?? "",
      companyId: json['companyId'] ?? 0,
      companyName: json['companyName'] ?? "",
      companyType: json['companyType'],
      isSuperAdmin: json['isSuperAdmin'] ?? 0,
      oldActorId: json['oldActorId'],
      organizationFullName: json['organizationFullName'] ?? "",
      organizationId: json['organizationId'] ?? 0,
      positionId: json['positionId'],
      positionName: json['positionName'] ?? "",
    );
  }
}