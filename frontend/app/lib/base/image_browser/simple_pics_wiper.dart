// import 'dart:io';
// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';
// import 'hero.dart';
//
// class SimplePicsWiper extends StatefulWidget {
//   const SimplePicsWiper({super.key, required this.url, required this.images});
//   final String url;
//   final List<String> images;
//   @override
//   _SimplePicsWiperState createState() => _SimplePicsWiperState();
// }
//
// class _SimplePicsWiperState extends State<SimplePicsWiper> {
//   GlobalKey<ExtendedImageSlidePageState> slidePagekey = GlobalKey<ExtendedImageSlidePageState>();
//
//   final List<int> _cachedIndexes = <int>[];
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final int index = widget.images.indexOf(widget.url);
//     // _preloadImage(index - 1);
//     // _preloadImage(index + 1);
//   }
//
//   void _preloadImage(int index) {
//     if (_cachedIndexes.contains(index)) {
//       return;
//     }
//     if (0 <= index && index < widget.images.length) {
//       final String url = widget.images[index];
//       if (url.startsWith('https:')) {
//         precacheImage(ExtendedNetworkImageProvider(url, cache: true), context);
//       }
//       _cachedIndexes.add(index);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.black,
//       // color: const Color.fromRGBO(192 , 192, 192, 0.3),
//       // shadowColor: Colors.transparent,
//       // surfaceTintColor: Colors.transparent,
//       child: ExtendedImageSlidePage(
//         key: slidePagekey,
//         slideAxis: SlideAxis.both,
//         slideType: SlideType.wholePage,
//         child: GestureDetector(
//           child: ExtendedImageGesturePageView.builder(
//             controller: ExtendedPageController(
//               initialPage: widget.images.indexOf(widget.url),
//               pageSpacing: 50,
//               shouldIgnorePointerWhenScrolling: false,
//             ),
//             itemCount: widget.images.length,
//             onPageChanged: (int page) {
//               // _preloadImage(page - 1);
//               // _preloadImage(page + 1);
//             },
//             itemBuilder: (BuildContext context, int index) {
//               final String url = widget.images[index];
//               return url == 'This is an video'
//                   ? ExtendedImageSlidePageHandler(
//                 child: Material(
//                   color: Colors.black,
//                   child: Container(
//                     alignment: Alignment.center,
//                     color: Colors.yellow,
//                     child: const Text('This is an video'),
//                   ),
//                 ),
//
//                 ///make hero better when slide out
//                 heroBuilderForSlidingPage: (Widget result) {
//                   return Hero(
//                     tag: url,
//                     child: result,
//                     flightShuttleBuilder: (BuildContext flightContext,
//                         Animation<double> animation,
//                         HeroFlightDirection flightDirection,
//                         BuildContext fromHeroContext,
//                         BuildContext toHeroContext) {
//                       final Hero hero =
//                       (flightDirection == HeroFlightDirection.pop
//                           ? fromHeroContext.widget
//                           : toHeroContext.widget) as Hero;
//                       return hero.child;
//                     },
//                   );
//                 },
//               )
//                   : HeroWidget(
//                 tag: url,
//                 slideType: SlideType.wholePage,
//                 slidePagekey: slidePagekey,
//                 child: url.startsWith("http") ? ExtendedImage.network(
//                   url,
//                   enableSlideOutPage: true,
//                   fit: BoxFit.contain,
//                   mode: ExtendedImageMode.gesture,
//                   initGestureConfigHandler: (ExtendedImageState state) {
//                     return GestureConfig(
//                       inPageView: true,
//                       initialScale: 1.0,
//                       maxScale: 5.0,
//                       animationMaxScale: 6.0,
//                       initialAlignment: InitialAlignment.center,
//                     );
//                   },
//                 ) : ExtendedImage.file(
//                     File(url),
//                     enableSlideOutPage: true,
//                     fit: BoxFit.contain,
//                     mode: ExtendedImageMode.gesture,
//                     initGestureConfigHandler: (ExtendedImageState state) {
//                       return GestureConfig(
//                         inPageView: true,
//                         initialScale: 1.0,
//                         maxScale: 5.0,
//                         animationMaxScale: 6.0,
//                         initialAlignment: InitialAlignment.center,
//                       );
//                     }
//                 ),
//               );
//             },
//           ),
//           onTap: () {
//             slidePagekey.currentState!.popPage();
//             Navigator.pop(context);
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
//
// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';
//
//
// class SimplePicsWiper extends StatefulWidget {
//   const SimplePicsWiper({super.key, required this.url, required this.images});
//   final String url;
//   final List<String> images;
//   @override
//   _SimplePicsWiperState createState() => _SimplePicsWiperState();
// }
//
// class _SimplePicsWiperState extends State<SimplePicsWiper> {
//   GlobalKey<ExtendedImageSlidePageState> slidePagekey = GlobalKey<ExtendedImageSlidePageState>();
//
//   final List<int> _cachedIndexes = <int>[];
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final int index = widget.images.indexOf(widget.url);
//     // _preloadImage(index - 1);
//     // _preloadImage(index + 1);
//   }
//
//   void _preloadImage(int index) {
//     if (_cachedIndexes.contains(index)) {
//       return;
//     }
//     if (0 <= index && index < widget.images.length) {
//       final String url = widget.images[index];
//       if (url.startsWith('https:')) {
//         precacheImage(ExtendedNetworkImageProvider(url, cache: true), context);
//       }
//       _cachedIndexes.add(index);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: ExtendedImageSlidePage(
//         key: slidePagekey,
//         slideAxis: SlideAxis.both,
//         slideType: SlideType.wholePage,
//         child: GestureDetector(
//           child: ExtendedImageGesturePageView.builder(
//             controller: ExtendedPageController(
//               initialPage: widget.images.indexOf(widget.url),
//               pageSpacing: 0,
//               shouldIgnorePointerWhenScrolling: false,
//             ),
//             itemCount: widget.images.length,
//             onPageChanged: (int page) {
//               // _preloadImage(page - 1);
//               // _preloadImage(page + 1);
//             },
//             itemBuilder: (BuildContext context, int index) {
//               final String url = widget.images[index];
//               return Container(
//                 color: Colors.transparent,  // 设置图片父视图的背景颜色为黑色
//                 child: url == 'This is an video'
//                     ? ExtendedImageSlidePageHandler(
//                   child: Material(
//                     color: Colors.transparent,
//                     child: Container(
//                       alignment: Alignment.center,
//                       color: Colors.transparent,
//                       child: const Text('This is an video'),
//                     ),
//                   ),
//
//                   ///make hero better when slide out
//                   heroBuilderForSlidingPage: (Widget result) {
//                     return Hero(
//                       tag: url,
//                       child: result,
//                       flightShuttleBuilder: (BuildContext flightContext,
//                           Animation<double> animation,
//                           HeroFlightDirection flightDirection,
//                           BuildContext fromHeroContext,
//                           BuildContext toHeroContext) {
//                         final Hero hero =
//                         (flightDirection == HeroFlightDirection.pop
//                             ? fromHeroContext.widget
//                             : toHeroContext.widget) as Hero;
//                         return hero.child;
//                       },
//                     );
//                   },
//                 )
//                     : HeroWidget(
//                   tag: url,
//                   slideType: SlideType.wholePage,
//                   slidePagekey: slidePagekey,
//                   child: url.startsWith("http") ? ExtendedImage.network(
//                     url,
//                     enableSlideOutPage: true,
//                     fit: BoxFit.contain,
//                     mode: ExtendedImageMode.gesture,
//                     initGestureConfigHandler: (ExtendedImageState state) {
//                       return GestureConfig(
//                         inPageView: true,
//                         initialScale: 1.0,
//                         maxScale: 5.0,
//                         animationMaxScale: 6.0,
//                         initialAlignment: InitialAlignment.center,
//                       );
//                     },
//                   ) : ExtendedImage.file(
//                       File(url),
//                       enableSlideOutPage: true,
//                       fit: BoxFit.contain,
//                       mode: ExtendedImageMode.gesture,
//                       initGestureConfigHandler: (ExtendedImageState state) {
//                         return GestureConfig(
//                           inPageView: true,
//                           initialScale: 1.0,
//                           maxScale: 5.0,
//                           animationMaxScale: 6.0,
//                           initialAlignment: InitialAlignment.center,
//                         );
//                       }
//                   ),
//                 ),
//               );
//             },
//           ),
//           onTap: () {
//             slidePagekey.currentState!.popPage();
//             Navigator.pop(context);
//           },
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
// /// make hero better when slide out
// class HeroWidget extends StatefulWidget {
//   const HeroWidget({super.key,
//     required this.child,
//     required this.tag,
//     required this.slidePagekey,
//     this.slideType = SlideType.onlyImage,
//   });
//   final Widget child;
//   final SlideType slideType;
//   final Object tag;
//   final GlobalKey<ExtendedImageSlidePageState> slidePagekey;
//   @override
//   _HeroWidgetState createState() => _HeroWidgetState();
// }
//
// class _HeroWidgetState extends State<HeroWidget> {
//   RectTween? _rectTween;
//   @override
//   Widget build(BuildContext context) {
//     return Hero(
//       tag: widget.tag,
//       createRectTween: (Rect? begin, Rect? end) {
//         _rectTween = RectTween(begin: begin, end: end);
//         return _rectTween!;
//       },
//       // make hero better when slide out
//       flightShuttleBuilder: (BuildContext flightContext,
//           Animation<double> animation,
//           HeroFlightDirection flightDirection,
//           BuildContext fromHeroContext,
//           BuildContext toHeroContext) {
//         // make hero more smoothly
//         final Hero hero = (flightDirection == HeroFlightDirection.pop
//             ? fromHeroContext.widget
//             : toHeroContext.widget) as Hero;
//         if (_rectTween == null) {
//           return hero;
//         }
//
//         if (flightDirection == HeroFlightDirection.pop) {
//           final bool fixTransform = widget.slideType == SlideType.onlyImage &&
//               (widget.slidePagekey.currentState!.offset != Offset.zero ||
//                   widget.slidePagekey.currentState!.scale != 1.0);
//
//           final Widget toHeroWidget = (toHeroContext.widget as Hero).child;
//           return AnimatedBuilder(
//             animation: animation,
//             builder: (BuildContext buildContext, Widget? child) {
//               Widget animatedBuilderChild = hero.child;
//               // make hero more smoothly
//               animatedBuilderChild = Stack(
//                 clipBehavior: Clip.antiAlias,
//                 alignment: Alignment.center,
//                 children: <Widget>[
//                   Opacity(
//                     opacity: 1 - animation.value,
//                     child: UnconstrainedBox(
//                       child: SizedBox(
//                         width: _rectTween!.begin!.width,
//                         height: _rectTween!.begin!.height,
//                         child: toHeroWidget,
//                       ),
//                     ),
//                   ),
//                   Opacity(
//                     opacity: animation.value,
//                     child: animatedBuilderChild,
//                   )
//                 ],
//               );
//
//               // fix transform when slide out
//               if (fixTransform) {
//                 final Tween<Offset> offsetTween = Tween<Offset>(
//                     begin: Offset.zero,
//                     end: widget.slidePagekey.currentState!.offset);
//                 final Tween<double> scaleTween = Tween<double>(
//                     begin: 1.0, end: widget.slidePagekey.currentState!.scale);
//                 animatedBuilderChild = Transform.translate(
//                   offset: offsetTween.evaluate(animation),
//                   child: Transform.scale(
//                     scale: scaleTween.evaluate(animation),
//                     child: animatedBuilderChild,
//                   ),
//                 );
//               }
//               return animatedBuilderChild;
//             },
//           );
//         }
//         return hero.child;
//       },
//       child: widget.child,
//     );
//   }
// }

import 'dart:io';
import 'dart:math';

import 'package:auto_shop_server/base/image_browser/hero.dart';
import 'package:auto_shop_server/app/utils/file_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SimplePicsWiper extends StatefulWidget {
  const SimplePicsWiper({super.key, required this.url, required this.images});
  final String url;
  final List<String> images;

  @override
  _SimplePicsWiperState createState() => _SimplePicsWiperState();
}

class _SimplePicsWiperState extends State<SimplePicsWiper> {
  GlobalKey<ExtendedImageSlidePageState> slidePagekey = GlobalKey<ExtendedImageSlidePageState>();
  final List<int> _cachedIndexes = <int>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final int index = widget.images.indexOf(widget.url);
    // _preloadImage(index - 1);
    // _preloadImage(index + 1);
  }

  void _preloadImage(int index) {
    if (_cachedIndexes.contains(index)) {
      return;
    }
    if (0 <= index && index < widget.images.length) {
      final String url = widget.images[index];
      if (url.startsWith('https:')) {
        precacheImage(ExtendedNetworkImageProvider(url, cache: true), context);
      }
      _cachedIndexes.add(index);
    }
  }

  //TODO 2025/3/20 cq这段代码我抽取了通用的公共方法有上传报错日志，这个方法废弃.
  /*Future<void> _saveImage(context, String url) async {
    // 请求权限
    final PermissionState permissionState = await PhotoManager.requestPermissionExtend();
    if (permissionState.isAuth) {
      try {
        Uint8List imageData;
        // 判断是网络图片还是本地图片
        if (url.startsWith('http')) {
          // 下载网络图片
          final http.Response response = await http.get(Uri.parse(url));
          imageData = response.bodyBytes;
        } else {
          // 读取本地图片
          imageData = await File(url).readAsBytes();
        }

        // 保存图片到相册
        final AssetEntity result = await PhotoManager.editor.saveImage(imageData, filename: '');
        if (result != null) {
          showMessage("图片保存成功");
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('图片保存成功')));
        } else {
          showMessage("图片保存失败");
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('图片保存失败')));
        }
      } catch (e) {
        showMessage("图片保存失败");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('图片保存失败：$e')));
      }
    } else {
      showMessage("请授予存储权限");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('请授予存储权限')));
    }
  }*/

  @override
  Widget build(BuildContext context) {
    // 获取页面的对角线长度作为最大距离
    final double maxDistance = sqrt(MediaQuery.of(context).size.width * MediaQuery.of(context).size.width + MediaQuery.of(context).size.height * MediaQuery.of(context).size.height);

    return Material(
      // color: Colors.transparent,
      color: Colors.transparent, // 将背景颜色设为黑色
      child: ExtendedImageSlidePage(
        key: slidePagekey,
        slideAxis: SlideAxis.both,
        slideType: SlideType.wholePage,
        slidePageBackgroundHandler: (Offset offset, Size pageSize) {
          // 计算当前偏移量的距离
          final double offsetDistance = offset.distance;
          // 根据偏移量计算透明度，拖拽越多，透明度越高
          final double opacity = (1 - offsetDistance / maxDistance).clamp(0.0, 1.0);
          return Colors.black.withOpacity(opacity);
        },
        child: GestureDetector(
          child: ExtendedImageGesturePageView.builder(
            controller: ExtendedPageController(
              initialPage: widget.images.indexOf(widget.url),
              pageSpacing: 0,
              shouldIgnorePointerWhenScrolling: false,
            ),
            itemCount: widget.images.length,
            onPageChanged: (int page) {
              // _preloadImage(page - 1);
              // _preloadImage(page + 1);
            },
            itemBuilder: (BuildContext context, int index) {
              final String url = widget.images[index];
              return Container(
                color: Colors.transparent,
                // color: Colors.black, // 设置图片父视图的背景颜色为黑色

                child: url == 'This is an video'
                    ? ExtendedImageSlidePageHandler(
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: const Text('This is an video'),
                          ),
                        ),
                        heroBuilderForSlidingPage: (Widget result) {
                          return Hero(
                            tag: url,
                            child: result,
                            flightShuttleBuilder: (BuildContext flightContext, Animation<double> animation, HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext) {
                              final Hero hero = (flightDirection == HeroFlightDirection.pop ? fromHeroContext.widget : toHeroContext.widget) as Hero;
                              return hero.child;
                            },
                          );
                        },
                      )
                    : HeroWidget(
                        tag: url,
                        slideType: SlideType.wholePage,
                        slidePagekey: slidePagekey,
                        child: GestureDetector(
                          onLongPress: () {
                            _showBottomSheet(context, url);
                          },
                          child: url.startsWith("http")
                              ? ExtendedImage.network(
                                  url,
                                  enableSlideOutPage: true,
                                  fit: BoxFit.contain,
                                  mode: ExtendedImageMode.gesture,
                                  initGestureConfigHandler: (ExtendedImageState state) {
                                    return GestureConfig(
                                      inPageView: true, // 是否在PageView中，确保与PageView滑动兼容
                                      initialScale: 1.0, // 初始缩放比例
                                      maxScale: 5.0, // 最大缩放比例
                                      animationMaxScale: 6.0, // 动画最大缩放比例
                                      initialAlignment: InitialAlignment.center, // 初始对齐方式
                                      minScale: 0.3, // 拖拽图片时允许的最小缩放比例（例如将图片缩放到70%的大小）
                                    );
                                  },
                                )
                              : ExtendedImage.file(File(url), enableSlideOutPage: true, fit: BoxFit.contain, mode: ExtendedImageMode.gesture, initGestureConfigHandler: (ExtendedImageState state) {
                                  return GestureConfig(
                                    inPageView: true, // 是否在PageView中，确保与PageView滑动兼容
                                    initialScale: 1.0, // 初始缩放比例
                                    maxScale: 5.0, // 最大缩放比例
                                    animationMaxScale: 6.0, // 动画最大缩放比例
                                    initialAlignment: InitialAlignment.center, // 初始对齐方式
                                    minScale: 0.3, // 拖拽图片时允许的最小缩放比例（例如将图片缩放到70%的大小）
                                  );
                                }),
                        ),
                      ),
              );
            },
          ),
          onTap: () {
            slidePagekey.currentState!.popPage();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, String url) {
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
                        //封装有通用的可以上传日志的保存图片的方法，我废弃它。
                        //_saveImage(context, url);
                        // FileUtilsMy.saveImageToAlbum(url,showMsg: true);
                        FileUtilsMy.saveImageToAlbumByImageGallerySaverPlus(url, showMsg: true);
                      }),
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('取消'),
                ),
              ),
            ));
  }
}
