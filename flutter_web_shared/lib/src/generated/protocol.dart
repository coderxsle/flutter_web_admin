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
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i1;
import 'generated/requests/user/user_add_request.dart' as _i2;
import 'requests/common/pagination.dart' as _i3;
import 'requests/dept/dept_request.dart' as _i4;
import 'requests/dict_code_request.dart' as _i5;
import 'requests/dict_data_request.dart' as _i6;
import 'requests/menu/menu_request.dart' as _i7;
import 'requests/user/user_list_request.dart' as _i8;
import 'requests/user/user_request.dart' as _i9;
import 'responses/dict_code_response.dart' as _i10;
import 'responses/login_response.dart' as _i11;
import 'responses/menu.dart' as _i12;
import 'responses/user_info.dart' as _i13;
import 'responses/user_info_response.dart' as _i14;
import 'package:flutter_web_shared/flutter_web_shared.dart' as _i15;
export 'generated/requests/user/user_add_request.dart';
export 'requests/common/pagination.dart';
export 'requests/dept/dept_request.dart';
export 'requests/dict_code_request.dart';
export 'requests/dict_data_request.dart';
export 'requests/menu/menu_request.dart';
export 'requests/user/user_list_request.dart';
export 'requests/user/user_request.dart';
export 'responses/dict_code_response.dart';
export 'responses/login_response.dart';
export 'responses/menu.dart';
export 'responses/user_info.dart';
export 'responses/user_info_response.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.UserAddRequest) {
      return _i2.UserAddRequest.fromJson(data) as T;
    }
    if (t == _i3.Pagination) {
      return _i3.Pagination.fromJson(data) as T;
    }
    if (t == _i4.DeptRequest) {
      return _i4.DeptRequest.fromJson(data) as T;
    }
    if (t == _i5.DictCodeRequest) {
      return _i5.DictCodeRequest.fromJson(data) as T;
    }
    if (t == _i6.DictDataRequest) {
      return _i6.DictDataRequest.fromJson(data) as T;
    }
    if (t == _i7.MenuRequest) {
      return _i7.MenuRequest.fromJson(data) as T;
    }
    if (t == _i8.UserListRequest) {
      return _i8.UserListRequest.fromJson(data) as T;
    }
    if (t == _i9.UserRequest) {
      return _i9.UserRequest.fromJson(data) as T;
    }
    if (t == _i10.DictCodeResponse) {
      return _i10.DictCodeResponse.fromJson(data) as T;
    }
    if (t == _i11.LoginResponse) {
      return _i11.LoginResponse.fromJson(data) as T;
    }
    if (t == _i12.Menu) {
      return _i12.Menu.fromJson(data) as T;
    }
    if (t == _i13.UserInfo) {
      return _i13.UserInfo.fromJson(data) as T;
    }
    if (t == _i14.UserInfoResponse) {
      return _i14.UserInfoResponse.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.UserAddRequest?>()) {
      return (data != null ? _i2.UserAddRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Pagination?>()) {
      return (data != null ? _i3.Pagination.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.DeptRequest?>()) {
      return (data != null ? _i4.DeptRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.DictCodeRequest?>()) {
      return (data != null ? _i5.DictCodeRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.DictDataRequest?>()) {
      return (data != null ? _i6.DictDataRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.MenuRequest?>()) {
      return (data != null ? _i7.MenuRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.UserListRequest?>()) {
      return (data != null ? _i8.UserListRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.UserRequest?>()) {
      return (data != null ? _i9.UserRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.DictCodeResponse?>()) {
      return (data != null ? _i10.DictCodeResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.LoginResponse?>()) {
      return (data != null ? _i11.LoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Menu?>()) {
      return (data != null ? _i12.Menu.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.UserInfo?>()) {
      return (data != null ? _i13.UserInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.UserInfoResponse?>()) {
      return (data != null ? _i14.UserInfoResponse.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i15.Menu>) {
      return (data as List).map((e) => deserialize<_i15.Menu>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i15.Menu>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i15.Menu>(e)).toList()
              : null)
          as T;
    }
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.UserAddRequest => 'UserAddRequest',
      _i3.Pagination => 'Pagination',
      _i4.DeptRequest => 'DeptRequest',
      _i5.DictCodeRequest => 'DictCodeRequest',
      _i6.DictDataRequest => 'DictDataRequest',
      _i7.MenuRequest => 'MenuRequest',
      _i8.UserListRequest => 'UserListRequest',
      _i9.UserRequest => 'UserRequest',
      _i10.DictCodeResponse => 'DictCodeResponse',
      _i11.LoginResponse => 'LoginResponse',
      _i12.Menu => 'Menu',
      _i13.UserInfo => 'UserInfo',
      _i14.UserInfoResponse => 'UserInfoResponse',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('flutter_web.', '');
    }

    switch (data) {
      case _i2.UserAddRequest():
        return 'UserAddRequest';
      case _i3.Pagination():
        return 'Pagination';
      case _i4.DeptRequest():
        return 'DeptRequest';
      case _i5.DictCodeRequest():
        return 'DictCodeRequest';
      case _i6.DictDataRequest():
        return 'DictDataRequest';
      case _i7.MenuRequest():
        return 'MenuRequest';
      case _i8.UserListRequest():
        return 'UserListRequest';
      case _i9.UserRequest():
        return 'UserRequest';
      case _i10.DictCodeResponse():
        return 'DictCodeResponse';
      case _i11.LoginResponse():
        return 'LoginResponse';
      case _i12.Menu():
        return 'Menu';
      case _i13.UserInfo():
        return 'UserInfo';
      case _i14.UserInfoResponse():
        return 'UserInfoResponse';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'UserAddRequest') {
      return deserialize<_i2.UserAddRequest>(data['data']);
    }
    if (dataClassName == 'Pagination') {
      return deserialize<_i3.Pagination>(data['data']);
    }
    if (dataClassName == 'DeptRequest') {
      return deserialize<_i4.DeptRequest>(data['data']);
    }
    if (dataClassName == 'DictCodeRequest') {
      return deserialize<_i5.DictCodeRequest>(data['data']);
    }
    if (dataClassName == 'DictDataRequest') {
      return deserialize<_i6.DictDataRequest>(data['data']);
    }
    if (dataClassName == 'MenuRequest') {
      return deserialize<_i7.MenuRequest>(data['data']);
    }
    if (dataClassName == 'UserListRequest') {
      return deserialize<_i8.UserListRequest>(data['data']);
    }
    if (dataClassName == 'UserRequest') {
      return deserialize<_i9.UserRequest>(data['data']);
    }
    if (dataClassName == 'DictCodeResponse') {
      return deserialize<_i10.DictCodeResponse>(data['data']);
    }
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i11.LoginResponse>(data['data']);
    }
    if (dataClassName == 'Menu') {
      return deserialize<_i12.Menu>(data['data']);
    }
    if (dataClassName == 'UserInfo') {
      return deserialize<_i13.UserInfo>(data['data']);
    }
    if (dataClassName == 'UserInfoResponse') {
      return deserialize<_i14.UserInfoResponse>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
