import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:cached_network_image/cached_network_image.dart';

/// 图片工具类
class ImageUtils {

  ///将base64流转化为图片
  static MemoryImage base64ToImage(String base64String) {
    return MemoryImage(
      base64Decode(base64String),
    );
  }

  ///将base64流转化为Uint8List对象
  static Uint8List base64ToUnit8list(String base64String) {
    return base64Decode(base64String);
  }

  ///将图片file转化为base64
  static String fileToBase64(File imgFile) {
    return base64Encode(imgFile.readAsBytesSync());
  }

  ///将网络链接图片转化为base64
  static Future networkImageToBase64(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return base64.encode(response.bodyBytes);
  }

  ///将asset图片转化为base64
  Future assetImageToBase64(String path) async {
    ByteData bytes = await rootBundle.load(path);
    return base64.encode(Uint8List.view(bytes.buffer));
  }

  /*Future<Uint8List> combineImages(List<String> imagePaths) async {
    List<Uint8List> images = [];

    // 加载并转换每张图片为Uint8List
    for (var imagePath in imagePaths) {
      final ByteData data = await rootBundle.load(imagePath); // 如果图片来自assets
      // 或者如果你从文件系统加载图片，可以使用File类
      // final File file = File(imagePath);
      // final Uint8List bytes = await file.readAsBytes();
      final Uint8List bytes = data.buffer.asUint8List();
      images.add(bytes);
    }

    // 将所有图片合并成一张大图
    img.Image combinedImage;
    int totalWidth = 0;
    int maxHeight = 0;

    // 计算总宽度和最大高度
    for (var bytes in images) {
      img.Image image = img.decodeImage(bytes)!;
      totalWidth += image.width;
      if (image.height > maxHeight) {
        maxHeight = image.height;
      }
    }

    // 创建一个新的空白图片
    combinedImage = img.Image(width: totalWidth, height: maxHeight);

    // 在新的图片上画出原来的图片
    int offsetX = 0;
    for (var bytes in images) {
      img.Image image = img.decodeImage(bytes)!;
      //img.copyInto(combinedImage, image, dstX: offsetX);
      img.copyResize(combinedImage, image, dstX: offsetX);
      offsetX += image.width;
    }

    // 编码合并后的图片为Uint8List
    return Uint8List.fromList(img.encodePng(combinedImage));
  }*/

  ///加载网络图片，并且指定宽高大小。使用默认预加载loading和错误视图
  /*static CachedNetworkImage showNetImageWh(String url, double width, double height) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url ?? '',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
              ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => Center(
        child: Container(
          height: 40,
          width: 40,
          margin: EdgeInsets.all(5),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        alignment: Alignment.center,
        color: Colors.black12,
        child: Icon(
          Icons.terrain,
          size: 64,
        ),
      ),
    );
  }*/


  ///加载网络图片，并且指定宽高大小。切割圆角
  /*static CachedNetworkImage showNetImageWhClip(String url,
      double width, double height , double circular) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url ?? '',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(circular),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
              ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => Center(
        child: Container(
          height: 40,
          width: 40,
          margin: EdgeInsets.all(5),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        alignment: Alignment.center,
        color: Colors.black12,
        child: Icon(
          Icons.terrain,
          size: 64,
        ),
      ),
    );
  }*/


  ///加载网络图片，切割圆形图片。
 /* static CachedNetworkImage showNetImageCircle(String url, double radius) {
    return CachedNetworkImage(
      width: radius * 2,
      height: radius * 2,
      imageUrl: url ?? '',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
              ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => Center(
        child: Container(
          height: 40,
          width: 40,
          margin: EdgeInsets.all(5),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        alignment: Alignment.center,
        color: Colors.black12,
        child: Icon(
          Icons.terrain,
          size: 64,
        ),
      ),
    );
  }*/

  ///加载网络图片，并且指定宽高大小。传入错误视图
  /*static CachedNetworkImage showNetImageWhError(String url,
      double width, double height , LoadingErrorWidgetBuilder error) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url ?? '',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
              ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => Center(
        child: Container(
          height: 40,
          width: 40,
          margin: EdgeInsets.all(5),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
        ),
      ),
      errorWidget: error
    );
  }*/

  ///加载网络图片，并且指定宽高大小。传入预加载，错误视图
  /*static CachedNetworkImage showNetImageWhPlaceError(String url,
      double width, double height ,PlaceholderWidgetBuilder place,
      LoadingErrorWidgetBuilder error) {
    return CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: url ?? '',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter:
                ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
          ),
        ),
        placeholder: place,
        errorWidget: error
    );
  }*/


}