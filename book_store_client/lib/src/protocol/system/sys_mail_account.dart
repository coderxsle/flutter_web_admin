/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// 邮箱账号表
abstract class SysMailAccount implements _i1.SerializableModel {
  SysMailAccount._({
    this.id,
    required this.mail,
    required this.username,
    required this.password,
    required this.host,
    required this.port,
    required this.sslEnable,
    required this.starttlsEnable,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysMailAccount({
    int? id,
    required String mail,
    required String username,
    required String password,
    required String host,
    required int port,
    required bool sslEnable,
    required bool starttlsEnable,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysMailAccountImpl;

  factory SysMailAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysMailAccount(
      id: jsonSerialization['id'] as int?,
      mail: jsonSerialization['mail'] as String,
      username: jsonSerialization['username'] as String,
      password: jsonSerialization['password'] as String,
      host: jsonSerialization['host'] as String,
      port: jsonSerialization['port'] as int,
      sslEnable: jsonSerialization['sslEnable'] as bool,
      starttlsEnable: jsonSerialization['starttlsEnable'] as bool,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String mail;

  String username;

  String password;

  String host;

  int port;

  bool sslEnable;

  bool starttlsEnable;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysMailAccount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysMailAccount copyWith({
    int? id,
    String? mail,
    String? username,
    String? password,
    String? host,
    int? port,
    bool? sslEnable,
    bool? starttlsEnable,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'mail': mail,
      'username': username,
      'password': password,
      'host': host,
      'port': port,
      'sslEnable': sslEnable,
      'starttlsEnable': starttlsEnable,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysMailAccountImpl extends SysMailAccount {
  _SysMailAccountImpl({
    int? id,
    required String mail,
    required String username,
    required String password,
    required String host,
    required int port,
    required bool sslEnable,
    required bool starttlsEnable,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          mail: mail,
          username: username,
          password: password,
          host: host,
          port: port,
          sslEnable: sslEnable,
          starttlsEnable: starttlsEnable,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysMailAccount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysMailAccount copyWith({
    Object? id = _Undefined,
    String? mail,
    String? username,
    String? password,
    String? host,
    int? port,
    bool? sslEnable,
    bool? starttlsEnable,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysMailAccount(
      id: id is int? ? id : this.id,
      mail: mail ?? this.mail,
      username: username ?? this.username,
      password: password ?? this.password,
      host: host ?? this.host,
      port: port ?? this.port,
      sslEnable: sslEnable ?? this.sslEnable,
      starttlsEnable: starttlsEnable ?? this.starttlsEnable,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
