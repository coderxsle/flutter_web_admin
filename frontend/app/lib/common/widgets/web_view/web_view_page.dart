import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:auto_shop_server/app/utils/constant_api.dart';
import 'package:auto_shop_server/app/utils/strings.dart';
import 'package:auto_shop_server/app/modules/pay_manager/wechat_manager.dart';
import 'package:auto_shop_server/utils/device_utils.dart';
import 'package:auto_shop_server/utils/error_log_utils.dart';
import 'package:auto_shop_server/common/widgets/circular_progress_dialog_number_anim.dart';
import 'package:auto_shop_server/common/widgets/permisson_manager.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../app/utils/common_widget/base_controller.dart';
import '../../../app/utils/common_widget/my_dialog.dart';
import '../../../app/utils/sring_utils.dart';
import '../../common_tools.dart';
import 'java_script_api.dart';

class WebViewPage extends StatefulWidget {
  final String? url; // 初始URL
  final String? title;
  final dynamic param;
  const WebViewPage({super.key, this.url, this.title, this.param});
  @override
  State<WebViewPage> createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> with SingleTickerProviderStateMixin {
  WebViewEnvironment? _webViewEnvironment;
  late final InAppWebViewController _controller;

  String _url = "";
  String _title = ''; // 动态网页标题
  double progress = 0; // 页面加载进度
  late Animation<double> _animation;
  late AnimationController _animationCtrl; // 动画控制器
  Duration animationTime = const Duration(milliseconds: 500); // 动画持续时间
  //监听下载任务，只能放在外部
  // ReceivePort portImageDownLoader = ReceivePort();
  //最后一次下载的文件
  // String downLoadFileFullPathLastTime = "";
  //目前只支持下载一张
  // String taskIdImage = "";

  // 添加菜单锁定状态变量
  bool _isMenuLocked = false;

  @override
  void dispose() {
    _animationCtrl.dispose();
    _unbindBackgroundIsolate();
    super.dispose();
  }

  @override
  void initState() {
    _webViewEnvironment = AppManager.webViewEnvironment;
    _setupParam();
    _setupProgress();
    //存储图片圈圈
    try {
      Get.put(NumberAnimController());
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w(" catch Exception =>${e.toString()}");
        ErrorLogUtils.addLogSingle(fun: "Get.put(NumberAnimController())", error: "${toString()}NumberAnimController的pub报错$e");
      }
    }

    /*try {
      //初始化下载器
      FlutterDownloader.registerCallback(downloadCallback, step: 10);
      final isSuccess = IsolateNameServer.registerPortWithName(portImageDownLoader.sendPort, imageDownloader_send_port);
      //logger.d("$isSuccess 注册状态 外部--：${isSuccess.toString()}");
      if (!isSuccess) {
        _unbindBackgroundIsolate();
        return;
      }

      portImageDownLoader.listen((dynamic data) async {
        //如果用到就取，用不到暂屏蔽
        //final taskId = (data as List<dynamic>)[0] as String;
        final status = DownloadTaskStatus.fromInt(data[1] as int);
        //final progress = data[2] as int;
        setState(() {
          //logger.d(" setState progress 更新进度条 外部：${progress.toString()}");
        });

        if (status == DownloadTaskStatus.complete) {
          logger.d("下载完成--complete");
          //showMessageBottomLikeAndroid("下载完成", isLong: false);
          //Directory saveDirDoc = await getApplicationDocumentsDirectory();
          //可能是动态权限的问题？
          FileUtilsMy.saveImageToAlbum(downLoadFileFullPathLastTime,showMsg: true);

        } else if (status == DownloadTaskStatus.running) {
          //logger.d("下载中");
        } else if (status == DownloadTaskStatus.canceled) {
          //logger.d("下载取消");
          showMessageBottomLikeAndroid("下载取消", isLong: false);
        } else if (status == DownloadTaskStatus.failed) {
          //logger.d("下载失败");
          showMessageBottomLikeAndroid("下载失败", isLong: false);
        }
      });
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.d(" catch Exception =>${e.toString()}");
      }
    }*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 禁用系统的默认返回手势,false代表允许返回
      onPopInvokedWithResult: (didPop, result) {
        _onPopInvokedWithResult(context, didPop, result);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: Platform.isAndroid ? true : false, // 避免键盘引发的,电子签页面进入编辑状态时，造成的页面跳动
        appBar: AppBar(
          backgroundColor: Colors.white,
          shape: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 0.5)),
          // title: NavigatorTitle(_title, color: Colors.black),
          title: Text(_title, style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600)),
          leadingWidth: 100,
          leading: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () async {
                  if (await _controller.canGoBack()) {
                    _controller.goBack();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.close_sharp, size: 30, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            if (progress < 1.0) LinearProgressIndicator(value: progress, minHeight: 2, color: Colors.indigoAccent),
            // 显示加载进度
            Expanded(
              child: InAppWebView(
                webViewEnvironment: _webViewEnvironment,
                initialSettings: InAppWebViewSettings(
                  useHybridComposition: true, // 启用混合模式以解决 WebView 层级问题
                  supportZoom: true, // 启用页面缩放功能，允许用户手动调整页面大小
                  useWideViewPort: true, // 允许 WebView 使用宽视图端口，使页面能够适配设备宽度
                  loadWithOverviewMode: true, // 根据视图大小调整页面缩放比例，适应屏幕
                  // forceDark: ForceDark.ON,                           // （可选）开启深色模式支持，适合夜间模式（仅 Android）
                  javaScriptEnabled: true, // 启用 JavaScript 支持，加载动态内容时必需
                  builtInZoomControls: true, // 显示缩放控制按钮（仅 Android）
                  displayZoomControls: false, // 隐藏缩放控制按钮（仅 Android）
                  allowFileAccess: true, // 允许访问本地文件，加载本地资源时需要
                  allowUniversalAccessFromFileURLs: true, // 允许从本地文件的 URL 加载其他资源，跨域需求时启用
                  isInspectable: kDebugMode, // 在调试模式下启用可检查功能（适用于开发调试）
                  iframeAllowFullscreen: true, // 允许 iframe 元素进入全屏模式
                  allowsInlineMediaPlayback: true, // 允许媒体（如视频）内联播放而非全屏
                  iframeAllow: "camera; microphone", // 为 iframe 元素启用相机和麦克风权限
                  mediaPlaybackRequiresUserGesture: false, // 媒体播放需要用户手势触发，防止自动播放
                  disableLongPressContextMenuOnLinks: true, // 禁用链接上的长按菜单
                  disableContextMenu: false, // 允许上下文菜单显示
                  suppressesIncrementalRendering: false, // 立即显示内容而不是等待全部渲染
                  verticalScrollBarEnabled: true, // 显示垂直滚动条
                  horizontalScrollBarEnabled: true, // 显示水平滚动条
                ),
                // initialData: InAppWebViewInitialData(data: html),
                initialUrlRequest: URLRequest(url: WebUri(_url)),
                onWebViewCreated: _onWebViewCreated,
                onLoadStart: _onLoadStart,
                onLoadStop: _onLoadStop,
                onReceivedError: _onReceivedError,
                onReceivedHttpError: _onReceivedHttpError,
                onTitleChanged: _onTitleChanged,
                onProgressChanged: _onProgressChanged,
                onConsoleMessage: _onConsoleMessage,
                contextMenu: ContextMenu(
                  menuItems: [
                    ContextMenuItem(
                        androidId: 1,
                        iosId: "1",
                        title: "复制",
                        action: () async {
                          String? selectedText = await _controller.getSelectedText();
                          if (selectedText != null && selectedText.isNotEmpty) {
                            await Clipboard.setData(ClipboardData(text: selectedText));
                            showMessageBottomLikeAndroid("复制成功", isLong: false);
                          }
                          return;
                        }),
                  ],
                  settings: ContextMenuSettings(
                    hideDefaultSystemContextMenuItems: true,
                  ),
                ),
                shouldOverrideUrlLoading: _shouldOverrideUrlLoading,
                onLongPressHitTestResult: _onLongPressHitTestResult,
                onPermissionRequest: (controller, PermissionRequest permissionRequest) async {
                  logger.i("WebView权限请求开始 - 请求的权限资源: ${permissionRequest.resources}");

                  // 检查是否包含摄像头权限请求
                  bool needsCamera = permissionRequest.resources.contains(PermissionResourceType.CAMERA);
                  logger.i("是否需要摄像头权限: $needsCamera");

                  if (!needsCamera) {
                    logger.i("不需要摄像头权限，直接授予请求的权限");
                    return PermissionResponse(resources: permissionRequest.resources, action: PermissionResponseAction.GRANT);
                  }

                  // 创建一个 Completer 来处理异步权限结果
                  logger.i("创建异步权限处理器");
                  final completer = Completer<PermissionResponse>();

                  // 检查权限状态
                  bool hasPermission = await PermissionManager.checkCamera();
                  logger.d("当前摄像头权限状态: ${hasPermission ? "已授予" : "未授予"}");

                  if (!hasPermission) {
                    logger.d("开始请求摄像头权限");
                    final message = "网页需要访问您的摄像头权限，以便进行拍照或录像等操作。";
                    PermissionManager.requestCamera(
                        message: message,
                        ok: () async {
                          logger.i("用户已在系统设置中授予摄像头权限");
                          // 权限授予后，重新触发权限响应
                          logger.i("完成权限请求，返回 GRANT 响应");
                          completer.complete(PermissionResponse(resources: permissionRequest.resources, action: PermissionResponseAction.GRANT));
                        });

                    logger.d("等待用户操作权限设置");
                    return completer.future;
                  }

                  logger.i("已有摄像头权限，返回 GRANT 响应");
                  return PermissionResponse(resources: permissionRequest.resources, action: PermissionResponseAction.GRANT);
                },
                // onJsAlert: (controller, jsAlertRequest) async {
                //   // return jsAlertCallback(context, jsAlertRequest.message ?? "");
                // },
                // onJsConfirm: (controller, jsConfirmRequest) async {
                //   // return jsConfirmCallback(context, jsConfirmRequest.message ?? "");
                // },
                // onJsPrompt: (controller, jsPromptRequest) async {
                //   // return jsPromptCallback(context, jsPromptRequest.message ?? "", jsPromptRequest.defaultValue);
                // },
              ),
            )
          ],
        ),
      ),
    );
  }

  _onPopInvokedWithResult(context, bool didPop, Object? result) async {
    if (didPop) {
      //Logger.logMy("didPop-->$didPop");
      return;
    } else {
      //Logger.logMy("didPop-下一步下一步->$didPop");
      _webViewGoBack(context);
    }
    //原始代码
    // if (!didPop) _webViewGoBack(context);
  }

  _webViewGoBack(context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> _onWebViewCreated(InAppWebViewController controller) async {
    _controller = controller;
    _setUserAgent();
    JavaScriptApi.register(controller);

    // 禁用长按菜单的初始化设置
    await _injectJavaScript(controller);

    // 添加JavaScript处理器
    _addJavaScriptHandlers(controller);

    // 注入DOM准备好时的回调
    await controller.evaluateJavascript(source: """
      if (document.readyState === 'complete') {
        window.flutter_inappwebview.callHandler('domReady');
      } else {
        document.addEventListener('DOMContentLoaded', function() {
          window.flutter_inappwebview.callHandler('domReady');
        });
      }
    """);

    // 设置键盘模式为 RESIZE_MODE
    await controller.setSettings(
      settings: InAppWebViewSettings(
        useHybridComposition: true,
        // 设置键盘模式，使页面在键盘弹出时自动调整大小
        displayZoomControls: false,
        cacheEnabled: false, //减小内存压力
        // 添加以下设置
        verticalScrollbarPosition: VerticalScrollbarPosition.SCROLLBAR_POSITION_RIGHT,
        supportMultipleWindows: true,
      ),
    );
  }

  void handleLongPress(List<dynamic> args) {
    if (args.isEmpty || args[0] is! String) return;

    String url = args[0];
    print("收到长按事件: $url");

    // 检查菜单锁定状态
    if (_isMenuLocked) {
      print("菜单已锁定，忽略此次长按");
      return;
    }

    // 锁定菜单，防止重复触发
    setState(() {
      _isMenuLocked = true;
    });

    // 显示菜单
    // _showBottomSheet(context, url);
  }

  Future<void> _injectJavaScript(InAppWebViewController controller) async {
    // 修改CSS，只对图片禁用默认行为，允许文本选择
    await controller.injectCSSCode(source: '''
      img {
        -webkit-touch-callout: none;
        -webkit-user-select: none;
        user-select: none;
        pointer-events: auto !important;
      }
      
      /* 增强文本选择样式 */
      ::selection {
        background: #b3d4fc;
        text-shadow: none;
      }
    ''');

    // 处理长按事件的JavaScript
    await controller.evaluateJavascript(source: '''
      (function() {
        // 防止重复初始化
        if (window.longPressInitialized) return;
        window.longPressInitialized = true;
        
        // 只对图片元素阻止默认上下文菜单
        document.addEventListener('contextmenu', function(e) {
          if (e.target.tagName.toLowerCase() === 'img') {
            e.preventDefault();
            return false;
          }
          // 允许文本选择的默认上下文菜单
          return true;
        }, false);
        
        var longPressTimer;
        var longPressThreshold = 500; // 长按时间阈值（毫秒）
        
        // 触摸开始
        document.addEventListener('touchstart', function(e) {
          if (longPressTimer) clearTimeout(longPressTimer);
          
          // 检查是否是图片元素
          var target = e.target;
          if (target.tagName.toLowerCase() === 'img') {
            longPressTimer = setTimeout(function() {
              var imgSrc = target.getAttribute('src');
              
              // 如果是相对路径，转换为绝对路径
              if (imgSrc && !imgSrc.startsWith('http')) {
                var base = document.baseURI || window.location.href;
                var url = new URL(imgSrc, base);
                imgSrc = url.href;
              }
              
              // 通知Flutter处理长按，使用'longPress'作为处理器名称
              if (imgSrc) {
                window.flutter_inappwebview.callHandler('longPress', imgSrc);
                console.log('长按图片: ' + imgSrc);
              }
            }, longPressThreshold);
          }
        }, false);
        
        // 触摸结束 - 清除定时器
        document.addEventListener('touchend', function() {
          if (longPressTimer) {
            clearTimeout(longPressTimer);
            longPressTimer = null;
          }
        }, false);
        
        // 触摸移动 - 如果移动超过阈值，取消长按
        document.addEventListener('touchmove', function() {
          if (longPressTimer) {
            clearTimeout(longPressTimer);
            longPressTimer = null;
          }
        }, false);
        
        // 通知DOM已准备好
        window.flutter_inappwebview.callHandler('domReady');
      })();
    ''');
  }

  // 设置自定义用户代理
  void _setUserAgent() async {
    final userAgentFromJs = await _controller.evaluateJavascript(source: "navigator.userAgent") ?? "";
    final modifiedUserAgent = "AutoSteward/$userAgentFromJs";
    await _controller.setSettings(
      settings: InAppWebViewSettings(userAgent: modifiedUserAgent),
    );
  }

  // onTitleChanged 当网页标题（document.title）改变时触发
  void _onTitleChanged(controller, title) {
    _title = (title as String).replaceAll('"', '');
    setState(() {});
  }

  // 当页面加载过程中出现错误时触发。用于捕获加载失败事件。
  void _onReceivedError(controller, request, error) {
    debugPrint('Error: $request, $error');
  }

  // 捕获 HTTP 错误，如 404 或 500。
  void _onReceivedHttpError(controller, request, errorResponse) {
    debugPrint('HTTP error: $request, $errorResponse');
  }

  // 拦截页面中的链接导航，允许或阻止导航行为，类似于 NavigationDelegate。
  Future<NavigationActionPolicy?> _shouldOverrideUrlLoading(controller, navigationAction) async {
    if (navigationAction.request.url!.host.contains("blocked.com")) {
      return NavigationActionPolicy.CANCEL; // 阻止导航
    }
    return NavigationActionPolicy.ALLOW; // 允许导航
  }

  // onUpdateVisitedHistory: 当 WebView 历史记录更新时触发，通常用于处理前进和后退操作。
  // void _onUpdateVisitedHistory(controller, url, isReload) {
  //   debugPrint('Navigated to: $url');
  // }

  // 当加载的页面需要服务器验证时触发。
  // Future<ServerTrustAuthResponse> _onReceivedServerTrustAuthRequest(controller, challenge) async {
  //   return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
  // }

  // 当页面需要 HTTP 认证时触发
  // Future<HttpAuthResponse> _onReceivedHttpAuthRequest(controller, challenge) async {
  //   return HttpAuthResponse(action: HttpAuthResponseAction.PROCEED);
  // }

  // 捕获 WebView 的 JavaScript console.log 输出，适合调试。
  void _onConsoleMessage(controller, consoleMessage) {
    debugPrint('Console message: ${consoleMessage.message}');
  }

  // 当页面尝试打开一个新窗口时触发（比如点击 target="_blank" 的链接）。
  // Future<bool> _onCreateWindow(controller, createWindowRequest) async {
  //   return true; // 允许创建新窗口
  // }

  // 拼接 URL 参数
  void _setupParam() {
    _title = widget.title ?? "";
    String baseUrl = widget.url ?? "";
    dynamic param = widget.param;
    if (param is int) {
      // 如果参数是整数，直接拼接在 URL 后
      _url = "$baseUrl/$param";
    } else if (param is Map) {
      // 如果参数是 Map，转换为 URL 查询参数格式
      String queryString = Uri(queryParameters: param.map((key, value) => MapEntry(key, value.toString()))).query;
      if (baseUrl.contains("?")) {
        _url = "$baseUrl&$queryString"; // 如果 URL 已经有查询参数，继续拼接
      } else {
        _url = "$baseUrl?$queryString"; // 如果 URL 没有查询参数，开始拼接
      }
    } else {
      _url = baseUrl; // 如果没有参数，直接使用原 URL
    }
    // 调试输出拼接后的 URL
    debugPrint("最终 URL: $_url");
  }

  void _setupProgress() {
    _animationCtrl = AnimationController(vsync: this, duration: animationTime);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationCtrl); // 初始化 _animation
    _animationCtrl.addListener(() {
      setState(() {
        progress = _animation.value;
      });
    });
  }

  // 页面进度变化时，更新进度条
  void _onProgressChanged(controller, progressValue) {
    if (progressValue < 100) {
      setState(() {
        progress = progressValue / 100;
      });
    } else {
      _animationCtrl.reset();
      _animationCtrl.forward(); // 当加载完成时重启动画，确保进度条到 1.0
    }
  }

  // 页面加载开始时，初始化进度条并启动动画
  void _onLoadStart(controller, url) {
    setState(() {
      progress = 0.0; // 设置初始进度为 0
      _animationCtrl.reset();
      _animationCtrl.forward(); // 启动动画
    });
  }

  // 页面加载结束时，启动动画并填满进度条
  void _onLoadStop(controller, url) async {
    // 渐变动画，从当前 progress 过渡到 1.0
    _animation = Tween<double>(begin: progress, end: 1.0).animate(_animationCtrl);
    _animationCtrl.forward(); // 启动动画
    _animationCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          progress = 1.0; // 确保进度条在页面完全加载后填满
        });
      }
    });

    // 页面加载完毕后应用我们的拦截器
    await _injectJavaScript(controller);

    // 在加载完成时手动调用一次我们的 JavaScript 监听代码
    await controller.evaluateJavascript(source: """
      // 为图片加载添加事件监听
      document.addEventListener('load', function(e) {
        if (e.target.tagName === 'IMG') {
          window.flutter_inappwebview.callHandler('reInjectBlocker');
        }
      }, true);
      
      // 在点击操作后重新注入拦截器
      document.addEventListener('click', function() {
        setTimeout(function() {
          window.flutter_inappwebview.callHandler('reInjectBlocker');
        }, 300);
      });
    """);

    String? userAgent = await _controller.evaluateJavascript(source: "navigator.userAgent");
    // logger.d("Modified User-Agent: $userAgent");

    // 在页面加载完毕后执行 JavaScript，修改 font-size
    if (DeviceUtils.isPad && userAgent!.contains("iPad")) {
      await controller.evaluateJavascript(
        source: """
        (function() {
          var htmlElement = document.querySelector('html');
          var currentFontSize = parseFloat(window.getComputedStyle(htmlElement).fontSize);
          if (currentFontSize > 24) {
            htmlElement.style.fontSize = '24px';
          }
        })();
      """,
      );
    }
  }

  // @pragma('vm:entry-point')
  // static Future<void> downloadCallback(String id, int status, int progress) async {
  //   IsolateNameServer.lookupPortByName(imageDownloader_send_port)?.send([id, status, progress]);
  // }

  Future<void> _onLongPressHitTestResult(InAppWebViewController controller, InAppWebViewHitTestResult hitTestResult) async {
    try {
      if (!ObjectUtil.isEmpty(hitTestResult)) {
        InAppWebViewHitTestResultType? type = hitTestResult.type;

        if (!ObjectUtil.isEmpty(type)) {
          //logger.d("type-->$type");
          switch (type) {
            case InAppWebViewHitTestResultType.IMAGE_TYPE:
            case InAppWebViewHitTestResultType.SRC_IMAGE_ANCHOR_TYPE:
              //提取图片链接
              String filePathUrl = hitTestResult.extra!;
              logger.d("---下载任务是---$filePathUrl");
              //downLoadUrlLastTime = filePathUrl;
              // if (!ObjectUtil.isEmptyString(taskIdImage)) {
              //   //logger.d("--taskIdImage-上一次的-下载任务是---$taskIdImage");
              //   await FlutterDownloader.remove(
              //     taskId: taskIdImage,
              //     shouldDeleteContent: true,
              //   );
              // }

              if (!ObjectUtil.isEmptyString(filePathUrl)) {
                _showBottomSheet(Get.context!, filePathUrl);
              }

              break;
            default:
              // 对于非图片类型的长按，不执行任何操作，使用系统默认行为
              break;
          }
        }
      } else {
        logger.w("hitTestResult-->是空值");
      }
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w(" catch Exception =>${e.toString()}");
      }
    }
  }

  _showBottomSheet(BuildContext context, String filePathUrl) {
    return showCupertinoModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        transitionBackgroundColor: Colors.transparent,
        barrierColor: Colors.black.withOpacity(0.5),
        shadow: const BoxShadow(color: Colors.transparent),
        builder: (context) => Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: CupertinoActionSheet(
                messageScrollController: ScrollController(),
                actions: [
                  CupertinoActionSheetAction(
                      child: const Text("保存到相册"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // 解锁菜单状态
                        _unlockMenuAfterDelay();
                        if (Platform.isIOS) _downLoadImage(context, filePathUrl);
                        if (Platform.isAndroid) _downLoadImageForAndroid(context, filePathUrl);
                      }),
                  CupertinoActionSheetAction(
                      child: const Text("复制图片链接"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // 解锁菜单状态
                        _unlockMenuAfterDelay();
                        Clipboard.setData(ClipboardData(text: filePathUrl));
                        showMessageBottomLikeAndroid("复制成功:$filePathUrl", isLong: true);
                      }),
                  CupertinoActionSheetAction(
                      child: const Text("微信分享好友"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // 解锁菜单状态
                        _unlockMenuAfterDelay();
                        WechatManager.shareImageMy(WeChatScene.session, filePathUrl);
                      }),
                  CupertinoActionSheetAction(
                      child: const Text("微信收藏"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // 解锁菜单状态
                        _unlockMenuAfterDelay();
                        WechatManager.shareWebpageMy(WeChatScene.favorite, url: filePathUrl, desc: "收藏", thumbnail: filePathUrl);
                      }),
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // 解锁菜单状态
                    _unlockMenuAfterDelay();
                  },
                  child: const Text('取消'),
                ),
              ),
            ));
  }

  // 延迟解锁菜单状态，防止误触发
  void _unlockMenuAfterDelay() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isMenuLocked = false;
        });
      } else {
        _isMenuLocked = false;
      }
    });
  }

  //做下载SD卡权限判断
  Future<void> _downLoadImageForAndroid(context, String downLoadUrl) async {
    List<Permission> permissions;

    if (AppManager.osSdkIntForAndroid < ANDROID_OS_SDK_33) {
      permissions = [Permission.storage];
    } else {
      permissions = [Permission.manageExternalStorage];
    }

    BaseController baseController = BaseController();
    if (!ObjectUtil.isEmpty(baseController)) {
      bool hasPermissionNotAllow = await baseController.checkPermissionAndroidList(permissions);
      if (hasPermissionNotAllow) {
        CommonTools.showDialogPermissionAndroidList(
            permissions: permissions,
            messageToUser: permission_content_camera_storage,
            doGranted: () {
              _downLoadImage(context, downLoadUrl);
            });
      } else {
        _downLoadImage(context, downLoadUrl);
      }
    }
  }

  /*Future<void> _downLoadImage(context, String downLoadUrl) async {
    try {
      //放在下载目录，在【设置页】清理缓存清理。
      String saveDirDoc = (await FileUtilsMy.getDownLoadDirPath())!;
      final savedDir = Directory(saveDirDoc);
      //Logger.logMy("$logCatTag savedDir：${savedDir.path.toString()}");
      if (!savedDir.existsSync()) {
        await savedDir.create();
      }

      String fileName = DateUtil.getNowDateStr() + StringUtils.splitPathName(downLoadUrl ?? "");
      //logger.d("新建的任务文件名=>${fileName.toString()}");

      downLoadFileFullPathLastTime = "${savedDir.path}/$fileName";

      taskIdImage = (await FlutterDownloader.enqueue(
        url: downLoadUrl,
        savedDir: savedDir.path,
        showNotification: true,
        saveInPublicStorage: false,
        fileName: fileName,
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
      ))!;
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.d(" catch Exception =>${e.toString()}");
      }
    }
  }*/

  Future<void> _downLoadImage(context, String fileUrlForDownLoad) async {
    NumberAnimController? numberAnimController;
    try {
      numberAnimController = CommonTools.getFindMy<NumberAnimController>();
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        showMessageBottomLikeAndroid(e.toString(), isLong: false);
        logger.w(" catch Exception =>${e.toString()}");
        ErrorLogUtils.addLogSingle(fun: "_downLoadImage1预备执行下载", error: "${toString()}NumberAnimController下载图片报错$e");
      }
    }
    //showLoadingMessage("图片下载中");
    SmartDialog.show(
      tag: 'progressNumber',
      keepSingle: true,
      usePenetrate: false,
      clickMaskDismiss: false,
      //animationType: SmartAnimationType.fade,
      builder: (_) => CircularProgressDialogAnimNumber(),
    );

    try {
      String fileName = DateUtil.formatDate(DateTime.now(), format: timeFormatDateTooLong2) + StringUtils.splitPathName(fileUrlForDownLoad ?? "");

      http.Response responseCurr = await http.get(Uri.parse(fileUrlForDownLoad));
      //图片保存完毕
      if (responseCurr.statusCode == 200) {
        // logger.d("新建的任务文件名=>${fileName.toString()}");
        await ImageGallerySaverPlus.saveImage(Uint8List.fromList(responseCurr.bodyBytes), quality: 100, name: fileName);
        if (!ObjectUtil.isEmpty(numberAnimController)) {
          StringBuffer stringBuffer = StringBuffer();
          stringBuffer.write("保存图片");
          stringBuffer.write(1);
          stringBuffer.write("/");
          stringBuffer.write(1);
          numberAnimController?.onClose();
          showMessageBottomLikeAndroid("保存成功$fileName", isLong: false);
        }
        SmartDialog.dismiss(tag: 'progressNumber', force: true);
      }
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.d(" catch Exception =>${e.toString()}");
        ErrorLogUtils.addLogSingle(fun: "_downLoadImage1", error: "${toString()}NumberController下载图片报错$e");
      }
    }
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping(imageDownloader_send_port);
  }

  // 添加JavaScript处理器
  void _addJavaScriptHandlers(InAppWebViewController controller) {
    // 处理长按事件
    controller.addJavaScriptHandler(
      handlerName: 'longPress',
      callback: handleLongPress,
    );

    // 监听DOM就绪事件
    controller.addJavaScriptHandler(
        handlerName: 'domReady',
        callback: (args) async {
          await _injectJavaScript(controller);
        });
  }
}
