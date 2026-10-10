import 'package:auto_shop_server/app/modules/login/model/button_type.dart';

class UserAccount {
  String? birthday;
  String? notes;
  String? occupation;
  String? idCard;
  num? lockedState;
  String? trueName;
  String? photoUrl;
  String? password;
  num? constellation;
  List? customerCenterPurviewList;
  String? loginIp;
  String? loginName;
  num? customerId;
  String? communityName;
  num? customerInfoId;
  num? communityId;
  String? wxName;
  String? wxUserOpenId;
  List<CustomerActorsItemEntity>? customerActors;
  String? email;
  String? qq;
  String? address;
  String? nickName;
  num? sex;
  String? postcode;
  String? telephone;
  String? userToken;
  num? companyId;
  num? loginFailureCount;
  String? phone;
  num? levelAreaId3;
  num? levelAreaId2;
  num? levelAreaId1;
  num? maritalStatus;
  String? hobby;
  List<ButtonType>? appFunctionList;//登录后下发的动态按钮列表

  UserAccount({this.birthday, this.notes, this.occupation, this.idCard, this.lockedState, this.trueName, this.photoUrl, this.password, this.constellation, this.customerCenterPurviewList, this.loginIp, this.loginName, this.customerId, this.communityName, this.customerInfoId, this.communityId, this.wxName, this.wxUserOpenId, this.customerActors, this.email, this.qq, this.address, this.nickName, this.sex, this.postcode, this.telephone, this.userToken, this.companyId, this.loginFailureCount, this.phone, this.levelAreaId3, this.levelAreaId2, this.levelAreaId1, this.maritalStatus, this.hobby,this.appFunctionList});

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(birthday: json['birthday'],
      notes: json['notes'],
      occupation: json['occupation'],
      idCard: json['idCard'],
      lockedState: json['lockedState'],
      trueName: json['trueName'],
      photoUrl: json['photoUrl'],
      password: json['password'],
      constellation: json['constellation'],
      customerCenterPurviewList: json['customerCenterPurviewList'],
      loginIp: json['loginIp'],
      loginName: json['loginName'],
      customerId: json['customerId'],
      communityName: json['communityName'],
      customerInfoId: json['customerInfoId'],
      communityId: json['communityId'],
      wxName: json['wxName'],
      wxUserOpenId: json['wxUserOpenId'],
      customerActors: json['customerActors'] == null ? null : List<
          CustomerActorsItemEntity>.from(json['customerActors'].map((x) =>
          CustomerActorsItemEntity.fromJson(x))),

      appFunctionList: json['appFunctionList'] == null ? null : List<
          ButtonType>.from(json['appFunctionList'].map((button) =>
          ButtonType.fromJson(button))),

      email: json['email'],
      qq: json['qq'],
      address: json['address'],
      nickName: json['nickName'],
      sex: json['sex'],
      postcode: json['postcode'],
      telephone: json['telephone'],
      userToken: json['userToken'],
      companyId: json['companyId'],
      loginFailureCount: json['loginFailureCount'],
      phone: json['phone'],
      levelAreaId3: json['levelAreaId3'],
      levelAreaId2: json['levelAreaId2'],
      levelAreaId1: json['levelAreaId1'],
      maritalStatus: json['maritalStatus'],
      hobby: json['hobby'],);
  }

  Map<String, dynamic> toJson() =>
      {
        'birthday': birthday,
        'notes': notes,
        'occupation': occupation,
        'idCard': idCard,
        'lockedState': lockedState,
        'trueName': trueName,
        'photoUrl': photoUrl,
        'password': password,
        'constellation': constellation,
        'customerCenterPurviewList': customerCenterPurviewList,
        'loginIp': loginIp,
        'loginName': loginName,
        'customerId': customerId,
        'communityName': communityName,
        'customerInfoId': customerInfoId,
        'communityId': communityId,
        'wxName': wxName,
        'wxUserOpenId': wxUserOpenId,
        'customerActors': customerActors?.map((e) => e.toJson()).toList(),
        'appFunctionList': appFunctionList?.map((button) => button.toJson()).toList(),
        'email': email,
        'qq': qq,
        'address': address,
        'nickName': nickName,
        'sex': sex,
        'postcode': postcode,
        'telephone': telephone,
        'userToken': userToken,
        'companyId': companyId,
        'loginFailureCount': loginFailureCount,
        'phone': phone,
        'levelAreaId3': levelAreaId3,
        'levelAreaId2': levelAreaId2,
        'levelAreaId1': levelAreaId1,
        'maritalStatus': maritalStatus,
        'hobby': hobby,
      };
}

class CustomerActorsItemEntity {
  num? customerActorId;
  num? actorId;
  num? customerId;
  String? actorName;
  num? isSuperAdmin;

  CustomerActorsItemEntity(
      {this.customerActorId, this.actorId, this.customerId, this.actorName, this.isSuperAdmin,});

  factory CustomerActorsItemEntity.fromJson(Map<String, dynamic> json) {
    return CustomerActorsItemEntity(customerActorId: json['customerActorId'],
      actorId: json['actorId'],
      customerId: json['customerId'],
      actorName: json['actorName'],
      isSuperAdmin: json['isSuperAdmin'],);
  }

  Map<String, dynamic> toJson() =>
      {
        'customerActorId': customerActorId,
        'actorId': actorId,
        'customerId': customerId,
        'actorName': actorName,
        'isSuperAdmin': isSuperAdmin,
      };
}