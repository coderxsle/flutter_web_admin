import 'dart:async';

import 'package:flutter/material.dart';

class FloatingLoggerOverlay extends StatefulWidget {
  const FloatingLoggerOverlay({super.key});

  @override
  _FloatingLoggerOverlayState createState() => _FloatingLoggerOverlayState();
}

class _FloatingLoggerOverlayState extends State<FloatingLoggerOverlay> {
  OverlayEntry? overlayEntry;
  Offset offset = Offset(20, 100); // 初始位置
  final List<String> logs = []; // 用于存储日志内容
  late StreamController<String> logStreamController;

  @override
  void initState() {
    super.initState();
    logStreamController = StreamController<String>.broadcast();
    _redirectLogs(); // 重定向日志
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    logStreamController.close();
    super.dispose();
  }

  void _redirectLogs() {
    // 自定义 log 方法，用于代替 print()
    void customLog(String message) {
      logStreamController.add("打印日志: $message");
    }

    // 捕获 log() 方法输出
    logStreamController.stream.listen((log) {
      setState(() {
        logs.add(log);
        overlayEntry?.markNeedsBuild();
      });
    });

    // 测试使用
    customLog("这是一个测试日志");
  }

  void showOverlay() {
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                offset += details.delta;
                overlayEntry?.markNeedsBuild(); // 更新位置
              });
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 300,
                height: 250,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text("实时系统日志", style: TextStyle(color: Colors.white)),
                    Divider(color: Colors.white),
                    Expanded(
                      child: StreamBuilder<String>(
                        stream: logStreamController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text("等待日志中...", style: TextStyle(color: Colors.white));
                          }
                          return ListView.builder(
                            itemCount: logs.length,
                            itemBuilder: (context, index) {
                              return Text(
                                logs[index],
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          logs.clear(); // 清空日志
                          overlayEntry?.markNeedsBuild();
                        });
                      },
                      child: Text("清空日志", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("浮动日志窗口示例")),
      body: Center(
        child: ElevatedButton(
          onPressed: showOverlay,
          child: Text("显示日志浮动窗口"),
        ),
      ),
    );
  }
}