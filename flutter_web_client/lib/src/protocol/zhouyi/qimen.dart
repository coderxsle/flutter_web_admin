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

abstract class Qimen implements _i1.SerializableModel {
  Qimen._({
    this.id,
    required this.userId,
    required this.panTime,
    required this.method,
    required this.dunType,
    required this.juShu,
    required this.question,
    required this.analysis,
    DateTime? createTime,
    DateTime? updateTime,
  })  : createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now();

  factory Qimen({
    int? id,
    required int userId,
    required DateTime panTime,
    required String method,
    required String dunType,
    required int juShu,
    required String question,
    required String analysis,
    DateTime? createTime,
    DateTime? updateTime,
  }) = _QimenImpl;

  factory Qimen.fromJson(Map<String, dynamic> jsonSerialization) {
    return Qimen(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      panTime: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['panTime']),
      method: jsonSerialization['method'] as String,
      dunType: jsonSerialization['dunType'] as String,
      juShu: jsonSerialization['juShu'] as int,
      question: jsonSerialization['question'] as String,
      analysis: jsonSerialization['analysis'] as String,
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

  int userId;

  /// 排盘时间
  DateTime panTime;

  /// 排盘方式（如奇门遁甲、四柱八字等）
  String method;

  /// 遁法（阳遁、阴遁）
  String dunType;

  /// # 局数（1~9）
  int juShu;

  /// 占事（用户所问之事）
  String question;

  /// 断言（断语或推演结果）
  String analysis;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// Returns a shallow copy of this [Qimen]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Qimen copyWith({
    int? id,
    int? userId,
    DateTime? panTime,
    String? method,
    String? dunType,
    int? juShu,
    String? question,
    String? analysis,
    DateTime? createTime,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'panTime': panTime.toJson(),
      'method': method,
      'dunType': dunType,
      'juShu': juShu,
      'question': question,
      'analysis': analysis,
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

class _QimenImpl extends Qimen {
  _QimenImpl({
    int? id,
    required int userId,
    required DateTime panTime,
    required String method,
    required String dunType,
    required int juShu,
    required String question,
    required String analysis,
    DateTime? createTime,
    DateTime? updateTime,
  }) : super._(
          id: id,
          userId: userId,
          panTime: panTime,
          method: method,
          dunType: dunType,
          juShu: juShu,
          question: question,
          analysis: analysis,
          createTime: createTime,
          updateTime: updateTime,
        );

  /// Returns a shallow copy of this [Qimen]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Qimen copyWith({
    Object? id = _Undefined,
    int? userId,
    DateTime? panTime,
    String? method,
    String? dunType,
    int? juShu,
    String? question,
    String? analysis,
    DateTime? createTime,
    DateTime? updateTime,
  }) {
    return Qimen(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      panTime: panTime ?? this.panTime,
      method: method ?? this.method,
      dunType: dunType ?? this.dunType,
      juShu: juShu ?? this.juShu,
      question: question ?? this.question,
      analysis: analysis ?? this.analysis,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}
