import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyCameraPreview extends StatefulWidget {
  final ValueChanged callback;
  const MyCameraPreview({super.key, required this.callback});

  @override
  MyCameraPreviewState createState() => MyCameraPreviewState();
}

class MyCameraPreviewState extends State<MyCameraPreview> {

  late final List<CameraDescription> cameras;
  late final CameraController cameraController;

  @override
  void dispose() {
    // 释放相机控制器资源
    cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _cameraInitialize();
    super.initState();
  }

  // 初始化相机
  _cameraInitialize() async {
    // 获取可用摄像头列表
    cameras = await availableCameras();
    final cameraFirst = cameras.first; // 选择第一个摄像头，通常是后置摄像头
    cameraController = CameraController(cameraFirst, ResolutionPreset.high);
    // 初始化相机控制器
    await cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 相机预览
          Positioned.fill(
            child: MyCameraPreview(callback: (value) async {
              // try {
              //   // 拍照并保存到临时文件路径
              //   final Directory tempDir = await getTemporaryDirectory();
              //   final String tempFilePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
              //   // 拍照，并将照片保存到临时路径
              //   final XFile picture = await cameraController.takePicture();
              //   // 将拍照保存的文件复制到临时路径
              //   await File(picture.path).copy(tempFilePath);
              //   // 调用回调函数，并返回新生成的临时文件路径
              //   widget.callback([tempFilePath]);
              //   // 关闭弹窗
              //   Navigator.of(context).pop();
              // } catch (e) {
              //   debugPrint("Error during taking picture: $e");
              // }
            }),
          ),
          // 拍照按钮
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: () async {
                  try {
                    // 拍照并获取文件路径
                    final XFile picture = await cameraController.takePicture();
                    final Directory tempDir = await getTemporaryDirectory();
                    final String tempFilePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
                    await File(picture.path).copy(tempFilePath);

                    // 调用回调函数，并返回新生成的临时文件路径
                    widget.callback(tempFilePath);

                    // 关闭相机页面
                    Navigator.of(context).pop();
                  } catch (e) {
                    debugPrint("Error during taking picture: $e");
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),
          // 关闭按钮
          Positioned(
            top: 30,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}