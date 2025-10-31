import 'dart:async';
import 'package:flutter_web_shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// WebSocket 连接状态回调
typedef WebSocketStatusCallback = void Function(bool isConnected);

/// WebSocket 消息回调
typedef WebSocketMessageCallback = void Function(String message);

/// WebSocket 错误回调
typedef WebSocketErrorCallback = void Function(dynamic error);

/// WebSocket 管理器
class WebSocketManager {
  // 配置常量
  static const int _maxRetryCount = 3;        // 最大重试次数
  static const int _retryDelaySeconds = 1;    // 重试间隔（秒）
  static const int _sendTimeoutSeconds = 15;  // 发送超时时间（秒）
  
  WebSocketChannel? _channel;
  bool _isConnected = false;
  DateTime? _lastSendTime;
  
  // 回调函数
  final WebSocketStatusCallback? onConnectionStatusChanged;
  final WebSocketMessageCallback? onMessageReceived;
  final WebSocketErrorCallback? onError;
  
  WebSocketManager({
    this.onConnectionStatusChanged,
    this.onMessageReceived,
    this.onError,
  });

  bool get isConnected => _isConnected;
  DateTime? get lastSendTime => _lastSendTime;

  /// 建立 WebSocket 连接
  Future<bool> connect(String url, {Map<String, String>? headers}) async {
    for (int retry = 0; retry < _maxRetryCount; retry++) {
      try {

        logger.d('官网示例的 URL: wss://rtasr.xfyun.cn/v1/ws?appid=595f23df&ts=1512041814&signa=IrrzsJeOFk1NGfJHW6SkHUoN9CU=');

        logger.d('WebSocket URL: $url');

        logger.i('正在尝试连接WebSocket (第${retry + 1}次)...');

        _channel = WebSocketChannel.connect(Uri.parse(url));
        
        // 监听 WebSocket 消息
        _channel!.stream.listen(_message, onError: _error, onDone: _done);
        
        _isConnected = true;
        _lastSendTime = DateTime.now();
        onConnectionStatusChanged?.call(_isConnected);
        
        logger.i('WebSocket连接成功');
        return true;
      } catch (e, stack) {
        logger.e('WebSocket连接失败', error: e, stackTrace: stack);
        _isConnected = false;
        onConnectionStatusChanged?.call(_isConnected);
        
        if (retry < _maxRetryCount - 1) {
          logger.i('等待$_retryDelaySeconds秒后重试...');
          await Future.delayed(const Duration(seconds: _retryDelaySeconds));
        }
      }
    }
    return false;
  }

  /// 处理 WebSocket 消息
  void _message(dynamic message) {
    try {

      onMessageReceived?.call(message.toString());

    } catch (e, stack) {
      logger.e('处理消息失败', error: e, stackTrace: stack);
    }
  }

  /// 处理 WebSocket 错误
  void _error(dynamic error) {
    logger.e('WebSocket错误: $error');
    _isConnected = false;
    onConnectionStatusChanged?.call(_isConnected);
    onError?.call(error);
  }

  /// 处理 WebSocket 关闭
  void _done() {
    _isConnected = false;
    onConnectionStatusChanged?.call(_isConnected);
  }

  /// 发送数据
  Future<void> send(dynamic data) async {
    if (!_isConnected || _channel == null) {
      logger.w('WebSocket未连接，无法发送数据');
      return;
    }

    // 检查发送间隔
    if (_lastSendTime != null) {
      final now = DateTime.now();
      if (now.difference(_lastSendTime!) > const Duration(seconds: _sendTimeoutSeconds)) {
        logger.e('数据发送超时');
        disconnect();
        throw TimeoutException('数据发送超时，已断开连接');
      }
    }

    try {
      _channel!.sink.add(data);
      _lastSendTime = DateTime.now();
    } catch (e, stack) {
      logger.e('发送数据失败', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// 关闭连接
  void disconnect() {
    logger.i('正在关闭WebSocket连接');
    
    if (_channel != null) {
      _isConnected = false;
      onConnectionStatusChanged?.call(_isConnected);
      _channel!.sink.close();
      _channel = null;
      _lastSendTime = null;
      logger.i('WebSocket连接已关闭');
    } else {
      logger.d('WebSocket已经关闭');
    }
  }

  /// 释放资源
  void dispose() {
    disconnect();
  }
}