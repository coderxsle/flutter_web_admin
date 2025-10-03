import 'package:book_store_client/book_store_client.dart';
import 'package:getx_go_main/logger.dart';
import 'dart:convert';
import 'package:serverpod_client/serverpod_client.dart';


/// Serverpod 客户端单例
///
/// 用法示例：
///   final client = ServerpodApi.instance.client;
///   final resp = await client.auth.adminLogin(username, password);
///
/// 开关日志：
///   ServerpodApi.enableApiLog = true;  // 开启
///   ServerpodApi.enableApiLog = false; // 关闭

// 全局可以用的客户端
Client get serverpodClient => ServerpodApi.instance.client;

class ServerpodApi {
  /// API 日志开关（默认开启）
  static bool enableApiLog = true;
  
  /// 获取全局单例
  static ServerpodApi get instance => _instance;
  
  /// 全局 Serverpod 客户端
  late Client _client;
  Client get client => _client;
  
  
  static final ServerpodApi _instance = ServerpodApi._internal();
  ServerpodApi._internal() {
    _initClient();
  }




  /// 初始化客户端（带日志拦截器）
  void _initClient() {
    _client = Client(LOCAL_URL, onSucceededCall: _onApiSuccess, onFailedCall: _onApiError);
  }

  // 如需切换环境，可加：
  void reconfigure(String host) {
    _client = Client(host, onSucceededCall: _onApiSuccess, onFailedCall: _onApiError);
  }

  /// API 请求成功回调
  void _onApiSuccess(MethodCallContext context) {
    if (!enableApiLog) return;

    logger.i('''
┌─────────────────────────────────────────────────────────────
│ ✅ API Success
├─────────────────────────────────────────────────────────────
│ Endpoint: ${context.endpointName}.${context.methodName}
│ Parameters: ${_formatParams(context.arguments)}
└─────────────────────────────────────────────────────────────''');
  }

  /// API 请求失败回调
  void _onApiError(MethodCallContext context, Object error, StackTrace stackTrace) {
    if (!enableApiLog) return;

    logger.e('''
┌─────────────────────────────────────────────────────────────
│ ❌ API Error
├─────────────────────────────────────────────────────────────
│ Endpoint: ${context.endpointName}.${context.methodName}
│ Parameters: ${_formatParams(context.arguments)}
│ Error: $error
└─────────────────────────────────────────────────────────────''');
  }

  /// 格式化参数（避免敏感信息泄露）
  String _formatParams(Map<String, dynamic> params) {
    final filtered = Map<String, dynamic>.from(params);
    // 隐藏敏感字段
    if (filtered.containsKey('password')) {
      filtered['password'] = '******';
    }
    if (filtered.containsKey('token')) {
      filtered['token'] = '******';
    }
    return JsonEncoder.withIndent('  ').convert(filtered);
  }

  /// 便捷访问各端点（可选）
  // EndpointAuth get auth => client.auth;
  // EndpointBook get book => client.book;

}
