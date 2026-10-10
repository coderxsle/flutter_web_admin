import 'dart:io';

import 'package:auto_shop_server/res/assets_res.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
// ================== 非模拟器 =====================
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
// ================== 非模拟器 =====================


class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {

  int nowPage = 0;
  PageController controller = PageController();
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _setupCameraAndMusic();
  }

  // 切换页面
  Future<void> _onPageChange() async {
    controller.addListener(() async {
      if (await Vibration.hasVibrator() as bool && nowPage != controller.page!.round()) {
        Vibration.vibrate(duration: 500, amplitude: 255);
      }
      player.play();
      nowPage = controller.page!.round();
    });
  }

  //设置播放音效
  void _setupCameraAndMusic() async {
    player.setAsset(AssetsRes.SCAN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // 关闭按钮
        // leading: IconButton(onPressed: ()=> Get.back(), icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Stack(
        children: [
          const ScanView(),
          // 底部菜单
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.black45,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 45),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                            children: [
                              const Text("扫一扫", style: TextStyle(fontSize: 16, color: Colors.white)),
                              const SizedBox(height: 5),
                              ClipOval(child: Container(width: 5, height: 5, color: Colors.white))
                            ]),
                      ]),
                ),
              ),
            ]
          )
        ],
      ),
    );
  }
}












class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  ScanViewState createState() => ScanViewState();
}

class ScanViewState extends State<ScanView> with WidgetsBindingObserver {
  double _zoomScale = 0;
  AudioPlayer player = AudioPlayer();

  final MobileScannerController controller = MobileScannerController(
    // torchEnabled: true,
    // formats: [BarcodeFormat.qrCode]
    // facing: CameraFacing.front,
    // detectionSpeed: DetectionSpeed.normal
    // detectionTimeoutMs: 1000,
    // returnImage: false,
  );


  @override
  void initState() {
    super.initState();
    _setPlayMusic();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
      //在前台激活
        if (!controller.autoStart) {
          controller.start();
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.paused:
      //在后台暂停
        controller.stop();
        break;
      case AppLifecycleState.hidden: // flutter 3.13
        break;
    }
  }

  // 开关手电筒
  void _changeFlashMode() {
    controller.toggleTorch();
  }

  // 双击放大或缩小
  void _changeZoomScale() {
    if (_zoomScale == 0) {
      _zoomScale = 1;
    } else {
      _zoomScale = 0;
    }
    controller.setZoomScale(_zoomScale);
  }

  // 双指捏合放大或缩小
  void _onScaleChaneg(ScaleUpdateDetails details) {
    _zoomScale = (details.scale / 10 * 6 - 0.6).clamp(0, 1);
    controller.setZoomScale(_zoomScale);
  }

  // 设置播放音效
  void _setPlayMusic() {
    player.setAsset(AssetsRes.SCAN);
  }

  // 二维码处理完毕回掉
  Future<void> _scanQrCode(BarcodeCapture capture) async {
    // 停止扫描
    controller.stop();
    // 声音提醒
    player.play();
    // 震动提示
    if (await Vibration.hasVibrator() as bool) {
      Vibration.vibrate(duration: 500, amplitude: 255);
    }

    final List<Barcode> barcodes = capture.barcodes;

    if(!ObjectUtil.isEmpty(barcodes)) {

       String? result = barcodes[0].rawValue as String;
      //日志：测试时候放开
      // for (final barcode in barcodes) {
      //   // String? result = barcodes[0].rawValue as String;
      //   // print('Barcode found! $result');
      //   logger.d('扫码成功，解析结果为：${barcode.rawValue}');
      // }

      Get.back(result: result);

    }else{
      Get.back(result: null);
    }

  }

  // 扫描相册二维码
  Future<void> _scanLocalQrCode() async {
    List<AssetEntity>? qrCodes = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
          maxAssets: 1,
          specialPickerType: SpecialPickerType.wechatMoment,
          requestType: RequestType.common
      ),
    );
    try {
      late File file;
      await qrCodes![0].file.then((value) => file = value!);
      // 开始解析相册选中的图片二维码
      final BarcodeCapture? result = await controller.analyzeImage(file.path);
      for (final Barcode barcode in result!.barcodes) {
        _scanQrCode(result);
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }


  // 手电筒
  Widget _flashLightButton() {
    return GestureDetector(
      onTap: _changeFlashMode,
      child: const Column(
        children: [
          Icon(Icons.flashlight_on_outlined, size: 44, color: Colors.white),
          SizedBox(height: 8),
          Text('轻触照亮', style: TextStyle(color: Colors.white, fontSize: 15))
        ],
      ),
    );
  }

  // 相册
  Widget _album() {
    return GestureDetector(
      onTap: _scanLocalQrCode,
      child: Column(children: [
        ClipOval(
            child: Container(
                padding: const EdgeInsets.all(10),
                color: const Color.fromRGBO(70, 70, 70, 1),
                child: const Icon(
                    Icons.image, color: Colors.white)
            )
        ),
        const SizedBox(height: 1),
        const Text('相册', style: TextStyle(color: Colors.white, fontSize: 11))
      ]),
    );
  }

  // 相机预览
  Widget _cameraView(MobileScanner scanner) {
    return GestureDetector(
        onDoubleTap: _changeZoomScale,
        onScaleUpdate: _onScaleChaneg,
        child: SizedBox(height: double.infinity, child: scanner));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(color: Colors.black),
      _cameraView(
          MobileScanner(
            controller: controller,
            onDetect: _scanQrCode,
          )
      ),
      Positioned(
          left: MediaQuery.of(context).size.width / 2 - 25,
          bottom: 165,
          child: _flashLightButton()),
      Positioned(
        right: 25,
        bottom: 125,
        child: _album(),
      ),
    ]);
  }
}




// _scanQrCode 二维码处理完毕回掉
// 交付外层处理（自己处理自己业务）
// if (GetUtils.isURL(result)) {
//   await launchUrl(Uri.parse(result), mode: LaunchMode.externalApplication);
// }else {
//   Get.back(result: result);
// }

//   else if (result.startsWith("AUTOSTEWARD_")) { // 如果是
//     Get.back(result: result);
//   }else {
//     // 二维码详情展示
//     Get.to(()=> Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('扫码结果'),
//         leading: BackButton(
//           onPressed: () {
//             controller.start();
//             Get.back();
//           },
//         ),
//       ),
//       body: Wrap(children: [
//         const SizedBox(height: 10),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Text(result),
//         )
//       ]),
//     ))?.then((value) {
//       controller.start();
//     });
//     }