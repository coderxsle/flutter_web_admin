import 'package:auto_shop_server/res/assets_res.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 结束编辑，防止键盘遮挡
endEditing() => FocusScope.of(Get.context!).requestFocus(FocusNode());
closeKeyboard() => endEditing();



// ===============================================================================
//                                    AfterDelay
// ===============================================================================
class AfterDelay {
  /// 延迟 x 秒后调用
  static Future<void> seconds(int seconds, {Function()? callBack}) async {
    return await Future.delayed(Duration(seconds: seconds), () {
      if (callBack != null) {
        callBack();
      }
    });
  }
  /// 延迟 x 毫秒后调用
  static Future<void> milliseconds(int milliseconds, {Function()? callBack}) async {
    return await Future.delayed(Duration(milliseconds: milliseconds), () {
      if (callBack != null) {
        callBack();
      }
    });
  }
}




// ===============================================================================
//                                    NavigationTitle
// ===============================================================================
class NavigationTitle extends StatelessWidget {
  final String title;
  const NavigationTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }
}



// ===============================================================================
//                                        Divider
// ===============================================================================
class DividerLine extends StatelessWidget {
  final double? left, right, height;
  final Color color;
  const DividerLine({super.key,  this.left = 0, this.right = 0, this.height = 0, this.color = Colors.black26});
  @override
  Widget build(BuildContext context) {
    return Divider(indent: left, endIndent: right, thickness: 0.4, height: height, color: color);
  }
}



// ===============================================================================
//                                    ImageNetworking
// ===============================================================================
class ImageNetworking extends StatelessWidget {
  final String url;
  final String? failedImage;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const ImageNetworking(this.url, {super.key, this.failedImage, this.width, this.height, this.fit});
  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      width: width,
      height: height,
      fit: fit ?? BoxFit.fitHeight,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return const Center(child: CupertinoActivityIndicator());
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.failed:
            return Image.asset(
              failedImage ?? AssetsRes.PLACEHOLDER_115,
              width: width,
              height: height,
              fit: fit,
            );
          default:
            return null;
        }
      },
    );
  }
}

// ===============================================================================
//                                    ImageAsset
// ===============================================================================
class ImageAsset extends StatelessWidget {
  final String name;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const ImageAsset(this.name, {super.key, this.width, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.asset(
      name,
      width: width,
      height: height,
      fit: fit,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return const Center(child: CupertinoActivityIndicator());
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.failed:
            return Image.asset(
              AssetsRes.PLACEHOLDER_115,
              width: width,
              height: height,
              fit: fit,
            );
          default:
            return null;
        }
      },
    );
  }
}

// ===============================================================================
//                                    ImageFile
// ===============================================================================
class ImageFile extends StatelessWidget {
  // 在Web平台上使用 dart:io 包中的 File 类时，会遇到兼容性问题
  // 因为 dart:io 仅适用于移动端和服务器端，不支持Web平台。对于Web平台，你需要使用不同的方法来处理文件。
  final dynamic file;  // 使用 dynamic 类型来兼容不同平台的文件类型
  final double? width;
  final double? height;
  final BoxFit? fit;
  const ImageFile(this.file, {super.key, this.width, this.height, this.fit});


  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(
        file,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      // 移动平台处理
      return ExtendedImage.file(
        file, // 假设 file 是一个 dart:io File 对象
        width: width,
        height: height,
        fit: fit,
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return const Center(child: CupertinoActivityIndicator());
            case LoadState.completed:
              return state.completedWidget;
            case LoadState.failed:
              return Image.asset(
                AssetsRes.PLACEHOLDER_115,
                width: width,
                height: height,
                fit: fit,
              );
            default:
              return null;
          }
        },
      );
    }
  }
}


// ===============================================================================
//                                    GradientButton
// ===============================================================================
class GradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final BorderRadius borderRadius;
  final VoidCallback onPressed;
  const GradientButton({super.key,
    required this.child,
    required this.gradient,
    required this.borderRadius,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(child: child),
        ),
      ),
    );
  }
}

// ===============================================================================
//                                    MyMaterialButton
// ===============================================================================
class MyMaterialButton extends StatefulWidget {
  final void Function() onPressed;
  final Color? color;
  final Color? splashColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final int? delayed;
  final Widget? child;
  const MyMaterialButton({super.key, required this.onPressed, this.color, this.splashColor, this.focusColor, this.hoverColor, this.highlightColor, this.borderRadius, this.padding, this.onLongPress, this.width, this.height, this.delayed, this.child});
  @override
  State<MyMaterialButton> createState() => _MyMaterialButtonState();
}
class _MyMaterialButtonState extends State<MyMaterialButton> {
  // 使用节流函数，确保在指定的时间间隔内，无论按钮被点击多少次，只执行一次操作。
  DateTime? _lastCall;
  void _handlePressed() {
    final now = DateTime.now();
    final duration = Duration(milliseconds: widget.delayed??160);
    if (_lastCall == null || now.difference(_lastCall!) > duration) {
      _lastCall = now;
      // 要稳一点，来个水波纹动画。
      Future.delayed(duration).then((value) => widget.onPressed());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: widget.width??double.infinity,
      decoration: BoxDecoration(
          color: widget.color??Colors.transparent,
          borderRadius: widget.borderRadius??BorderRadius.zero
      ),
      child: ClipRRect(
        borderRadius: widget.borderRadius??BorderRadius.zero,
        child: Material(
          child: InkWell(
            splashColor: widget.splashColor, focusColor: widget.focusColor,
            hoverColor: widget.hoverColor, highlightColor: widget.highlightColor,
            onTap: _handlePressed,
            child: Padding(
              padding: widget.padding??EdgeInsets.zero,
              child: Center(child: widget.child),
            ),
          ),
        ),
      ),
    );
  }
}



