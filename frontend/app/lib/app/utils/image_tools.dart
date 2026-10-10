import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageTool {
  /// 将图片路径的数组转换成 MultipartFile 数组，方便直接使用 FormData
  static Future<List<MultipartFile>> imageFiles(List imagePath) async {
    List<MultipartFile> files = [];
    for (var path in imagePath) {
      String? jpegPath = await convertImageToJpeg(path);
      final fileName = path.split('/').last.replaceAll('.heic', '.jpeg');
      files.add(await MultipartFile.fromFile(jpegPath!, filename: fileName));
    }
    return files;
  }

  /// 将.heic格式的图片转换成.jpeg格式的图片
  static Future<String?> convertImageToJpeg(String? imagePath) async {
    if (imagePath != null && imagePath.isNotEmpty && imagePath.toLowerCase().endsWith('.heic')) {
      File imageFile = File(imagePath);
      final imageBytes = await imageFile.readAsBytes();
      List<int> compressedImageBytes = await FlutterImageCompress.compressWithList(
        imageBytes,
        quality: 90,
        format: CompressFormat.jpeg,
      );
      String directory = path.dirname(imagePath);
      String fileName = path.basenameWithoutExtension(imagePath);
      String newPath = path.join(directory, '$fileName.jpeg');
      File convertedImage = File(newPath);
      await convertedImage.writeAsBytes(compressedImageBytes);
      return convertedImage.path;
    }
    XFile? file = await ImageTool.imageCompressAndGetFile(File(imagePath!));
    return file?.path;
  }

  /// 图片压缩 File -> File
  static Future<XFile?> imageCompressAndGetFile(File file) async {
    // 低于200 KB不压缩
    if (file.lengthSync() < 200 * 1024) {
      return XFile(file.path);
    }

    int quality;
    if (file.lengthSync() > 4 * 1024 * 1024) {
      // 大于4MB
      quality = 65; // 设置为70以避免过多细节丢失
    } else if (file.lengthSync() > 2 * 1024 * 1024) {
      // 2MB - 4MB
      quality = 70;
    } else if (file.lengthSync() > 1 * 1024 * 1024) {
      // 1MB - 2MB
      quality = 80;
    } else if (file.lengthSync() > 0.5 * 1024 * 1024) {
      // 500KB - 1MB
      quality = 90;
    } else {
      // 200KB - 500KB
      quality = 100;
    }

    // 获取临时目录路径
    Directory tempDir = await getTemporaryDirectory();
    var targetPath = "${tempDir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";

    // 执行压缩
    XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: quality, // 仅设置质量，不改变尺寸
      rotate: 0,
    );

    // print("压缩后：${file.lengthSync() / 1024}");
    // print("压缩后：${File(result!.path).lengthSync() / 1024}");
    return result;
  }

  /// 图片压缩 File -> Uint8List
  static Future<Uint8List?> imageCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    // print(file.lengthSync());
    // print(result?.length);
    return result;
  }

  /// 图片压缩 Asset -> Uint8List
  static Future<Uint8List?> imageCompressAsset(String assetName) async {
    var list = await FlutterImageCompress.compressAssetImage(
      assetName,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 180,
    );
    // print(list?.length);
    return list;
  }

  /// 图片压缩 Uint8List -> Uint8List
  static Future<Uint8List> testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1024,
      minWidth: 768,
      quality: 96,
      // rotate: 135,
    );
    // print(list.length);
    // print(result.length);
    return result;
  }

  // /// 根据 ulr 获取图片指定像素的颜色
  // /// assetPath: 'assets/your_image.png'
  // Future<ui.Color> loadImage(String assetPath, int x, int y) async {
  //   // 加载图片
  //   final ByteData data = await rootBundle.load(assetPath);
  //   final Uint8List bytes = data.buffer.asUint8List();
  //
  //
  //   // 获取指定像素的颜色
  //   // final int pixel32 = image?.getPixel(x, y) as int;
  //   // final int hex = img.getColor(pixel32, pixel32, pixel32, 1);
  //
  //   // 转换为 Flutter 的 Color 类型
  //   // 使用 `image` 包解码图片
  //   final img.Image? image = img.decodeImage(Uint8List.views(bytes.buffer));
  //   final ByteData? byteData = await image?.toByteData(format: ui.ImageByteFormat.rawRgba);
  //
  //   // 获取指定像素的颜色
  //   if (byteData != null) {
  //     final int pixelIndex = (y * image.width + x) * 4;
  //     final int r = byteData.getUint8(pixelIndex);
  //     final int g = byteData.getUint8(pixelIndex + 1);
  //     final int b = byteData.getUint8(pixelIndex + 2);
  //     final int a = byteData.getUint8(pixelIndex + 3);
  //     return Color.fromARGB(a, r, g, b);
  //   }
  //   return Colors.transparent;
  // }
  //
  //
  // Future<ui.Color> loadImage2(String assetPath, int x, int y) async {
  //   // 加载图片
  //   final ByteData data = await rootBundle.load(assetPath);
  //   final Uint8List bytes = data.buffer.asUint8List();
  //
  //   // 使用 `image` 包解码图片
  //   final img.Image? image = img.decodeImage(bytes);
  //
  //   // 获取指定像素的颜色
  //   if (image != null && x >= 0 && y >= 0 && x < image.width && y < image.height) {
  //     final Pixel pixel = image.getPixel(x, y);
  //     var color = img.getColor(pixel, pixel, pixel, pixel);
  //     return ui.Color.fromARGB(a, r, g, b);
  //   }
  // }
  //
  //
  // // 根据图片获取指定像素的颜色
  // Future<ui.Color> getPixelColorWithImage(ui.Image image, int x, int y) async {
  //   final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  //   if (byteData == null) return Colors.transparent;
  //
  //   final Uint8List bytes = byteData.buffer.asUint8List();
  //   final int pixelIndex = (y * image.width + x) * 4;
  //
  //   // 提取颜色值
  //   final int r = bytes[pixelIndex];
  //   final int g = bytes[pixelIndex + 1];
  //   final int b = bytes[pixelIndex + 2];
  //   final int a = bytes[pixelIndex + 3];
  //
  //   return Color.fromARGB(a, r, g, b);
  // }

  static Future<ui.Color> getPixelColor(String imageUrl, int x, int y) async {
    try {
      // 下载图片
      Uri uri = Uri.parse(imageUrl);
      if (uri.host.isNotEmpty) {
        final response = await http.get(uri);
        if (response.statusCode == 200) {
          final imageBytes = response.bodyBytes;
          // 加载图片为 ui.Image
          final Completer<ui.Image> completer = Completer();
          ui.decodeImageFromList(imageBytes, (ui.Image img) {
            completer.complete(img);
          });
          final ui.Image image = await completer.future;

          // 检查坐标是否在图像范围内
          if (x < 0 || y < 0 || x >= image.width || y >= image.height) {
            throw Exception('Pixel coordinates are out of range');
          }

          // 获取指定像素的颜色值
          final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
          final int pixelOffset = (y * image.width + x) * 4;
          if (byteData != null && pixelOffset < byteData.lengthInBytes) {
            final int r = byteData.getUint8(pixelOffset);
            final int g = byteData.getUint8(pixelOffset + 1);
            final int b = byteData.getUint8(pixelOffset + 2);
            final int a = byteData.getUint8(pixelOffset + 3);
            return ui.Color.fromARGB(a, r, g, b);
          }
          return const ui.Color.fromRGBO(0, 0, 0, 0);
        } else {
          return const ui.Color.fromRGBO(0, 0, 0, 0);
          // throw Exception('Failed to load image');
        }
      } else {
        logger.d("uri.host 是空的");
      }
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.d(" uri.host =>${e.toString()}");
      }
    }
    return const ui.Color.fromRGBO(0, 0, 0, 0);
  }

  //bug:发现图片质量太大或者尺寸太大无法分享 ：在分享时候重新压缩一次即可 2024-12-23
  static Future<Uint8List> compressImage(Uint8List imageData, {required int width, required int quality}) async {
    // 将 Uint8List 转换为 Image 对象
    final originalImage = img.decodeImage(imageData);
    if (originalImage == null) {
      throw Exception("Invalid image data");
    }
    // 创建一个副本以避免修改原始图像
    final compressedImage = img.copyResize(originalImage, width: width); // 设置你想要的宽度
    // 如果你想根据质量而不是尺寸来压缩，可以使用 encodeJpg 的 quality 参数
    final compressedImageData = img.encodeJpg(compressedImage, quality: quality); // 设置你想要的质量
    return Uint8List.fromList(compressedImageData);
  }

  //判断图片是否小于128KB
  static bool isImageSmallerThan128KB(Uint8List imageData) {
    // 128 KB in bytes
    //final int maxBytes = 128 * 1024;
    final int maxBytes = 126 * 1024;
    // Check if the image size is less than 128 KB
    return imageData.lengthInBytes < maxBytes;
  }

  //判断图片是否小于500KB
  static bool isImageSmallerThan500KB(Uint8List imageData) {
    // 128 KB in bytes
    //final int maxBytes = 128 * 1024;
    final int maxBytes = 500 * 1024;
    // Check if the image size is less than 128 KB
    return imageData.lengthInBytes < maxBytes;
  }

  //查看图片的字节大小
  static double imageSize(Uint8List imageData) {
    try {
      double imageSize = imageData.lengthInBytes / 1024;
      logger.d("小程序分享【原图】大小是-->${imageData.lengthInBytes / 1024}");
      return imageSize;
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) logger.w(" catch Exception =>${e.toString()}");
    }
    return 0.0;
  }

  ///@description 图片指定大小压缩
  static Uint8List compressImageToSize(Uint8List imageData, int targetSize) {
    try {
      // 解码图片
      final originalImage = img.decodeImage(imageData);
      if (originalImage == null) {
        return Uint8List(0); // 返回空列表或抛出异常，取决于你的错误处理策略
      }
      // 初始质量设置为90%
      int quality = 80;
      Uint8List compressedData;

      bool result = isImageSmallerThan128KB(imageData);
      logger.d("isImageSmallerThan128KB=>${result.toString()}");
      if (!result) {
        do {
          // 重新编码图片并调整质量
          compressedData = img.encodeJpg(originalImage, quality: quality);
          // 检查大小是否满足条件
          if (compressedData.lengthInBytes <= targetSize) {
            try {
              logger.d("返回压缩后的图大小是-->${compressedData.lengthInBytes / 1024}");
            } on Exception catch (e) {
              if (!ObjectUtil.isEmpty(e)) {
                logger.w(" catch Exception =>${e.toString()}");
              }
            }
            return compressedData; // 返回压缩后的数据
          }
          // 逐步降低质量直到大小满足要求或不能再降低质量
          // quality = max(quality - 10, 10); // 逐步降低质量，但至少保留10%的质量以避免严重失真
          quality = max(quality - 20, 2); // 逐步降低质量，但至少保留10%的质量以避免严重失真
          logger.d("quality-->${quality.toString()}");
        } while (quality > 2); // 继续循环直到质量降到最低点

        /*try {
          logger.d("图片压缩-->${compressedData.lengthInBytes / 1024}");
        } on Exception catch (e) {
          if (!ObjectUtil.isEmpty(e)) {
            logger.w(" catch Exception =>${e.toString()}");
          }
        }*/
      } else {
        logger.d("图片的大于128KB");
      }
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w(" catch Exception =>${e.toString()}");
      }
    }
    // 如果所有尝试都失败了，返回原始数据或抛出异常
    return imageData; // 或者你可以选择返回null或抛出异常
  }

  // 图片压缩
  static Uint8List compressImageMy(Uint8List imageBytes, {double targetQuality = 0.8}) {
    // 使用image插件加载图片
    img.Image? originalImage = img.decodeImage(imageBytes);

    if (originalImage == null) {
      throw Exception('图片加载失败');
    }

    // 初始尝试用指定的质量进行压缩
    List<int> compressedImageBytes = img.encodeJpg(originalImage, quality: (targetQuality * 100).toInt());

    // 如果压缩后的图片小于或等于目标大小，则返回
    if (compressedImageBytes.length <= 500 * 1024) {
      return Uint8List.fromList(compressedImageBytes);
    }

    // 否则，递归地降低质量直到满足条件或者达到最低质量限制
    double step = 0.05; // 每次减少质量的比例
    while (targetQuality > step && compressedImageBytes.length > 500 * 1024) {
      targetQuality -= step;
      compressedImageBytes = img.encodeJpg(originalImage, quality: (targetQuality * 100).toInt());
    }
    //------------------------------------
    //!!代码勿删-可以查看压缩之后图片的总大小
    /*try {
      logger.d("compressImageMy图片压缩之后大小是-->${compressedImageBytes.length / 1024}");
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w(" catch Exception =>${e.toString()}");
      }
    }*/
    //------------------------------------
    // 返回最终的压缩图片数据
    return Uint8List.fromList(compressedImageBytes);
  }

  // 图片压缩--为了复检中图片拍照
  static Uint8List compressImageForExecuteXFile(Uint8List imageBytes, {double targetQuality = 0.8}) {
    // 使用image插件加载图片
    img.Image? originalImage = img.decodeImage(imageBytes);

    if (originalImage == null) {
      throw Exception('图片加载失败');
    }

    // 初始尝试用指定的质量进行压缩
    List<int> compressedImageBytes = img.encodeJpg(originalImage, quality: (targetQuality * 100).toInt());

    //!!代码勿删-可以查看压缩之后图片的总大小
    try {
      logger.d("compressImageMy图片压缩之后大小是-->${compressedImageBytes.length / 1024}");
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w(" catch Exception =>${e.toString()}");
      }
    }
    //------------------------------------
    // 返回最终的压缩图片数据
    return Uint8List.fromList(compressedImageBytes);
  }

  //保存图片
  static Future<void> saveUint8ListToFile(Uint8List imageData, String filePath) async {
    // 创建一个文件
    File file = File(filePath);
    // 将Uint8List写入文件
    file.writeAsBytesSync(imageData);
  }

  //额外放到这里，将来用到再改造。
  Future<Uint8List> compressImage64(String imagePath) async {
    final result = await FlutterImageCompress.compressWithFile(
      imagePath,
      minWidth: 150, // 设置缩略图的宽度
      minHeight: 150, // 设置缩略图的高度
      quality: 70, // 设置压缩质量
      format: CompressFormat.jpeg, // 使用 JPEG 格式
    );

    if (result == null) {
      throw Exception("图片压缩失败");
    }

    // 检查压缩结果是否小于 64KB
    if (result.length > 64 * 1024) {
      throw Exception("压缩后的图片大小仍然超过 64KB，请尝试降低质量或尺寸");
    }

    return result;
  }
}
