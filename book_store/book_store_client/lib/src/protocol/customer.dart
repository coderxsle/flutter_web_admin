/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// 用于存储书店客户/会员的基本信息
/// customer: 面向前台的客户/会员账户系统
abstract class Customer implements _i1.SerializableModel {
  Customer._({
    this.id,
    String? userName,
    String? password,
    String? nickname,
    String? phone,
    String? email,
    int? status,
    int? memberLevel,
    DateTime? createTime,
    DateTime? updateTime,
  })  : userName = userName ?? '',
        password = password ?? '',
        nickname = nickname ?? '',
        phone = phone ?? '',
        email = email ?? '',
        status = status ?? 0,
        memberLevel = memberLevel ?? 0,
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now();

  factory Customer({
    int? id,
    String? userName,
    String? password,
    String? nickname,
    String? phone,
    String? email,
    int? status,
    int? memberLevel,
    DateTime? createTime,
    DateTime? updateTime,
  }) = _CustomerImpl;

  factory Customer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Customer(
      id: jsonSerialization['id'] as int?,
      userName: jsonSerialization['userName'] as String,
      password: jsonSerialization['password'] as String,
      nickname: jsonSerialization['nickname'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String,
      status: jsonSerialization['status'] as int,
      memberLevel: jsonSerialization['memberLevel'] as int,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 用户名（唯一）
  String userName;

  /// 密码
  String password;

  /// 昵称
  String nickname;

  /// 手机号
  String phone;

  /// 邮箱
  String email;

  /// 账户状态：0-正常，1-禁用
  int status;

  /// 会员等级：0-普通会员，1-银卡会员，2-金卡会员
  int memberLevel;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  Customer copyWith({
    int? id,
    String? userName,
    String? password,
    String? nickname,
    String? phone,
    String? email,
    int? status,
    int? memberLevel,
    DateTime? createTime,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userName': userName,
      'password': password,
      'nickname': nickname,
      'phone': phone,
      'email': email,
      'status': status,
      'memberLevel': memberLevel,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerImpl extends Customer {
  _CustomerImpl({
    int? id,
    String? userName,
    String? password,
    String? nickname,
    String? phone,
    String? email,
    int? status,
    int? memberLevel,
    DateTime? createTime,
    DateTime? updateTime,
  }) : super._(
          id: id,
          userName: userName,
          password: password,
          nickname: nickname,
          phone: phone,
          email: email,
          status: status,
          memberLevel: memberLevel,
          createTime: createTime,
          updateTime: updateTime,
        );

  @override
  Customer copyWith({
    Object? id = _Undefined,
    String? userName,
    String? password,
    String? nickname,
    String? phone,
    String? email,
    int? status,
    int? memberLevel,
    DateTime? createTime,
    DateTime? updateTime,
  }) {
    return Customer(
      id: id is int? ? id : this.id,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      nickname: nickname ?? this.nickname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      status: status ?? this.status,
      memberLevel: memberLevel ?? this.memberLevel,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}
