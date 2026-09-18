/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_web_shared/flutter_web_shared.dart' as _iq2hfrj8;
import 'package:serverpod_serialization/serverpod_serialization.dart' as _iss;
import 'generated/requests/user/user_add_request.dart' as _i7yixuie;
import 'requests/common/pagination.dart' as _itl4kzds;
import 'requests/dept/dept_request.dart' as _is9xqypk;
import 'requests/dict_code_request.dart' as _iaak6ul3;
import 'requests/dict_data_request.dart' as _iebfzj6q;
import 'requests/menu/menu_request.dart' as _icikpxxo;
import 'requests/user/user_list_request.dart' as _is2dk0a6;
import 'requests/user/user_request.dart' as _i9wrndu2;
import 'responses/dict_code_response.dart' as _i2pr3qtq;
import 'responses/login_response.dart' as _i040frdn;
import 'responses/menu.dart' as _iesexrja;
import 'responses/user_info.dart' as _ivixcmb7;
import 'responses/user_info_response.dart' as _isnnzsug;
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

class Protocol extends _iss.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  final Set<_iss.SerializationManager> _hostProtocols = {};

  void registerHostProtocol(
    String projectName,
    _iss.SerializationManager protocol,
  ) {
    _hostProtocols.add(protocol);
  }

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(dynamic data, [Type? t]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _iss.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i7yixuie.UserAddRequest) {
      return _i7yixuie.UserAddRequest.fromJson(data) as T;
    }
    if (t == _itl4kzds.Pagination) {
      return _itl4kzds.Pagination.fromJson(data) as T;
    }
    if (t == _is9xqypk.DeptRequest) {
      return _is9xqypk.DeptRequest.fromJson(data) as T;
    }
    if (t == _iaak6ul3.DictCodeRequest) {
      return _iaak6ul3.DictCodeRequest.fromJson(data) as T;
    }
    if (t == _iebfzj6q.DictDataRequest) {
      return _iebfzj6q.DictDataRequest.fromJson(data) as T;
    }
    if (t == _icikpxxo.MenuRequest) {
      return _icikpxxo.MenuRequest.fromJson(data) as T;
    }
    if (t == _is2dk0a6.UserListRequest) {
      return _is2dk0a6.UserListRequest.fromJson(data) as T;
    }
    if (t == _i9wrndu2.UserRequest) {
      return _i9wrndu2.UserRequest.fromJson(data) as T;
    }
    if (t == _i2pr3qtq.DictCodeResponse) {
      return _i2pr3qtq.DictCodeResponse.fromJson(data) as T;
    }
    if (t == _i040frdn.LoginResponse) {
      return _i040frdn.LoginResponse.fromJson(data) as T;
    }
    if (t == _iesexrja.Menu) {
      return _iesexrja.Menu.fromJson(data) as T;
    }
    if (t == _ivixcmb7.UserInfo) {
      return _ivixcmb7.UserInfo.fromJson(data) as T;
    }
    if (t == _isnnzsug.UserInfoResponse) {
      return _isnnzsug.UserInfoResponse.fromJson(data) as T;
    }
    if (t == _iss.getType<_i7yixuie.UserAddRequest?>()) {
      return (data != null ? _i7yixuie.UserAddRequest.fromJson(data) : null)
          as T;
    }
    if (t == _iss.getType<_itl4kzds.Pagination?>()) {
      return (data != null ? _itl4kzds.Pagination.fromJson(data) : null) as T;
    }
    if (t == _iss.getType<_is9xqypk.DeptRequest?>()) {
      return (data != null ? _is9xqypk.DeptRequest.fromJson(data) : null) as T;
    }
    if (t == _iss.getType<_iaak6ul3.DictCodeRequest?>()) {
      return (data != null ? _iaak6ul3.DictCodeRequest.fromJson(data) : null)
          as T;
    }
    if (t == _iss.getType<_iebfzj6q.DictDataRequest?>()) {
      return (data != null ? _iebfzj6q.DictDataRequest.fromJson(data) : null)
          as T;
    }
    if (t == _iss.getType<_icikpxxo.MenuRequest?>()) {
      return (data != null ? _icikpxxo.MenuRequest.fromJson(data) : null) as T;
    }
    if (t == _iss.getType<_is2dk0a6.UserListRequest?>()) {
      return (data != null ? _is2dk0a6.UserListRequest.fromJson(data) : null)
          as T;
    }
    if (t == _iss.getType<_i9wrndu2.UserRequest?>()) {
      return (data != null ? _i9wrndu2.UserRequest.fromJson(data) : null) as T;
    }
    if (t == _iss.getType<_i2pr3qtq.DictCodeResponse?>()) {
      return (data != null ? _i2pr3qtq.DictCodeResponse.fromJson(data) : null)
          as T;
    }
    if (t == _iss.getType<_i040frdn.LoginResponse?>()) {
      return (data != null ? _i040frdn.LoginResponse.fromJson(data) : null)
          as T;
    }
    if (t == _iss.getType<_iesexrja.Menu?>()) {
      return (data != null ? _iesexrja.Menu.fromJson(data) : null) as T;
    }
    if (t == _iss.getType<_ivixcmb7.UserInfo?>()) {
      return (data != null ? _ivixcmb7.UserInfo.fromJson(data) : null) as T;
    }
    if (t == _iss.getType<_isnnzsug.UserInfoResponse?>()) {
      return (data != null ? _isnnzsug.UserInfoResponse.fromJson(data) : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _iss.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _iss.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_iq2hfrj8.Menu>) {
      return (data as List).map((e) => deserialize<_iq2hfrj8.Menu>(e)).toList()
          as T;
    }
    if (t == _iss.getType<List<_iq2hfrj8.Menu>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iq2hfrj8.Menu>(e))
                    .toList()
              : null)
          as T;
    }
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i7yixuie.UserAddRequest => 'UserAddRequest',
      _itl4kzds.Pagination => 'Pagination',
      _is9xqypk.DeptRequest => 'DeptRequest',
      _iaak6ul3.DictCodeRequest => 'DictCodeRequest',
      _iebfzj6q.DictDataRequest => 'DictDataRequest',
      _icikpxxo.MenuRequest => 'MenuRequest',
      _is2dk0a6.UserListRequest => 'UserListRequest',
      _i9wrndu2.UserRequest => 'UserRequest',
      _i2pr3qtq.DictCodeResponse => 'DictCodeResponse',
      _i040frdn.LoginResponse => 'LoginResponse',
      _iesexrja.Menu => 'Menu',
      _ivixcmb7.UserInfo => 'UserInfo',
      _isnnzsug.UserInfoResponse => 'UserInfoResponse',
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
      case _i7yixuie.UserAddRequest():
        return 'UserAddRequest';
      case _itl4kzds.Pagination():
        return 'Pagination';
      case _is9xqypk.DeptRequest():
        return 'DeptRequest';
      case _iaak6ul3.DictCodeRequest():
        return 'DictCodeRequest';
      case _iebfzj6q.DictDataRequest():
        return 'DictDataRequest';
      case _icikpxxo.MenuRequest():
        return 'MenuRequest';
      case _is2dk0a6.UserListRequest():
        return 'UserListRequest';
      case _i9wrndu2.UserRequest():
        return 'UserRequest';
      case _i2pr3qtq.DictCodeResponse():
        return 'DictCodeResponse';
      case _i040frdn.LoginResponse():
        return 'LoginResponse';
      case _iesexrja.Menu():
        return 'Menu';
      case _ivixcmb7.UserInfo():
        return 'UserInfo';
      case _isnnzsug.UserInfoResponse():
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
      return deserialize<_i7yixuie.UserAddRequest>(data['data']);
    }
    if (dataClassName == 'Pagination') {
      return deserialize<_itl4kzds.Pagination>(data['data']);
    }
    if (dataClassName == 'DeptRequest') {
      return deserialize<_is9xqypk.DeptRequest>(data['data']);
    }
    if (dataClassName == 'DictCodeRequest') {
      return deserialize<_iaak6ul3.DictCodeRequest>(data['data']);
    }
    if (dataClassName == 'DictDataRequest') {
      return deserialize<_iebfzj6q.DictDataRequest>(data['data']);
    }
    if (dataClassName == 'MenuRequest') {
      return deserialize<_icikpxxo.MenuRequest>(data['data']);
    }
    if (dataClassName == 'UserListRequest') {
      return deserialize<_is2dk0a6.UserListRequest>(data['data']);
    }
    if (dataClassName == 'UserRequest') {
      return deserialize<_i9wrndu2.UserRequest>(data['data']);
    }
    if (dataClassName == 'DictCodeResponse') {
      return deserialize<_i2pr3qtq.DictCodeResponse>(data['data']);
    }
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i040frdn.LoginResponse>(data['data']);
    }
    if (dataClassName == 'Menu') {
      return deserialize<_iesexrja.Menu>(data['data']);
    }
    if (dataClassName == 'UserInfo') {
      return deserialize<_ivixcmb7.UserInfo>(data['data']);
    }
    if (dataClassName == 'UserInfoResponse') {
      return deserialize<_isnnzsug.UserInfoResponse>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  Object? dynamicFieldToJson(Object? object, {bool forProtocol = false}) {
    if ((object is List || object is Set || object is Map) ||
        getClassNameForObject(object) != null) {
      return super.dynamicFieldToJson(object, forProtocol: forProtocol);
    }
    for (final protocol in _hostProtocols) {
      final className = protocol.getClassNameForObject(object);
      if (className == null) continue;
      final host = protocol.getModuleName();
      final wrapped = {
        'className': className.contains('.') ? className : '$host.$className',
        'data': object,
      };
      return forProtocol
          ? _iss.SerializationManager.toEncodableForProtocol(wrapped)
          : _iss.SerializationManager.toEncodable(wrapped);
    }
    return super.dynamicFieldToJson(object, forProtocol: forProtocol);
  }

  @override
  dynamic deserializeDynamicFieldValue(Object? value) {
    if (value == null) return null;
    if (value is! Map<String, dynamic> || value['className'] is! String) {
      throw FormatException(
        'Dynamic fields are encoded as a Map with className and data, but got '
        '${value.runtimeType} instead.',
      );
    }
    final className = value['className'] as String;
    for (final protocol in _hostProtocols) {
      final host = protocol.getModuleName();
      final hostPrefix = '$host.';
      if (className.startsWith(hostPrefix)) {
        final strippedClassName = className.substring(hostPrefix.length);
        if (strippedClassName.contains('.')) {
          throw FormatException(
            'Dynamic field className must not use multiple prefixes: $className',
          );
        }
        final hostData = Map<String, dynamic>.from(value);
        hostData['className'] = strippedClassName;
        return protocol.deserializeByClassName(hostData);
      }
    }
    if (className.contains('.')) {
      for (final protocol in _hostProtocols) {
        try {
          return protocol.deserializeByClassName(value);
        } on _iss.DeserializationClassNameNotFoundException catch (_) {}
      }
    }
    return deserializeByClassName(value);
  }

  @override
  String getModuleName() => 'flutter_web';

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
