import 'package:web/web.dart' as web;
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Flutter Web优化配置
/// 提供Web平台特定的性能优化和监控功能
class WebOptimization {
  /// 初始化Web优化
  static void initialize() {
    if (kIsWeb) {
      _setupPerformanceMonitoring();
      _optimizeRendering();
    }
  }

  /// 设置性能监控
  static void _setupPerformanceMonitoring() {
    if (!kIsWeb) return;
    
    // 注册性能标记函数到JS
    final recordFunc = ((String name, double value) {
      debugPrint('Flutter性能指标 - $name: ${value.toStringAsFixed(2)}ms');
    }).toJS;
    
    // 使用扩展方法语法
    globalContext.setProperty('recordFlutterPerf'.toJS, recordFunc);
    
    // 添加Flutter框架性能监控
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double firstFrameTime = WidgetsBinding.instance.currentSystemFrameTimeStamp.inMicroseconds / 1000;
      
      // 使用 callMethodVarArgs 方法
      globalContext.callMethodVarArgs(
        'recordFlutterPerf'.toJS, 
        [firstFrameTime.toString().toJS, firstFrameTime.toJS]);
    });
  }

  /// 优化渲染性能
  static void _optimizeRendering() {
    if (!kIsWeb) return;
    
    // 设置渲染优先级
    web.document.querySelector('meta[name="viewport"]')?.setAttribute('content', 
      'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no');
    
    // 禁用右键菜单以提高性能
    web.document.addEventListener('contextmenu', 
      ((web.Event event) => event.preventDefault()).toJS);
    
    // 优化触摸事件
    const jsCode = '''
      document.addEventListener('touchstart', function(e) {
        if (e.touches.length > 1) {
          e.preventDefault();
        }
      }, { passive: false });
    ''';
    
    // 使用 callMethodVarArgs 方法
    globalContext.callMethodVarArgs('eval'.toJS, [jsCode.toJS]);
  }

  /// 记录性能指标
  static void recordPerformanceMetric(String name, double milliseconds) {
    if (kIsWeb) {
      // 使用 callMethodVarArgs 方法
      globalContext.callMethodVarArgs(
        'recordPerfMetric'.toJS, 
        [name.toJS, milliseconds.toJS]);
    }
  }

  /// 预加载资源
  static void preloadAssets(List<String> assetPaths) {
    if (!kIsWeb) return;
    
    for (final String path in assetPaths) {
      final link = web.HTMLLinkElement();
      link.rel = 'preload';
      link.href = path;
        
      if (path.endsWith('.woff2') || path.endsWith('.woff')) {
        link.as = 'font';
        link.crossOrigin = 'anonymous';
      } else if (path.endsWith('.png') || path.endsWith('.jpg') || path.endsWith('.jpeg')) {
        link.as = 'image';
      } else if (path.endsWith('.json')) {
        link.as = 'fetch';
      }
      
      web.document.head?.appendChild(link);
    }
  }

  /// 清理内存
  static void cleanupMemory() {
    if (kIsWeb) {
      const jsCode = '''
        if (window.gc) {
          window.gc();
        }
      ''';
      
      // 使用 callMethodVarArgs 方法
      globalContext.callMethodVarArgs('eval'.toJS, [jsCode.toJS]);
    }
  }
  
  /// 获取当前渲染器类型
  static String getRendererType() {
    if (!kIsWeb) return 'native';
    
    // 使用扩展方法语法
    final canvasKit = globalContext.getProperty('flutterCanvasKit'.toJS);
    final renderer = canvasKit != null ? 'canvaskit' : 'html';
    return renderer;
  }
  
  /// 检测网络状态
  static bool isOnline() {
    if (!kIsWeb) return true;
    return web.window.navigator.onLine;
  }
  
  /// 监听网络状态变化
  static void onNetworkStatusChange(void Function(bool isOnline) callback) {
    if (!kIsWeb) return;
    
    web.window.addEventListener('online', 
      ((web.Event _) => callback(true)).toJS);
    web.window.addEventListener('offline', 
      ((web.Event _) => callback(false)).toJS);
  }
} 